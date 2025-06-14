const Collection = require("../models/collectionModel");
const multer = require("multer");
const path = require("path");
const fs = require("fs");

// Configure multer for image upload
const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    const uploadDir = "uploads/collections";
    // Create directory if it doesn't exist
    if (!fs.existsSync(uploadDir)) {
      fs.mkdirSync(uploadDir, { recursive: true });
    }
    cb(null, uploadDir);
  },
  filename: function (req, file, cb) {
    const uniqueSuffix = Date.now() + "-" + Math.round(Math.random() * 1e9);
    cb(null, file.fieldname + "-" + uniqueSuffix + path.extname(file.originalname));
  },
});

const upload = multer({
  storage: storage,
  fileFilter: function (req, file, cb) {
    // Accept images only
    if (!file.originalname.match(/\.(jpg|jpeg|png|gif)$/)) {
      return cb(new Error("Only image files are allowed!"), false);
    }
    cb(null, true);
  },
  limits: {
    fileSize: 5 * 1024 * 1024, // 5MB limit
  },
});

exports.createCollection = async (req, res) => {
  try {
    const { name } = req.body;
    const thumbnail = req.files?.thumbnail?.[0];
    const statusImages = req.files?.status_images;

    // Validate required fields
    if (!name || !thumbnail || !statusImages) {
      return res.status(400).json({
        success: false,
        error: "Missing required fields: name, thumbnail, and status_images are required"
      });
    }

    // Validate status_images is an array
    if (!Array.isArray(statusImages)) {
      return res.status(400).json({
        success: false,
        error: "status_images must be an array of images"
      });
    }

    // Create array of status image paths
    const statusImagePaths = statusImages.map(file => file.path);

    const result = await Collection.create({
      name,
      thumbnail: thumbnail.path,
      status_images: statusImagePaths
    });

    res.status(201).json(result);
  } catch (error) {
    console.error('Error in createCollection:', error);
    res.status(500).json({
      success: false,
      error: error.message || "Internal server error"
    });
  }
};

exports.getAllCollections = async (req, res) => {
  try {
    const collections = await Collection.getAll();
    res.json({
      success: true,
      data: collections
    });
  } catch (error) {
    console.error('Error in getAllCollections:', error);
    res.status(500).json({
      success: false,
      error: error.message || "Internal server error"
    });
  }
};

exports.getCollectionById = async (req, res) => {
  try {
    const id = req.params.id;
    if (!id) {
      return res.status(400).json({
        success: false,
        error: "Collection ID is required"
      });
    }

    const collection = await Collection.getById(id);
    if (!collection) {
      return res.status(404).json({
        success: false,
        error: "Collection not found"
      });
    }

    res.json({
      success: true,
      data: collection
    });
  } catch (error) {
    console.error('Error in getCollectionById:', error);
    res.status(500).json({
      success: false,
      error: error.message || "Internal server error"
    });
  }
};

exports.updateCollection = async (req, res) => {
  try {
    const id = req.params.id;
    const { name } = req.body;
    const thumbnail = req.files?.thumbnail?.[0];
    const statusImages = req.files?.status_images;

    if (!id) {
      return res.status(400).json({
        success: false,
        error: "Collection ID is required"
      });
    }

    // Get existing collection
    const existingCollection = await Collection.getById(id);
    if (!existingCollection) {
      return res.status(404).json({
        success: false,
        error: "Collection not found"
      });
    }

    // Prepare update data
    const updateData = {
      name: name || existingCollection.name,
      thumbnail: thumbnail ? thumbnail.path : existingCollection.thumbnail,
      status_images: statusImages ? statusImages.map(file => file.path) : existingCollection.status_images
    };

    const result = await Collection.update(id, updateData);
    res.json(result);
  } catch (error) {
    console.error('Error in updateCollection:', error);
    res.status(500).json({
      success: false,
      error: error.message || "Internal server error"
    });
  }
};

exports.deleteCollection = async (req, res) => {
  try {
    const id = req.params.id;
    if (!id) {
      return res.status(400).json({
        success: false,
        error: "Collection ID is required"
      });
    }

    // Get collection before deleting to remove files
    const collection = await Collection.getById(id);
    if (!collection) {
      return res.status(404).json({
        success: false,
        error: "Collection not found"
      });
    }

    // Delete associated files
    if (collection.thumbnail) {
      fs.unlinkSync(collection.thumbnail);
    }
    if (collection.status_images) {
      collection.status_images.forEach(imagePath => {
        if (fs.existsSync(imagePath)) {
          fs.unlinkSync(imagePath);
        }
      });
    }

    const result = await Collection.delete(id);
    res.json(result);
  } catch (error) {
    console.error('Error in deleteCollection:', error);
    res.status(500).json({
      success: false,
      error: error.message || "Internal server error"
    });
  }
};

// Export multer upload middleware
exports.upload = upload; 