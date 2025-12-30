const multer = require('multer');
const path = require('path');
const fs = require('fs');
const ApiResponse = require('../../utils/response');

// Configure storage
const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    const uploadPath = path.join(__dirname, '../../../uploads/banners');

    // Create directory if it doesn't exist
    if (!fs.existsSync(uploadPath)) {
      fs.mkdirSync(uploadPath, { recursive: true });
    }

    cb(null, uploadPath);
  },
  filename: function (req, file, cb) {
    // Generate unique filename
    const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
    cb(null, 'banner-' + uniqueSuffix + path.extname(file.originalname));
  }
});

// File filter for images only
const fileFilter = (req, file, cb) => {
  const allowedTypes = /jpeg|jpg|png|gif|webp/;
  const extname = allowedTypes.test(path.extname(file.originalname).toLowerCase());
  const mimetype = allowedTypes.test(file.mimetype);

  if (mimetype && extname) {
    return cb(null, true);
  } else {
    cb(new Error('Only image files are allowed (jpeg, jpg, png, gif, webp)'));
  }
};

// Create multer upload instance
const upload = multer({
  storage: storage,
  limits: {
    fileSize: 5 * 1024 * 1024 // 5MB limit
  },
  fileFilter: fileFilter
});

/**
 * Upload single banner image
 * POST /api/v1/admin/upload/banner
 */
const uploadBannerImage = async (req, res, next) => {
  try {
    if (!req.file) {
      return ApiResponse.error(res, 'No file uploaded', 400);
    }

    // Generate URL for the uploaded file
    const fileUrl = `/uploads/banners/${req.file.filename}`;

    return ApiResponse.success(res, {
      filename: req.file.filename,
      originalName: req.file.originalname,
      size: req.file.size,
      url: fileUrl
    }, 'Image uploaded successfully', 201);
  } catch (error) {
    console.error('Upload error:', error);
    next(error);
  }
};

/**
 * Delete banner image
 * DELETE /api/v1/admin/upload/banner/:filename
 */
const deleteBannerImage = async (req, res, next) => {
  try {
    const { filename } = req.params;
    const filePath = path.join(__dirname, '../../../uploads/banners', filename);

    // Check if file exists
    if (!fs.existsSync(filePath)) {
      return ApiResponse.error(res, 'File not found', 404);
    }

    // Delete file
    fs.unlinkSync(filePath);

    return ApiResponse.success(res, { filename }, 'Image deleted successfully');
  } catch (error) {
    console.error('Delete file error:', error);
    next(error);
  }
};

module.exports = {
  upload,
  uploadBannerImage,
  deleteBannerImage,
};
