require("dotenv").config()
const db = require("../config/db"); // Ensure this uses mysql2/promise
const jwt = require("jsonwebtoken");
const bcrypt = require("bcrypt");
const axios = require("axios");
const jwtConfig = require("../config/jwtConfig");
const MAX_ATTEMPTS = 3; // Limit OTP attempts
const OTP_EXPIRY_MINUTES = 10; // OTP expires after 10 minutes
const OTP_RATE_LIMIT_MINUTES = 1; // Prevent multiple OTP requests within 1 min
const LOCKOUT_DURATION_MINUTES = 5; // Lock user for 5 minutes after failed attempts
const accessToken=process.env.ACCESS_SECRET
const refreshToken=process.env.REFRESH_SECRET
const checkMobile = async (mobile_number) => {
  const query = "SELECT * FROM users WHERE mobile_number = ?";
  const [results] = await db.query(query, [mobile_number]);
  return results;
};

// Save OTP for a mobile number
const insertOtp = async (mobile_number, otp, otpExpiry) => {
  try {
    const [result] = await db.query(
      "INSERT INTO otp_verification (mobile_number, otp, expires_at) VALUES (?, ?, ?)",
      [mobile_number, otp, otpExpiry]
    );
    return result;
  } catch (err) {
    throw err;
  }
};

// Send SMS using an external API old
// const sendSMS = async (phoneNumber, otp) => {
//   try {
//     const apiUrl = "http://bulksms.agnisofterp.com/api/smsapi";
//     const params = {
//       key: "f4c3e6001753ec62c906f4bab4ad73df", // Your API key
//       route: 2,
//       sender: "SMSTRT",
//       number: phoneNumber,
//       sms: `Dear valued Customer Your Service Code ${otp} For savings scheme. Thanks for choosing AGNISOFT. For Any Support Call - +91 9159152272 -SMSTRT`,
//       templateid: "1607100000000328064",
//     };
//     console.log(apiUrl, { params });
//     const response = await axios.get(apiUrl, { params });
//     return response.data;
//   } catch (error) {
//     console.error("SMS API Error:", error);
//     throw error;
//   }
// };

// Send SMS using an external API New SMS service for DC Jewlerys
// Route to send OTP
const sendSMS = async (phoneNumber, otp) => {
  // return;
  try {
    if (!phoneNumber || !otp) {
      return res.status(400).json({ error: "Missing required fields" });
    }

    // const apiUrl = `https://api.mybulksms.in/smsotp.php?lg=DCJewellers&key0=z0FEPLfgcQ5zVKS9&key1=1707174141718175093&key2=1701174132304074433&id=DCJEWE&to=${phoneNumber}&uc=1&msg=Dear%20User%20,%20Your%20OTP%20for%20Dc%20Jewellery%20DigitalApp%20registration%20is%20${otp}.%20Thank%20you%20for%20choosing%20Dc%20Jewellery%C2%A0DigitalApp.`;
    const apiUrl = `https://api.mybulksms.in/smsotp.php?lg=Akila&key0=7gVW0z8JyRAC2Hus&key1=1707174546714387446&key2=1701174463618611787&id=AKILAJ&to=${phoneNumber}&uc=1&msg=Dear User , Your OTP for Akila Jewellers DigitalApp registration is ${otp}. Thank you for choosing Akila Jewellers DigitalApp.`
    const response = await axios.get(apiUrl);
    return response.data;
  } catch (error) {
    console.error("Error sending OTP:", error);
    res.status(500).json({ error: "Failed to send OTP" });
  }
};

// Verify OTP from the database and, if valid, generate a JWT token and return user details
// const verifyOtp = async (mobile_number, otp) => {
//   try {
//     const [results] = await db.query(
//       "SELECT * FROM otp_verification WHERE mobile_number = ? AND otp = ? AND expires_at > NOW()",
//       [mobile_number, otp]
//     );

//     if (results.length === 0) {
//       return { success: false, message: "Invalid or expired OTP" };
//     }

//     // OTP is valid; generate JWT token
//     const token = jwt.sign({ mobile_number }, jwtConfig.secret, {
//       expiresIn: "1h",
//     });

//     // Fetch user details
//     const [userResults] = await db.query(
//       "SELECT * FROM users WHERE mobile_number = ?",
//       [mobile_number]
//     );
//     if (userResults.length === 0) {
//       return { success: false, message: "User not found" };
//     }

//     const user = userResults[0];
//     return {
//       success: true,
//       message: "OTP verified successfully",
//       token: token,
//       user: {
//         user_id: user.id,
//         name: user.name,
//         email: user.email,
//         user_type: user.user_type,
//         mobile_number: user.mobile_number,
//         referralCode: user.referral_code,
//         mpinStatus: user.mpin ? true : false,
//       },
//     };
//   } catch (err) {
//     console.error("Error in verifyOtp:", err);
//     throw err;
//   }
// };
const generateAccessToken = (user) => {
  console.log("acesstoken",accessToken,user)
  return jwt.sign({ id: user.id, mobileNumber: user.mobile_number||user.mobileNumber, userType: user.user_type||user.userType }, accessToken, {
    expiresIn: "1h", 
  });
};

