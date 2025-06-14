const InitialPopup = require("../models/initialPopupModel");
const multer = require("multer");
const path = require("path");
const fs = require("fs");

// Configure multer for image upload
const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    const uploadDir = "uploads/popups";
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

exports.createPopup = async (req, res) => {
  try {
    const { title, link_url, status, startDate, endDate } = req.body;
    const image = req.file;

    if (!image) {
      return res.status(400).json({
        success: false,
        error: "Image is required"
      });
    }

    if (!title) {
      return res.status(400).json({
        success: false,
        error: "Title is required"
      });
    }

    // First, deactivate all existing active popups
    await InitialPopup.deactivateAllActive();

    // Then create the new popup
    const result = await InitialPopup.create({
      title,
      image_url: image.path,
      link_url,
      status: 'active', // Force status to be active for new popup
      startDate,
      endDate
    });

    res.status(201).json(result);
  } catch (error) {
    console.error('Error in createPopup:', error);
    res.status(500).json({
      success: false,
      error: error.message || "Internal server error"
    });
  }
};

exports.getAllPopups = async (req, res) => {
  try {
    const popups = await InitialPopup.getAll();
    res.json({
      success: true,
      data: popups
    });
  } catch (error) {
    console.error('Error in getAllPopups:', error);
    res.status(500).json({
      success: false,
      error: error.message || "Internal server error"
    });
  }
};

exports.getActivePopups = async (req, res) => {
  try {
    const popups = await InitialPopup.getActive();
    res.json({
      success: true,
      data: popups
    });
  } catch (error) {
    console.error('Error in getActivePopups:', error);
    res.status(500).json({
      success: false,
      error: error.message || "Internal server error"
    });
  }
};

exports.getPopupById = async (req, res) => {
  try {
    const id = req.params.id;
    if (!id) {
      return res.status(400).json({
        success: false,
        error: "Popup ID is required"
      });
    }

    const popup = await InitialPopup.getById(id);
    if (!popup) {
      return res.status(404).json({
        success: false,
        error: "Popup not found"
      });
    }

    res.json({
      success: true,
      data: popup
    });
  } catch (error) {
    console.error('Error in getPopupById:', error);
    res.status(500).json({
      success: false,
      error: error.message || "Internal server error"
    });
  }
};

exports.updatePopup = async (req, res) => {
  try {
    const id = req.params.id;
    const { title, link_url, status, start_date, end_date } = req.body;
    const image = req.file;

    if (!id) {
      return res.status(400).json({
        success: false,
        error: "Popup ID is required"
      });
    }

    // Get existing popup
    const existingPopup = await InitialPopup.getById(id);
    if (!existingPopup) {
      return res.status(404).json({
        success: false,
        error: "Popup not found"
      });
    }

    // Prepare update data
    const updateData = {
      title,
      image_url: image ? image.path : undefined,
      link_url,
      status,
      start_date,
      end_date
    };

    const result = await InitialPopup.update(id, updateData);
    res.json(result);
  } catch (error) {
    console.error('Error in updatePopup:', error);
    res.status(500).json({
      success: false,
      error: error.message || "Internal server error"
    });
  }
};

exports.deletePopup = async (req, res) => {
  try {
    const id = req.params.id;
    if (!id) {
      return res.status(400).json({
        success: false,
        error: "Popup ID is required"
      });
    }

    // Get popup before deleting to remove image
    const popup = await InitialPopup.getById(id);
    if (!popup) {
      return res.status(404).json({
        success: false,
        error: "Popup not found"
      });
    }

    // Delete associated image
    if (popup.image_url) {
      fs.unlinkSync(popup.image_url);
    }

    const result = await InitialPopup.delete(id);
    res.json(result);
  } catch (error) {
    console.error('Error in deletePopup:', error);
    res.status(500).json({
      success: false,
      error: error.message || "Internal server error"
    });
  }
};

// Export multer upload middleware
exports.upload = upload; 