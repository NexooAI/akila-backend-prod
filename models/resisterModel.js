const db = require("../config/db");

// Helper function to generate a random 6-character alphanumeric referral code
function generateReferralCode() {
  const chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
  let code = "";
  for (let i = 0; i < 6; i++) {
    code += chars.charAt(Math.floor(Math.random() * chars.length));
  }
  return code;
}

// Check if a mobile number is already registered
const checkMobileExists = async (mobile_number) => {
  const query = "SELECT * FROM users WHERE mobile_number = ?";
  const [results] = await db.query(query, [mobile_number]);
  return results;
};

// Save OTP for a mobile number
const saveOTP = async (mobile_number, otp, expires_at) => {
  const query =
    "INSERT INTO otp_verification (mobile_number, otp, expires_at) VALUES (?, ?, ?)";
  const [result] = await db.query(query, [mobile_number, otp, expires_at]);
  return result;
};

// Verify OTP from the database
const verifyOTPInDb = async (mobile_number, otp) => {
  const query =
    "SELECT * FROM otp_verification WHERE mobile_number = ? AND otp = ? AND expires_at > NOW()";
  const [results] = await db.query(query, [mobile_number, otp]);
  return results;
};

// Create a new user with a unique referral code.
// This function recursively generates a referral code and checks for uniqueness.
const createUser = async (userData) => {
  async function tryInsert() {
    const referralCode = generateReferralCode();
    const checkQuery = "SELECT * FROM users WHERE referral_code = ?";
    const [results] = await db.query(checkQuery, [referralCode]);
    if (results.length > 0) {
      // Duplicate referral code found; try again.
      return tryInsert();
    } else {
      userData.referral_code = referralCode;
      const query =
        "INSERT INTO users (mobile_number, name, email, mpin, referral_code) VALUES (?, ?, ?, ?, ?)";
      const [result] = await db.query(query, [
        userData.mobile_number,
        userData.name,
        userData.email,
        userData.hashedMPIN,
        referralCode,
      ]);
      return result;
    }
  }
  return tryInsert();
};

module.exports = {
  checkMobileExists,
  saveOTP,
  verifyOTPInDb,
  createUser,
};
