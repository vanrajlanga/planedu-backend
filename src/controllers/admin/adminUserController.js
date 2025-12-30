const { query, getClient } = require('../../config/database');
const ApiResponse = require('../../utils/response');

/**
 * Get all users with pagination, search, filtering, and sorting
 * GET /api/v1/admin/users
 * Query params: page, limit, search, status, user_type, sort, order
 */
const getUsers = async (req, res, next) => {
  try {
    // Parse and validate query parameters
    const page = parseInt(req.query.page) || 1;
    const limit = Math.min(parseInt(req.query.limit) || 25, 100); // Max 100 per page
    const offset = (page - 1) * limit;
    const search = req.query.search?.trim() || '';
    const status = req.query.status || ''; // active, inactive, suspended
    const userType = req.query.user_type || ''; // student, counselor, institution
    const sortBy = req.query.sort || 'created_at'; // Default sort by created_at
    const order = req.query.order?.toUpperCase() === 'ASC' ? 'ASC' : 'DESC';

    // Validate sort column to prevent SQL injection
    const allowedSortColumns = ['created_at', 'email', 'user_type', 'last_login', 'login_count'];
    const sortColumn = allowedSortColumns.includes(sortBy) ? sortBy : 'created_at';

    // Build WHERE clause dynamically with parameterized queries
    const conditions = [];
    const params = [];
    let paramIndex = 1;

    // Search filter (email, phone, or name)
    if (search) {
      conditions.push(`(
        u.email ILIKE $${paramIndex} OR
        u.phone ILIKE $${paramIndex + 1} OR
        up.first_name ILIKE $${paramIndex + 2} OR
        up.last_name ILIKE $${paramIndex + 3}
      )`);
      params.push(`%${search}%`, `%${search}%`, `%${search}%`, `%${search}%`);
      paramIndex += 4;
    }

    // Status filter
    if (status) {
      conditions.push(`u.status = $${paramIndex}`);
      params.push(status);
      paramIndex++;
    }

    // User type filter
    if (userType) {
      conditions.push(`u.user_type = $${paramIndex}`);
      params.push(userType);
      paramIndex++;
    }

    const whereClause = conditions.length > 0 ? `WHERE ${conditions.join(' AND ')}` : '';

    // Get total count for pagination
    const countQuery = `
      SELECT COUNT(DISTINCT u.user_id) as total
      FROM users u
      LEFT JOIN user_profiles up ON u.user_id = up.user_id
      ${whereClause}
    `;
    const countResult = await query(countQuery, params);
    const total = parseInt(countResult.rows[0].total);
    const totalPages = Math.ceil(total / limit);

    // Get paginated users
    const usersQuery = `
      SELECT
        u.user_id,
        u.email,
        u.phone,
        u.user_type,
        u.status,
        u.email_verified,
        u.phone_verified,
        u.created_at,
        u.last_login,
        u.login_count,
        up.first_name,
        up.last_name,
        up.city,
        up.state,
        up.profile_photo_url,
        up.target_course
      FROM users u
      LEFT JOIN user_profiles up ON u.user_id = up.user_id
      ${whereClause}
      ORDER BY u.${sortColumn} ${order}
      LIMIT $${paramIndex} OFFSET $${paramIndex + 1}
    `;

    params.push(limit, offset);
    const usersResult = await query(usersQuery, params);

    // Build pagination metadata
    const pagination = {
      page,
      limit,
      total,
      totalPages,
      hasNext: page < totalPages,
      hasPrev: page > 1,
    };

    return ApiResponse.success(res, {
      users: usersResult.rows,
      pagination,
    }, 'Users retrieved successfully');
  } catch (error) {
    console.error('Get users error:', error);
    next(error);
  }
};

/**
 * Get single user by ID
 * GET /api/v1/admin/users/:id
 */
