const express = require("express");
const router = express.Router();
const policyController = require("../controllers/policyController");
const { verifyToken, authorizeRole } = require("../middlewares/authenticate");
/**
 * @swagger
 * components:
 *   schemas:
 *     Policy:
 *       type: object
 *       properties:
 *         id:
 *           type: number
 *         type:
 *           type: string
 *           description: Policy type (e.g., "terms_and_conditions", "privacy_policy").
 *         title:
 *           type: string
 *         subtitle:
 *           type: string
 *         description:
 *           type: string
 *         created_at:
 *           type: string
 *           format: date-time
 *         updated_at:
 *           type: string
 *           format: date-time
 *       required:
 *         - type
 *         - title
 *         - description
 *
 * tags:
 *   - name: Policies
 *     description: API for managing policies
 */

/**
 * @swagger
 * /policies:
 *   post:
 *     summary: Create a new policy record
 *     tags: [Policies]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/Policy'
 *     responses:
 *       201:
 *         description: Policy created successfully.
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 message:
 *                   type: string
 *                   example: "Policy created successfully"
 *                 data:
 *                   $ref: '#/components/schemas/Policy'
 *       500:
 *         description: Server error.
 */
router.post(
  "/",
  verifyToken,
  authorizeRole(["Admin", "Super Admin", "user"]),
  policyController.createPolicy
);

/**
 * @swagger
 * /policies:
 *   get:
 *     summary: Retrieve all policy records
 *     tags: [Policies]
 *     responses:
 *       200:
 *         description: A list of policies.
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 data:
 *                   type: array
 *                   items:
 *                     $ref: '#/components/schemas/Policy'
 *       500:
 *         description: Server error.
 */
router.get(
  "/",
  verifyToken,
  authorizeRole(["Admin", "Super Admin", "Branch Manager", "user"]),
  policyController.getAllPolicies
);

/**
 * @swagger
 * /policies/type/{type}:
 *   get:
 *     summary: Retrieve policies filtered by type
 *     tags: [Policies]
 *     parameters:
 *       - in: path
 *         name: type
 *         required: true
 *         schema:
 *           type: string
 *         description: The type of policy (e.g., "terms_and_conditions", "privacy_policy")
 *     responses:
 *       200:
 *         description: A list of policies filtered by type.
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 data:
 *                   type: array
 *                   items:
 *                     $ref: '#/components/schemas/Policy'
 *       500:
 *         description: Server error.
 */
router.get(
  "/type/:type",
  verifyToken,
  authorizeRole(["Admin", "Super Admin", "Branch Manager", "user"]),
  policyController.getPoliciesByType
);

/**
 * @swagger
 * /policies/{id}:
 *   get:
 *     summary: Retrieve a policy record by ID
 *     tags: [Policies]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: number
 *         description: The policy record ID.
 *     responses:
 *       200:
 *         description: Policy record found.
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Policy'
 *       404:
 *         description: Policy record not found.
 *       500:
 *         description: Server error.
 */
router.get(
  "/:id",
  verifyToken,
  authorizeRole(["Admin", "Super Admin", "Branch Manager", "user"]),
  policyController.getPolicyById
);

/**
 * @swagger
 * /policies/{id}:
 *   put:
 *     summary: Update a policy record by ID
 *     tags: [Policies]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: number
 *         description: The policy record ID.
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/Policy'
 *     responses:
 *       200:
 *         description: Policy updated successfully.
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 message:
 *                   type: string
 *                   example: "Policy updated successfully"
 *       500:
 *         description: Server error.
 */
router.put(
  "/:id",
  verifyToken,
  authorizeRole(["Admin", "Super Admin"]),
  policyController.updatePolicy
);

/**
 * @swagger
 * /policies/{id}:
 *   delete:
 *     summary: Delete a policy record by ID
 *     tags: [Policies]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: number
 *         description: The policy record ID.
 *     responses:
 *       200:
 *         description: Policy deleted successfully.
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 message:
 *                   type: string
 *                   example: "Policy deleted successfully"
 *       500:
 *         description: Server error.
 */
router.delete(
  "/:id",
  verifyToken,
  authorizeRole(["Admin", "Super Admin"]),
  policyController.deletePolicy
);

module.exports = router;
