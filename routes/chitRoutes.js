// routes/chitRoutes.js
const express = require("express");
const router = express.Router();
const chitController = require("../controllers/chitController");
const { verifyToken, authorizeRole } = require("../middlewares/authenticate");
/**
 * @swagger
 * components:
 *   schemas:
 *     Chit:
 *       type: object
 *       properties:
 *         CHITID:
 *           type: string
 *           description: Unique chit identifier.
 *         SCHEMEID:
 *           type: string
 *           description: Identifier for the scheme.
 *         AMOUNT:
 *           type: number
 *           description: Amount of the chit.
 *         NOINS:
 *           type: number
 *           description: Number of installments.
 *         TOTALMEMBERS:
 *           type: number
 *           description: Total number of members in the chit.
 *         REGNO:
 *           type: string
 *           description: Registration number.
 *         ACTIVE:
 *           type: string
 *           description: Indicates if the chit is active ("Y" or "N").
 *         METID:
 *           type: string
 *           description: Meeting or meta identifier.
 *         GROUPCODE:
 *           type: string
 *           description: Group code associated with the chit.
 *       example:
 *         CHITID: "C001"
 *         SCHEMEID: "S001"
 *         AMOUNT: 10000
 *         NOINS: 10
 *         TOTALMEMBERS: 15
 *         REGNO: "R001"
 *         ACTIVE: "Y"
 *         METID: "M001"
 *         GROUPCODE: "G001"
 */

/**
 * @swagger
 * tags:
 *   name: Chits
 *   description: API for managing chits
 */

/**
 * @swagger
 * /chits:
 *   post:
 *     summary: Create a new chit
 *     tags: [Chits]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/Chit'
 *     responses:
 *       201:
 *         description: Chit created successfully
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 CHITID:
 *                   type: string
 *                   example: "C001"
 *                 message:
 *                   type: string
 *                   example: "Chit created successfully"
 *       500:
 *         description: Server error
 */
router.post("/", 
    //verifyToken,authorizeRole(["Super Admin"]),
    chitController.createChit);

/**
 * @swagger
 * /chits:
 *   get:
 *     summary: Retrieve all chits
 *     tags: [Chits]
 *     responses:
 *       200:
 *         description: A list of chits
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 $ref: '#/components/schemas/Chit'
 *       500:
 *         description: Server error
 */
router.get("/",
    //verifyToken,authorizeRole(["Super Admin","Admin","Branch Manager","user"]) ,
    chitController.getAllChits);

/**
 * @swagger
 * /chits/{id}:
 *   get:
 *     summary: Retrieve a single chit by CHITID
 *     tags: [Chits]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: string
 *         description: Chit's unique identifier (CHITID)
 *     responses:
 *       200:
 *         description: Chit found
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Chit'
 *       404:
 *         description: Chit not found
 *       500:
 *         description: Server error
 */
router.get("/:id",
    //verifyToken,authorizeRole(["Super Admin","Admin","Branch Manager","user"]), 
    chitController.getChitById);

/**
 * @swagger
 * /chits/{id}:
 *   put:
 *     summary: Update an existing chit
 *     tags: [Chits]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: string
 *         description: Chit's unique identifier (CHITID)
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/Chit'
 *     responses:
 *       200:
 *         description: Chit updated successfully
 *       500:
 *         description: Server error
 */
router.put("/:id",
   // verifyToken,authorizeRole(["Super Admin"]), 
    chitController.updateChit);

/**
 * @swagger
 * /chits/{id}:
 *   delete:
 *     summary: Delete a chit by CHITID
 *     tags: [Chits]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: string
 *         description: Chit's unique identifier (CHITID)
 *     responses:
 *       200:
 *         description: Chit deleted successfully
 *       500:
 *         description: Server error
 */
router.delete("/:id",verifyToken,authorizeRole(["Super Admin"]),chitController.deleteChit);

module.exports = router;