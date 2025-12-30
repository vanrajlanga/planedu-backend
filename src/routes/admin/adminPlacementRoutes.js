const express = require('express');
const router = express.Router();
const adminPlacementController = require('../../controllers/admin/adminPlacementController');
const { authenticateAdmin } = require('../../middleware/admin/adminAuth');

// Apply authentication middleware to all routes
router.use(authenticateAdmin);

// Get all placements with filters and pagination
router.get('/placements', adminPlacementController.getPlacements);

// Get placement statistics by college
router.get('/placements/stats/:college_id', adminPlacementController.getPlacementStatsByCollege);

// Get a single placement by ID
router.get('/placements/:id', adminPlacementController.getPlacement);

// Create a new placement
router.post('/placements', adminPlacementController.createPlacement);

// Update a placement
router.put('/placements/:id', adminPlacementController.updatePlacement);

// Delete a placement (soft delete)
router.delete('/placements/:id', adminPlacementController.deletePlacement);

module.exports = router;
