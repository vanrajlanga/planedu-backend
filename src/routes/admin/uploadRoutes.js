const express = require('express');
const router = express.Router();
const { upload, uploadBannerImage, deleteBannerImage } = require('../../controllers/admin/uploadController');
const { authenticateAdmin } = require('../../middleware/admin/adminAuth');

// All routes require admin authentication
router.use(authenticateAdmin);

/**
 * @route   POST /api/v1/admin/upload/banner
 * @desc    Upload banner image
 * @access  Admin
 */
router.post('/banner', upload.single('image'), uploadBannerImage);

/**
 * @route   DELETE /api/v1/admin/upload/banner/:filename
 * @desc    Delete banner image
 * @access  Admin
 */
router.delete('/banner/:filename', deleteBannerImage);

module.exports = router;