const getUserById = async (req, res, next) => {
  try {
    const { id } = req.params;

    const userQuery = `
      SELECT
        u.user_id,
        u.email,
        u.phone,
        u.user_type,
        u.status,
        u.email_verified,
        u.phone_verified,
        u.created_at,
        u.updated_at,
        u.last_login,
        u.login_count,
        up.first_name,
        up.last_name,
        up.date_of_birth,
        up.gender,
        up.city,
        up.state,
        up.country,
        up.profile_photo_url,
        up.bio,
        up.target_course,
        up.current_education_level
      FROM users u
      LEFT JOIN user_profiles up ON u.user_id = up.user_id
      WHERE u.user_id = $1
    `;

    const userResult = await query(userQuery, [id]);

    if (userResult.rows.length === 0) {
      return ApiResponse.error(res, 'User not found', 404);
    }

    // Get user's roles
    const rolesQuery = `
      SELECT r.name as role_name
      FROM user_roles ur
      JOIN roles r ON ur.role_id = r.id
      WHERE ur.user_id = $1
    `;
    const rolesResult = await query(rolesQuery, [id]);

    const user = {
      ...userResult.rows[0],
      roles: rolesResult.rows.map(r => r.role_name),
    };

    return ApiResponse.success(res, user, 'User retrieved successfully');
  } catch (error) {
    console.error('Get user error:', error);
    next(error);
  }
};

/**
 * Update user details
 * PUT /api/v1/admin/users/:id
 */
const updateUser = async (req, res, next) => {
  const client = await getClient();

  try {
    await client.query('BEGIN');

    const { id } = req.params;
    const {
      email,
      phone,
      user_type,
      first_name,
      last_name,
      date_of_birth,
      gender,
      city,
      state,
      country,
      bio,
      target_course,
      current_education_level,
    } = req.body;

    // Check if user exists
    const userCheck = await client.query('SELECT user_id FROM users WHERE user_id = $1', [id]);
    if (userCheck.rows.length === 0) {
      await client.query('ROLLBACK');
      return ApiResponse.error(res, 'User not found', 404);
    }

    // Update users table (only allowed fields)
    const userUpdates = [];
    const userParams = [];
    let paramIndex = 1;

    if (email !== undefined) {
      userUpdates.push(`email = $${paramIndex}`);
      userParams.push(email);
      paramIndex++;
    }

    if (phone !== undefined) {
      userUpdates.push(`phone = $${paramIndex}`);
      userParams.push(phone);
      paramIndex++;
    }

    if (user_type !== undefined) {
      userUpdates.push(`user_type = $${paramIndex}`);
      userParams.push(user_type);
      paramIndex++;
    }

    if (userUpdates.length > 0) {
      userUpdates.push(`updated_at = NOW()`);
      userParams.push(id);
      const userUpdateQuery = `
        UPDATE users
        SET ${userUpdates.join(', ')}
        WHERE user_id = $${paramIndex}
      `;
      await client.query(userUpdateQuery, userParams);
    }

    // Update user_profiles table
    const profileUpdates = [];
    const profileParams = [];
    let profileParamIndex = 1;

    if (first_name !== undefined) {
      profileUpdates.push(`first_name = $${profileParamIndex}`);
      profileParams.push(first_name);
      profileParamIndex++;
    }

    if (last_name !== undefined) {
      profileUpdates.push(`last_name = $${profileParamIndex}`);
      profileParams.push(last_name);
      profileParamIndex++;
    }

    if (date_of_birth !== undefined) {
      profileUpdates.push(`date_of_birth = $${profileParamIndex}`);
      profileParams.push(date_of_birth);
      profileParamIndex++;
    }

    if (gender !== undefined) {
      profileUpdates.push(`gender = $${profileParamIndex}`);
      profileParams.push(gender);
      profileParamIndex++;
    }

    if (city !== undefined) {
      profileUpdates.push(`city = $${profileParamIndex}`);
      profileParams.push(city);
      profileParamIndex++;
    }

    if (state !== undefined) {
      profileUpdates.push(`state = $${profileParamIndex}`);
      profileParams.push(state);
      profileParamIndex++;
    }

    if (country !== undefined) {
      profileUpdates.push(`country = $${profileParamIndex}`);
      profileParams.push(country);
      profileParamIndex++;
    }

    if (bio !== undefined) {
      profileUpdates.push(`bio = $${profileParamIndex}`);
      profileParams.push(bio);
      profileParamIndex++;
    }

    if (target_course !== undefined) {
      profileUpdates.push(`target_course = $${profileParamIndex}`);
      profileParams.push(target_course);
      profileParamIndex++;
    }

    if (current_education_level !== undefined) {
      profileUpdates.push(`current_education_level = $${profileParamIndex}`);
      profileParams.push(current_education_level);
      profileParamIndex++;
    }

    if (profileUpdates.length > 0) {
      profileUpdates.push(`updated_at = NOW()`);
      profileParams.push(id);
      const profileUpdateQuery = `
        UPDATE user_profiles
        SET ${profileUpdates.join(', ')}
        WHERE user_id = $${profileParamIndex}
      `;
      await client.query(profileUpdateQuery, profileParams);
    }

    // Log admin action
    await client.query(
      `INSERT INTO admin_audit_logs (admin_id, action, resource_type, resource_id, details, created_at)
       VALUES ($1, $2, $3, $4, $5, NOW())`,
      [req.admin.admin_id, 'UPDATE', 'user', id, JSON.stringify({ updates: req.body })]
    );

    await client.query('COMMIT');

    // Fetch updated user
    const updatedUserResult = await query(
      `SELECT u.*, up.first_name, up.last_name, up.city, up.state
       FROM users u
       LEFT JOIN user_profiles up ON u.user_id = up.user_id
       WHERE u.user_id = $1`,
      [id]
    );

    return ApiResponse.success(res, updatedUserResult.rows[0], 'User updated successfully');
  } catch (error) {
    await client.query('ROLLBACK');
    console.error('Update user error:', error);
    next(error);
  } finally {
    client.release();
  }
};

