const express = require("express");
const router = express.Router();
const offerController = require("../controllers/offerController");
const multerUpload=require('../utils/mutlter-config')
const { verifyToken, authorizeRole } = require("../middlewares/authenticate");
/**
 * @swagger
 * components:
 *   schemas:
 *     Offer:
 *       type: object
 *       properties:
 *         title:
 *           type: string
 *           description: The offer title.
 *         subtitle:
 *           type: string
 *           description: The offer subtitle.
 *         discount:
 *           type: number
 *           description: Discount value for the offer.
 *         start_date:
 *           type: string
 *           format: date
 *           description: Offer start date.
 *         end_date:
 *           type: string
 *           format: date
 *           description: Offer end date.
 *         image_url:
 *           type: string
 *           description: URL of the offer image.
 *         is_active:
 *           type: boolean
 *           description: Offer active status.
 *       required:
 *         - title
 *         - discount
 *         - start_date
 *         - end_date
 *
 * tags:
 *   - name: Offers
 *     description: API for managing offers
 */

/**
 * @swagger
 * /offers:
 *   get:
 *     summary: Retrieve all offers
 *     tags: [Offers]
 *     responses:
 *       200:
 *         description: A list of offers.
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 data:
 *                   type: array
 *                   items:
 *                     $ref: '#/components/schemas/Offer'
 *       500:
 *         description: Server error.
 */
router.get("/offers",verifyToken,authorizeRole(["Admin", "Super Admin"]), offerController.getOffers);

/**
 * @swagger
 * /offers/{id}:
 *   get:
 *     summary: Retrieve a single offer by ID (active or all, as needed)
 *     tags: [Offers]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: number
 *         description: The offer ID.
 *     responses:
 *       200:
 *         description: Offer retrieved successfully.
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Offer'
 *       404:
 *         description: Offer not found.
 *       500:
 *         description: Server error.
 */
router.get("/offers/:id",verifyToken,authorizeRole(["Admin", "Super Admin"]), offerController.getOfferById);

/**
 * @swagger
 * /offers:
 *   post:
 *     summary: Create a new offer
 *     tags: [Offers]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/Offer'
 *     responses:
 *       201:
 *         description: Offer created successfully.
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 id:
 *                   type: number
 *                 message:
 *                   type: string
 *                   example: "Offer created"
 *       500:
 *         description: Server error.
 */
router.post("/offers",verifyToken,authorizeRole(["Admin", "Super Admin"]), multerUpload.single("image"),offerController.createOffer);

/**
 * @swagger
 * /offers/{id}:
 *   put:
 *     summary: Update an existing offer by ID
 *     tags: [Offers]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: number
 *         description: The offer ID.
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/Offer'
 *     responses:
 *       200:
 *         description: Offer updated successfully.
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 message:
 *                   type: string
 *                   example: "Offer updated"
 *       500:
 *         description: Server error.
 */
router.put("/offers/:id",verifyToken,authorizeRole(["Admin", "Super Admin"]), multerUpload.single("image"),offerController.updateOffer);

/**
 * @swagger
 * /offers/{id}:
 *   delete:
 *     summary: Delete an offer by ID
 *     tags: [Offers]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: number
 *         description: The offer ID.
 *     responses:
 *       200:
 *         description: Offer deleted successfully.
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 message:
 *                   type: string
 *                   example: "Offer deleted successfully"
 *       500:
 *         description: Server error.
 */
router.delete("/offers/:id",verifyToken,authorizeRole(["Admin", "Super Admin"]), offerController.deleteOffer);

module.exports = router;
