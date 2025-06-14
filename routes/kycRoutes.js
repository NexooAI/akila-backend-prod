const express = require("express");
const router = express.Router();
const kycController = require("../controllers/kycController");
const { verifyToken, authorizeRole } = require("../middlewares/authenticate");
/**
 * @swagger
 * components:
 *   schemas:
 *     Kyc:
 *       type: object
 *       properties:
 *         id:
 *           type: integer
 *           description: Auto-generated ID of the KYC record.
 *         user_id:
 *           type: integer
 *           description: The ID of the user associated with this KYC record.
 *           example: 1
 *         doorno:
 *           type: string
 *           description: Door number.
 *           example: "123A"
 *         street:
 *           type: string
 *           description: Street name.
 *           example: "Main Street"
 *         area:
 *           type: string
 *           description: Area name.
 *           example: "Downtown"
 *         city:
 *           type: string
 *           description: City name.
 *           example: "New York"
 *         district:
 *           type: string
 *           description: District name.
 *           example: "Manhattan"
 *         state:
 *           type: string
 *           description: State name.
 *           example: "NY"
 *         country:
 *           type: string
 *           description: Country name.
 *           example: "USA"
 *         pincode:
 *           type: string
 *           description: Postal code.
 *           example: "10001"
 *         dob:
 *           type: string
 *           format: date
 *           description: Date of birth.
 *           example: "1990-01-01"
 *         addressproof:
 *           type: string
 *           description: URL or file path for address proof.
 *           example: "https://example.com/proof.jpg"
 *         enternumber:
 *           type: string
 *           description: An identifier number.
 *           example: "EN123456"
 *         nominee_name:
 *           type: string
 *           description: Nominee name.
 *           example: "Jane Doe"
 *         nominee_relationship:
 *           type: string
 *           description: Nominee relationship.
 *           example: "Sister"
 *       required:
 *         - user_id
 *         - doorno
 *         - street
 *         - area
 *         - city
 *         - district
 *         - state
 *         - country
 *         - pincode
 *         - dob
 *         - addressproof
 *         - enternumber
 *         - nominee_name
 *         - nominee_relationship
 *
 * tags:
 *   - name: Kyc
 *     description: KYC record management
 */

/**
 * @swagger
 * /kyc:
 *   post:
 *     summary: Create a new KYC record
 *     tags: [Kyc]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/Kyc'
 *     responses:
 *       201:
 *         description: KYC record created successfully
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 message:
 *                   type: string
 *                   example: "KYC record created successfully"
 *                 data:
 *                   $ref: '#/components/schemas/Kyc'
 *       500:
 *         description: Server error
 */
router.post("/",
    //  verifyToken, authorizeRole(['user']), 
     kycController.createKyc);

/**
 * @swagger
 * /kyc:
 *   get:
 *     summary: Get all KYC records
 *     tags: [Kyc]
 *     responses:
 *       200:
 *         description: A list of KYC records
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 data:
 *                   type: array
 *                   items:
 *                     $ref: '#/components/schemas/Kyc'
 *       500:
 *         description: Server error
 */
router.get("/", 
    // verifyToken, authorizeRole(['user']), 
kycController.getAllKyc);

/**
 * @swagger
 * /kyc/{id}:
 *   get:
 *     summary: Get a single KYC record by ID
 *     tags: [Kyc]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: The KYC record ID.
 *     responses:
 *       200:
 *         description: A single KYC record
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Kyc'
 *       404:
 *         description: KYC record not found
 *       500:
 *         description: Server error
 */
router.get("/:id", 
    // verifyToken, authorizeRole(['user']),
 kycController.getKycById);

/**
 * @swagger
 * /kyc/{id}:
 *   put:
 *     summary: Update a KYC record by ID
 *     tags: [Kyc]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: The KYC record ID.
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/Kyc'
 *     responses:
 *       200:
 *         description: KYC record updated successfully
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 message:
 *                   type: string
 *                   example: "KYC record updated successfully"
 *       500:
 *         description: Server error
 */
router.put("/:id",
    //  verifyToken, authorizeRole(['user']), 
kycController.updateKyc);

/**
 * @swagger
 * /kyc/{id}:
 *   delete:
 *     summary: Delete a KYC record by ID
 *     tags: [Kyc]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: The KYC record ID.
 *     responses:
 *       200:
 *         description: KYC record deleted successfully
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 message:
 *                   type: string
 *                   example: "KYC record deleted successfully"
 *       500:
 *         description: Server error
 */
router.delete("/:id",
    //  verifyToken, authorizeRole(['user']), 
kycController.deleteKyc);

/**
 * @swagger
 * components:
 *   schemas:
 *     KycStatus:
 *       type: object
 *       properties:
 *         user_id:
 *           type: integer
 *         kyc_status:
 *           type: string
 *           description: The KYC status ("Completed" if a record exists, "Not Completed" otherwise)
 *           example: "Completed"
 *
 * tags:
 *   - name: Kyc
 *     description: KYC record management
 */

/**
 * @swagger
 * /kyc/status/{user_id}:
 *   get:
 *     summary: Get KYC status for a specific user
 *     tags: [Kyc]
 *     parameters:
 *       - in: path
 *         name: user_id
 *         required: true
 *         schema:
 *           type: integer
 *         description: The ID of the user
 *     responses:
 *       200:
 *         description: KYC status retrieved successfully
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/KycStatus'
 *       500:
 *         description: Server error
 */
router.get("/status/:user_id", 
    // verifyToken, authorizeRole(['user']),
 kycController.getKycStatus);

module.exports = router;