/**
 * Update user status
 * PUT /api/v1/admin/users/:id/status
 */
const updateUserStatus = async (req, res, next) => {
  try {
    const { id } = req.params;
    const { status } = req.body;

    // Validate status
    const validStatuses = ['active', 'inactive', 'suspended'];
    if (!validStatuses.includes(status)) {
      return ApiResponse.error(res, 'Invalid status. Must be: active, inactive, or suspended', 400);
    }

    // Update status
    const updateResult = await query(
      'UPDATE users SET status = $1, updated_at = NOW() WHERE user_id = $2 RETURNING user_id, status',
      [status, id]
    );

    if (updateResult.rows.length === 0) {
      return ApiResponse.error(res, 'User not found', 404);
    }

    // Log admin action
    await query(
      `INSERT INTO admin_audit_logs (admin_id, action, resource_type, resource_id, details, created_at)
       VALUES ($1, $2, $3, $4, $5, NOW())`,
      [req.admin.admin_id, 'UPDATE_STATUS', 'user', id, JSON.stringify({ status })]
    );

    return ApiResponse.success(res, updateResult.rows[0], 'User status updated successfully');
  } catch (error) {
    console.error('Update user status error:', error);
    next(error);
  }
};

/**
 * Delete user (soft delete - set status to inactive)
 * DELETE /api/v1/admin/users/:id
 */
const deleteUser = async (req, res, next) => {
  try {
    const { id } = req.params;

    // Soft delete by setting status to inactive
    const deleteResult = await query(
      'UPDATE users SET status = $1, updated_at = NOW() WHERE user_id = $2 RETURNING user_id',
      ['inactive', id]
    );

    if (deleteResult.rows.length === 0) {
      return ApiResponse.error(res, 'User not found', 404);
    }

    // Log admin action
    await query(
      `INSERT INTO admin_audit_logs (admin_id, action, resource_type, resource_id, details, created_at)
       VALUES ($1, $2, $3, $4, $5, NOW())`,
      [req.admin.admin_id, 'DELETE', 'user', id, JSON.stringify({ soft_delete: true })]
    );

    return ApiResponse.success(res, { user_id: id }, 'User deleted successfully');
  } catch (error) {
    console.error('Delete user error:', error);
    next(error);
  }
};

