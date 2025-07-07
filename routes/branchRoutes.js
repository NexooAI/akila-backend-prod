// routes/branchRoutes.js
const express = require("express");
const router = express.Router();
const branchController = require("../controllers/branchController");
const { verifyToken, authorizeRole } = require("../middlewares/authenticate");
/**
 * @swagger
 * components:
 *   schemas:
 *     Branch:
 *       type: object
 *       properties:
 *         id:
 *           type: integer
 *           description: Auto-generated unique identifier
 *         branchid:
 *           type: string
 *           description: Custom branch identifier
 *         branch_name:
 *           type: string
 *           description: Name of the branch
 *         address:
 *           type: string
 *           description: Branch address
 *         city:
 *           type: string
 *           description: City where the branch is located
 *         state:
 *           type: string
 *           description: State where the branch is located
 *         country:
 *           type: string
 *           description: Country (default is India)
 *           default: India
 *         phone:
 *           type: string
 *           description: Contact phone number
 *         active:
 *           type: string
 *           description: Branch status (Y for active, N for inactive)
 *           default: Y
 *       example:
 *         id: 1
 *         branchid: "BR001"
 *         branch_name: "Main Branch"
 *         address: "123 Main Street"
 *         city: "Mumbai"
 *         state: "Maharashtra"
 *         country: "India"
 *         phone: "1234567890"
 *         active: "Y"
 */

/**
 * @swagger
 * tags:
 *   name: Branches
 *   description: API for managing branches
 */

/**
 * @swagger
 * /branches:
 *   post:
 *     summary: Create a new branch
 *     tags: [Branches]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               branchid:
 *                 type: string
 *                 example: "BR001"
 *               branch_name:
 *                 type: string
 *                 example: "Main Branch"
 *               address:
 *                 type: string
 *                 example: "123 Main Street"
 *               city:
 *                 type: string
 *                 example: "Mumbai"
 *               state:
 *                 type: string
 *                 example: "Maharashtra"
 *               country:
 *                 type: string
 *                 example: "India"
 *               phone:
 *                 type: string
 *                 example: "1234567890"
 *               active:
 *                 type: string
 *                 example: "Y"
 *     responses:
 *       201:
 *         description: Branch created successfully
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 id:
 *                   type: integer
 *                   example: 1
 *                 message:
 *                   type: string
 *                   example: Branch created successfully
 *       500:
 *         description: Server error
 */
router.post("/",
    // verifyToken,authorizeRole(["Admin", "Super Admin"]), 
    branchController.createBranch);

/**
 * @swagger
 * /branches:
 *   get:
 *     summary: Retrieve all branches
 *     tags: [Branches]
 *     responses:
 *       200:
 *         description: A list of branches
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 $ref: '#/components/schemas/Branch'
 *       500:
 *         description: Server error
 */
router.get("/",
    // verifyToken,authorizeRole(["Admin", "Super Admin","Branch Manager","Sales Executive","user"]), 
    branchController.getAllBranches);

/**
 * @swagger
 * /branches/{id}:
 *   get:
 *     summary: Retrieve a branch by its id
 *     tags: [Branches]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: Branch id
 *     responses:
 *       200:
 *         description: Branch found
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Branch'
 *       404:
 *         description: Branch not found
 *       500:
 *         description: Server error
 */
router.get("/:id",
    // verifyToken,authorizeRole(["Admin", "Super Admin","Branch Manager","Sales Executive","user"]), 
branchController.getBranchById);

/**
 * @swagger
 * /branches/{id}:
 *   put:
 *     summary: Update an existing branch
 *     tags: [Branches]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: Branch id
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               branchid:
 *                 type: string
 *                 example: "BR001"
 *               branch_name:
 *                 type: string
 *                 example: "Main Branch Updated"
 *               address:
 *                 type: string
 *                 example: "456 Secondary Street"
 *               city:
 *                 type: string
 *                 example: "Pune"
 *               state:
 *                 type: string
 *                 example: "Maharashtra"
 *               country:
 *                 type: string
 *                 example: "India"
 *               phone:
 *                 type: string
 *                 example: "0987654321"
 *               active:
 *                 type: string
 *                 example: "N"
 *     responses:
 *       200:
 *         description: Branch updated successfully
 *       500:
 *         description: Server error
 */
router.put("/:id",
    // verifyToken,authorizeRole(["Admin", "Super Admin"]), 
    branchController.updateBranch);

/**
 * @swagger
 * /branches/{id}:
 *   delete:
 *     summary: Delete a branch by its id
 *     tags: [Branches]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: Branch id
 *     responses:
 *       200:
 *         description: Branch deleted successfully
 *       500:
 *         description: Server error
 */
router.delete("/:id",
    // verifyToken,authorizeRole(["Admin", "Super Admin"]), 
    branchController.deleteBranch);

module.exports = router;
