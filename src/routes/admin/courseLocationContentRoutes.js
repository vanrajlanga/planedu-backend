const express = require('express');
const router = express.Router();
const courseLocationContentController = require('../../controllers/admin/courseLocationContentController');
const { authenticateAdmin } = require('../../middleware/admin/adminAuth');

// All routes require admin authentication
router.use(authenticateAdmin);

// Get all course location content entries
router.get('/', courseLocationContentController.getAll);

// Get available locations for a course type
router.get('/available-locations/:courseType', courseLocationContentController.getAvailableLocations);

// Get specific content by course type and location slug
router.get('/:courseType/:locationSlug', courseLocationContentController.getOne);

// Create new content
router.post('/', courseLocationContentController.create);

// Update content
router.put('/:courseType/:locationSlug', courseLocationContentController.update);

// Delete content
router.delete('/:courseType/:locationSlug', courseLocationContentController.delete);

module.exports = router;