/**
 * Bulk update user status
 * POST /api/v1/admin/users/bulk-status
 */
const bulkUpdateStatus = async (req, res, next) => {
  const client = await getClient();

  try {
    const { user_ids, status } = req.body;

    // Validate
    if (!Array.isArray(user_ids) || user_ids.length === 0) {
      return ApiResponse.error(res, 'user_ids must be a non-empty array', 400);
    }

    if (user_ids.length > 100) {
      return ApiResponse.error(res, 'Maximum 100 users can be updated at once', 400);
    }

    const validStatuses = ['active', 'inactive', 'suspended'];
    if (!validStatuses.includes(status)) {
      return ApiResponse.error(res, 'Invalid status', 400);
    }

    await client.query('BEGIN');

    // Bulk update with transaction
    const placeholders = user_ids.map((_, i) => `$${i + 2}`).join(',');
    const updateQuery = `
      UPDATE users
      SET status = $1, updated_at = NOW()
      WHERE user_id IN (${placeholders})
      RETURNING user_id
    `;

    const updateResult = await client.query(updateQuery, [status, ...user_ids]);
    const affectedCount = updateResult.rows.length;

    // Log admin action
    await client.query(
      `INSERT INTO admin_audit_logs (admin_id, action, resource_type, resource_id, details, created_at)
       VALUES ($1, $2, $3, $4, $5, NOW())`,
      [req.admin.admin_id, 'BULK_UPDATE_STATUS', 'user', null, JSON.stringify({ user_ids, status, affected: affectedCount })]
    );

    await client.query('COMMIT');

    return ApiResponse.success(res, { affected: affectedCount }, `${affectedCount} users updated successfully`);
  } catch (error) {
    await client.query('ROLLBACK');
    console.error('Bulk update status error:', error);
    next(error);
  } finally {
    client.release();
  }
};

/**
 * Export users to CSV
 * GET /api/v1/admin/users/export
 */
const exportUsers = async (req, res, next) => {
  try {
    const { status, user_type } = req.query;

    // Build WHERE clause
    const conditions = [];
    const params = [];
    let paramIndex = 1;

    if (status) {
      conditions.push(`u.status = $${paramIndex}`);
      params.push(status);
      paramIndex++;
    }

    if (user_type) {
      conditions.push(`u.user_type = $${paramIndex}`);
      params.push(user_type);
      paramIndex++;
    }

    const whereClause = conditions.length > 0 ? `WHERE ${conditions.join(' AND ')}` : '';

    // Fetch all users matching criteria
    const usersQuery = `
      SELECT
        u.user_id,
        u.email,
        u.phone,
        u.user_type,
        u.status,
        u.email_verified,
        u.phone_verified,
        u.created_at,
        u.last_login,
        up.first_name,
        up.last_name,
        up.city,
        up.state,
        up.target_course
      FROM users u
      LEFT JOIN user_profiles up ON u.user_id = up.user_id
      ${whereClause}
      ORDER BY u.created_at DESC
    `;

    const usersResult = await query(usersQuery, params);

    // Convert to CSV format
    const users = usersResult.rows;
    if (users.length === 0) {
      return ApiResponse.error(res, 'No users found to export', 404);
    }

    // CSV Headers
    const headers = [
      'User ID', 'Email', 'Phone', 'First Name', 'Last Name',
      'User Type', 'Status', 'City', 'State', 'Target Course',
      'Email Verified', 'Phone Verified', 'Last Login', 'Created At'
    ];

    // CSV Rows
    const csvRows = users.map(user => [
      user.user_id,
      user.email || '',
      user.phone || '',
      user.first_name || '',
      user.last_name || '',
      user.user_type,
      user.status,
      user.city || '',
      user.state || '',
      user.target_course || '',
      user.email_verified ? 'Yes' : 'No',
      user.phone_verified ? 'Yes' : 'No',
      user.last_login || '',
      user.created_at
    ].map(field => `"${String(field).replace(/"/g, '""')}"`).join(','));

    const csv = [headers.join(','), ...csvRows].join('\n');

    // Set headers for file download
    res.setHeader('Content-Type', 'text/csv');
    res.setHeader('Content-Disposition', `attachment; filename="users-export-${Date.now()}.csv"`);
    res.send(csv);
  } catch (error) {
    console.error('Export users error:', error);
    next(error);
  }
};

