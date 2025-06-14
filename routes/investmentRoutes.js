// routes/investment.routes.js
const express = require("express");
const router = express.Router();
const investmentController = require("../controllers/investmentController");
const { verifyToken, authorizeRole } = require("../middlewares/authenticate");

/**
 * @swagger
 * tags:
 *   name: Investments
 *   description: Investment management API
 */

/**
 * @swagger
 * /investments:
 *   get:
 *     summary: Retrieve a list of investments
 *     tags: [Investments]
 *     security:
 *       - BearerAuth: []  # Added security
 *     responses:
 *       200:
 *         description: A list of investments.
 */
router.get("/", 
    //verifyToken, authorizeRole(['user',"Super Admin","Admin","Sales Executive","Branch Manager","user"]), 
    investmentController.getAllInvestments);

/**
 * @swagger
 * /investments/user_investments/{userId}:
 *   get:
 *     summary: Retrieve all investments for a specific user
 *     description: Fetches a list of investments associated with a given user ID.
 *     tags: [Investments]
 *     security:
 *       - BearerAuth: []
 *     parameters:
 *       - in: path
 *         name: userId
 *         required: true
 *         description: The ID of the user whose investments are to be retrieved.
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Successfully retrieved investments.
 *       400:
 *         description: Bad request due to missing or invalid userId parameter.
 *       404:
 *         description: No investments found for the user.
 *       500:
 *         description: Internal server error.
 */
router.get("/user_investments/:userId", 
    //verifyToken, authorizeRole(['user']), 
    investmentController.getInvestmentsByUser);
/**
 * @swagger
 * /investments/check-payment:
 *   post:
 *     summary: Check if the user has paid for the current month
 *     description: Returns whether the user has completed the payment for the given investment in the current month.
 *     tags:
 *       - Investments
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               userId:
 *                 type: integer
 *                 example: 123
 *                 description: The ID of the user
 *               investmentId:
 *                 type: integer
 *                 example: 456
 *                 description: The ID of the investment
 *     responses:
 *       200:
 *         description: Payment status retrieved successfully
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success:
 *                   type: boolean
 *                   example: true
 *                 message:
 *                   type: string
 *                   example: "Payment is pending."
 *       500:
 *         description: Internal server error
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 error:
 *                   type: string
 *                   example: "Database connection failed"
 */
router.post("/check-payment", 
    //verifyToken, authorizeRole(['user']), 
    investmentController.checkPayment);
    /**
 * @swagger
 * /deactive_investments/{id}:
 *   put:
 *     summary: Update an existing deactive_investments
 *     tags: [Investments]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         description: Investment ID.
 *         schema:
 *           type: integer
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               userId:
 *                 type: integer
 *               chitId:
 *                 type: integer
 *               schemeId:
 *                 type: integer
 *               accountName:
 *                 type: string
 *               joiningDate:
 *                 type: string
 *                 format: date
 *               paymentStatus:
 *                 type: string
 *               status:
 *                 type: string
 *               descripation:
 *                 type: string
 *     responses:
 *       200:
 *         description: Investment updated.
 *       404:
 *         description: Investment not found.
 */
router.put("/deactive/:id", 
    //verifyToken, authorizeRole(['Super Admin','Admin','Branch Manager']), 
    investmentController.deactivateupdateInvestment);

/**
 * @swagger
 * /investments/{id}:
 *   get:
 *     summary: Retrieve a single investment by id
 *     tags: [Investments]
 *     security:
 *       - BearerAuth: []  # Added security
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         description: Investment ID.
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Investment details.
 *       404:
 *         description: Investment not found.
 */
router.get("/:id", 
    //verifyToken, authorizeRole(["Super Admin","Admin","Sales Executive","Branch Manager","user"]), 
    investmentController.getInvestmentById);

/**
 * @swagger
 * /investments:
 *   post:
 *     summary: Create a new investment
 *     tags: [Investments]
 *     security:
 *       - BearerAuth: []  # Added security
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               userId:
 *                 type: integer
 *               chitId:
 *                 type: integer
 *               schemeId:
 *                 type: integer
 *               accountName:
 *                 type: string
 *               associated_branch:
 *                 type: integer
 *     responses:
 *       201:
 *         description: Investment created.
 */
router.post("/", 
    //verifyToken, authorizeRole(['user']), 
    investmentController.createInvestment);


/**
 * @swagger
 * /investments/{id}:
 *   put:
 *     summary: Update an existing investment
 *     tags: [Investments]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         description: Investment ID.
 *         schema:
 *           type: integer
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               userId:
 *                 type: integer
 *               chitId:
 *                 type: integer
 *               schemeId:
 *                 type: integer
 *               accountName:
 *                 type: string
 *               accountNo:
 *                 type: integer
 *               paymentStatus:
 *                 type: string
 *               paymentAmount:
 *                 type: integer
 *     responses:
 *       200:
 *         description: Investment updated.
 *       404:
 *         description: Investment not found.
 */
router.put("/:id", 
    //verifyToken, authorizeRole(['user']), 
    investmentController.updateInvestment);

/**
 * @swagger
 * /investments/{id}:
 *   delete:
 *     summary: Delete an investment
 *     tags: [Investments]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         description: Investment ID.
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Investment deleted.
 *       404:
 *         description: Investment not found.
 */
router.delete("/:id", 
    //verifyToken, authorizeRole(['user']), 
    investmentController.deleteInvestment);

/**
 * @swagger
 * /investments/user/{userId}/details:
 *   get:
 *     summary: Retrieve aggregated investment details for a specific user
 *     tags: [Investments]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: userId
 *         required: true
 *         description: User ID.
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Aggregated investment details.
 *       500:
 *         description: Server error.
 */

/**
 * @swagger
 * /investments/export-investments:
 *   get:
 *     summary: Export investments data as a CSV file
 *     description: Exports investments filtered by userId, date range, schemeId, and chitId
 *     tags: [Investments]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: query
 *         name: userId
 *         required: true
 *         description: ID of the user whose investments are to be exported
 *         schema:
 *           type: integer
 *       - in: query
 *         name: startDate
 *         required: false
 *         description: Start date for filtering investments (YYYY-MM-DD)
 *         schema:
 *           type: string
 *           format: date
 *       - in: query
 *         name: endDate
 *         required: false
 *         description: End date for filtering investments (YYYY-MM-DD)
 *         schema:
 *           type: string
 *           format: date
 *       - in: query
 *         name: schemeId
 *         required: false
 *         description: Scheme ID for filtering investments
 *         schema:
 *           type: integer
 *       - in: query
 *         name: chitId
 *         required: false
 *         description: Chit ID for filtering investments
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: CSV file downloaded successfully
 *       404:
 *         description: No investments found for given filters
 *       500:
 *         description: Server error
 */
router.get("/export", 
    //verifyToken, authorizeRole(['Super Admin','Admin','Branch Manager',"user"]), 
    investmentController.exportInvestments);



module.exports = router;
