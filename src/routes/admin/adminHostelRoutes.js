const express = require('express');
const router = express.Router({ mergeParams: true });
const adminHostelController = require('../../controllers/admin/adminHostelController');

// Routes for college-specific hostels
// Base path: /api/v1/admin/colleges/:collegeId/hostels

// Get all hostels for a college
router.get('/', adminHostelController.getHostelsByCollege);

// Get a single hostel
router.get('/:id', adminHostelController.getHostel);

// Create a new hostel
router.post('/', adminHostelController.createHostel);

// Update a hostel
router.put('/:id', adminHostelController.updateHostel);

// Delete a hostel
router.delete('/:id', adminHostelController.deleteHostel);

module.exports = router;
