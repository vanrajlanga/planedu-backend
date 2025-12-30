const express = require('express');
const router = express.Router();
const adminAuthController = require('../../controllers/admin/adminAuthController');
const { authenticateAdmin } = require('../../middleware/admin/adminAuth');
const { body } = require('express-validator');
const ApiResponse = require('../../utils/response');

// Validation middleware
const validate = (req, res, next) => {
  const { validationResult } = require('express-validator');
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return ApiResponse.error(res, 'Validation failed', 400, errors.array());
  }
  next();
};

// Login validator
const loginValidator = [
  body('email')
    .isEmail()
    .withMessage('Please provide a valid email')
    .normalizeEmail(),
  body('password')
    .notEmpty()
    .withMessage('Password is required')
    .isLength({ min: 6 })
    .withMessage('Password must be at least 6 characters'),
  validate
];

/**
 * @route   POST /api/v1/admin/auth/login
 * @desc    Admin login with email and password
 * @access  Public
 */
router.post('/login', loginValidator, adminAuthController.adminLogin);

/**
 * @route   GET /api/v1/admin/auth/me
 * @desc    Get current admin profile
 * @access  Private (Admin only)
 */
router.get('/me', authenticateAdmin, adminAuthController.getAdminProfile);

/**
 * @route   POST /api/v1/admin/auth/logout
 * @desc    Logout admin
 * @access  Private (Admin only)
 */
router.post('/logout', authenticateAdmin, adminAuthController.adminLogout);

module.exports = router;
