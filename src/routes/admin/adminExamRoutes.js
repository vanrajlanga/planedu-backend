const express = require('express');
const router = express.Router();
const adminExamController = require('../../controllers/admin/adminExamController');
const { authenticateAdmin } = require('../../middleware/admin/adminAuth');

// Apply authentication middleware to all routes
router.use(authenticateAdmin);

// Get all exams with filters and pagination
router.get('/exams', adminExamController.getExams);

// Get a single exam by ID
router.get('/exams/:id', adminExamController.getExam);

// Create a new exam
router.post('/exams', adminExamController.createExam);

// Update an exam
router.put('/exams/:id', adminExamController.updateExam);

// Update exam status
router.put('/exams/:id/status', adminExamController.updateExamStatus);

// Bulk update exam status
router.post('/exams/bulk-status', adminExamController.bulkUpdateStatus);

// Delete an exam (soft delete)
router.delete('/exams/:id', adminExamController.deleteExam);

module.exports = router;
