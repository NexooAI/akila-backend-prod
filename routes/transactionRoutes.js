// routes/transactionRoutes.js
const express = require("express");
const router = express.Router();
const transactionController = require("../controllers/transactionController");
const { verifyToken, authorizeRole, verifyTokenaccess } = require("../middlewares/authenticate");
/**
 * @swagger
 * tags:
 *   name: Transactions
 *   description: API for managing transaction records.
 */

/**
 * @swagger
 * /transactions:
 *   post:
 *     summary: Create a new transaction
 *     description: Stores a new transaction in the database.
 *     tags:
 *       - Transactions
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - userId
 *               - investmentId
 *               - schemeId
 *               - accountNumber
 *               - orderId
 *               - amount
 *               - currency
 *               - paymentMethod
 *               - paymentStatus
 *               - paymentDate
 *             properties:
 *               userId:
 *                 type: integer
 *                 example: 1
 *               investmentId:
 *                 type: integer
 *                 example: 26
 *               schemeId:
 *                 type: integer
 *                 example: 4
 *               chitId:
 *                 type: integer
 *                 nullable: true
 *                 example: 2
 *               accountNumber:
 *                 type: string
 *                 example: "1234567890"
 *               paymentId:
 *                 type: integer
 *                 nullable: true
 *                 example: 1
 *               orderId:
 *                 type: string
 *                 example: "ORD9876543210"
 *               amount:
 *                 type: number
 *                 example: 20000.00
 *               currency:
 *                 type: string
 *                 example: "INR"
 *               paymentMethod:
 *                 type: string
 *                 example: "UPI"
 *               signature:
 *                 type: string
 *                 nullable: true
 *                 example: "d2a7f8b9c0e1"
 *               paymentStatus:
 *                 type: string
 *                 enum: [Success, Failed, Pending]
 *                 example: "Success"
 *               paymentDate:
 *                 type: string
 *                 format: date-time
 *                 example: "2025-03-01T10:30:00Z"
 *               status:
 *                 type: string
 *                 enum: [paid, paynow, coming soon]
 *                 example: "paid"
 *               gatewayTransactionId:
 *                 type: string
 *                 nullable: true
 *                 example: "GTX87654321"
 *     responses:
 *       201:
 *         description: Transaction created successfully
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 message:
 *                   type: string
 *                   example: "Transaction created successfully"
 *                 transactionId:
 *                   type: integer
 *                   example: 101
 *       400:
 *         description: Invalid input data
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 message:
 *                   type: string
 *                   example: "Invalid request data"
 *       500:
 *         description: Internal server error
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 message:
 *                   type: string
 *                   example: "Internal Server Error"
 */
router.post(
  "/",
  //verifyToken,authorizeRole(['user']),
  transactionController.createTransaction
);
/**
 * @swagger
 * /transactions/export:
 *   get:
 *     summary: Export filtered payment transactions to an Excel file
 *     description: Generates an Excel file containing transactions filtered by date.
 *     parameters:
 *       - in: query
 *         name: startDate
 *         schema:
 *           type: string
 *           format: date
 *         required: true
 *         description: Start date for filtering transactions (YYYY-MM-DD).
 *       - in: query
 *         name: endDate
 *         schema:
 *           type: string
 *           format: date
 *         required: true
 *         description: End date for filtering transactions (YYYY-MM-DD).
 *     responses:
 *       200:
 *         description: Excel file with filtered transactions
 *         content:
 *           application/vnd.openxmlformats-officedocument.spreadsheetml.sheet:
 *             schema:
 *               type: string
 *               format: binary
 *       400:
 *         description: Missing date parameters
 *       404:
 *         description: No transactions found in the given date range
 *       500:
 *         description: Internal server error
 */
router.get("/export",
  // verifyToken,authorizeRole(['Super Admin','Admin']),
   transactionController.exportPayments);


/**
 * @swagger
 * /transactions:
 *   get:
 *     summary: Retrieve all transaction records
 *     tags: [Transactions]
 *     responses:
 *       200:
 *         description: Transactions retrieved successfully.
 *       500:
 *         description: Server error.
 */
router.get("/",
  // verifyToken,authorizeRole(['Super Admin','Admin']),
 transactionController.getAllTransactions);

/**
 * @swagger
 * /transactions/{id}:
 *   get:
 *     summary: Retrieve a transaction record by id
 *     tags: [Transactions]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: The transaction id.
 *     responses:
 *       200:
 *         description: Transaction retrieved successfully.
 *       404:
 *         description: Transaction not found.
 *       500:
 *         description: Server error.
 */