/**
 * Get all available roles
 * GET /api/v1/admin/users/roles
 */
const getAllRoles = async (req, res, next) => {
  try {
    const rolesResult = await query('SELECT * FROM roles ORDER BY name');

    return ApiResponse.success(res, rolesResult.rows, 'Roles retrieved successfully');
  } catch (error) {
    console.error('Get roles error:', error);
    next(error);
  }
};

/**
 * Assign role to user
 * POST /api/v1/admin/users/:id/roles
 */
const assignUserRole = async (req, res, next) => {
  const client = await getClient();

  try {
    const { id } = req.params;
    const { role_id } = req.body;

    if (!role_id) {
      return ApiResponse.error(res, 'role_id is required', 400);
    }

    await client.query('BEGIN');

    // Check if user exists
    const userCheck = await client.query('SELECT user_id FROM users WHERE user_id = $1', [id]);
    if (userCheck.rows.length === 0) {
      await client.query('ROLLBACK');
      return ApiResponse.error(res, 'User not found', 404);
    }

    // Check if role exists
    const roleCheck = await client.query('SELECT id FROM roles WHERE id = $1', [role_id]);
    if (roleCheck.rows.length === 0) {
      await client.query('ROLLBACK');
      return ApiResponse.error(res, 'Role not found', 404);
    }

    // Check if user already has this role
    const existingRole = await client.query(
      'SELECT * FROM user_roles WHERE user_id = $1 AND role_id = $2',
      [id, role_id]
    );

    if (existingRole.rows.length > 0) {
      await client.query('ROLLBACK');
      return ApiResponse.error(res, 'User already has this role', 400);
    }

    // Assign role
    await client.query(
      'INSERT INTO user_roles (user_id, role_id) VALUES ($1, $2)',
      [id, role_id]
    );

    // Log admin action
    await client.query(
      `INSERT INTO admin_audit_logs (admin_id, action, resource_type, resource_id, details, created_at)
       VALUES ($1, $2, $3, $4, $5, NOW())`,
      [req.admin.admin_id, 'ASSIGN_ROLE', 'user', id, JSON.stringify({ role_id })]
    );

    await client.query('COMMIT');

    return ApiResponse.success(res, { user_id: id, role_id }, 'Role assigned successfully');
  } catch (error) {
    await client.query('ROLLBACK');
    console.error('Assign role error:', error);
    next(error);
  } finally {
    client.release();
  }
};

/**
 * Remove role from user
 * DELETE /api/v1/admin/users/:id/roles/:roleId
 */
const removeUserRole = async (req, res, next) => {
  const client = await getClient();

  try {
    const { id, roleId } = req.params;

    await client.query('BEGIN');

    // Remove role
    const deleteResult = await client.query(
      'DELETE FROM user_roles WHERE user_id = $1 AND role_id = $2 RETURNING *',
      [id, roleId]
    );

    if (deleteResult.rows.length === 0) {
      await client.query('ROLLBACK');
      return ApiResponse.error(res, 'Role assignment not found', 404);
    }

    // Log admin action
    await client.query(
      `INSERT INTO admin_audit_logs (admin_id, action, resource_type, resource_id, details, created_at)
       VALUES ($1, $2, $3, $4, $5, NOW())`,
      [req.admin.admin_id, 'REMOVE_ROLE', 'user', id, JSON.stringify({ role_id: roleId })]
    );

    await client.query('COMMIT');

    return ApiResponse.success(res, { user_id: id, role_id: roleId }, 'Role removed successfully');
  } catch (error) {
    await client.query('ROLLBACK');
    console.error('Remove role error:', error);
    next(error);
  } finally {
    client.release();
  }
};

