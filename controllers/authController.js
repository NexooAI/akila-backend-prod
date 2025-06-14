require("dotenv").config();
const jwt = require("jsonwebtoken");
const authModel = require("../models/authModel");
const bcrypt = require("bcrypt");
const db = require("../config/db");
const REFRESH_SECRET = process.env.REFRESH_SECRET;
const secret = require("../config/jwtConfig").secret;
const { generateAccessToken } = require("../models/authModel");
// Check if mobile exists, insert OTP, and send SMS using async/await
const checkMobile = async (req, res) => {
  try {
    const { mobile_number } = req.body;
    const results = await authModel.checkMobile(mobile_number);
    console.log(results, "------------");
    if (results.length === 0) {
      return res.status(404).json({ error: "Invalid mobile number" });
    }
    const otp = Math.floor(1000 + Math.random() * 9000).toString(); // 4-digit OTP
    const otpExpiry = new Date(Date.now() + 10 * 60000); // OTP expiry in 10 minutes

    // Insert OTP into database
    await authModel.insertOtp(mobile_number, otp, otpExpiry);
    // Send SMS (assuming sendSMS returns a result)
    const sms = await authModel.sendSMS(mobile_number, otp);
    console.log(sms, "-----------");
    res.json({ message: "OTP sent successfully", ...sms });
  } catch (error) {
    console.error("Error in checkMobile:", error);
    res.status(500).json({ error: "Internal Server Error" });
  }
};

// Verify OTP using async/await
const verifyOtp = async (req, res) => {
  try {
    const { mobile_number, otp } = req.body;
    console.log("Received mobile_number and OTP:", mobile_number, otp);
    const result = await authModel.verifyOtp(mobile_number, otp);
    if (!result.success) {
      return res.status(400).json({
        success: false,
        message: result.message,
      });
    }
    res.json({
      success: true,
      message: result.message,
      accessToken: result.token,
      token: result.jwttoken,
      refreshtoken: result.refreshToken,
      user: result.user,
    });
  } catch (error) {
    console.error("Error during OTP verification:", error);
    res.status(500).json({ error: error.error || "An error occurred" });
  }
};

// Login with email and MPIN using promise-based db.query and async/await
const login = async (req, res) => {
  try {
    const { email, mpin } = req.body;
    // db should be configured with mysql2/promise
    const [results] = await db.query("SELECT * FROM users WHERE email = ?", [
      email,
    ]);
    if (!results || results.length === 0) {
      console.log("No user found with this email:", email);
      return res.status(400).json({
        success: false,
        message: "Invalid email or MPIN",
      });
    }
    const user = results[0];
    if (user.user_type !== "admin") {
      console.log("Access denied: User is not an admin");
      return res.status(403).json({
        success: false,
        message: "Access denied. Only admins can log in.",
      });
    }
    // Compare entered MPIN with hashed MPIN stored in DB
    const isMatch = await bcrypt.compare(mpin, user.mpin);
    if (!isMatch) {
      console.log("Incorrect MPIN for email:", email);
      return res.status(400).json({
        success: false,
        message: "Invalid email or MPIN",
      });
    }
    // Generate JWT token
    const token = jwt.sign({ user_id: user.id }, secret, {
      expiresIn: "24h", // Token expires in 24 hours
    });
    res.json({
      success: true,
      message: "Login successful",
      token: token,
      user: {
        user_id: user.id,
        name: user.name,
        email: user.email,
        mobile_number: user.mobile_number,
        usertype: user.user_type,
        referralCode: user.referralCode,
        mpinStatus: user.mpin ? true : false,
      },
    });
  } catch (error) {
    console.error("Error querying the database:", error);
    res.status(500).json({ error: "Database query error" });
  }
};
const adminlogin = async (req, res) => {
  try {
    const { email, password } = req.body;
    const result = await authModel.adminLogin(email, password);
    if (!result.success) {
      return res.status(400).json({
        success: false,
        message: result.message,
      });
    }
    res.json({
      success: true,
      message: result.message,
      token: result.token,
      user: result.user,
    });
  } catch (error) {
    res.status(500).json({ success: false, message: error });
  }
};

const refreshToken = async (req, res) => {
  const { refreshToken } = req.body;

  if (!refreshToken) {
    return res.status(403).json({ message: "Refresh token missing" });
  }

  jwt.verify(refreshToken, REFRESH_SECRET, (err, decoded) => {
    if (err) {
      return res.status(403).json({ message: "Invalid refresh token" });
    }
    console.log("decoded", decoded);

    const newAccessToken = generateAccessToken(decoded);

    res.json({ accessToken: newAccessToken });
  });
};
module.exports = {
  checkMobile,
  verifyOtp,
  login,
  adminlogin,
  refreshToken,
};