router.get("/:id",
  // verifyToken,authorizeRole(['Super Admin','Admin']), 
  transactionController.getTransactionById);

/**
 * @swagger
 * /transactions/{id}:
 *   put:
 *     summary: Update a transaction record by id
 *     tags: [Transactions]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               userid:
 *                 type: integer
 *               inversementid:
 *                 type: integer
 *               schemeid:
 *                 type: integer
 *               chitid:
 *                 type: integer
 *               installment:
 *                 type: integer
 *               accountnumber:
 *                 type: string
 *               payment_id:
 *                 type: string
 *               order_id:
 *                 type: string
 *               amount:
 *                 type: number
 *               currency:
 *                 type: string
 *               payment_method:
 *                 type: string
 *               signature:
 *                 type: string
 *               payment_status:
 *                 type: string
 *               paymentdate:
 *                 type: string
 *                 format: date-time
 *               status:
 *                 type: string
 *                 enum: [paid, paynow, comming soon]
 *             example:
 *               userid: 1
 *               inversementid: 10
 *               schemeid: 101
 *               chitid: 50
 *               installment: 1
 *               accountnumber: "101"
 *               payment_id: "PAY12345"
 *               order_id: "ORD67890"
 *               amount: 300.50
 *               currency: "USD"
 *               payment_method: "Credit Card"
 *               signature: "newsignature123"
 *               payment_status: "Success"
 *               paymentdate: "2025-03-02T12:00:00Z"
 *               status: "paid"
 *     responses:
 *       200:
 *         description: Transaction updated successfully.
 *       404:
 *         description: Transaction not found.
 *       500:
 *         description: Server error.
 */
router.put("/:id",
  // verifyToken,authorizeRole(['Super Admin','Admin']), 
transactionController.updateTransaction);

/**
 * @swagger
 * /transactions/{id}:
 *   delete:
 *     summary: Delete a transaction record by id
 *     tags: [Transactions]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: The transaction id.
 *     responses:
 *       200:
 *         description: Transaction deleted successfully.
 *       404:
 *         description: Transaction not found.
 *       500:
 *         description: Server error.
 */
router.delete("/:id",
  // verifyToken,authorizeRole(['Super Admin','Admin']),
 transactionController.deleteTransaction);


/**
 * @swagger
 * /filter_transactions:
 *   get:
 *     summary: Get filtered transactions
 *     description: Fetch transactions based on optional filters such as userId, investmentId, schemeId, accountNumber, and chitId. If no filters are provided, returns all transactions.
 *     tags: [Transactions]
 *     parameters:
 *       - in: query
 *         name: userId
 *         schema:
 *           type: integer
 *         required: false
 *         description: Filter transactions by user ID
 *       - in: query
 *         name: investmentId
 *         schema:
 *           type: integer
 *         required: false
 *         description: Filter transactions by investment ID
 *       - in: query
 *         name: schemeId
 *         schema:
 *           type: integer
 *         required: false
 *         description: Filter transactions by scheme ID
 *       - in: query
 *         name: accountNumber
 *         schema:
 *           type: string
 *         required: false
 *         description: Filter transactions by account number
 *       - in: query
 *         name: chitId
 *         schema:
 *           type: integer
 *         required: false
 *         description: Filter transactions by chit ID
 *     responses:
 *       200:
 *         description: Successfully retrieved transaction list
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success:
 *                   type: boolean
 *                   example: true
 *                 data:
 *                   type: array
 *                   items:
 *                     type: object
 *                     properties:
 *                       transactionId:
 *                         type: integer
 *                         example: 101
 *                       userId:
 *                         type: integer
 *                         example: 123
 *                       investmentId:
 *                         type: integer
 *                         example: 456
 *                       schemeId:
 *                         type: integer
 *                         example: 789
 *                       accountNumber:
 *                         type: string
 *                         example: "1234567890"
 *                       chitId:
 *                         type: integer
 *                         example: 321
 *                       status:
 *                         type: string
 *                         example: "Success"
 *       400:
 *         description: Bad request due to invalid parameters
 *       500:
 *         description: Internal server error
 */
router.get("/filter_transactions",
  // verifyToken,authorizeRole(['Super Admin','Admin']),
   transactionController.getTransactions);

module.exports = router;
