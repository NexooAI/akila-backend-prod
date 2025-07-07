const express = require("express");
const router = express.Router();
const paymentController = require("../controllers/paymentController");
const { verifyToken, authorizeRole, verifyTokenaccess } = require("../middlewares/authenticate");

/**
 * @swagger
 * components:
 *   schemas:
 *     Payment:
 *       type: object
 *       properties:
 *         id:
 *           type: integer
 *           example: 1
 *         investmentId:
 *           type: integer
 *           example: 26
 *         paymentAmount:
 *           type: number
 *           format: float
 *           example: 20000.00
 *         userId:
 *           type: integer
 *           example: 1
 *         paymentMethod:
 *           type: string
 *           enum: ["UPI", "NetBanking", "CreditCard", "DebitCard"]
 *           example: "UPI"
 *         schemeId:
 *           type: integer
 *           example: 4
 *         transactionId:
 *           type: string
 *           example: "XXXXRCYYYYMMDD########"
 *         createdAt:
 *           type: string
 *           format: date-time
 *           example: "2025-03-16T14:30:00Z"
 *   securitySchemes:
 *     bearerAuth:
 *       type: http
 *       scheme: bearer
 *       bearerFormat: JWT
 * 
 * tags:
 *   - name: Payments
 *     description: API for managing payment records
 */

/**
 * @swagger
 * /payments/initiate:
 *   post:
 *     summary: Initiate a new payment
 *     tags: [Payments]
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - investmentId
 *               - amount
 *               - paymentMethod
 *             properties:
 *               investmentId:
 *                 type: integer
 *                 example: 26
 *               amount:
 *                 type: number
 *                 format: float
 *                 example: 20000.00
 *               paymentMethod:
 *                 type: string
 *                 enum: ["UPI", "NetBanking", "CreditCard", "DebitCard"]
 *                 example: "UPI"
 *     responses:
 *       200:
 *         description: Payment initiated successfully
 *       401:
 *         description: Unauthorized
 *       500:
 *         description: Server error
 */
router.post('/initiate', 
// verifyToken, authorizeRole(['user']),
 paymentController.initiatePayment);

/**
 * @swagger
 * /payments/status:
 *   post:
 *     summary: Handle payment gateway response
 *     tags: [Payments]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               status:
 *                 type: string
 *                 example: "SUCCESS"
 *               transactionId:
 *                 type: string
 *                 example: "XXXXRCYYYYMMDD########"
 *     responses:
 *       200:
 *         description: Payment status updated successfully
 *       500:
 *         description: Server error
 */
router.post('/status', paymentController.handleJuspayResponse);

