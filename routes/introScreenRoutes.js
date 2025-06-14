const express = require('express');
const router = express.Router();
const introScreenController = require('../controllers/introScreenController');
/**
 * @swagger
 * tags:
 *   name: intro Screens
 *   description: intro screens management endpoints
 */

/**
 * @swagger
 * components:
 *   schemas:
 *     introScreen:
 *       type: object
 *       properties:
 *         id:
 *           type: integer
 *         title:
 *           type: string
 *         image:
 *           type: string
 *         startDate:
 *           type: string
 *           format: date
 *         endDate:
 *           type: string
 *           format: date
 *         status:
 *           type: string
 *           enum: [active, inactive]
 */

/**
 * @swagger
 * /intro-screens/active:
 *   get:
 *     security:
 *       - bearerAuth: []
 *     tags: [intro Screens]
 *     summary: Get active intro screens
 *     responses:
 *       200:
 *         description: List of active intro screens
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
 *                     $ref: '#/components/schemas/introScreen'
 *       500:
 *         description: Internal server error
 */
router.get('/active', introScreenController.getActive);

/**
 * @swagger
 * /intro-screens/initial-popup:
 *   get:
 *     security:
 *       - bearerAuth: []
 *     tags: [intro Screens]
 *     summary: Get initial popup screen
 *     responses:
 *       200:
 *         description: Initial popup screen details
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success:
 *                   type: boolean
 *                 data:
 *                   $ref: '#/components/schemas/introScreen'
 *       500:
 *         description: Internal server error
 */
router.get('/initial-popup', introScreenController.getInitialPopup);

/**
 * @swagger
 * /intro-screens:
 *   post:
 *     security:
 *       - bearerAuth: []
 *     tags: [intro Screens]
 *     summary: Create a new intro screen
 *     requestBody:
 *       required: true
 *       content:
 *         multipart/form-data:
 *           schema:
 *             type: object
 *             properties:
 *               title:
 *                 type: string
 *                 description: Title of the intro screen
 *               image:
 *                 type: string
 *                 format: binary
 *                 description: Image file to upload
 *               startDate:
 *                 type: string
 *                 format: date
 *                 description: Start date of the intro screen
 *               endDate:
 *                 type: string
 *                 format: date
 *                 description: End date of the intro screen
 *               status:
 *                 type: string
 *                 enum: [active, inactive]
 *                 description: Status of the intro screen
 *     responses:
 *       201:
 *         description: intro screen created successfully
 *       400:
 *         description: Bad request
 *       500:
 *         description: Internal server error
 */
router.post('/', introScreenController.create);

/**
 * @swagger
 * /intro-screens:
 *   get:
 *     security:
 *       - bearerAuth: []
 *     tags: [intro Screens]
 *     summary: Get all intro screens
 *     responses:
 *       200:
 *         description: List of intro screens
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
 *                     $ref: '#/components/schemas/introScreen'
 *       500:
 *         description: Internal server error
 */
router.get('/', introScreenController.getAll);

/**
 * @swagger
 * /intro-screens/{id}:
 *   get:
 *     security:
 *       - bearerAuth: []
 *     tags: [intro Screens]
 *     summary: Get intro screen by ID
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: intro screen ID
 *     responses:
 *       200:
 *         description: intro screen details
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success:
 *                   type: boolean
 *                 data:
 *                   $ref: '#/components/schemas/introScreen'
 *       404:
 *         description: intro screen not found
 *       500:
 *         description: Internal server error
 */
router.get('/:id', introScreenController.getById);

/**
 * @swagger
 * /intro-screens/{id}:
 *   put:
 *     security:
 *       - bearerAuth: []
 *     tags: [intro Screens]
 *     summary: Update intro screen
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: intro screen ID
 *     requestBody:
 *       required: true
 *       content:
 *         multipart/form-data:
 *           schema:
 *             type: object
 *             properties:
 *               title:
 *                 type: string
 *                 description: Title of the intro screen
 *               image:
 *                 type: string
 *                 format: binary
 *                 description: Image file to upload
 *               startDate:
 *                 type: string
 *                 format: date
 *                 description: Start date of the intro screen
 *               endDate:
 *                 type: string
 *                 format: date
 *                 description: End date of the intro screen
 *               status:
 *                 type: string
 *                 enum: [active, inactive]
 *                 description: Status of the intro screen
 *     responses:
 *       200:
 *         description: intro screen updated successfully
 *       400:
 *         description: Bad request
 *       500:
 *         description: Internal server error
 */
router.put('/:id', introScreenController.update);

/**
 * @swagger
 * /intro-screens/{id}:
 *   delete:
 *     security:
 *       - bearerAuth: []
 *     tags: [intro Screens]
 *     summary: Delete intro screen
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: intro screen ID
 *     responses:
 *       200:
 *         description: intro screen deleted successfully
 *       404:
 *         description: intro screen not found
 *       500:
 *         description: Internal server error
 */
router.delete('/:id', introScreenController.delete);

module.exports = router;
