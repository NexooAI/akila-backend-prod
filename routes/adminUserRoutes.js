const express = require("express");
const router = express.Router();
const adminUserController = require("../controllers/adminUserController");
const { verifyToken, authorizeRole } = require("../middlewares/authenticate");

/**
 * @swagger
 * components:
 *   schemas:
 *     AdminUser:
 *       type: object
 *       properties:
 *         id:
 *           type: string
 *           example: "123456"
 *         mobileNumber:
 *           type: string
 *           example: "98928393"
 *         fname:
 *           type: string
 *           example: "John"
 *         lname:
 *           type: string
 *           example: "Doe"
 *         email:
 *           type: string
 *           format: email
 *           example: "john.doe@example.com"
 *         empid:
 *           type: string
 *           example: "EMP12338"
 *         roleId:
 *           type: integer
 *           example: 1
 *         status:
 *           type: string
 *           enum: [active, inactive]
 *           example: "active"
 *         created_at:
 *           type: string
 *           format: date-time
 *         updated_at:
 *           type: string
 *           format: date-time
 */

/**
 * @swagger
 * /admin-users:
 *   get:
 *     summary: Get all admin users
 *     description: Retrieve details of all admin users. Only accessible by Admin and Super Admin roles.
 *     tags: [Admin Users]
 *     security:
 *       - BearerAuth: []
 *     responses:
 *       200:
 *         description: Successfully retrieved all admin users
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 $ref: '#/components/schemas/AdminUser'
 *       401:
 *         description: Unauthorized, missing or invalid token
 *       403:
 *         description: Forbidden, insufficient permissions
 */
router.get("/", verifyToken, authorizeRole(["Admin", "Super Admin"]), adminUserController.getAllAdminUser);

/**
 * @swagger
 * /admin-users/{id}:
 *   get:
 *     summary: Get admin user by ID
 *     description: Retrieve details of a specific admin user by their ID. Only accessible by Admin and Super Admin roles.
 *     tags: [Admin Users]
 *     security:
 *       - BearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: string
 *         description: The unique ID of the admin user
 *     responses:
 *       200:
 *         description: Successfully retrieved the admin user details
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/AdminUser'
 *       400:
 *         description: Invalid ID supplied
 *       401:
 *         description: Unauthorized, missing or invalid token
 *       403:
 *         description: Forbidden, insufficient permissions
 *       404:
 *         description: Admin user not found
 */
router.get("/:id", verifyToken, authorizeRole(["Admin", "Super Admin"]), adminUserController.getAdminUser);

/**
 * @swagger
 * /admin-users:
 *   post:
 *     summary: Create a new admin user
 *     tags: [Admin Users]
 *     security:
 *       - BearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - mobileNumber
 *               - fname
 *               - lname
 *               - email
 *               - password
 *               - empid
 *               - roleId
 *             properties:
 *               mobileNumber:
 *                 type: string
 *                 example: "98928393"
 *               fname:
 *                 type: string
 *                 example: "John"
 *               lname:
 *                 type: string
 *                 example: "Doe"
 *               email:
 *                 type: string
 *                 format: email
 *                 example: "john.doe@example.com"
 *               password:
 *                 type: string
 *                 format: password
 *                 example: "1234"
 *               empid:
 *                 type: string
 *                 example: "EMP12338"
 *               roleId:
 *                 type: integer
 *                 example: 1
 *               status:
 *                 type: string
 *                 enum: [active, inactive]
 *                 example: "active"
 *     responses:
 *       201:
 *         description: Admin user created successfully
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/AdminUser'
 *       400:
 *         description: Bad request, missing or invalid fields
 *       401:
 *         description: Unauthorized, missing or invalid token
 *       403:
 *         description: Forbidden, insufficient permissions
 *       409:
 *         description: Conflict, email already in use
 */
router.post("/", verifyToken, authorizeRole(["Super Admin", "Admin", "Branch Manager"]), adminUserController.createAdminUser);

/**
 * @swagger
 * /admin-users/{id}:
 *   put:
 *     summary: Update an admin user
 *     tags: [Admin Users]
 *     security:
 *       - BearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: string
 *         description: The unique ID of the admin user
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               mobileNumber:
 *                 type: string
 *                 example: "98928393"
 *               fname:
 *                 type: string
 *                 example: "John"
 *               lname:
 *                 type: string
 *                 example: "Doe"
 *               email:
 *                 type: string
 *                 format: email
 *                 example: "john.doe@example.com"
 *               empid:
 *                 type: string
 *                 example: "EMP12338"
 *               roleId:
 *                 type: integer
 *                 example: 1
 *               status:
 *                 type: string
 *                 enum: [active, inactive]
 *                 example: "active"
 *     responses:
 *       200:
 *         description: Admin user updated successfully
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/AdminUser'
 *       400:
 *         description: Bad request, missing or invalid fields
 *       401:
 *         description: Unauthorized, missing or invalid token
 *       403:
 *         description: Forbidden, insufficient permissions
 *       404:
 *         description: Admin user not found
 */
router.put("/:id", verifyToken, authorizeRole(["Super Admin", "Admin"]), adminUserController.updateAdminUser);

/**
 * @swagger
 * /admin-users/{id}/deactivate:
 *   put:
 *     summary: Deactivate an admin user
 *     description: This API deactivates an admin user by updating their status. Requires Super Admin role.
 *     tags: [Admin Users]
 *     security:
 *       - BearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: string
 *         description: The unique ID of the admin user
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - description
 *             properties:
 *               description:
 *                 type: string
 *                 example: "User left the organization"
 *     responses:
 *       200:
 *         description: Admin user deactivated successfully
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/AdminUser'
 *       400:
 *         description: Bad request, missing or invalid fields
 *       401:
 *         description: Unauthorized, missing or invalid token
 *       403:
 *         description: Forbidden, insufficient permissions
 *       404:
 *         description: Admin user not found
 */
router.put("/:id/deactivate", verifyToken, authorizeRole(["Super Admin"]), adminUserController.deactivateAdminUser);

/**
 * @swagger
 * /admin-users/{id}:
 *   delete:
 *     summary: Delete an admin user
 *     description: This API permanently deletes an admin user. Requires Super Admin role.
 *     tags: [Admin Users]
 *     security:
 *       - BearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: string
 *         description: The unique ID of the admin user
 *     responses:
 *       200:
 *         description: Admin user deleted successfully
 *       401:
 *         description: Unauthorized, missing or invalid token
 *       403:
 *         description: Forbidden, insufficient permissions
 *       404:
 *         description: Admin user not found
 */
router.delete("/:id", verifyToken, authorizeRole(["Super Admin"]), adminUserController.deleteAdminUser);

module.exports = router;