// Generate Refresh Token (expires in 7 days)
const generateRefreshToken = (user) => {
  console.log("'refreshtoken",user)
  return jwt.sign({ id: user.id, mobileNumber: user.mobile_number, userType: user.user_type }, refreshToken, {
    expiresIn: "7d", 
  });
};
const verifyOtp = async (mobileNumber, otp) => {
  try {
    console.log("acesstoken",process.env.JWT_SECRET,accessToken)
    // Check if user is temporarily locked out
    const [lockResult] = await db.query(
      "SELECT locked_until FROM otp_verification WHERE mobile_number = ?",
      [mobileNumber]
    );

    if (lockResult.length > 0 && lockResult[0].locked_until > new Date()) {
      return { success: false, message: "Too many failed attempts. Try again later." };
    }

    // Fetch OTP details
    const [otpResult] = await db.query(
      `SELECT otp, attempts, expires_at, is_used FROM otp_verification 
       WHERE mobile_number = ? ORDER BY id DESC LIMIT 1`,
      [mobileNumber]
    );

    if (otpResult.length === 0) {
      return { success: false, message: "No OTP found. Request a new one." };
    }

    const { otp: storedOtp, attempts, expires_at, is_used } = otpResult[0];

    // 🛑 Fix: Only check `is_used` when OTP matches
    if (is_used) {
      return { success: false, message: "OTP already used. Request a new one." };
    }

    // Check OTP expiry
    if (new Date() > new Date(expires_at)) {
      return { success: false, message: "OTP expired. Request a new one." };
    }

    console.log("storedOtp:", storedOtp, "Entered OTP:", otp);

    // Convert both stored and entered OTP to string before comparison
    if (String(otp) !== String(storedOtp)) {
      const newAttempts = attempts + 1;
      console.log('newAttempts:', newAttempts, 'MAX_ATTEMPTS:', MAX_ATTEMPTS);
console.log(newAttempts,MAX_ATTEMPTS)
      if (newAttempts > MAX_ATTEMPTS) {
        const lockTime = new Date();
        lockTime.setMinutes(lockTime.getMinutes() + LOCKOUT_DURATION_MINUTES);
        await db.query(
          "UPDATE otp_verification SET locked_until = ? WHERE mobile_number = ? ORDER BY id DESC LIMIT 1",
          [lockTime, mobileNumber]
        );
        return { success: false, message: "Too many failed attempts. Try again later." };
      }

      // 🛑 Fix: Only update `attempts` on incorrect OTP, NOT `is_used`
      await db.query(
        "UPDATE otp_verification SET attempts = ? WHERE mobile_number = ? ORDER BY id DESC LIMIT 1",
        [newAttempts, mobileNumber]
      );

      return { success: false, message: "Incorrect OTP. Try again." };
    }

    //  OTP is correct → Now mark it as used!
    await db.query("UPDATE otp_verification SET is_used = 1 WHERE mobile_number = ? ORDER BY id DESC LIMIT 1", [mobileNumber]);

    // Fetch user details
    const [userResults] = await db.query(
      "SELECT id, name, email, user_type, referral_code, mpin,mobile_number FROM users WHERE mobile_number = ?",
      [mobileNumber]
    );

    if (userResults.length === 0) {
      return { success: false, message: "User not found." };
    }

    const user = userResults[0];

    // Generate JWT Token
    if (!process.env.JWT_SECRET) {
      throw new Error("Missing JWT Secret");
    }

    const jwttoken = jwt.sign(
      { id: user.id, mobileNumber: user.mobile_number, userType: user.user_type },
      process.env.JWT_SECRET,
      { expiresIn: "15d" }
    );
    const token=generateAccessToken(user)
    const refreshToken=generateRefreshToken(user)

    await db.query(
      "INSERT INTO user_tokens (user_id, refresh_token, expires_at) VALUES (?, ?, DATE_ADD(NOW(), INTERVAL 7 DAY)) ON DUPLICATE KEY UPDATE refresh_token = VALUES(refresh_token), expires_at = VALUES(expires_at)",
      [user.id, refreshToken]
    );
  
    console.log("refreshtoken",refreshToken)

    return {
      success: true,
      message: "OTP verified successfully",
      token,
      refreshToken:refreshToken,
      jwttoken:jwttoken,
      user: {
        user_id: user.id,
        name: user.name,
        email: user.email,
        userType: user.user_type,
        mobile_number: mobileNumber,
        referralCode: user.referral_code,
        mpinStatus: !!user.mpin
      }
    };
  } catch (err) {
    console.error("Error in verifyOtp:", err);
    throw err;
  }
};
// Get the user type for a given mobile number
const getUserType = async (mobile_number) => {
  try {
    const [userResults] = await db.query(
      "SELECT user_type FROM users WHERE mobile_number = ?",
      [mobile_number]
    );
    return userResults;
  } catch (err) {
    throw err;
  }
};
const adminLogin = async (email,password) => {
  console.log("email",email,password)

  try {
      const [rows] = await db.query(
          `SELECT au.*, r.role_name FROM adminuser au 
          LEFT JOIN roles r ON au.role_id = r.id WHERE au.email = ? AND au.status = 'active'`,
          [email]
      );
console.log('rows',rows)
      if (rows.length === 0) return {success:false, message: "Invalid credentials" };

      const user = rows[0];
      const passwordMatch = await bcrypt.compare(password, user.password);
      console.log("pass",passwordMatch)
      if (!passwordMatch) return {success:false, message: "Invalid credentials" };

      const token = jwt.sign(
          { id: user.id, email: user.email, roleId: user.role_id, role: user.role_name },
          process.env.JWT_SECRET,
          { expiresIn: "1h" }
      );

      return {success:true, token, user: { id: user.id, email: user.email, role: user.role_name,user_id: user.id,
        name: user.Fname +' '+ user.lname,mobile_number: user.mobile_number, } }

  } catch (error) {
     return error
  }
};
module.exports = {
  checkMobile,
  insertOtp,
  verifyOtp,
  getUserType,
  sendSMS,
  adminLogin,
  generateAccessToken,
  generateRefreshToken
};