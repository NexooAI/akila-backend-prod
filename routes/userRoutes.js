const express = require("express");
const router = express.Router();
const userController = require("../controllers/userController");
const authenticateToken = require("../middlewares/authenticate");
const { verifyToken, authorizeRole } = require("../middlewares/authenticate");
// ----- Swagger Components & Endpoints ----- //

/**
 * @swagger
 * components:
 *   schemas:
 *     User:
 *       type: object
 *       properties:
 *         name:
 *           type: string
 *         email:
 *           type: string
 *         mobile_number:
 *           type: string
 *         referred_by:
 *          type: string
 *       required:
 *         - name
 *         - email
 *         - mobile_number
 *
 *     AggregatedUserData:
 *       type: object
 *       properties:
 *         user:
 *           $ref: '#/components/schemas/User'
 *         kyc_data:
 *           type: object
 *           description: KYC details for the user.
 *         investment_data:
 *           type: array
 *           description: List of investments for the user, each including nested scheme and chit data.
 *           items:
 *             type: object
 *
 * tags:
 *   - name: User
 *     description: User management endpoints
 *   - name: UserData
 *     description: Aggregated user data (includes KYC and investments)
 */

/**
 * @swagger
 * /users:
 *   post:
 *     summary: Create a new user
 *     tags: [User]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/User'
 *     responses:
 *       201:
 *         description: User created successfully.
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 message:
 *                   type: string
 *                 data:
 *                   $ref: '#/components/schemas/User'
 *       500:
 *         description: Server error.
 */
router.post("/users", userController.createUser);

/**
 * @swagger
 * /users:
 *   get:
 *     summary: Get all users
 *     tags: [User]
 *     security:
 *       - bearerAuth: []
 *     responses:
 *       200:
 *         description: A list of users.
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 data:
 *                   type: array
 *                   items:
 *                     $ref: '#/components/schemas/User'
 *       500:
 *         description: Server error.
 */
router.get(
  "/users",
  verifyToken,
  authorizeRole([
    "Admin",
    "Super Admin",
    "Branch Manager",
    "Sales Executive",
    "user",
  ]),
  userController.getUsers
);

/**
 * @swagger
 * /users/{user_id}:
 *   get:
 *     summary: Get a single user by ID
 *     tags: [User]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: user_id
 *         required: true
 *         schema:
 *           type: integer
 *         description: The ID of the user.
 *     responses:
 *       200:
 *         description: User details returned successfully.
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/User'
 *       404:
 *         description: User not found.
 *       500:
 *         description: Server error.
 */
router.get(
  "/users/:user_id",
  verifyToken,
  authorizeRole([
    "Admin",
    "Super Admin",
    "Branch Manager",
    "Sales Executive",
    "user",
  ]),
  userController.getUserById
);

/**
 * @swagger
 * /users/{user_id}:
 *   put:
 *     summary: Update a user by ID
 *     tags: [User]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: user_id
 *         required: true
 *         schema:
 *           type: integer
 *         description: The ID of the user to update.
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/User'
 *     responses:
 *       200:
 *         description: User updated successfully.
 *       500:
 *         description: Server error.
 */
router.put(
  "/users/:user_id",
  verifyToken,
  authorizeRole(["user"]),
  userController.updateUser
);

/**
 * @swagger
 * /users/{user_id}:
 *   delete:
 *     summary: Delete a user by ID
 *     tags: [User]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: user_id
 *         required: true
 *         schema:
 *           type: integer
 *         description: The ID of the user to delete.
 *     responses:
 *       200:
 *         description: User deleted successfully.
 *       500:
 *         description: Server error.
 */
router.delete(
  "/users/:user_id",
  verifyToken,
  authorizeRole(["user"]),
  userController.deleteUser
);

/**
 * @swagger
 * /userdata/{user_id}:
 *   get:
 *     summary: Get aggregated user data including KYC and investment details
 *     tags: [UserData]
 *     parameters:
 *       - in: path
 *         name: user_id
 *         required: true
 *         schema:
 *           type: integer
 *         description: The ID of the user for whom to retrieve aggregated data.
 *     responses:
 *       200:
 *         description: Aggregated user data returned successfully.
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/AggregatedUserData'
 *       404:
 *         description: User not found.
 *       500:
 *         description: Server error.
 */
router.get(
  "/userdata/:user_id",
  verifyToken,
  authorizeRole([
    "Admin",
    "Super Admin",
    "Branch Manager",
    "Sales Executive",
    "user",
  ]),
  userController.getUserAggregatedData
);
/**
 * @swagger
 * /search_users:
 *   post:
 *     summary: Search users by mobile number
 *     tags: [Users]
 *     security:
 *       - BearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               mobile_number:
 *                 type: string
 *                 example: "9876543210"
 *                 description: Mobile number (must be a 10-digit string)
 *     responses:
 *       200:
 *         description: Users fetched successfully
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 message:
 *                   type: string
 *                   example: "Users fetched successfully"
 *                 data:
 *                   type: array
 *                   items:
 *                     type: object
 *                     properties:
 *                       id:
 *                         type: integer
 *                       email:
 *                         type: string
 *                         format: email
 *                       mobile_number:
 *                         type: string
 *                       created_at:
 *                         type: string
 *                         format: date-time
 *                       name:
 *                         type: string
 *                       referral_code:
 *                         type: string
 *                       kyc_status:
 *                         type: string
 *                       kyc_data:
 *                         type: object
 *                         description: User KYC data if available
 *       400:
 *         description: Invalid mobile number format
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 error:
 *                   type: string
 *                   example: "Invalid mobile number format. It must be a 10-digit string."
 *       404:
 *         description: No user found
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 error:
 *                   type: string
 *                   example: "No user found with the provided mobile number."
 *       500:
 *         description: Internal server error
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 error:
 *                   type: string
 *                   example: "Failed to fetch users"
 */

router.post(
  "/search_users",
  verifyToken,
  authorizeRole([
    "Admin",
    "Super Admin",
    "Branch Manager",
    "Sales Executive",
    "user",
  ]),
  userController.searchUsers
);
module.exports = router;
