// routes/authRoutes.js
const express = require("express");
const router = express.Router();
const roleController = require("../controllers/roleController");
const { verifyToken, authorizeRole } = require("../middlewares/authenticate");
/**
 * @swagger
 * tags:
 *   name: Authentication
 *   description: User authentication endpoints
 */

/**
 * @swagger
 * /auth/role:
 *   post:
 *     summary: Create a new role
 *     tags: [Roles]
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               roleName:
 *                 type: string
 *                 example: "Admin"
 *               description:
 *                 type: string
 *                 example: "Has full access to the system"
 *     responses:
 *       201:
 *         description: Role created successfully
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 id:
 *                   type: integer
 *                   example: 1
 *                 roleName:
 *                   type: string
 *                   example: "Admin"
 *                 description:
 *                   type: string
 *                   example: "Has full access to the system"
 *       400:
 *         description: Invalid request data
 *       401:
 *         description: Unauthorized - Token is missing or invalid
 *       403:
 *         description: Forbidden - Only Super Admin can create roles
 */

router.post("/auth/role", verifyToken, authorizeRole(["Super Admin"]), roleController.createRole);
/**
 * @swagger
 * /auth/role:
 *   get:
 *     summary: Retrieve all roles
 *     tags: [Roles]
 *     security:
 *       - bearerAuth: []
 *     responses:
 *       200:
 *         description: List of all roles
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 type: object
 *                 properties:
 *                   id:
 *                     type: integer
 *                     example: 1
 *                   roleName:
 *                     type: string
 *                     example: "Admin"
 *                   description:
 *                     type: string
 *                     example: "Has full access to the system"
 *       401:
 *         description: Unauthorized - Token is missing or invalid
 */
router.get("/auth/role", verifyToken, roleController.getAllRoles);
/**
 * @swagger
 * /auth/role/{id}:
 *   delete:
 *     summary: Delete a role by ID
 *     tags: [Roles]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: The ID of the role to be deleted
 *     responses:
 *       200:
 *         description: Role deleted successfully
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 message:
 *                   type: string
 *                   example: "Role deleted successfully"
 *       400:
 *         description: Invalid role ID
 *       401:
 *         description: Unauthorized - Token is missing or invalid
 *       403:
 *         description: Forbidden - User does not have permission
 *       404:
 *         description: Role not found
 */

router.delete("/auth/role/:id", verifyToken, authorizeRole(["Super Admin"]), roleController.deleteRole);
/**
 * @swagger
 * auth/role/assign-permissions:
 *   post:
 *     summary: Assign multiple permissions to a role
 *     tags: [Roles]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               roleId:
 *                 type: integer
 *                 example: 1
 *               permissionIds:
 *                 type: array
 *                 items:
 *                   type: integer
 *                 example: [1, 2, 3]
 *     responses:
 *       200:
 *         description: Permissions assigned successfully
 */
router.post("/auth/role/assign-permissions", verifyToken, authorizeRole(["Super Admin"]), roleController.assignPermissionToRole);
/**
 * @swagger
 * /auth/{roleId}/permissions:
 *   get:
 *     summary: Get permissions assigned to a role
 *     tags: [Roles]
 *     parameters:
 *       - in: path
 *         name: roleId
 *         required: true
 *         schema:
 *           type: integer
 *         example: 1
 *     responses:
 *       200:
 *         description: Role permissions retrieved successfully
 */
router.get("/auth/:roleId/permissions", verifyToken, roleController.getRolePermissions);
module.exports = router;
