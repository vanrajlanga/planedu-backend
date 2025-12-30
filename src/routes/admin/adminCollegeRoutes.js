const express = require('express');
const router = express.Router();
const adminCollegeController = require('../../controllers/admin/adminCollegeController');
const { authenticateAdmin } = require('../../middleware/admin/adminAuth');

// All routes require admin authentication
router.use(authenticateAdmin);

/**
 * @route   GET /api/v1/admin/colleges
 * @desc    Get all colleges with pagination, search, and filters
 * @access  Admin
 * @query   page, limit, search, college_type, ownership, state, status, is_featured, is_verified, sort_by, sort_order
 */
router.get('/', adminCollegeController.getColleges);

/**
 * @route   GET /api/v1/admin/colleges/filter-options
 * @desc    Get filter options for dropdowns (states, types, ownership)
 * @access  Admin
 */
router.get('/filter-options', adminCollegeController.getFilterOptions);

/**
 * @route   GET /api/v1/admin/colleges/:id
 * @desc    Get single college by ID
 * @access  Admin
 */
router.get('/:id', adminCollegeController.getCollegeById);

/**
 * @route   POST /api/v1/admin/colleges
 * @desc    Create new college
 * @access  Admin
 */
router.post('/', adminCollegeController.createCollege);

/**
 * @route   PUT /api/v1/admin/colleges/:id
 * @desc    Update college
 * @access  Admin
 */
router.put('/:id', adminCollegeController.updateCollege);

/**
 * @route   PUT /api/v1/admin/colleges/:id/status
 * @desc    Update college status
 * @access  Admin
 */
router.put('/:id/status', adminCollegeController.updateCollegeStatus);

/**
 * @route   DELETE /api/v1/admin/colleges/:id
 * @desc    Soft delete college
 * @access  Admin
 */
router.delete('/:id', adminCollegeController.deleteCollege);

/**
 * @route   POST /api/v1/admin/colleges/bulk-status
 * @desc    Bulk update college status
 * @access  Admin
 */
router.post('/bulk-status', adminCollegeController.bulkUpdateStatus);

module.exports = router;
