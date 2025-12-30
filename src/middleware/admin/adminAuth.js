const jwt = require('jsonwebtoken');
const ApiResponse = require('../../utils/response');

/**
 * Middleware to authenticate admin users
 */
const authenticateAdmin = (req, res, next) => {
  try {
    // Get token from header
    const authHeader = req.headers.authorization;

    if (!authHeader || !authHeader.startsWith('Bearer ')) {
      return ApiResponse.error(res, 'Access denied. No token provided.', 401);
    }

    const token = authHeader.split(' ')[1];

    // Verify token
    const decoded = jwt.verify(token, process.env.JWT_SECRET);

    // Check if token is for admin
    if (decoded.type !== 'admin') {
      return ApiResponse.error(res, 'Access denied. Admin privileges required.', 403);
    }

    // Attach admin info to request
    req.admin = {
      admin_id: decoded.admin_id,
      email: decoded.email,
      role: decoded.role
    };

    next();

  } catch (error) {
    if (error.name === 'JsonWebTokenError') {
      return ApiResponse.error(res, 'Invalid token', 401);
    }
    if (error.name === 'TokenExpiredError') {
      return ApiResponse.error(res, 'Token expired', 401);
    }
    return ApiResponse.error(res, 'Authentication failed', 401);
  }
};

/**
 * Middleware to check if admin has super_admin role
 */
const requireSuperAdmin = (req, res, next) => {
  if (req.admin.role !== 'super_admin') {
    return ApiResponse.error(res, 'Access denied. Super admin privileges required.', 403);
  }
  next();
};

/**
 * Middleware to check if admin has specific role
 */
const requireRole = (...roles) => {
  return (req, res, next) => {
    if (!roles.includes(req.admin.role)) {
      return ApiResponse.error(res, `Access denied. Required role: ${roles.join(' or ')}`, 403);
    }
    next();
  };
};

module.exports = {
  authenticateAdmin,
  requireSuperAdmin,
  requireRole
};
