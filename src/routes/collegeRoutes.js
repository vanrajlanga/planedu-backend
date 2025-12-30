const express = require('express');
const router = express.Router();
const collegeController = require('../controllers/collegeController');
const { optionalAuth } = require('../middleware/auth');

/**
 * @route   GET /api/v1/colleges
 * @desc    Get all colleges with search and filters
 * @access  Public
 */
router.get('/', optionalAuth, collegeController.getAllColleges);

/**
 * @route   GET /api/v1/colleges/:slug
 * @desc    Get college details by slug
 * @access  Public
 */
router.get('/:slug', optionalAuth, collegeController.getCollegeBySlug);

/**
 * @route   GET /api/v1/colleges/:college_id/reviews
 * @desc    Get college reviews
 * @access  Public
 */
router.get('/:college_id/reviews', optionalAuth, collegeController.getCollegeReviews);

module.exports = router;
