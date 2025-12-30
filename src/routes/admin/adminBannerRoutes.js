const express = require('express');
const router = express.Router();
const {
  getBanners,
  getBannerById,
  createBanner,
  updateBanner,
  deleteBanner,
  getBannerPlacements,
  getBannerPageTypes,
  bulkUpdateStatus,
  getBannerStats,
} = require('../../controllers/admin/adminBannerController');
const { authenticateAdmin } = require('../../middleware/admin/adminAuth');

// All banner routes require admin authentication
router.use(authenticateAdmin);

// Get all banners with pagination and filters
router.get('/', getBanners);

// Get banner placements (must come before /:id)
router.get('/placements', getBannerPlacements);

// Get banner page types (must come before /:id)
router.get('/page-types', getBannerPageTypes);

// Get banner statistics (must come before /:id)
router.get('/stats', getBannerStats);

// Bulk update status
router.post('/bulk-status', bulkUpdateStatus);

// Get single banner
router.get('/:id', getBannerById);

// Create new banner
router.post('/', createBanner);

// Update banner
router.put('/:id', updateBanner);

// Delete banner
router.delete('/:id', deleteBanner);

module.exports = router;
