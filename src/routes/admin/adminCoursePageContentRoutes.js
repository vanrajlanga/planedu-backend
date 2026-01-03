const express = require('express');
const router = express.Router();
const adminCoursePageContentController = require('../../controllers/admin/adminCoursePageContentController');
const { authenticateAdmin } = require('../../middleware/admin/adminAuth');

// All routes require admin authentication
router.use(authenticateAdmin);

// Get available course types for content creation
router.get('/course-types', adminCoursePageContentController.getAvailableCourseTypes);

// Get all course page content entries
router.get('/', adminCoursePageContentController.getAllCoursePageContent);

// Get course page content by course type
router.get('/:courseType', adminCoursePageContentController.getCoursePageContentByType);

// Create new course page content
router.post('/', adminCoursePageContentController.createCoursePageContent);

// Update course page content (upsert)
router.put('/:courseType', adminCoursePageContentController.updateCoursePageContent);

// Delete course page content
router.delete('/:courseType', adminCoursePageContentController.deleteCoursePageContent);

module.exports = router;
