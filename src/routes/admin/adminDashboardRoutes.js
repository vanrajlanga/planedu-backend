const express = require('express');
const router = express.Router();
const {
  getDashboardStats,
  getRecentActivity,
  getAnalytics,
} = require('../../controllers/admin/adminDashboardController');
const { authenticateAdmin } = require('../../middleware/admin/adminAuth');

// All dashboard routes require admin authentication
router.use(authenticateAdmin);

// Dashboard statistics
router.get('/stats', getDashboardStats);

// Recent activity feed
router.get('/recent-activity', getRecentActivity);

// Analytics data
router.get('/analytics', getAnalytics);

module.exports = router;
