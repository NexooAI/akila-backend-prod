const express = require("express");
const router = express.Router();
const flashNewsController = require("../controllers/flashNewsController");

/**
 * @swagger
 * components:
 *   schemas:
 *     FlashNews:
 *       type: object
 *       required:
 *         - fNews
 *         - startDate
 *         - endDate
 *         - status
 *       properties:
 *         id:
 *           type: integer
 *           description: The auto-generated id of the flash news
 *         fNews:
 *           type: string
 *           description: The flash news content
 *         startDate:
 *           type: string
 *           format: date
 *           description: Start date of the flash news display period
 *         endDate:
 *           type: string
 *           format: date
 *           description: End date of the flash news display period
 *         status:
 *           type: string
 *           enum: [active, inactive]
 *           description: The status of the flash news
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
 *   name: Flash News
 *   description: Flash news management endpoints
 */

/**
 * @swagger
 * /flash-news:
 *   post:
 *     tags: [Flash News]
 *     summary: Create a new flash news
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - fNews
 *               - startDate
 *               - endDate
 *               - status
 *             properties:
 *               fNews:
 *                 type: string
 *                 description: Flash news content
 *               startDate:
 *                 type: string
 *                 format: date
 *                 description: Start date of the flash news
 *               endDate:
 *                 type: string
 *                 format: date
 *                 description: End date of the flash news
 *               status:
 *                 type: string
 *                 enum: [active, inactive]
 *                 description: Status of the flash news
 *     responses:
 *       201:
 *         description: Flash news created successfully
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success:
 *                   type: boolean
 *                 data:
 *                   $ref: '#/components/schemas/FlashNews'
 *       400:
 *         description: Bad request - Invalid input data
 *       500:
 *         description: Internal server error
 */
router.post("/", flashNewsController.createFlashNews);

/**
 * @swagger
 * /flash-news:
 *   get:
 *     tags: [Flash News]
 *     summary: Get all flash news
 *     responses:
 *       200:
 *         description: List of all flash news
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
 *                     $ref: '#/components/schemas/FlashNews'
 *       500:
 *         description: Internal server error
 */
router.get("/", flashNewsController.getFlashNews);

/**
 * @swagger
 * /flash-news/active:
 *   get:
 *     tags: [Flash News]
 *     summary: Get all active flash news
 *     responses:
 *       200:
 *         description: List of active flash news
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
 *                     $ref: '#/components/schemas/FlashNews'
 *       500:
 *         description: Internal server error
 */
router.get("/active", flashNewsController.getActiveFlashNews);

/**
 * @swagger
 * /flash-news/{id}:
 *   get:
 *     tags: [Flash News]
 *     summary: Get a specific flash news by ID
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: Flash news ID
 *     responses:
 *       200:
 *         description: Flash news details
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success:
 *                   type: boolean
 *                 data:
 *                   $ref: '#/components/schemas/FlashNews'
 *       404:
 *         description: Flash news not found
 *       500:
 *         description: Internal server error
 */
router.get("/:id", flashNewsController.getFlashNewsById);

/**
 * @swagger
 * /flash-news/{id}:
 *   put:
 *     tags: [Flash News]
 *     summary: Update a specific flash news
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: Flash news ID
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               fNews:
 *                 type: string
 *                 description: Flash news content
 *               startDate:
 *                 type: string
 *                 format: date
 *                 description: Start date of the flash news
 *               endDate:
 *                 type: string
 *                 format: date
 *                 description: End date of the flash news
 *               status:
 *                 type: string
 *                 enum: [active, inactive]
 *                 description: Status of the flash news
 *     responses:
 *       200:
 *         description: Flash news updated successfully
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success:
 *                   type: boolean
 *                 data:
 *                   $ref: '#/components/schemas/FlashNews'
 *       404:
 *         description: Flash news not found
 *       500:
 *         description: Internal server error
 */
router.put("/:id", flashNewsController.updateFlashNews);

/**
 * @swagger
 * /flash-news/{id}:
 *   delete:
 *     tags: [Flash News]
 *     summary: Delete a specific flash news
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: Flash news ID
 *     responses:
 *       200:
 *         description: Flash news deleted successfully
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success:
 *                   type: boolean
 *                 message:
 *                   type: string
 *       404:
 *         description: Flash news not found
 *       500:
 *         description: Internal server error
 */
router.delete("/:id", flashNewsController.deleteFlashNews);

module.exports = router;
