const ApiResponse = require('../utils/response');

/**
 * Global error handler middleware
 */
const errorHandler = (err, req, res, next) => {
  console.error('Error:', err);

  // Database errors
  if (err.code === '23505') {
    return ApiResponse.error(res, 'Duplicate entry. Resource already exists.', 409);
  }

  if (err.code === '23503') {
    return ApiResponse.error(res, 'Referenced resource not found.', 400);
  }

  if (err.code === '22P02') {
    return ApiResponse.error(res, 'Invalid data type.', 400);
  }

  // Validation errors
  if (err.name === 'ValidationError') {
    return ApiResponse.error(res, 'Validation failed', 400, err.details);
  }

  // JWT errors
  if (err.name === 'JsonWebTokenError') {
    return ApiResponse.error(res, 'Invalid token', 401);
  }

  if (err.name === 'TokenExpiredError') {
    return ApiResponse.error(res, 'Token expired', 401);
  }

  // Default error
  return ApiResponse.error(
    res,
    err.message || 'Internal server error',
    err.statusCode || 500
  );
};

/**
 * 404 handler
 */
const notFoundHandler = (req, res) => {
  return ApiResponse.error(res, `Route ${req.originalUrl} not found`, 404);
};

module.exports = {
  errorHandler,
  notFoundHandler
};
