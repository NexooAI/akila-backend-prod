// routes/schemeRoutes.js
const express = require("express");
const router = express.Router();
const schemeController = require("../controllers/schemeController");
const upload = require("../upload");
const { verifyToken, authorizeRole } = require("../middlewares/authenticate");
/**
 * @swagger
 * components:
 *   schemas:
 *     Scheme:
 *       type: object
 *       properties:
 *         SCHEMEID:
 *           type: number
 *           description: Auto-generated scheme ID.
 *         SCHEMENAME:
 *           type: string
 *         SCHEMETYPE:
 *           type: string
 *         SCHEMENO:
 *           type: string
 *         REGNO:
 *           type: string
 *         ACTIVE:
 *           type: string
 *         BRANCHID:
 *           type: string
 *         INS_TYPE:
 *           type: string
 *         DESCRIPTION:
 *           type: string
 *         SLOGAN:
 *           type: string
 *         IMAGE:
 *           type: string
 *           description: File path of the uploaded image.
 *         ICON:
 *           type: string
 *           description: File path of the uploaded icon.
 *         created_at:
 *           type: string
 *           format: date-time
 *       required:
 *         - SCHEMENAME
 *         - SCHEMETYPE
 *         - SCHEMENO
 *         - REGNO
 *         - ACTIVE
 *         - BRANCHID
 *         - INS_TYPE
 *
 * tags:
 *   - name: Schemes
 *     description: API for managing schemes
 */

/**
 * @swagger
 * /schemes:
 *   post:
 *     summary: Create a new scheme
 *     description: API endpoint to create a new scheme record with file uploads for image and icon.
 *     tags: [Schemes]
 *     consumes:
 *       - multipart/form-data
 *     requestBody:
 *       required: true
 *       content:
 *         multipart/form-data:
 *           schema:
 *             type: object
 *             required:
 *               - SCHEMENAME
 *               - SCHEMETYPE
 *               - SCHEMENO
 *               - REGNO
 *               - BRANCHID
 *               - INS_TYPE
 *               - duration_months
 *               - scheme_plan_type_id
 *               - payment_frequency_id
 *             properties:
 *               SCHEMENAME:
 *                 type: string
 *                 example: "Gold Investment Plan"
 *               SCHEMETYPE:
 *                 type: string
 *                 enum: [FIXED, FLEXI, Weight]
 *               SCHEMENO:
 *                 type: string
 *                 example: "12345"
 *               REGNO:
 *                 type: string
 *                 example: "REG-98765"
 *               ACTIVE:
 *                 type: string
 *                 enum: [Y, N]
 *                 example: "Y"
 *               BRANCHID:
 *                 type: integer
 *                 example: 2
 *               INS_TYPE:
 *                 type: string
 *                 example: "Gold-based"
 *               DESCRIPTION:
 *                 type: string
 *                 example: "Best gold savings plan"
 *               SLOGAN:
 *                 type: string
 *                 example: "Invest today, secure tomorrow"
 *               type:
 *                 type: string
 *                 enum: [gold, silver]
 *                 example: "gold"
 *               fixed:
 *                 type: number
 *                 format: float
 *                 example: 0.0
 *               duration_months:
 *                 type: integer
 *                 example: 11
 *               scheme_plan_type_id:
 *                 type: integer
 *                 example: 2
 *               payment_frequency_id:
 *                 type: array
 *                 items:
 *                   type: integer
 *                 example: [4]
 *               IMAGE:
 *                 type: string
 *                 format: binary
 *               ICON:
 *                 type: string
 *                 format: binary
 *     responses:
 *       201:
 *         description: Scheme created successfully
 *       400:
 *         description: Bad request due to missing required fields or invalid data
 *       500:
 *         description: Server error
 */
router.post(
  "/",
  upload.fields([
    { name: "IMAGE", maxCount: 1 },
    { name: "ICON", maxCount: 1 },
  ]),
  schemeController.createScheme
);

/**
 * @swagger
 * /schemes:
 *   get:
 *     summary: Retrieve all schemes
 *     description: Retrieve a list of all schemes along with their associated chits and branch details.
 *     tags: [Schemes]
 *     responses:
 *       200:
 *         description: A list of schemes.
 *       500:
 *         description: Server error.
 */
router.get("/", schemeController.getAllSchemes);

/**
 * @swagger
 * /schemes/{id}:
 *   get:
 *     summary: Retrieve a scheme by ID
 *     description: Retrieve a single scheme by its SCHEMEID, including associated chits and branch details.
 *     tags: [Schemes]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: number
 *         description: Scheme ID.
 *     responses:
 *       200:
 *         description: A scheme object.
 *       404:
 *         description: Scheme not found.
 *       500:
 *         description: Server error.
 */
router.get("/:id", schemeController.getSchemeById);

