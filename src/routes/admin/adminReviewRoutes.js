const express = require('express');
const router = express.Router();
const adminReviewController = require('../../controllers/admin/adminReviewController');
const { authenticateAdmin } = require('../../middleware/admin/adminAuth');

// Apply authentication middleware to all routes
router.use(authenticateAdmin);

// Get all reviews with filters and pagination
router.get('/reviews', adminReviewController.getReviews);

// Get review statistics
router.get('/reviews/stats', adminReviewController.getReviewStats);

// Get a single review by ID
router.get('/reviews/:id', adminReviewController.getReview);

// Update review status
router.put('/reviews/:id/status', adminReviewController.updateReviewStatus);

// Reply to a review
router.post('/reviews/:id/reply', adminReviewController.replyToReview);

// Bulk update review status
router.post('/reviews/bulk-status', adminReviewController.bulkUpdateStatus);

// Bulk delete reviews
router.post('/reviews/bulk-delete', adminReviewController.bulkDeleteReviews);

// Delete a review (soft delete)
router.delete('/reviews/:id', adminReviewController.deleteReview);

module.exports = router;