/**
 * Get user activity logs
 * GET /api/v1/admin/users/:id/activity
 */
const getUserActivity = async (req, res, next) => {
  try {
    const { id } = req.params;
    const limit = parseInt(req.query.limit) || 50;
    const page = parseInt(req.query.page) || 1;
    const offset = (page - 1) * limit;

    // Check if user exists
    const userCheck = await query('SELECT user_id FROM users WHERE user_id = $1', [id]);
    if (userCheck.rows.length === 0) {
      return ApiResponse.error(res, 'User not found', 404);
    }

    // Get total count
    const countResult = await query(
      'SELECT COUNT(*) as total FROM analytics.user_activity WHERE user_id = $1',
      [id]
    );
    const total = parseInt(countResult.rows[0].total);

    // Get activity logs
    const activityResult = await query(
      `SELECT
        id, activity_type, entity_type, entity_id,
        search_query, filters_applied, meta, created_at
       FROM analytics.user_activity
       WHERE user_id = $1
       ORDER BY created_at DESC
       LIMIT $2 OFFSET $3`,
      [id, limit, offset]
    );

    return ApiResponse.success(res, {
      activities: activityResult.rows,
      pagination: {
        page,
        limit,
        total,
        totalPages: Math.ceil(total / limit),
      }
    }, 'User activity retrieved successfully');
  } catch (error) {
    console.error('Get user activity error:', error);
    next(error);
  }
};

/**
 * Initiate password reset for user
 * POST /api/v1/admin/users/:id/reset-password
 */
const initiatePasswordReset = async (req, res, next) => {
  const client = await getClient();

  try {
    const { id } = req.params;

    await client.query('BEGIN');

    // Check if user exists
    const userResult = await client.query(
      'SELECT user_id, email FROM users WHERE user_id = $1',
      [id]
    );

    if (userResult.rows.length === 0) {
      await client.query('ROLLBACK');
      return ApiResponse.error(res, 'User not found', 404);
    }

    const user = userResult.rows[0];

    // Generate reset token (simple random string for admin-initiated reset)
    const resetToken = require('crypto').randomBytes(32).toString('hex');
    const expiresAt = new Date(Date.now() + 24 * 60 * 60 * 1000); // 24 hours

    // Delete any existing reset tokens for this user
    await client.query('DELETE FROM password_resets WHERE user_id = $1', [id]);

    // Insert new reset token
    await client.query(
      `INSERT INTO password_resets (user_id, token, expires_at, created_at)
       VALUES ($1, $2, $3, NOW())`,
      [id, resetToken, expiresAt]
    );

    // Log admin action
    await client.query(
      `INSERT INTO admin_audit_logs (admin_id, action, resource_type, resource_id, details, created_at)
       VALUES ($1, $2, $3, $4, $5, NOW())`,
      [req.admin.admin_id, 'INITIATE_PASSWORD_RESET', 'user', id, JSON.stringify({ email: user.email })]
    );

    await client.query('COMMIT');

    // In production, you would send an email with the reset link
    // For now, return the token (admin can manually provide to user)
    return ApiResponse.success(res, {
      user_id: id,
      email: user.email,
      reset_token: resetToken,
      expires_at: expiresAt,
      reset_link: `${process.env.FRONTEND_URL || 'http://localhost:3001'}/reset-password?token=${resetToken}`
    }, 'Password reset initiated successfully');
  } catch (error) {
    await client.query('ROLLBACK');
    console.error('Initiate password reset error:', error);
    next(error);
  } finally {
    client.release();
  }
};

module.exports = {
  getUsers,
  getUserById,
  updateUser,
  updateUserStatus,
  deleteUser,
  bulkUpdateStatus,
  exportUsers,
  getAllRoles,
  assignUserRole,
  removeUserRole,
  getUserActivity,
  initiatePasswordReset,
};
