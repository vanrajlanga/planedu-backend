const bcrypt = require('bcrypt');
const { query, getClient } = require('../../config/database');
const ApiResponse = require('../../utils/response');
const { generateAccessToken, generateRefreshToken } = require('../../utils/jwt');

/**
 * Admin Login
 * POST /api/v1/admin/auth/login
 */
const adminLogin = async (req, res, next) => {
  try {
    const { email, password } = req.body;

    // Find admin user
    const adminResult = await query(
      'SELECT * FROM admin_users WHERE email = $1 AND status = $2',
      [email, 'active']
    );

    if (adminResult.rows.length === 0) {
      return ApiResponse.error(res, 'Invalid credentials', 401);
    }

    const admin = adminResult.rows[0];

    // Verify password
    const isPasswordValid = await bcrypt.compare(password, admin.password_hash);

    if (!isPasswordValid) {
      return ApiResponse.error(res, 'Invalid credentials', 401);
    }

    // Generate JWT tokens
    const tokenPayload = {
      admin_id: admin.admin_id,
      email: admin.email,
      role: admin.role,
      type: 'admin'
    };

    const accessToken = generateAccessToken(tokenPayload);
    const refreshToken = generateRefreshToken(tokenPayload);

    // Create admin session
    await query(
      `INSERT INTO admin_sessions (admin_id, session_token, ip_address, expires_at, created_at)
       VALUES ($1, $2, $3, NOW() + INTERVAL '7 days', NOW())`,
      [admin.admin_id, refreshToken, req.ip]
    );

    // Log admin login
    await query(
      `INSERT INTO admin_audit_logs (admin_id, action, resource_type, ip_address, created_at)
       VALUES ($1, $2, $3, $4, NOW())`,
      [admin.admin_id, 'login', 'admin', req.ip]
    );

    // Remove sensitive data
    delete admin.password_hash;

    return ApiResponse.success(
      res,
      {
        admin: {
          admin_id: admin.admin_id,
          email: admin.email,
          name: admin.name,
          role: admin.role
        },
        access_token: accessToken,
        refresh_token: refreshToken,
        expires_in: 604800 // 7 days
      },
      'Login successful'
    );

  } catch (error) {
    console.error('Admin login error:', error);
    next(error);
  }
};

/**
 * Get Current Admin Profile
 * GET /api/v1/admin/auth/me
 */
const getAdminProfile = async (req, res, next) => {
  try {
    const adminId = req.admin.admin_id;

    const adminResult = await query(
      'SELECT admin_id, email, name, role, status, created_at FROM admin_users WHERE admin_id = $1',
      [adminId]
    );

    if (adminResult.rows.length === 0) {
      return ApiResponse.error(res, 'Admin not found', 404);
    }

    return ApiResponse.success(res, adminResult.rows[0], 'Profile retrieved successfully');

  } catch (error) {
    console.error('Get admin profile error:', error);
    next(error);
  }
};

/**
 * Admin Logout
 * POST /api/v1/admin/auth/logout
 */
const adminLogout = async (req, res, next) => {
  try {
    const adminId = req.admin.admin_id;

    // Invalidate all admin sessions
    await query(
      'UPDATE admin_sessions SET is_active = false WHERE admin_id = $1',
      [adminId]
    );

    // Log admin logout
    await query(
      `INSERT INTO admin_audit_logs (admin_id, action, resource_type, ip_address, created_at)
       VALUES ($1, $2, $3, $4, NOW())`,
      [adminId, 'logout', 'admin', req.ip]
    );

    return ApiResponse.success(res, null, 'Logged out successfully');

  } catch (error) {
    console.error('Admin logout error:', error);
    next(error);
  }
};

module.exports = {
  adminLogin,
  getAdminProfile,
  adminLogout
};
