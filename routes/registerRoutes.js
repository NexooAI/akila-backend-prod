// routes/registerRoutes.js
const express = require("express");
const router = express.Router();

// Destructure functions from your register controller.
const {
  registerMobile,
  verifyOTP,
  register,
} = require("../controllers/registerController");

/**
 * @swagger
 * components:
 *   schemas:
 *     RegisterMobileRequest:
 *       type: object
 *       required:
 *         - mobile_number
 *       properties:
 *         mobile_number:
 *           type: string
 *           description: The user's mobile number.
 *           example: "1234567890"
 *     RegisterMobileResponse:
 *       type: object
 *       properties:
 *         message:
 *           type: string
 *           description: Response message indicating that OTP has been sent.
 *           example: "OTP sent successfully"
 *
 *     VerifyOTPRequest:
 *       type: object
 *       required:
 *         - mobile_number
 *         - otp
 *       properties:
 *         mobile_number:
 *           type: string
 *           description: The mobile number used for registration.
 *           example: "1234567890"
 *         otp:
 *           type: string
 *           description: The OTP received by the user.
 *           example: "123456"
 *     VerifyOTPResponse:
 *       type: object
 *       properties:
 *         message:
 *           type: string
 *           description: Response message indicating OTP verification status.
 *           example: "OTP verified successfully"
 *
 *     CompleteRegistrationRequest:
 *       type: object
 *       required:
 *         - mobile_number
 *         - name
 *         - email
 *         - mpin
 *       properties:
 *         mobile_number:
 *           type: string
 *           description: The user's mobile number.
 *           example: "1234567890"
 *         name:
 *           type: string
 *           description: The user's full name.
 *           example: "John Doe"
 *         email:
 *           type: string
 *           description: The user's email address.
 *           example: "john.doe@example.com"
 *         mpin:
 *           type: string
 *           description: A secure MPIN for the user.
 *           example: "1234"
 *     CompleteRegistrationResponse:
 *       type: object
 *       properties:
 *         message:
 *           type: string
 *           description: Response message indicating successful registration.
 *           example: "Registration completed successfully"
 *         referral_code:
 *           type: string
 *           description: A unique referral code generated for the user.
 *           example: "ABC123"
 *
 * tags:
 *   - name: Registration
 *     description: Endpoints for user registration
 */

/**
 * @swagger
 * /register/mobile:
 *   post:
 *     summary: Register a mobile number
 *     tags: [Registration]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/RegisterMobileRequest'
 *     responses:
 *       200:
 *         description: Mobile number registered successfully and OTP sent.
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/RegisterMobileResponse'
 *       500:
 *         description: Server error.
 */
router.post("/mobile", registerMobile);

/**
 * @swagger
 * /register/verify-otp:
 *   post:
 *     summary: Verify OTP for mobile registration
 *     tags: [Registration]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/VerifyOTPRequest'
 *     responses:
 *       200:
 *         description: OTP verified successfully.
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/VerifyOTPResponse'
 *       400:
 *         description: Invalid OTP.
 *       500:
 *         description: Server error.
 */
router.post("/verify-otp", verifyOTP);

/**
 * @swagger
 * /register/complete:
 *   post:
 *     summary: Complete user registration
 *     tags: [Registration]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/CompleteRegistrationRequest'
 *     responses:
 *       201:
 *         description: Registration completed successfully.
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/CompleteRegistrationResponse'
 *       500:
 *         description: Server error.
 */
router.post("/complete", register);

module.exports = router;
