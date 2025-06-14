const express = require("express");
const router = express.Router();
const controller = require("../controllers/notificationController");

/**
 * @swagger
 * /notifications/token:
 *   post:
 *     summary: Save or update a device token
 *     tags: [Notifications]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required: [userId, token, device_type]
 *             properties:
 *               userId: { type: integer }
 *               token: { type: string }
 *               device_type: { type: string, enum: [ios, android, web] }
 *     responses:
 *       200:
 *         description: Token saved or updated successfully
 *       400:
 *         description: Missing or invalid fields
 */
router.post("/token", controller.saveToken);

/**
 * @swagger
 * /notifications/tokens:
 *   get:
 *     summary: Get all active device tokens
 *     tags: [Notifications]
 *     responses:
 *       200:
 *         description: List of all active tokens
 */
router.get("/tokens", controller.getTokens);

/**
 * @swagger
 * /notifications/tokens/{userId}:
 *   get:
 *     summary: Get all active tokens for a specific user
 *     tags: [Notifications]
 *     parameters:
 *       - in: path
 *         name: userId
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: List of user's active tokens
 */
router.get("/tokens/:userId", controller.getUserTokens);

/**
 * @swagger
 * /notifications/token/{id}:
 *   delete:
 *     summary: Delete a specific token
 *     tags: [Notifications]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Token deleted successfully
 */
router.delete("/token/:id", controller.deleteToken);

/**
 * @swagger
 * /notifications/tokens/user/{userId}:
 *   delete:
 *     summary: Delete all tokens for a specific user
 *     tags: [Notifications]
 *     parameters:
 *       - in: path
 *         name: userId
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: All user tokens deleted successfully
 */
router.delete("/tokens/user/:userId", controller.deleteUserTokens);

/**
 * @swagger
 * /notifications/token/status:
 *   put:
 *     summary: Update token status
 *     tags: [Notifications]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required: [token, status]
 *             properties:
 *               token: { type: string }
 *               status: { type: string, enum: [active, inactive] }
 *     responses:
 *       200:
 *         description: Token status updated successfully
 */
router.put("/token/status", controller.updateTokenStatus);

/**
 * @swagger
 * /notifications/token/{id}:
 *   put:
 *     summary: Update a token by ID
 *     tags: [Notifications]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: The token ID to update
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               token:
 *                 type: string
 *                 description: New token value (optional)
 *               device_type:
 *                 type: string
 *                 enum: [ios, android, web]
 *                 description: Device type (optional)
 *               status:
 *                 type: string
 *                 enum: [active, inactive]
 *                 description: Token status (optional)
 *     responses:
 *       200:
 *         description: Token updated successfully
 *       400:
 *         description: Invalid input
 *       404:
 *         description: Token not found
 */
router.put("/token/:id", controller.updateToken);

module.exports = router; 