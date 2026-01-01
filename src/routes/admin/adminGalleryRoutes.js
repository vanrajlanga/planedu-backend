const express = require('express');
const router = express.Router({ mergeParams: true });
const adminGalleryController = require('../../controllers/admin/adminGalleryController');
const { authenticateAdmin } = require('../../middleware/admin/adminAuth');

// All routes require admin authentication
router.use(authenticateAdmin);

// Get valid categories
router.get('/categories', adminGalleryController.getCategories);

// Get all gallery images for a college
router.get('/', adminGalleryController.getGallery);

// Get single image
router.get('/:id', adminGalleryController.getGalleryImage);

// Create new gallery image
router.post('/', adminGalleryController.createGalleryImage);

// Reorder gallery images
router.post('/reorder', adminGalleryController.reorderGallery);

// Update gallery image
router.put('/:id', adminGalleryController.updateGalleryImage);

// Delete gallery image
router.delete('/:id', adminGalleryController.deleteGalleryImage);

module.exports = router;
