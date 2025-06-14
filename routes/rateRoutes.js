// routes/rateRoutes.js
const express = require("express");
const router = express.Router();
const rateController = require("../controllers/rateController");
const { verifyToken, authorizeRole } = require("../middlewares/authenticate");
/**
 * @swagger
 * components:
 *   schemas:
 *     Rate:
 *       type: object
 *       required:
 *         - gold_rate
 *       properties:
 *         id:
 *           type: integer
 *           description: The auto-generated id of the rate
 *         gold_rate:
 *           type: number
 *           format: float
 *           description: The current gold rate
 *         silver_rate:
 *           type: number
 *           format: float
 *           description: The current silver rate
 *         show_silver:
 *           type: boolean
 *           description: Whether to show the silver rate or not
 *         status:
 *           type: string
 *           enum: [active, inactive]
 *           description: The status of the rate
 *         created_at:
 *           type: string
 *           format: date-time
 *           description: The creation timestamp
 *         updated_at:
 *           type: string
 *           format: date-time
 *           description: The last update timestamp
 */

/**
 * @swagger
 * tags:
 *   name: Rates
 *   description: API for managing rate records
 */

/**
 * @swagger
 * /rates:
 *   post:
 *     summary: Create a new rate
 *     tags: [Rates]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - gold_rate
 *             properties:
 *               gold_rate:
 *                 type: number
 *                 format: float
 *                 description: The gold rate value
 *               silver_rate:
 *                 type: number
 *                 format: float
 *                 description: The silver rate value
 *               show_silver:
 *                 type: boolean
 *                 description: Whether to show the silver rate or not
 *               status:
 *                 type: string
 *                 enum: [active, inactive]
 *                 description: The status of the rate
 *     responses:
 *       201:
 *         description: The rate was successfully created
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Rate'
 *       400:
 *         description: Invalid input
 *       500:
 *         description: Server error
 */
router.post("/", rateController.createRate);

/**
 * @swagger
 * /rates:
 *   get:
 *     summary: Returns all rates
 *     tags: [Rates]
 *     responses:
 *       200:
 *         description: The list of rates
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success:
 *                   type: boolean
 *                 data:
 *                   type: array
 *                   items:
 *                     $ref: '#/components/schemas/Rate'
 *       500:
 *         description: Server error
 */
router.get("/", rateController.getAllRates);

/**
 * @swagger
 * /rates/current:
 *   get:
 *     summary: Get the current active rate
 *     tags: [Rates]
 *     responses:
 *       200:
 *         description: The current active rate
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success:
 *                   type: boolean
 *                 data:
 *                   $ref: '#/components/schemas/Rate'
 *       404:
 *         description: No active rate found
 *       500:
 *         description: Server error
 */
router.get("/current", rateController.getCurrentRate);

/**
 * @swagger
 * /rates/{id}:
 *   get:
 *     summary: Get a rate by id
 *     tags: [Rates]
 *     parameters:
 *       - in: path
 *         name: id
 *         schema:
 *           type: integer
 *         required: true
 *         description: The rate id
 *     responses:
 *       200:
 *         description: The rate description by id
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success:
 *                   type: boolean
 *                 data:
 *                   $ref: '#/components/schemas/Rate'
 *       404:
 *         description: The rate was not found
 *       500:
 *         description: Server error
 */
router.get("/:id", rateController.getRateById);

/**
 * @swagger
 * /rates/{id}:
 *   put:
 *     summary: Update a rate by id
 *     tags: [Rates]
 *     parameters:
 *       - in: path
 *         name: id
 *         schema:
 *           type: integer
 *         required: true
 *         description: The rate id
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               gold_rate:
 *                 type: number
 *                 format: float
 *                 description: The gold rate value
 *               silver_rate:
 *                 type: number
 *                 format: float
 *                 description: The silver rate value
 *               show_silver:
 *                 type: boolean
 *                 description: Whether to show the silver rate or not
 *               status:
 *                 type: string
 *                 enum: [active, inactive]
 *                 description: The status of the rate
 *     responses:
 *       200:
 *         description: The rate was successfully updated
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Rate'
 *       404:
 *         description: The rate was not found
 *       500:
 *         description: Server error
 */
router.put("/:id", rateController.updateRate);

/**
 * @swagger
 * /rates/{id}:
 *   delete:
 *     summary: Delete a rate by id
 *     tags: [Rates]
 *     parameters:
 *       - in: path
 *         name: id
 *         schema:
 *           type: integer
 *         required: true
 *         description: The rate id
 *     responses:
 *       200:
 *         description: The rate was successfully deleted
 *       404:
 *         description: The rate was not found
 *       500:
 *         description: Server error
 */
router.delete("/:id", rateController.deleteRate);

module.exports = router;
