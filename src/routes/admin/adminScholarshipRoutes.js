const express = require('express');
const router = express.Router();
const adminScholarshipController = require('../../controllers/admin/adminScholarshipController');
const { authenticateAdmin } = require('../../middleware/admin/adminAuth');

// Apply authentication middleware to all routes
router.use(authenticateAdmin);

// Get all scholarships with filters and pagination
router.get('/scholarships', adminScholarshipController.getScholarships);

// Get a single scholarship by ID
router.get('/scholarships/:id', adminScholarshipController.getScholarship);

// Create a new scholarship
router.post('/scholarships', adminScholarshipController.createScholarship);

// Update a scholarship
router.put('/scholarships/:id', adminScholarshipController.updateScholarship);

// Update scholarship status
router.put('/scholarships/:id/status', adminScholarshipController.updateScholarshipStatus);

// Bulk update scholarship status
router.post('/scholarships/bulk-status', adminScholarshipController.bulkUpdateStatus);

// Delete a scholarship (soft delete)
router.delete('/scholarships/:id', adminScholarshipController.deleteScholarship);

module.exports = router;
