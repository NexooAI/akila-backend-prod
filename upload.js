// upload.js
const multer = require("multer");
const path = require("path");

// Configure storage options
const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, path.join(__dirname, "uploads"));
  },
  filename: function (req, file, cb) {
    // Generate a unique filename with timestamp
    cb(null, Date.now() + "-" + file.originalname);
  },
});

// Optional: Filter only image files
const fileFilter = (req, file, cb) => {
  if (
    file.mimetype === "image/jpeg" ||
    file.mimetype === "image/png" ||
    file.mimetype === "image/jpg"
  ) {
    cb(null, true);
  } else {
    cb(new Error("Unsupported file type"), false);
  }
};

const upload = multer({ storage, fileFilter });
module.exports = upload;
