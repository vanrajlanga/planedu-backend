const express = require('express');
const router = express.Router();
const adminCourseController = require('../../controllers/admin/adminCourseController');
const { authenticateAdmin } = require('../../middleware/admin/adminAuth');

// Apply authentication middleware to all routes
router.use(authenticateAdmin);

// Get all courses with filters and pagination
router.get('/courses', adminCourseController.getCourses);

// Get filter options
router.get('/courses/filter-options', adminCourseController.getFilterOptions);

// Get a single course by ID
router.get('/courses/:id', adminCourseController.getCourse);

// Create a new course
router.post('/courses', adminCourseController.createCourse);

// Update a course
router.put('/courses/:id', adminCourseController.updateCourse);

// Update course status
router.put('/courses/:id/status', adminCourseController.updateCourseStatus);

// Bulk update course status
router.post('/courses/bulk-status', adminCourseController.bulkUpdateStatus);

// Delete a course (soft delete)
router.delete('/courses/:id', adminCourseController.deleteCourse);

module.exports = router;
