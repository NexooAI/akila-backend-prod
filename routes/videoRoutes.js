// routes/videoRoutes.js
const express = require("express");
const router = express.Router();
const videoController = require("../controllers/videoController");

/**
 * @swagger
 * components:
 *   schemas:
 *     Video:
 *       type: object
 *       properties:
 *         id:
 *           type: number
 *           description: Unique video identifier.
 *         title:
 *           type: string
 *           description: Title of the video.
 *         subtitle:
 *           type: string
 *           description: Subtitle of the video.
 *         video_url:
 *           type: string
 *           description: URL of the video.
 *         status:
 *           type: string
 *           description: Status of the video (active/inactive).
 *         created_at:
 *           type: string
 *           format: date-time
 *           description: Timestamp when the video was created.
 *       example:
 *         id: 1
 *         title: "Sample Video"
 *         subtitle: "This is a sample video"
 *         video_url: "http://example.com/video.mp4"
 *         status: "active"
 *         created_at: "2024-07-21T10:00:00Z"
 *
 * tags:
 *   - name: Videos
 *     description: API for managing video records
 */

/**
 * @swagger
 * /videos/active:
 *   get:
 *     summary: Retrieve all active video records
 *     tags: [Videos]
 *     responses:
 *       200:
 *         description: A list of active video records.
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 $ref: '#/components/schemas/Video'
 *       500:
 *         description: Server error.
 */
router.get("/active", videoController.getActiveVideos);
/**
 * @swagger
 * /videos:
 *   post:
 *     summary: Create a new video record
 *     tags: [Videos]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               title:
 *                 type: string
 *                 description: Title of the video.
 *                 example: "Sample Video"
 *               subtitle:
 *                 type: string
 *                 description: Subtitle of the video.
 *                 example: "This is a sample video"
 *               video_url:
 *                 type: string
 *                 description: URL of the video.
 *                 example: "http://example.com/video.mp4"
 *               status:
 *                 type: string
 *                 description: Status of the video (active/inactive).
 *                 example: "active"
 *     responses:
 *       201:
 *         description: Video created successfully.
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Video'
 *       500:
 *         description: Server error.
 */
router.post("/", videoController.createVideo);

/**
 * @swagger
 * /videos:
 *   get:
 *     summary: Retrieve all video records
 *     tags: [Videos]
 *     responses:
 *       200:
 *         description: A list of video records.
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 $ref: '#/components/schemas/Video'
 *       500:
 *         description: Server error.
 */
router.get("/", videoController.getAllVideos);

/**
 * @swagger
 * /videos/{id}:
 *   get:
 *     summary: Retrieve a video record by ID
 *     tags: [Videos]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: number
 *         description: The video record ID.
 *     responses:
 *       200:
 *         description: Video record found.
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Video'
 *       404:
 *         description: Video record not found.
 *       500:
 *         description: Server error.
 */
router.get("/:id", videoController.getVideoById);

/**
 * @swagger
 * /videos/{id}:
 *   put:
 *     summary: Update a video record by ID
 *     tags: [Videos]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: number
 *         description: The video record ID.
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               title:
 *                 type: string
 *                 description: Title of the video.
 *                 example: "Updated Video Title"
 *               subtitle:
 *                 type: string
 *                 description: Subtitle of the video.
 *                 example: "Updated subtitle"
 *               video_url:
 *                 type: string
 *                 description: URL of the video.
 *                 example: "http://example.com/updated_video.mp4"
 *               status:
 *                 type: string
 *                 description: Status of the video (active/inactive).
 *                 example: "inactive"
 *     responses:
 *       200:
 *         description: Video updated successfully.
 *       500:
 *         description: Server error.
 */
router.put("/:id", videoController.updateVideo);

/**
 * @swagger
 * /videos/{id}:
 *   delete:
 *     summary: Delete a video record by ID
 *     tags: [Videos]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: number
 *         description: The video record ID.
 *     responses:
 *       200:
 *         description: Video deleted successfully.
 *       500:
 *         description: Server error.
 */
router.delete("/:id", videoController.deleteVideo);


module.exports = router;
