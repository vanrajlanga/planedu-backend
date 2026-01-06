const { body, validationResult } = require('express-validator');
const ApiResponse = require('../utils/response');

const validate = (req, res, next) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    return ApiResponse.error(res, 'Validation failed', 400, errors.array());
  }
  next();
};

const registerValidator = [
  body('email')
    .optional()
    .isEmail()
    .withMessage('Please provide a valid email')
    .normalizeEmail(),
  body('phone')
    .optional()
    .matches(/^[+]?[\d\s-()]+$/)
    .withMessage('Invalid phone number format'),
  body('name')
    .optional()
    .trim()
    .isLength({ min: 1, max: 200 })
    .withMessage('Name must be between 1 and 200 characters'),
  body('city')
    .optional()
    .trim()
    .isLength({ min: 1, max: 100 })
    .withMessage('City must be between 1 and 100 characters'),
  body('course')
    .optional()
    .trim()
    .isLength({ min: 1, max: 200 })
    .withMessage('Course must be between 1 and 200 characters'),
  body('user_type')
    .optional()
    .isIn(['student', 'parent', 'counsellor', 'admin', 'institution'])
    .withMessage('Invalid user type'),
  // At least one of email or phone must be provided
  body()
    .custom((value, { req }) => {
      if (!req.body.email && !req.body.phone) {
        throw new Error('Either email or phone number is required');
      }
      return true;
    }),
  validate
];

const verifyOTPValidator = [
  body('email')
    .optional()
    .isEmail()
    .withMessage('Please provide a valid email')
    .normalizeEmail(),
  body('phone')
    .optional()
    .matches(/^[+]?[\d\s-()]+$/)
    .withMessage('Invalid phone number format'),
  body('otp')
    .isLength({ min: 6, max: 6 })
    .withMessage('OTP must be 6 digits')
    .isNumeric()
    .withMessage('OTP must contain only numbers'),
  // At least one of email or phone must be provided
  body()
    .custom((value, { req }) => {
      if (!req.body.email && !req.body.phone) {
        throw new Error('Either email or phone number is required');
      }
      return true;
    }),
  validate
];

const resendOTPValidator = [
  body('email')
    .optional()
    .isEmail()
    .withMessage('Please provide a valid email')
    .normalizeEmail(),
  body('phone')
    .optional()
    .matches(/^[+]?[\d\s-()]+$/)
    .withMessage('Invalid phone number format'),
  // At least one of email or phone must be provided
  body()
    .custom((value, { req }) => {
      if (!req.body.email && !req.body.phone) {
        throw new Error('Either email or phone number is required');
      }
      return true;
    }),
  validate
];

const updateProfileValidator = [
  body('first_name')
    .optional()
    .trim()
    .isLength({ min: 1, max: 100 })
    .withMessage('First name must be between 1 and 100 characters'),
  body('last_name')
    .optional()
    .trim()
    .isLength({ min: 1, max: 100 })
    .withMessage('Last name must be between 1 and 100 characters'),
  body('date_of_birth')
    .optional()
    .isISO8601()
    .withMessage('Invalid date format'),
  body('gender')
    .optional()
    .isIn(['male', 'female', 'other', 'prefer_not_to_say'])
    .withMessage('Invalid gender value'),
  validate
];

module.exports = {
  registerValidator,
  verifyOTPValidator,
  resendOTPValidator,
  updateProfileValidator
};
