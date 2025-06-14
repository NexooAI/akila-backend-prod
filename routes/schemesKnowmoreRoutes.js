const express = require("express");
const router = express.Router();
const schemeKnowmoreController = require("../controllers/schemesKnowmoreController");
const upload = require("../upload"); // Make sure this exports a configured Multer instance
const { verifyToken, authorizeRole } = require("../middlewares/authenticate");
/**
 * @swagger
 * tags:
 *   name: schemesknowmore
 *   description: API for managing schemesknowmore records with image uploads.
 */

/**
 * @swagger
 * /schemesknowmore:
 *   post:
 *     summary: Create a new schemeKnowmore record
 *     tags: [schemesknowmore]
 *     consumes:
 *       - multipart/form-data
 *     requestBody:
 *       content:
 *         multipart/form-data:
 *           schema:
 *             type: object
 *             required:
 *               - scheme_id
 *               - title
 *             properties:
 *               scheme_id:
 *                 type: integer
 *               title:
 *                 type: string
 *               subtitle:
 *                 type: string
 *               description:
 *                 type: string
 *               image:
 *                 type: string
 *                 format: binary
 *               status:
 *                 type: string
 *                 enum: [active, inactive]
 *             example:
 *               scheme_id: 1001
 *               title: "Premium Gold Plan"
 *               subtitle: "Exclusive Benefits"
 *               description: "This scheme offers premium benefits."
 *               status: "active"
 *     responses:
 *       201:
 *         description: SchemeKnowmore created successfully.
 *       500:
 *         description: Server error.
 */
router.post(
  "/schemesknowmore",verifyToken,authorizeRole(["Super Admin"]),
  upload.single("image"),
  schemeKnowmoreController.createSchemeKnowmore
);

/**
 * @swagger
 * /schemesknowmore:
 *   get:
 *     summary: Retrieve all schemesknowmore records
 *     tags: [schemesknowmore]
 *     responses:
 *       200:
 *         description: schemesknowmore fetched successfully.
 *       500:
 *         description: Server error.
 */
router.get("/schemesknowmore",verifyToken,authorizeRole(["Admin", "Super Admin","Branch Manager","Sales Executive","user"]), schemeKnowmoreController.getAllSchemeKnowmore);

/**
 * @swagger
 * /schemesknowmore/{id}:
 *   get:
 *     summary: Retrieve a schemeKnowmore record by primary key id
 *     tags: [schemesknowmore]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         description: The primary key id.
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: SchemeKnowmore fetched successfully.
 *       404:
 *         description: SchemeKnowmore not found.
 *       500:
 *         description: Server error.
 */
router.get(
  "/schemesknowmore/:id",verifyToken,authorizeRole(["Admin", "Super Admin","Branch Manager","Sales Executive","user"]),
  schemeKnowmoreController.getSchemeKnowmoreById
);

/**
 * @swagger
 * /schemesknowmore/scheme/{scheme_id}:
 *   get:
 *     summary: Retrieve schemesknowmore records by scheme_id
 *     tags: [schemesknowmore]
 *     parameters:
 *       - in: path
 *         name: scheme_id
 *         required: true
 *         description: The scheme identifier.
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: SchemeKnowmore details retrieved successfully.
 *       404:
 *         description: No SchemeKnowmore found for this scheme_id.
 *       500:
 *         description: Server error.
 */
router.get(
  "/schemesknowmore/scheme/:scheme_id",verifyToken,authorizeRole(["Admin", "Super Admin","Branch Manager","Sales Executive","user"]),
  schemeKnowmoreController.getSchemeKnowmoreBySchemeId
);

/**
 * @swagger
 * /schemesknowmore/{id}:
 *   put:
 *     summary: Update a schemeKnowmore record by primary key id
 *     tags: [schemesknowmore]
 *     consumes:
 *       - multipart/form-data
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         description: The primary key id.
 *         schema:
 *           type: integer
 *     requestBody:
 *       content:
 *         multipart/form-data:
 *           schema:
 *             type: object
 *             properties:
 *               scheme_id:
 *                 type: integer
 *               title:
 *                 type: string
 *               subtitle:
 *                 type: string
 *               description:
 *                 type: string
 *               image:
 *                 type: string
 *                 format: binary
 *               status:
 *                 type: string
 *                 enum: [active, inactive]
 *             example:
 *               scheme_id: 1001
 *               title: "Updated Scheme Title"
 *               subtitle: "Updated Subtitle"
 *               description: "Updated description."
 *               status: "inactive"
 *     responses:
 *       200:
 *         description: SchemeKnowmore updated successfully.
 *       404:
 *         description: SchemeKnowmore not found.
 *       500:
 *         description: Server error.
 */
router.put(
  "/schemesknowmore/:id",verifyToken,authorizeRole(["Super Admin"]),
  upload.single("image"),
  schemeKnowmoreController.updateSchemeKnowmore
);

/**
 * @swagger
 * /schemesknowmore/{id}:
 *   delete:
 *     summary: Delete a schemeKnowmore record by primary key id
 *     tags: [schemesknowmore]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         description: The primary key id.
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: SchemeKnowmore deleted successfully.
 *       404:
 *         description: SchemeKnowmore not found.
 *       500:
 *         description: Server error.
 */
router.delete(
  "/schemesknowmore/:id",verifyToken,authorizeRole(["Super Admin"]),
  schemeKnowmoreController.deleteSchemeKnowmore
);

module.exports = router;
