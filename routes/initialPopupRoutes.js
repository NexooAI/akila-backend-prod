const express = require("express");
const router = express.Router();
const initialPopupController = require("../controllers/initialPopupController");

/**
 * @swagger
 * components:
 *   schemas:
 *     InitialPopup:
 *       type: object
 *       required:
 *         - title
 *         - image_url
 *       properties:
 *         id:
 *           type: integer
 *           description: The auto-generated id of the popup
 *         title:
 *           type: string
 *           description: The title of the popup
 *         image_url:
 *           type: string
 *           description: The URL of the popup image
 *         link_url:
 *           type: string
 *           description: The URL that the popup links to
 *         status:
 *           type: string
 *           enum: [active, inactive]
 *           description: The status of the popup
 *         start_date:
 *           type: string
 *           format: date-time
 *           description: The start date of the popup display period
 *         end_date:
 *           type: string
 *           format: date-time
 *           description: The end date of the popup display period
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
 * /initial-popups:
 *   post:
 *     summary: Create a new initial popup
 *     tags: [Initial Popups]
 *     requestBody:
 *       required: true
 *       content:
 *         multipart/form-data:
 *           schema:
 *             type: object
 *             required:
 *               - title
 *               - image
 *             properties:
 *               title:
 *                 type: string
 *                 description: The title of the popup
 *               image:
 *                 type: string
 *                 format: binary
 *                 description: The popup image file
 *               link_url:
 *                 type: string
 *                 description: The URL that the popup links to
 *               status:
 *                 type: string
 *                 enum: [active, inactive]
 *                 description: The status of the popup
 *               start_date:
 *                 type: string
 *                 format: date-time
 *                 description: The start date of the popup display period
 *               end_date:
 *                 type: string
 *                 format: date-time
 *                 description: The end date of the popup display period
 *     responses:
 *       201:
 *         description: The popup was successfully created
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/InitialPopup'
 *       400:
 *         description: Invalid input
 *       500:
 *         description: Server error
 */
router.post(
  "/",
  initialPopupController.upload.single("image"),
  initialPopupController.createPopup
);

/**
 * @swagger
 * /initial-popups:
 *   get:
 *     summary: Returns all popups
 *     tags: [Initial Popups]
 *     responses:
 *       200:
 *         description: The list of all popups
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
 *                     $ref: '#/components/schemas/InitialPopup'
 *       500:
 *         description: Server error
 */
router.get("/", initialPopupController.getAllPopups);

/**
 * @swagger
 * /initial-popups/active:
 *   get:
 *     summary: Returns all active popups
 *     tags: [Initial Popups]
 *     responses:
 *       200:
 *         description: The list of active popups
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
 *                     $ref: '#/components/schemas/InitialPopup'
 *       500:
 *         description: Server error
 */
router.get("/active", initialPopupController.getActivePopups);

/**
 * @swagger
 * /initial-popups/{id}:
 *   get:
 *     summary: Get an initial popup by id
 *     tags: [Initial Popups]
 *     parameters:
 *       - in: path
 *         name: id
 *         schema:
 *           type: integer
 *         required: true
 *         description: The popup id
 *     responses:
 *       200:
 *         description: The popup description by id
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success:
 *                   type: boolean
 *                 data:
 *                   $ref: '#/components/schemas/InitialPopup'
 *       404:
 *         description: The popup was not found
 *       500:
 *         description: Server error
 */
router.get("/:id", initialPopupController.getPopupById);

/**
 * @swagger
 * /initial-popups/{id}:
 *   put:
 *     summary: Update an initial popup by id
 *     tags: [Initial Popups]
 *     parameters:
 *       - in: path
 *         name: id
 *         schema:
 *           type: integer
 *         required: true
 *         description: The popup id
 *     requestBody:
 *       required: true
 *       content:
 *         multipart/form-data:
 *           schema:
 *             type: object
 *             properties:
 *               title:
 *                 type: string
 *                 description: The title of the popup
 *               image:
 *                 type: string
 *                 format: binary
 *                 description: The popup image file
 *               link_url:
 *                 type: string
 *                 description: The URL that the popup links to
 *               status:
 *                 type: string
 *                 enum: [active, inactive]
 *                 description: The status of the popup
 *               start_date:
 *                 type: string
 *                 format: date-time
 *                 description: The start date of the popup display period
 *               end_date:
 *                 type: string
 *                 format: date-time
 *                 description: The end date of the popup display period
 *     responses:
 *       200:
 *         description: The popup was successfully updated
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/InitialPopup'
 *       404:
 *         description: The popup was not found
 *       500:
 *         description: Server error
 */
router.put(
  "/:id",
  initialPopupController.upload.single("image"),
  initialPopupController.updatePopup
);

/**
 * @swagger
 * /initial-popups/{id}:
 *   delete:
 *     summary: Delete an initial popup by id
 *     tags: [Initial Popups]
 *     parameters:
 *       - in: path
 *         name: id
 *         schema:
 *           type: integer
 *         required: true
 *         description: The popup id
 *     responses:
 *       200:
 *         description: The popup was successfully deleted
 *       404:
 *         description: The popup was not found
 *       500:
 *         description: Server error
 */
router.delete("/:id", initialPopupController.deletePopup);

module.exports = router;
