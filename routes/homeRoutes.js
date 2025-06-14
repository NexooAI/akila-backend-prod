const express = require("express");
const router = express.Router();
const { verifyToken } = require("../middlewares/authenticate");
const homeController = require("../controllers/homeController");

/**
 * @swagger
 * tags:
 *   - name: Home
 *     description: Mobile home page data endpoints
 */

/**
 * @swagger
 * /home:
 *   get:
 *     summary: Get all mobile home page data in a single API call
 *     description: Retrieves current rates, collections, posters, flash news, schemes, and user-specific investment data
 *     tags: [Home]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: query
 *         name: userId
 *         schema:
 *           type: integer
 *         description: Optional user ID. If provided, includes user-specific investment data.
 *     responses:
 *       200:
 *         description: Home page data retrieved successfully
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success:
 *                   type: boolean
 *                   example: true
 *                 data:
 *                   type: object
 *                   properties:
 *                     currentRates:
 *                       type: object
 *                       properties:
 *                         goldRate:
 *                           type: number
 *                           example: 5500.00
 *                         silverRate:
 *                           type: number
 *                           example: 75.00
 *                         lastUpdated:
 *                           type: string
 *                           format: date-time
 *                     collections:
 *                       type: array
 *                       items:
 *                         type: object
 *                         properties:
 *                           id:
 *                             type: integer
 *                           title:
 *                             type: string
 *                           description:
 *                             type: string
 *                           image:
 *                             type: string
 *                           status:
 *                             type: string
 *                     posters:
 *                       type: array
 *                       items:
 *                         type: object
 *                         properties:
 *                           id:
 *                             type: integer
 *                           title:
 *                             type: string
 *                           description:
 *                             type: string
 *                           image:
 *                             type: string
 *                           status:
 *                             type: string
 *                     flashNews:
 *                       type: array
 *                       items:
 *                         type: object
 *                         properties:
 *                           id:
 *                             type: integer
 *                           title:
 *                             type: string
 *                           content:
 *                             type: string
 *                           status:
 *                             type: string
 *                           startDate:
 *                             type: string
 *                             format: date
 *                           endDate:
 *                             type: string
 *                             format: date
 *                     schemes:
 *                       type: array
 *                       items:
 *                         type: object
 *                         properties:
 *                           id:
 *                             type: integer
 *                           name:
 *                             type: string
 *                           type:
 *                             type: string
 *                           description:
 *                             type: string
 *                           image:
 *                             type: string
 *                           icon:
 *                             type: string
 *                           planType:
 *                             type: integer
 *                           paymentFrequency:
 *                             type: integer
 *                     introScreen:
 *                       type: object
 *                       nullable: true
 *                       properties:
 *                         title:
 *                           type: string
 *                         image:
 *                           type: string
 *                         startDate:
 *                           type: string
 *                           format: date
 *                         endDate:
 *                           type: string
 *                           format: date
 *                     userInvestments:
 *                       type: object
 *                       nullable: true
 *                       properties:
 *                         investments:
 *                           type: array
 *                           items:
 *                             type: object
 *                             properties:
 *                               id:
 *                                 type: integer
 *                               schemeName:
 *                                 type: string
 *                               amount:
 *                                 type: number
 *                               status:
 *                                 type: string
 *                               joiningDate:
 *                                 type: string
 *                                 format: date
 *                               accountNumber:
 *                                 type: string
 *                               scheme:
 *                                 type: object
 *                               chit:
 *                                 type: object
 *                         analytics:
 *                           type: object
 *                           properties:
 *                             totalSavingAmount:
 *                               type: number
 *                             totalSavingGold:
 *                               type: number
 *                             totalSavingSilver:
 *                               type: number
 *       401:
 *         description: Unauthorized
 *       500:
 *         description: Server error
 */
router.get("/", 
    // verifyToken, 
    homeController.getHomeData);

module.exports = router; 