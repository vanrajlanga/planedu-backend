const express = require('express');
const router = express.Router();
const {
  getAllSettings,
  getSettingByKey,
  updateSetting,
  bulkUpdateSettings,
  getPublicSettings,
  getCategories,
  createSetting,
  deleteSetting
} = require('../../controllers/admin/adminSettingsController');
const { authenticateAdmin } = require('../../middleware/admin/adminAuth');

// Public routes (no authentication required)
router.get('/public', getPublicSettings);

// All other routes require admin authentication
router.use(authenticateAdmin);

/**
 * @route   GET /api/v1/admin/settings
 * @desc    Get all settings (with optional category filter)
 * @access  Admin
 */
router.get('/', getAllSettings);

/**
 * @route   GET /api/v1/admin/settings/categories
 * @desc    Get all setting categories
 * @access  Admin
 */
router.get('/categories', getCategories);

/**
 * @route   GET /api/v1/admin/settings/:key
 * @desc    Get single setting by key
 * @access  Admin
 */
router.get('/:key', getSettingByKey);

/**
 * @route   POST /api/v1/admin/settings
 * @desc    Create new setting
 * @access  Admin
 */
router.post('/', createSetting);

/**
 * @route   PUT /api/v1/admin/settings/bulk
 * @desc    Bulk update settings
 * @access  Admin
 */
router.put('/bulk', bulkUpdateSettings);

/**
 * @route   PUT /api/v1/admin/settings/:key
 * @desc    Update setting by key
 * @access  Admin
 */
router.put('/:key', updateSetting);

/**
 * @route   DELETE /api/v1/admin/settings/:key
 * @desc    Delete setting by key
 * @access  Admin
 */
router.delete('/:key', deleteSetting);

module.exports = router;
