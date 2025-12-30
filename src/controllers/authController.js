const bcrypt = require('bcrypt');
const { query, getClient } = require('../config/database');
const ApiResponse = require('../utils/response');
const { generateAccessToken, generateRefreshToken } = require('../utils/jwt');

/**
 * User Registration / Request OTP
 * POST /api/v1/auth/register
 */
const register = async (req, res, next) => {
  const client = await getClient();

  try {
    const {
      email,
      phone,
      name,          // Single name field from form
      city,          // Required field
      course,        // Required field
      user_type = 'student'
    } = req.body;

    await client.query('BEGIN');

    // Check if user already exists
    const existingUser = await client.query(
      'SELECT user_id, email_verified FROM users WHERE email = $1 OR phone = $2',
      [email, phone]
    );

    let userId;
    let isNewUser = false;

    if (existingUser.rows.length > 0) {
      // User exists - just send OTP for login
      userId = existingUser.rows[0].user_id;
    } else {
      // New user - create account
      isNewUser = true;

      // Insert user (no password needed)
      const userResult = await client.query(
        `INSERT INTO users (email, phone, user_type, email_verified, phone_verified, status, created_at, updated_at)
         VALUES ($1, $2, $3, false, false, 'active', NOW(), NOW())
         RETURNING user_id, email, user_type, created_at`,
        [email, phone, user_type]
      );

      userId = userResult.rows[0].user_id;

      // Split name into first and last (simple split on first space)
      const nameParts = name ? name.trim().split(/\s+/) : [];
      const firstName = nameParts[0] || '';
      const lastName = nameParts.slice(1).join(' ') || '';

      // Create user profile with city and target_course
      await client.query(
        `INSERT INTO user_profiles (user_id, first_name, last_name, city, target_course, created_at, updated_at)
         VALUES ($1, $2, $3, $4, $5, NOW(), NOW())`,
        [userId, firstName, lastName, city, course]
      );
    }

    // Generate OTP (6 digits)
    const otp = Math.floor(100000 + Math.random() * 900000).toString();

    // Delete any existing unused OTPs for this user
    await client.query(
      'DELETE FROM user_verifications WHERE user_id = $1 AND type = $2 AND consumed = false',
      [userId, email ? 'email' : 'phone']
    );

    // Insert new OTP
    await client.query(
      `INSERT INTO user_verifications (user_id, type, code, expires_at, created_at)
       VALUES ($1, $2, $3, NOW() + INTERVAL '10 minutes', NOW())`,
      [userId, email ? 'email' : 'phone', otp]
    );

    await client.query('COMMIT');

    // TODO: Send OTP via email/SMS
    console.log(`📧 OTP for ${email || phone}: ${otp}`);

    return ApiResponse.success(
      res,
      {
        user_id: userId,
        email: email,
        phone: phone,
        is_new_user: isNewUser,
        otp_sent: true,
        expires_in: 600 // 10 minutes in seconds
      },
      isNewUser ? 'Registration successful. OTP sent.' : 'OTP sent for login.',
      isNewUser ? 201 : 200
    );

  } catch (error) {
    await client.query('ROLLBACK');
    console.error('Registration/OTP request error:', error);
    next(error);
  } finally {
    client.release();
  }
};

/**
 * Verify OTP and Login
 * POST /api/v1/auth/verify-otp
 */
const verifyOTP = async (req, res, next) => {
  try {
    const { email, phone, otp } = req.body;

    const identifier = email || phone;
    const type = email ? 'email' : 'phone';

    // Verify OTP
    const verification = await query(
      `SELECT uv.*, u.user_id, u.email, u.phone, u.user_type
       FROM user_verifications uv
       JOIN users u ON uv.user_id = u.user_id
       WHERE (u.email = $1 OR u.phone = $1)
         AND uv.type = $2
         AND uv.code = $3
         AND uv.expires_at > NOW()
         AND uv.consumed = false`,
      [identifier, type, otp]
    );

    if (verification.rows.length === 0) {
      return ApiResponse.error(res, 'Invalid or expired OTP', 400);
    }

    const userData = verification.rows[0];
    const userId = userData.user_id;
    const verificationId = userData.id;

    // Mark verification as used
    await query(
      'UPDATE user_verifications SET consumed = true WHERE id = $1',
      [verificationId]
    );

    // Mark email/phone as verified
    if (type === 'email') {
      await query(
        'UPDATE users SET email_verified = true, updated_at = NOW() WHERE user_id = $1',
        [userId]
      );
    } else {
      await query(
        'UPDATE users SET phone_verified = true, updated_at = NOW() WHERE user_id = $1',
        [userId]
      );
    }

    // Get full user profile
    const userResult = await query(
      `SELECT
        u.user_id,
        u.email,
        u.phone,
        u.user_type,
        u.email_verified,
        u.phone_verified,
        up.first_name,
        up.last_name,
        up.profile_photo_url
       FROM users u
       LEFT JOIN user_profiles up ON u.user_id = up.user_id
       WHERE u.user_id = $1`,
      [userId]
    );

    const user = userResult.rows[0];

    // Get user roles
    const rolesResult = await query(
      `SELECT r.name as role_name
       FROM user_roles ur
       JOIN roles r ON ur.role_id = r.id
       WHERE ur.user_id = $1`,
      [userId]
    );

    const roles = rolesResult.rows.map(r => r.role_name);

    // Generate tokens
    const tokenPayload = {
      user_id: user.user_id,
      email: user.email,
      phone: user.phone,
      user_type: user.user_type,
      roles
    };

    const accessToken = generateAccessToken(tokenPayload);
    const refreshToken = generateRefreshToken(tokenPayload);

    // Create session
    await query(
      `INSERT INTO user_sessions (user_id, session_token, ip_address, expires_at, created_at)
       VALUES ($1, $2, $3, NOW() + INTERVAL '7 days', NOW())`,
      [
        user.user_id,
        refreshToken,
        req.ip
      ]
    );

    // Update login stats
    await query(
      `UPDATE users
       SET last_login = NOW(), login_count = COALESCE(login_count, 0) + 1, updated_at = NOW()
       WHERE user_id = $1`,
      [user.user_id]
    );

    return ApiResponse.success(
      res,
      {
        user: {
          ...user,
          roles
        },
        access_token: accessToken,
        refresh_token: refreshToken,
        expires_in: 604800 // 7 days in seconds
      },
      'Login successful'
    );

  } catch (error) {
    console.error('OTP verification error:', error);
    next(error);
  }
};

