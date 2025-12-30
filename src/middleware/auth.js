const { verifyToken } = require('../utils/jwt');
const ApiResponse = require('../utils/response');

/**
 * Middleware to verify JWT token
 */
const authenticate = async (req, res, next) => {
  try {
    const authHeader = req.headers.authorization;

    if (!authHeader || !authHeader.startsWith('Bearer ')) {
      return ApiResponse.error(res, 'No token provided', 401);
    }

    const token = authHeader.substring(7); // Remove 'Bearer ' prefix

    try {
      const decoded = verifyToken(token);
      req.user = decoded;
      next();
    } catch (error) {
      return ApiResponse.error(res, 'Invalid or expired token', 401);
    }
  } catch (error) {
    return ApiResponse.error(res, 'Authentication failed', 500);
  }
};

/**
 * Middleware to check if user has specific role
 */
const authorize = (...roles) => {
  return (req, res, next) => {
    if (!req.user) {
      return ApiResponse.error(res, 'Unauthorized', 401);
    }

    if (!roles.includes(req.user.user_type)) {
      return ApiResponse.error(
        res,
        'You do not have permission to access this resource',
        403
      );
    }

    next();
  };
};

/**
 * Optional authentication - doesn't fail if no token provided
 */
const optionalAuth = async (req, res, next) => {
  try {
    const authHeader = req.headers.authorization;

    if (authHeader && authHeader.startsWith('Bearer ')) {
      const token = authHeader.substring(7);
      try {
        const decoded = verifyToken(token);
        req.user = decoded;
      } catch (error) {
        // Token invalid, but continue without user
        req.user = null;
      }
    }
    next();
  } catch (error) {
    next();
  }
};

module.exports = {
  authenticate,
  authorize,
  optionalAuth
};
