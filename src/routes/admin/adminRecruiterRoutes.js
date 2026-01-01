const express = require('express');
const router = express.Router({ mergeParams: true });
const adminRecruiterController = require('../../controllers/admin/adminRecruiterController');
const { authenticateAdmin } = require('../../middleware/admin/adminAuth');

// All routes require admin authentication
router.use(authenticateAdmin);

// Get sector options
router.get('/sectors', adminRecruiterController.getSectorOptions);

// Get all recruiters for a placement
router.get('/:placementId/recruiters', adminRecruiterController.getRecruiters);

// Get single recruiter
router.get('/:placementId/recruiters/:id', adminRecruiterController.getRecruiter);

// Create recruiter
router.post('/:placementId/recruiters', adminRecruiterController.createRecruiter);

// Bulk create recruiters
router.post('/:placementId/recruiters/bulk', adminRecruiterController.bulkCreateRecruiters);

// Update recruiter
router.put('/:placementId/recruiters/:id', adminRecruiterController.updateRecruiter);

// Delete recruiter
router.delete('/:placementId/recruiters/:id', adminRecruiterController.deleteRecruiter);

module.exports = router;
