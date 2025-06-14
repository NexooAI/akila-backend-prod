const express = require('express');
const router = express.Router();
const multer = require('multer');
const path = require('path');
const fs = require('fs');

const posterController = require('../controllers/posterController');

// Configure multer for file upload
const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    const uploadDir = 'uploads/posters';
    // Create directory if it doesn't exist
    if (!fs.existsSync(uploadDir)) {
      fs.mkdirSync(uploadDir, { recursive: true });
    }
    cb(null, uploadDir);
  },
  filename: function (req, file, cb) {
    const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
    cb(null, uniqueSuffix + path.extname(file.originalname));
  }
});

const upload = multer({
  storage: storage,
  limits: {
    fileSize: 5 * 1024 * 1024 // 5MB limit
  },
  fileFilter: function (req, file, cb) {
    // Accept images only
    if (!file.originalname.match(/\.(jpg|jpeg|png|gif)$/)) {
      return cb(new Error('Only image files are allowed!'), false);
    }
    cb(null, true);
  }
});

/**
 * @swagger
 * tags:
 *   name: Posters
 *   description: Poster management
 */

/**
 * @swagger
 * components:
 *   schemas:
 *     Poster:
 *       type: object
 *       properties:
 *         id:
 *           type: integer
 *         title:
 *           type: string
 *         image:
 *           type: string
 *         startDate:
 *           type: string
 *           format: date
 *         endDate:
 *           type: string
 *           format: date
 *         status:
 *           type: integer
 */

/**
 * @swagger
 * /posters:
 *   post:
 *     summary: Create a new poster
 *     tags: [Posters]
 *     consumes:
 *       - multipart/form-data
 *     requestBody:
 *       required: true
 *       content:
 *         multipart/form-data:
 *           schema:
 *             type: object
 *             required:
 *               - image
 *               - title
 *               - startDate
 *               - endDate
 *             properties:
 *               image:
 *                 type: string
 *                 format: binary
 *               title:
 *                 type: string
 *               startDate:
 *                 type: string
 *                 format: date
 *                 example: "2024-03-19"
 *               endDate:
 *                 type: string
 *                 format: date
 *                 example: "2024-03-26"
 *     responses:
 *       201:
 *         description: Poster created successfully
 *       400:
 *         description: Bad request
 *       500:
 *         description: Server error
 */
router.post('/', upload.single('image'), posterController.createPoster);

/**
 * @swagger
 * /posters:
 *   get:
 *     summary: Get all posters
 *     tags: [Posters]
 *     responses:
 *       200:
 *         description: List of all posters
 *       500:
 *         description: Server error
 */
router.get('/', posterController.getAllPosters);

/**
 * @swagger
 * /posters/active:
 *   get:
 *     summary: Get all active posters
 *     tags: [Posters]
 *     responses:
 *       200:
 *         description: List of active posters
 *       500:
 *         description: Server error
 */
router.get('/active', posterController.getActivePosters);

/**
 * @swagger
 * /posters/{id}:
 *   get:
 *     summary: Get a poster by ID
 *     tags: [Posters]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Poster details
 *       404:
 *         description: Poster not found
 *       500:
 *         description: Server error
 */
router.get('/:id', posterController.getPosterById);

/**
 * @swagger
 * /posters/{id}:
 *   delete:
 *     summary: Delete a poster
 *     tags: [Posters]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Poster deleted successfully
 *       404:
 *         description: Poster not found
 *       500:
 *         description: Server error
 */
router.delete('/:id', posterController.deletePoster);

module.exports = router; 