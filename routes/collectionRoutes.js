const express = require("express");
const router = express.Router();
const controller = require("../controllers/collectionController");

/**
 * @swagger
 * components:
 *   schemas:
 *     Collection:
 *       type: object
 *       required:
 *         - name
 *         - thumbnail
 *         - status_images
 *       properties:
 *         id:
 *           type: integer
 *           description: The auto-generated id of the collection
 *         name:
 *           type: string
 *           description: The name of the collection
 *         thumbnail:
 *           type: string
 *           description: URL or path for the collection thumbnail
 *         status_images:
 *           type: array
 *           items:
 *             type: string
 *           description: Array of URLs for status images
 *         created_at:
 *           type: string
 *           format: date-time
 *           description: The date the collection was created
 *         updated_at:
 *           type: string
 *           format: date-time
 *           description: The date the collection was last updated
 */

/**
 * @swagger
 * /collections:
 *   post:
 *     summary: Create a new collection
 *     tags: [Collections]
 *     requestBody:
 *       required: true
 *       content:
 *         multipart/form-data:
 *           schema:
 *             type: object
 *             required:
 *               - name
 *               - thumbnail
 *               - status_images
 *             properties:
 *               name:
 *                 type: string
 *                 description: The name of the collection
 *               thumbnail:
 *                 type: string
 *                 format: binary
 *                 description: The collection thumbnail image
 *               status_images:
 *                 type: array
 *                 items:
 *                   type: string
 *                   format: binary
 *                 description: Array of status images for the collection
 *     responses:
 *       201:
 *         description: Collection created successfully
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Collection'
 *       400:
 *         description: Invalid input
 *       500:
 *         description: Server error
 */
router.post(
  "/",
  controller.upload.fields([
    { name: "thumbnail", maxCount: 1 },
    { name: "status_images", maxCount: 10 },
  ]),
  controller.createCollection
);

/**
 * @swagger
 * /collections:
 *   get:
 *     summary: Get all collections
 *     tags: [Collections]
 *     responses:
 *       200:
 *         description: List of all collections
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success:
 *                   type: boolean
 *                 data:
 *                   type: array
 *                   items:
 *                     $ref: '#/components/schemas/Collection'
 *       500:
 *         description: Server error
 */
router.get("/", controller.getAllCollections);

/**
 * @swagger
 * /collections/{id}:
 *   get:
 *     summary: Get a collection by ID
 *     tags: [Collections]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: The collection ID
 *     responses:
 *       200:
 *         description: Collection details
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 success:
 *                   type: boolean
 *                 data:
 *                   $ref: '#/components/schemas/Collection'
 *       404:
 *         description: Collection not found
 *       500:
 *         description: Server error
 */
router.get("/:id", controller.getCollectionById);

/**
 * @swagger
 * /collections/{id}:
 *   put:
 *     summary: Update a collection
 *     tags: [Collections]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: The collection ID
 *     requestBody:
 *       required: true
 *       content:
 *         multipart/form-data:
 *           schema:
 *             type: object
 *             properties:
 *               name:
 *                 type: string
 *                 description: The name of the collection
 *               thumbnail:
 *                 type: string
 *                 format: binary
 *                 description: The collection thumbnail image
 *               status_images:
 *                 type: array
 *                 items:
 *                   type: string
 *                   format: binary
 *                 description: Array of status images for the collection
 *     responses:
 *       200:
 *         description: Collection updated successfully
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Collection'
 *       400:
 *         description: Invalid input
 *       404:
 *         description: Collection not found
 *       500:
 *         description: Server error
 */
router.put(
  "/:id",
  controller.upload.fields([
    { name: "thumbnail", maxCount: 1 },
    { name: "status_images", maxCount: 10 },
  ]),
  controller.updateCollection
);

/**
 * @swagger
 * /collections/{id}:
 *   delete:
 *     summary: Delete a collection
 *     tags: [Collections]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: The collection ID
 *     responses:
 *       200:
 *         description: Collection deleted successfully
 *       404:
 *         description: Collection not found
 *       500:
 *         description: Server error
 */
router.delete("/:id", controller.deleteCollection);

module.exports = router;