/**
 * Resend OTP
 * POST /api/v1/auth/resend-otp
 */
const resendOTP = async (req, res, next) => {
  try {
    const { email, phone } = req.body;

    const identifier = email || phone;
    const type = email ? 'email' : 'phone';

    // Check if user exists
    const userResult = await query(
      'SELECT user_id FROM users WHERE email = $1 OR phone = $1',
      [identifier]
    );

    if (userResult.rows.length === 0) {
      return ApiResponse.error(res, 'User not found. Please register first.', 404);
    }

    const userId = userResult.rows[0].user_id;

    // Generate new OTP
    const otp = Math.floor(100000 + Math.random() * 900000).toString();

    // Delete any existing unused OTPs
    await query(
      'DELETE FROM user_verifications WHERE user_id = $1 AND type = $2 AND consumed = false',
      [userId, type]
    );

    // Insert new OTP
    await query(
      `INSERT INTO user_verifications (user_id, type, code, expires_at, created_at)
       VALUES ($1, $2, $3, NOW() + INTERVAL '10 minutes', NOW())`,
      [userId, type, otp]
    );

    // TODO: Send OTP via email/SMS
    console.log(`📧 Resent OTP for ${identifier}: ${otp}`);

    return ApiResponse.success(
      res,
      {
        otp_sent: true,
        expires_in: 600
      },
      'OTP resent successfully'
    );

  } catch (error) {
    console.error('Resend OTP error:', error);
    next(error);
  }
};

/**
 * Logout
 * POST /api/v1/auth/logout
 */
const logout = async (req, res, next) => {
  try {
    const userId = req.user.user_id;

    // Delete all active sessions for the user
    await query(
      'UPDATE user_sessions SET is_active = false WHERE user_id = $1',
      [userId]
    );

    return ApiResponse.success(res, null, 'Logged out successfully');

  } catch (error) {
    console.error('Logout error:', error);
    next(error);
  }
};

/**
 * Get Current User Profile
 * GET /api/v1/auth/me
 */
const getProfile = async (req, res, next) => {
  try {
    const userId = req.user.user_id;

    const userResult = await query(
      `SELECT
        u.user_id,
        u.email,
        u.phone,
        u.user_type,
        u.email_verified,
        u.phone_verified,
        u.created_at,
        u.last_login,
        up.first_name,
        up.last_name,
        up.date_of_birth,
        up.gender,
        up.profile_photo_url,
        up.city,
        up.state,
        up.country,
        up.target_course
       FROM users u
       LEFT JOIN user_profiles up ON u.user_id = up.user_id
       WHERE u.user_id = $1`,
      [userId]
    );

    if (userResult.rows.length === 0) {
      return ApiResponse.error(res, 'User not found', 404);
    }

    return ApiResponse.success(res, userResult.rows[0], 'Profile retrieved successfully');

  } catch (error) {
    console.error('Get profile error:', error);
    next(error);
  }
};

/**
 * Update User Profile
 * PUT /api/v1/auth/profile
 */
const updateProfile = async (req, res, next) => {
  try {
    const userId = req.user.user_id;
    const {
      first_name,
      last_name,
      name,           // Single name field (alternative to first/last)
      date_of_birth,
      gender,
      city,
      state,
      country,
      course,         // Target course
      pincode,
      address
    } = req.body;

    // If 'name' is provided, split it into first and last
    let finalFirstName = first_name;
    let finalLastName = last_name;

    if (name && !first_name && !last_name) {
      const nameParts = name.trim().split(/\s+/);
      finalFirstName = nameParts[0] || '';
      finalLastName = nameParts.slice(1).join(' ') || '';
    }

    // Update profile
    await query(
      `UPDATE user_profiles
       SET
         first_name = COALESCE($1, first_name),
         last_name = COALESCE($2, last_name),
         date_of_birth = COALESCE($3, date_of_birth),
         gender = COALESCE($4, gender),
         city = COALESCE($5, city),
         state = COALESCE($6, state),
         country = COALESCE($7, country),
         target_course = COALESCE($8, target_course),
         updated_at = NOW()
       WHERE user_id = $9`,
      [finalFirstName, finalLastName, date_of_birth, gender, city, state, country, course, userId]
    );

    // Get updated profile
    const userResult = await query(
      `SELECT
        u.user_id,
        u.email,
        u.phone,
        u.user_type,
        up.first_name,
        up.last_name,
        up.date_of_birth,
        up.gender,
        up.profile_photo_url,
        up.city,
        up.state,
        up.country,
        up.target_course
       FROM users u
       LEFT JOIN user_profiles up ON u.user_id = up.user_id
       WHERE u.user_id = $1`,
      [userId]
    );

    return ApiResponse.success(
      res,
      userResult.rows[0],
      'Profile updated successfully'
    );

  } catch (error) {
    console.error('Update profile error:', error);
    next(error);
  }
};

module.exports = {
  register,
  verifyOTP,
  resendOTP,
  logout,
  getProfile,
  updateProfile
};
