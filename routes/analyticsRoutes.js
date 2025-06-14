const express = require("express");
const router = express.Router();
const analyticsController = require("../controllers/analyticsController");

/**
 * @swagger
 * components:
 *   schemas:
 *     AnalyticsCounts:
 *       type: object
 *       properties:
 *         total_users:
 *           type: number
 *         total_kyc:
 *           type: number
 *         total_investments:
 *           type: number
 *         total_payments:
 *           type: number
 *         total_offers:
 *           type: number
 *         total_policies:
 *           type: number
 *         total_branches:
 *           type: number
 *         total_schemes:
 *           type: number
 *         total_chits:
 *           type: number
 *       example:
 *         total_users: 100
 *         total_kyc: 80
 *         total_investments: 50
 *         total_payments: 45
 *         total_offers: 10
 *         total_policies: 5
 *         total_branches: 3
 *         total_schemes: 8
 *         total_chits: 12
 *
 * tags:
 *   - name: Analytics
 *     description: API for aggregated analytics data
 */

/**
 * @swagger
 * /analytics/counts:
 *   get:
 *     summary: Retrieve aggregated counts from various tables
 *     tags: [Analytics]
 *     responses:
 *       200:
 *         description: Aggregated counts retrieved successfully.
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/AnalyticsCounts'
 *       500:
 *         description: Server error.
 */
router.get("/counts", analyticsController.getAnalyticsCounts);

module.exports = router;
