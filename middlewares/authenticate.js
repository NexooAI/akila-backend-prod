const jwt = require("jsonwebtoken");
const jwtConfig = require("../config/jwtConfig");
const accessToken=process.env.ACCESS_SECRET
const refreshToken=process.env.REFRESH_SECRET
const db = require("../config/db"); 

const {generateAccessToken}=require('../models/authModel')
// const authenticateToken = (req, res, next) => {
//   const authHeader = req.headers["authorization"];
//   const token = authHeader && authHeader.split(" ")[0];
//   if (!token) return res.status(401).json({ error: "Access denied" });

//   jwt.verify(token, jwtConfig.secret, (err, user) => {
//     if (err) return res.status(403).json({ error: "Invalid token" });
//     req.user = user;
//     next();
//   });
// };
const authenticateToken = (req, res, next) => {
  // Retrieve the token from the Authorization header
  const authHeader = req.headers["authorization"];
  // This example assumes the token is sent as "Bearer <token>"
  const token = authHeader && authHeader.split(" ")[1];

  // Optional: If you want to attach a dummy user object when a token is present,
  // you can do so here. Otherwise, simply call next() regardless of token presence.
  if (token) {
    // For example, assign a dummy user to req.user
    req.user = { id: "dummyUser", token };
  } else {
    req.user = null;
  }

  // Bypass token verification and proceed to the next middleware/route handler
  next();
};

const verifyToken = (req, res, next) => {

  const token = req.header("Authorization")?.split(" ")[1];
  console.log("token",token)
  if (!token) return res.status(401).json({ message: "Access Denied" });

  try {
      const verified = jwt.verify(token, process.env.JWT_SECRET);
      console.log("verfirled",verified)
      req.user = verified;
      next();
  } catch (error) {
      res.status(401).json({ message: "Invalid Token" });
  }
};

const verifyTokenaccess = (req, res, next) => {
try{
  const token = req.headers["authorization"]?.split(" ")[1];
console.log("refreshToken",refreshToken)
  if (!token) {
    return res.status(401).json({ message: "Token missing" });
  }

  jwt.verify(token, accessToken, (err, decoded) => {
    if (err) {
      if (err.name === "TokenExpiredError") {
        // If token is expired, attempt to refresh it
        return handleTokenRefresh(req, res, next);
      }
      return res.status(403).json({ message: "Invalid or expired token" });
    }

    req.user = decoded; // Attach decoded user data to request
    next();
  });
}
catch(err)
{
console.log(err)
}
  
};
// const handleTokenRefresh = (req, res, next) => {
//   const refreshToken = req.headers["x-refresh-token"]; // Get refresh token from headers
//   if (!refreshToken) {
//     return res.status(401).json({ message: "Refresh token required" });
//   }

//   jwt.verify(refreshToken, process.env.REFRESH_SECRET, (err, decoded) => {
//     if (err) {
//       return res.status(403).json({ message: "Invalid or expired refresh token" });
//     }

//     // Generate a new access token
//     const newAccessToken = generateAccessToken(decoded);
//     res.setHeader("x-new-access-token", newAccessToken); // Send new token in response header

//     // Reattempt request with new token
//     req.headers["authorization"] = `Bearer ${newAccessToken}`;
//     verifyTokenaccess(req, res, next);
//   });
// };
const handleTokenRefresh = async (req, res, next) => {
  const refreshToken = req.headers["x-refresh-token"];
  if (!refreshToken) {
    return res.status(401).json({ message: "Refresh token required" });
  }

  jwt.verify(refreshToken, process.env.REFRESH_SECRET, async (err, decoded) => {
    if (err) {
      return res.status(403).json({ message: "Invalid or expired refresh token" });
    }

    const userId = decoded.id;

    // 🔒 Fetch and validate refresh token from DB
    const [rows] = await db.query(
      "SELECT * FROM user_tokens WHERE user_id = ? AND refresh_token = ? AND expires_at > NOW()",
      [userId, refreshToken]
    );
    console.log("rows",rows,userId)

    if (rows.length === 0) {
      return res.status(403).json({ message: "Refresh token not found or expired" });
    }
     const [userResults] = await db.query(
          "SELECT id, name, email, user_type, referral_code, mpin,mobile_number FROM users WHERE id = ?",
          [userId]
        );
    
        if (userResults.length === 0) {
          return { success: false, message: "User not found." };
        }
    
        const user = userResults[0];

    // ✅ Generate new tokens
    const newAccessToken = generateAccessToken(user);
    const newRefreshToken = generateRefreshToken(user);
console.log("new refrestoken",newRefreshToken)
    // 📝 Update refresh token in DB
    await db.query(
      "UPDATE user_tokens SET refresh_token = ?, expires_at = DATE_ADD(NOW(), INTERVAL 7 DAY) WHERE user_id = ?",
      [newRefreshToken, userId]
    );

    res.setHeader("x-new-access-token", newAccessToken);
    res.setHeader("x-new-refresh-token", newRefreshToken);
    req.headers["authorization"] = `Bearer ${newAccessToken}`;
    verifyTokenaccess(req, res, next); // Retry original request
  });
};

const generateRefreshToken = (user) => {
  console.log("'refreshtoken",user)
  return jwt.sign({ id: user.id, mobileNumber: user.mobile_number, userType: user.user_type }, refreshToken, {
    expiresIn: "7d", 
  });
};
const authorizeRole = (roles) => {
  return (req, res, next) => {
    console.log('req',req.user)
    req.user.role=req.user.userType||req.user.role
    console.log('requser',req.user)
      if (!roles.includes(req.user.role)) {
          return res.status(403).json({ message: "Access denied" });
      }
      next();
  };
};
module.exports = {
  verifyToken,
  authenticateToken,
  authorizeRole,
  verifyTokenaccess
};