/**
 * @swagger
 * /schemes/{id}:
 *   put:
 *     summary: Update an existing scheme record with optional file uploads.
 *     description: Updates scheme details while preserving existing chit records.
 *     tags: [Schemes]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: Unique ID of the scheme to update.
 *     requestBody:
 *       required: true
 *       content:
 *         multipart/form-data:
 *           schema:
 *             type: object
 *             required:
 *               - SCHEMENAME
 *               - SCHEMETYPE
 *               - duration_months
 *               - scheme_plan_type_id
 *               - payment_frequency_id
 *             properties:
 *               SCHEMENAME:
 *                 type: string
 *                 example: "Gold Investment Plan"
 *               SCHEMETYPE:
 *                 type: string
 *                 enum: [FIXED, FLEXI, Weight]
 *               SCHEMENO:
 *                 type: string
 *                 example: "12345"
 *               REGNO:
 *                 type: string
 *                 example: "REG-98765"
 *               ACTIVE:
 *                 type: string
 *                 enum: [Y, N]
 *               BRANCHID:
 *                 type: integer
 *                 example: 2
 *               INS_TYPE:
 *                 type: string
 *                 example: "Gold-based"
 *               DESCRIPTION:
 *                 type: string
 *                 example: "Best gold savings plan"
 *               SLOGAN:
 *                 type: string
 *                 example: "Invest today, secure tomorrow"
 *               type:
 *                 type: string
 *                 enum: [gold, silver]
 *               fixed:
 *                 type: number
 *                 format: float
 *               duration_months:
 *                 type: integer
 *                 example: 11
 *               scheme_plan_type_id:
 *                 type: integer
 *                 example: 2
 *               payment_frequency_id:
 *                 type: array
 *                 items:
 *                   type: integer
 *                 example: [4]
 *               IMAGE:
 *                 type: string
 *                 format: binary
 *               ICON:
 *                 type: string
 *                 format: binary
 *     responses:
 *       200:
 *         description: Scheme updated successfully.
 *       400:
 *         description: Validation error due to missing fields.
 *       500:
 *         description: Server error while updating scheme.
 */
router.put(
  "/:id",
  upload.fields([
    { name: "IMAGE", maxCount: 1 },
    { name: "ICON", maxCount: 1 },
  ]),
  schemeController.updateScheme
);

/**
 * @swagger
 * /schemes/{id}:
 *   delete:
 *     summary: Delete a scheme
 *     description: Delete a scheme record by its SCHEMEID.
 *     tags: [Schemes]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: number
 *         description: Scheme ID.
 *     responses:
 *       200:
 *         description: Scheme deleted successfully.
 *       500:
 *         description: Server error.
 */
router.delete("/:id", schemeController.deleteScheme);
/**
 * @swagger
 * /schemes/subplan_list:
 *   get:
 *     summary: Get scheme plan list
 *     description: Retrieve all scheme plans, including details like sub-plan types and payment frequencies.
 *     tags:
 *       - Schemes
 *     responses:
 *       200:
 *         description: Successfully retrieved scheme plans
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 status:
 *                   type: integer
 *                   example: 200
 *                 message:
 *                   type: string
 *                   example: "Scheme plans retrieved successfully."
 *                 data:
 *                   type: array
 *                   items:
 *                     type: object
 *                     properties:
 *                       SCHEMEID:
 *                         type: integer
 *                         example: 1
 *                       SCHEMENAME:
 *                         type: string
 *                         example: "Gold Chit Plan"
 *                       SCHEMETYPE:
 *                         type: string
 *                         example: "Monthly"
 *                       DURATION_DAYS:
 *                         type: integer
 *                         example: 30
 *                       PAYMENT_FREQUENCY:
 *                         type: string
 *                         example: "Weekly"
 *       404:
 *         description: No scheme plans found
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 status:
 *                   type: integer
 *                   example: 404
 *                 message:
 *                   type: string
 *                   example: "No scheme plans found."
 *       500:
 *         description: Internal server error
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 status:
 *                   type: integer
 *                   example: 500
 *                 message:
 *                   type: string
 *                   example: "Internal server error while fetching scheme plans."
 */

router.post("/subplan_list", schemeController.getSchemeplan);
// Legacy routes for backward compatibility
router.post(
  "/schemes",
  upload.fields([
    { name: "IMAGE", maxCount: 1 },
    { name: "ICON", maxCount: 1 },
  ]),
  schemeController.createScheme
);

router.get("/schemes", schemeController.getAllSchemes);
router.get("/schemes/:id", schemeController.getSchemeById);

router.put(
  "/schemes/:id",
  upload.fields([
    { name: "IMAGE", maxCount: 1 },
    { name: "ICON", maxCount: 1 },
  ]),
  schemeController.updateScheme
);
router.delete("/schemes/:id", schemeController.deleteScheme);

module.exports = router;