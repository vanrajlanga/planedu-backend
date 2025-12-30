const express = require('express');
const router = express.Router();
const authController = require('../controllers/authController');
const { authenticate } = require('../middleware/auth');
const {
  registerValidator,
  verifyOTPValidator,
  resendOTPValidator,
  updateProfileValidator
} = require('../validators/authValidator');

/**
 * @route   POST /api/v1/auth/register
 * @desc    Register a new user or request OTP for existing user
 * @access  Public
 */
router.post('/register', registerValidator, authController.register);

/**
 * @route   POST /api/v1/auth/verify-otp
 * @desc    Verify OTP and login
 * @access  Public
 */
router.post('/verify-otp', verifyOTPValidator, authController.verifyOTP);

/**
 * @route   POST /api/v1/auth/resend-otp
 * @desc    Resend OTP
 * @access  Public
 */
router.post('/resend-otp', resendOTPValidator, authController.resendOTP);

/**
 * @route   POST /api/v1/auth/logout
 * @desc    Logout user
 * @access  Private
 */
router.post('/logout', authenticate, authController.logout);

/**
 * @route   GET /api/v1/auth/me
 * @desc    Get current user profile
 * @access  Private
 */
router.get('/me', authenticate, authController.getProfile);

/**
 * @route   PUT /api/v1/auth/profile
 * @desc    Update user profile
 * @access  Private
 */
router.put('/profile', authenticate, updateProfileValidator, authController.updateProfile);

module.exports = router;
