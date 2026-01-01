const express = require('express');
const router = express.Router({ mergeParams: true });
const adminCutoffController = require('../../controllers/admin/adminCutoffController');

// Routes for college-specific cutoffs
// Base path: /api/v1/admin/colleges/:collegeId/cutoffs

// Get all cutoffs for a college
router.get('/', adminCutoffController.getCutoffsByCollege);

// Get filter options (years, categories, exams)
router.get('/filters', adminCutoffController.getFilterOptions);

// Get a single cutoff
router.get('/:id', adminCutoffController.getCutoff);

// Create a new cutoff
router.post('/', adminCutoffController.createCutoff);

// Bulk create cutoffs
router.post('/bulk', adminCutoffController.bulkCreateCutoffs);

// Update a cutoff
router.put('/:id', adminCutoffController.updateCutoff);

// Delete a cutoff
router.delete('/:id', adminCutoffController.deleteCutoff);

module.exports = router;
