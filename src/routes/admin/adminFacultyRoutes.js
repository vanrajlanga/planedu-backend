const express = require('express');
const router = express.Router({ mergeParams: true });
const adminFacultyController = require('../../controllers/admin/adminFacultyController');

// Routes for college-specific faculty
// Base path: /api/v1/admin/colleges/:collegeId/faculty

// Get all faculty for a college
router.get('/', adminFacultyController.getFacultyByCollege);

// Get a single faculty member
router.get('/:id', adminFacultyController.getFaculty);

// Create a new faculty member
router.post('/', adminFacultyController.createFaculty);

// Update a faculty member
router.put('/:id', adminFacultyController.updateFaculty);

// Delete a faculty member
router.delete('/:id', adminFacultyController.deleteFaculty);

module.exports = router;
