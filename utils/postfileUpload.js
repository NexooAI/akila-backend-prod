const multer = require("multer");
const path = require("path");
const fs = require("fs");

// Ensure the uploads/posts folder exists
const uploadDir = path.join(__dirname, "..", "uploads", "posts");
if (!fs.existsSync(uploadDir)) {
  fs.mkdirSync(uploadDir, { recursive: true });
}

// Slugify helper
const slugify = (str) => {
  return str
    .toLowerCase()
    .replace(/\s+/g, '-')           // spaces to dashes
    .replace(/[^a-z0-9\-]/g, '')    // remove special chars
    .replace(/\-{2,}/g, '-')        // collapse multiple dashes
    .replace(/^\-+|\-+$/g, '');     // trim dashes from ends
};

// Multer storage
const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, uploadDir); // Save files in uploads/posts/
  },
  filename: function (req, file, cb) {
    const ext = path.extname(file.originalname); // .jpg, .png
    const title = req.body.title || 'post';
    const slugTitle = slugify(title);
    const filename = `${slugTitle}-${Date.now()}${ext}`;
    cb(null, filename);
  }
});

// File filter for images only
const fileFilter = (req, file, cb) => {
  const allowedTypes = ["image/jpeg", "image/png", "image/jpg", "image/webp"];
  if (allowedTypes.includes(file.mimetype)) {
    cb(null, true);
  } else {
    cb(new Error("Invalid file type. Only JPEG, PNG, JPG, and WEBP are allowed."), false);
  }
};

// Upload instance
const upload = multer({
  storage,
  limits: { fileSize: 5 * 1024 * 1024 }, // 5MB
  fileFilter,
});

module.exports = upload;
