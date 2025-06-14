const bcrypt = require("bcrypt");
const registerModel = require("../models/resisterModel");
const authModel = require("../models/authModel"); // for sending SMS

// Step 1: Register Mobile - Check mobile number and send OTP
exports.registerMobile = async (req, res) => {
  try {
    const { mobile_number } = req.body;
    console.log(`registerMobile ${mobile_number}`);

    const results = await registerModel.checkMobileExists(mobile_number);
    if (results.length > 0) {
      return res
        .status(400)
        .json({ error: "Mobile number already registered" });
    }

    // Generate a 4-digit OTP
    const otp = Math.floor(1000 + Math.random() * 9000);
    console.log("Generated OTP:", otp);

    // Set OTP expiry to 10 minutes from now
    const otpExpiry = new Date(Date.now() + 10 * 60000);

    // Save OTP and then send it via SMS
    await registerModel.saveOTP(mobile_number, otp, otpExpiry);
    const smsResult = await authModel.sendSMS(mobile_number, otp);
    console.log(smsResult);
    res.json({ message: "OTP sent successfully", sms: smsResult });
  } catch (err) {
    console.error("Error in registerMobile:", err);
    res.status(500).json({ error: "Database error" });
  }
};

// Step 2: Verify OTP
exports.verifyOTP = async (req, res) => {
  try {
    const { mobile_number, otp } = req.body;
    const results = await registerModel.verifyOTPInDb(mobile_number, otp);
    if (results.length === 0) {
      return res.status(400).json({ error: "Invalid OTP or OTP expired" });
    }
    res.json({
      message: "OTP verified successfully, proceed with registration",
      userType: "new",
    });
  } catch (err) {
    console.error("Error in verifyOTP:", err);
    res.status(500).json({ error: "Database error" });
  }
};

// Step 3: Complete Registration - Create user record with hashed MPIN and unique referral code
exports.register = async (req, res) => {
  try {
    const { mobile_number, name, email, mpin } = req.body;
    if (!mobile_number || !name || !email || !mpin) {
      return res.status(400).json({ error: "Missing required fields" });
    }

    // Hash the MPIN (or password)
    const hashedMPIN = await bcrypt.hash(mpin, 10);

    const userData = {
      mobile_number,
      name,
      email,
      hashedMPIN, // Store the hashed MPIN
    };

    await registerModel.createUser(userData);
    res.json({
      message: "Registration complete",
      status: 200,
    });
  } catch (err) {
    console.error("Error in register:", err);
    res.status(500).json({ error: err.sqlMessage || err });
  }
};