/**
 * @swagger
 * /payments/user:
 *   get:
 *     summary: Get payments for a specific user with filters and pagination
 *     tags: [Payments]
 *     parameters:
 *       - in: query
 *         name: userId
 *         required: true
 *         schema:
 *           type: integer
 *         description: User ID to get payments for
 *         example: 1
 *       - in: query
 *         name: status
 *         schema:
 *           type: string
 *           enum: ["success", "pending", "failed", "CHARGED", "PENDING", "FAILED"]
 *         description: Filter by payment status
 *         example: "success"
 *       - in: query
 *         name: paymentMethod
 *         schema:
 *           type: string
 *           enum: ["UPI", "NetBanking", "CreditCard", "DebitCard", "Cash"]
 *         description: Filter by payment method
 *         example: "UPI"
 *       - in: query
 *         name: schemeId
 *         schema:
 *           type: integer
 *         description: Filter by scheme ID
 *         example: 4
 *       - in: query
 *         name: investmentId
 *         schema:
 *           type: integer
 *         description: Filter by investment ID
 *         example: 26
 *       - in: query
 *         name: startDate
 *         schema:
 *           type: string
 *           format: date
 *         description: Filter payments from this date (YYYY-MM-DD)
 *         example: "2024-01-01"
 *       - in: query
 *         name: endDate
 *         schema:
 *           type: string
 *           format: date
 *         description: Filter payments until this date (YYYY-MM-DD)
 *         example: "2024-12-31"
 *       - in: query
 *         name: minAmount
 *         schema:
 *           type: number
 *           format: float
 *         description: Filter payments with minimum amount
 *         example: 1000.00
 *       - in: query
 *         name: maxAmount
 *         schema:
 *           type: number
 *           format: float
 *         description: Filter payments with maximum amount
 *         example: 50000.00
 *       - in: query
 *         name: limit
 *         schema:
 *           type: integer
 *           minimum: 1
 *           maximum: 100
 *         description: Number of records to return (default 50)
 *         example: 20
 *       - in: query
 *         name: offset
 *         schema:
 *           type: integer
 *           minimum: 0
 *         description: Number of records to skip (default 0)
 *         example: 0
 *       - in: query
 *         name: sortBy
 *         schema:
 *           type: string
 *           enum: ["created_at", "payment_date", "amount", "payment_status", "monthNumber"]
 *         description: Field to sort by (default created_at)
 *         example: "payment_date"
 *       - in: query
 *         name: sortOrder
 *         schema:
 *           type: string
 *           enum: ["ASC", "DESC"]
 *         description: Sort order (default DESC)
 *         example: "DESC"
 *     responses:
 *       200:
 *         description: List of user payments with pagination info
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
 *                       id:
 *                         type: integer
 *                         example: 1
 *                       investment_id:
 *                         type: integer
 *                         example: 26
 *                       user_id:
 *                         type: integer
 *                         example: 1
 *                       amount:
 *                         type: number
 *                         format: float
 *                         example: 20000.00
 *                       payment_status:
 *                         type: string
 *                         example: "success"
 *                       payment_method:
 *                         type: string
 *                         example: "UPI"
 *                       transaction_id:
 *                         type: string
 *                         example: "XXXXRCYYYYMMDD########"
 *                       payment_date:
 *                         type: string
 *                         format: date-time
 *                         example: "2025-03-16T14:30:00Z"
 *                       monthNumber:
 *                         type: integer
 *                         example: 1
 *                       schemeName:
 *                         type: string
 *                         example: "Gold Scheme"
 *                       schemeType:
 *                         type: string
 *                         example: "gold"
 *                       schemeDisplayName:
 *                         type: string
 *                         example: "Premium Gold Plan"
 *                 pagination:
 *                   type: object
 *                   properties:
 *                     total:
 *                       type: integer
 *                       example: 150
 *                     limit:
 *                       type: integer
 *                       example: 20
 *                     offset:
 *                       type: integer
 *                       example: 0
 *                     hasMore:
 *                       type: boolean
 *                       example: true
 *                 filters:
 *                   type: object
 *                   description: Applied filters
 *                 status:
 *                   type: integer
 *                   example: 200
 *       400:
 *         description: Bad request - User ID required
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success:
 *                   type: boolean
 *                   example: false
 *                 message:
 *                   type: string
 *                   example: "User ID is required. Please provide userId in query parameters."
 *       500:
 *         description: Server error
 */
router.get('/user', 
// verifyToken,
 paymentController.getPaymentsByUser);

/**
 * @swagger
 * /payments:
 *   post:
 *     summary: Create a new payment record
 *     tags: [Payments]
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/Payment'
 *     responses:
 *       201:
 *         description: Payment created successfully
 *       401:
 *         description: Unauthorized
 *       500:
 *         description: Server error
 *   get:
 *     summary: Get all payments
 *     tags: [Payments]
 *     security:
 *       - bearerAuth: []
 *     responses:
 *       200:
 *         description: List of all payments
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 $ref: '#/components/schemas/Payment'
 *       401:
 *         description: Unauthorized
 *       500:
 *         description: Server error
 */
router.post('/', 
// verifyToken, 
paymentController.createPayment);
router.get('/', 
// verifyToken,
 paymentController.getAllPayments);

/**
 * @swagger
 * /payments/{id}:
 *   get:
 *     summary: Get payment by ID
 *     tags: [Payments]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: Payment ID
 *     responses:
 *       200:
 *         description: Payment details
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Payment'
 *       401:
 *         description: Unauthorized
 *       404:
 *         description: Payment not found
 *       500:
 *         description: Server error
 *   put:
 *     summary: Update payment by ID
 *     tags: [Payments]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: Payment ID
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/Payment'
 *     responses:
 *       200:
 *         description: Payment updated successfully
 *       401:
 *         description: Unauthorized
 *       404:
 *         description: Payment not found
 *       500:
 *         description: Server error
 *   delete:
 *     summary: Delete payment by ID
 *     tags: [Payments]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: Payment ID
 *     responses:
 *       200:
 *         description: Payment deleted successfully
 *       401:
 *         description: Unauthorized
 *       404:
 *         description: Payment not found
 *       500:
 *         description: Server error
 */
router.get('/:id',
//  verifyToken,
 paymentController.getPaymentById);
router.put('/:id', 
// verifyToken,
 paymentController.updatePayment);
router.delete('/:id',
//  verifyToken,
 paymentController.deletePayment);

 router.post('/ccavenue_initiate-payment', paymentController.ccinitiatePayment);
  router.all('/ccavenue_paymentresponse', paymentController.ccavenueresponse);

module.exports = router;
