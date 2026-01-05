const express = require('express');
const router = express.Router();
const { upload, galleryUpload, uploadBannerImage, deleteBannerImage, uploadGalleryImage, deleteGalleryImage } = require('../../controllers/admin/uploadController');
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

/**
 * @route   POST /api/v1/admin/upload/gallery
 * @desc    Upload gallery image
 * @access  Admin
 */
router.post('/gallery', galleryUpload.single('image'), uploadGalleryImage);

/**
 * @route   DELETE /api/v1/admin/upload/gallery/:filename
 * @desc    Delete gallery image
 * @access  Admin
 */
router.delete('/gallery/:filename', deleteGalleryImage);

module.exports = router;
