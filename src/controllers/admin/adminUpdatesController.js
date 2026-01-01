const { query, getClient } = require('../../config/database');
const ApiResponse = require('../../utils/response');

/**
 * Get all updates for a college
 * GET /api/v1/admin/colleges/:collegeId/updates
 */
const getUpdates = async (req, res, next) => {
  try {
    const { collegeId } = req.params;
    const page = parseInt(req.query.page) || 1;
    const limit = Math.min(parseInt(req.query.limit) || 25, 100);
    const offset = (page - 1) * limit;
    const update_type = req.query.update_type || '';

    // Check if college exists
    const collegeCheck = await query(
      'SELECT college_id, college_name FROM colleges WHERE college_id = $1 AND deleted_at IS NULL',
      [collegeId]
    );

    if (collegeCheck.rows.length === 0) {
      return ApiResponse.error(res, 'College not found', 404);
    }

    // Build query
    const conditions = ['college_id = $1'];
    const params = [collegeId];
    let paramIndex = 2;

    if (update_type) {
      conditions.push(`update_type = $${paramIndex}`);
      params.push(update_type);
      paramIndex++;
    }

    const whereClause = conditions.join(' AND ');

    // Get total count
    const countQuery = `SELECT COUNT(*) as total FROM college_updates WHERE ${whereClause}`;
    const countResult = await query(countQuery, params);
    const total = parseInt(countResult.rows[0].total);

    // Get updates (pinned first, then by date)
    const updatesQuery = `
      SELECT *
      FROM college_updates
      WHERE ${whereClause}
      ORDER BY is_pinned DESC, published_at DESC
      LIMIT $${paramIndex} OFFSET $${paramIndex + 1}
    `;
    params.push(limit, offset);

    const result = await query(updatesQuery, params);

    return ApiResponse.success(res, {
      college: collegeCheck.rows[0],
      updates: result.rows,
      pagination: {
        page,
        limit,
        total,
        totalPages: Math.ceil(total / limit),
        hasNext: page < Math.ceil(total / limit),
        hasPrev: page > 1,
      }
    }, 'Updates retrieved successfully');
  } catch (error) {
    console.error('Get updates error:', error);
    next(error);
  }
};

/**
 * Get single update by ID
 * GET /api/v1/admin/colleges/:collegeId/updates/:id
 */
const getUpdateById = async (req, res, next) => {
  try {
    const { collegeId, id } = req.params;

    const result = await query(
      'SELECT * FROM college_updates WHERE id = $1 AND college_id = $2',
      [id, collegeId]
    );

    if (result.rows.length === 0) {
      return ApiResponse.error(res, 'Update not found', 404);
    }

    return ApiResponse.success(res, result.rows[0], 'Update retrieved successfully');
  } catch (error) {
    console.error('Get update error:', error);
    next(error);
  }
};

/**
 * Create new update
 * POST /api/v1/admin/colleges/:collegeId/updates
 */
const createUpdate = async (req, res, next) => {
  try {
    const { collegeId } = req.params;
    const { update_type, title, content, source_url, event_date, is_pinned, expires_at } = req.body;

    // Check if college exists
    const collegeCheck = await query(
      'SELECT college_id FROM colleges WHERE college_id = $1 AND deleted_at IS NULL',
      [collegeId]
    );

    if (collegeCheck.rows.length === 0) {
      return ApiResponse.error(res, 'College not found', 404);
    }

    // Validation
    if (!title || !content) {
      return ApiResponse.error(res, 'Title and content are required', 400);
    }

    const insertQuery = `
      INSERT INTO college_updates
        (college_id, update_type, title, content, source_url, event_date, is_pinned, expires_at)
      VALUES ($1, $2, $3, $4, $5, $6, $7, $8)
      RETURNING *
    `;

    const result = await query(insertQuery, [
      collegeId,
      update_type || 'key_update',
      title,
      content,
      source_url || null,
      event_date || null,
      is_pinned === true || is_pinned === 'true',
      expires_at || null
    ]);

    return ApiResponse.success(res, result.rows[0], 'Update created successfully', 201);
  } catch (error) {
    console.error('Create update error:', error);
    next(error);
  }
};

/**
 * Update existing update
 * PUT /api/v1/admin/colleges/:collegeId/updates/:id
 */
const updateUpdate = async (req, res, next) => {
  try {
    const { collegeId, id } = req.params;
    const { update_type, title, content, source_url, event_date, is_pinned, expires_at } = req.body;

    // Check if update exists
    const checkResult = await query(
      'SELECT id FROM college_updates WHERE id = $1 AND college_id = $2',
      [id, collegeId]
    );

    if (checkResult.rows.length === 0) {
      return ApiResponse.error(res, 'Update not found', 404);
    }

    const updateQuery = `
      UPDATE college_updates
      SET
        update_type = $1,
        title = $2,
        content = $3,
        source_url = $4,
        event_date = $5,
        is_pinned = $6,
        expires_at = $7
      WHERE id = $8 AND college_id = $9
      RETURNING *
    `;

    const result = await query(updateQuery, [
      update_type || 'key_update',
      title,
      content,
      source_url || null,
      event_date || null,
      is_pinned === true || is_pinned === 'true',
      expires_at || null,
      id,
      collegeId
    ]);

    return ApiResponse.success(res, result.rows[0], 'Update updated successfully');
  } catch (error) {
    console.error('Update update error:', error);
    next(error);
  }
};

/**
 * Delete update
 * DELETE /api/v1/admin/colleges/:collegeId/updates/:id
 */
const deleteUpdate = async (req, res, next) => {
  try {
    const { collegeId, id } = req.params;

    const deleteResult = await query(
      'DELETE FROM college_updates WHERE id = $1 AND college_id = $2 RETURNING id',
      [id, collegeId]
    );

    if (deleteResult.rows.length === 0) {
      return ApiResponse.error(res, 'Update not found', 404);
    }

    return ApiResponse.success(res, { id }, 'Update deleted successfully');
  } catch (error) {
    console.error('Delete update error:', error);
    next(error);
  }
};

/**
 * Toggle pin status
 * PUT /api/v1/admin/colleges/:collegeId/updates/:id/pin
 */
const togglePin = async (req, res, next) => {
  try {
    const { collegeId, id } = req.params;

    // Get current pin status
    const current = await query(
      'SELECT id, is_pinned FROM college_updates WHERE id = $1 AND college_id = $2',
      [id, collegeId]
    );

    if (current.rows.length === 0) {
      return ApiResponse.error(res, 'Update not found', 404);
    }

    // Toggle pin status
    const newStatus = !current.rows[0].is_pinned;

    const result = await query(
      'UPDATE college_updates SET is_pinned = $1 WHERE id = $2 RETURNING *',
      [newStatus, id]
    );

    return ApiResponse.success(res, result.rows[0], `Update ${newStatus ? 'pinned' : 'unpinned'} successfully`);
  } catch (error) {
    console.error('Toggle pin error:', error);
    next(error);
  }
};

module.exports = {
  getUpdates,
  getUpdateById,
  createUpdate,
  updateUpdate,
  deleteUpdate,
  togglePin,
};
