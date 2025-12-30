const { pool } = require('../../config/database');

/**
 * Get all reviews with pagination, search, and filters
 */
exports.getReviews = async (req, res) => {
  const client = await pool.connect();

  try {
    const {
      page = 1,
      limit = 20,
      search = '',
      college_id,
      user_id,
      status = '',
      min_rating,
      max_rating,
      sort_by = 'created_at',
      sort_order = 'DESC'
    } = req.query;

    const offset = (page - 1) * limit;
    const conditions = ["r.deleted_at IS NULL"];
    const params = [];
    let paramCounter = 1;

    // Search filter
    if (search) {
      conditions.push(`(r.title ILIKE $${paramCounter} OR r.review_text ILIKE $${paramCounter})`);
      params.push(`%${search}%`);
      paramCounter++;
    }

    // College filter
    if (college_id) {
      conditions.push(`r.college_id = $${paramCounter}`);
      params.push(college_id);
      paramCounter++;
    }

    // User filter
    if (user_id) {
      conditions.push(`r.user_id = $${paramCounter}`);
      params.push(user_id);
      paramCounter++;
    }

    // Status filter
    if (status) {
      conditions.push(`r.status = $${paramCounter}`);
      params.push(status);
      paramCounter++;
    }

    // Rating filters
    if (min_rating) {
      conditions.push(`r.overall_rating >= $${paramCounter}`);
      params.push(min_rating);
      paramCounter++;
    }

    if (max_rating) {
      conditions.push(`r.overall_rating <= $${paramCounter}`);
      params.push(max_rating);
      paramCounter++;
    }

    const whereClause = conditions.length > 0 ? `WHERE ${conditions.join(' AND ')}` : '';

    // Validate sort_by to prevent SQL injection
    const validSortColumns = ['overall_rating', 'helpful_count', 'created_at', 'updated_at'];
    const sortColumn = validSortColumns.includes(sort_by) ? sort_by : 'created_at';
    const sortDirection = sort_order.toUpperCase() === 'ASC' ? 'ASC' : 'DESC';

    // Get total count
    const countQuery = `
      SELECT COUNT(*) as total
      FROM reviews r
      ${whereClause}
    `;
    const countResult = await client.query(countQuery, params);
    const total = parseInt(countResult.rows[0].total);

    // Get reviews with user and college info
    const reviewsQuery = `
      SELECT
        r.*,
        COALESCE(up.first_name || ' ' || up.last_name, u.username, u.email) as user_name,
        u.email as user_email,
        c.college_name,
        c.short_name as college_short_name,
        c.city,
        c.state
      FROM reviews r
      LEFT JOIN users u ON r.user_id = u.user_id
      LEFT JOIN user_profiles up ON u.user_id = up.user_id
      LEFT JOIN colleges c ON r.college_id = c.college_id
      ${whereClause}
      ORDER BY r.${sortColumn} ${sortDirection}
      LIMIT $${paramCounter} OFFSET $${paramCounter + 1}
    `;
    params.push(limit, offset);

    const reviewsResult = await client.query(reviewsQuery, params);

    res.json({
      success: true,
      data: reviewsResult.rows,
      pagination: {
        page: parseInt(page),
        limit: parseInt(limit),
        total,
        pages: Math.ceil(total / limit)
      }
    });

  } catch (error) {
    console.error('Get reviews error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch reviews',
      error: error.message
    });
  } finally {
    client.release();
  }
};

/**
 * Get a single review by ID
 */
exports.getReview = async (req, res) => {
  const client = await pool.connect();

  try {
    const { id } = req.params;

    const query = `
      SELECT
        r.*,
        COALESCE(up.first_name || ' ' || up.last_name, u.username, u.email) as user_name,
        u.email as user_email,
        u.phone as user_phone,
        c.college_name,
        c.short_name as college_short_name,
        c.city,
        c.state,
        c.logo_url,
        COALESCE(admin_up.first_name || ' ' || admin_up.last_name, admin_user.username) as replied_by_name
      FROM reviews r
      LEFT JOIN users u ON r.user_id = u.user_id
      LEFT JOIN user_profiles up ON u.user_id = up.user_id
      LEFT JOIN colleges c ON r.college_id = c.college_id
      LEFT JOIN users admin_user ON r.replied_by = admin_user.user_id
      LEFT JOIN user_profiles admin_up ON admin_user.user_id = admin_up.user_id
      WHERE r.review_id = $1 AND r.deleted_at IS NULL
    `;

    const result = await client.query(query, [id]);

    if (result.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Review not found'
      });
    }

    res.json({
      success: true,
      data: result.rows[0]
    });

  } catch (error) {
    console.error('Get review error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch review',
      error: error.message
    });
  } finally {
    client.release();
  }
};

/**
 * Update review status
 */
exports.updateReviewStatus = async (req, res) => {
  const client = await pool.connect();

  try {
    const { id } = req.params;
    const { status } = req.body;

    if (!status || !['pending', 'approved', 'rejected'].includes(status)) {
      return res.status(400).json({
        success: false,
        message: 'Invalid status. Must be pending, approved, or rejected'
      });
    }

    const query = `
      UPDATE reviews
      SET status = $1, updated_at = CURRENT_TIMESTAMP
      WHERE review_id = $2 AND deleted_at IS NULL
      RETURNING *
    `;

    const result = await client.query(query, [status, id]);

    if (result.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Review not found'
      });
    }

    res.json({
      success: true,
      message: 'Review status updated successfully',
      data: result.rows[0]
    });

  } catch (error) {
    console.error('Update review status error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to update review status',
      error: error.message
    });
  } finally {
    client.release();
  }
};

/**
 * Delete a review (soft delete)
 */
exports.deleteReview = async (req, res) => {
  const client = await pool.connect();

  try {
    const { id } = req.params;

    const query = `
      UPDATE reviews
      SET deleted_at = CURRENT_TIMESTAMP
      WHERE review_id = $1 AND deleted_at IS NULL
      RETURNING review_id
    `;

    const result = await client.query(query, [id]);

    if (result.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Review not found'
      });
    }

    res.json({
      success: true,
      message: 'Review deleted successfully'
    });

  } catch (error) {
    console.error('Delete review error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to delete review',
      error: error.message
    });
  } finally {
    client.release();
  }
};

/**
 * Reply to a review
 */
exports.replyToReview = async (req, res) => {
  const client = await pool.connect();

  try {
    const { id } = req.params;
    const { reply } = req.body;

    if (!reply || reply.trim() === '') {
      return res.status(400).json({
        success: false,
        message: 'Reply text is required'
      });
    }

    // Get admin user ID from authenticated request
    const adminUserId = req.user.user_id;

    const query = `
      UPDATE reviews
      SET
        admin_reply = $1,
        replied_at = CURRENT_TIMESTAMP,
        replied_by = $2,
        updated_at = CURRENT_TIMESTAMP
      WHERE review_id = $3 AND deleted_at IS NULL
      RETURNING *
    `;

    const result = await client.query(query, [reply, adminUserId, id]);

    if (result.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Review not found'
      });
    }

    res.json({
      success: true,
      message: 'Reply posted successfully',
      data: result.rows[0]
    });

  } catch (error) {
    console.error('Reply to review error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to post reply',
      error: error.message
    });
  } finally {
    client.release();
  }
};

/**
 * Get review statistics
 */
exports.getReviewStats = async (req, res) => {
  const client = await pool.connect();

  try {
    const { college_id } = req.query;

    let collegeCondition = '';
    const params = [];

    if (college_id) {
      collegeCondition = 'WHERE college_id = $1 AND deleted_at IS NULL';
      params.push(college_id);
    } else {
      collegeCondition = 'WHERE deleted_at IS NULL';
    }

    const statsQuery = `
      SELECT
        COUNT(*) as total_reviews,
        COUNT(CASE WHEN status = 'pending' THEN 1 END) as pending_reviews,
        COUNT(CASE WHEN status = 'approved' THEN 1 END) as approved_reviews,
        COUNT(CASE WHEN status = 'rejected' THEN 1 END) as rejected_reviews,
        ROUND(AVG(overall_rating), 2) as average_rating,
        COUNT(CASE WHEN overall_rating >= 4 THEN 1 END) as positive_reviews,
        COUNT(CASE WHEN overall_rating <= 2 THEN 1 END) as negative_reviews
      FROM reviews
      ${collegeCondition}
    `;

    const statsResult = await client.query(statsQuery, params);

    // Get rating distribution
    const distributionQuery = `
      SELECT
        overall_rating as rating,
        COUNT(*) as count
      FROM reviews
      ${collegeCondition}
      GROUP BY overall_rating
      ORDER BY overall_rating DESC
    `;

    const distributionResult = await client.query(distributionQuery, params);

    res.json({
      success: true,
      data: {
        statistics: statsResult.rows[0],
        rating_distribution: distributionResult.rows
      }
    });

  } catch (error) {
    console.error('Get review stats error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch review statistics',
      error: error.message
    });
  } finally {
    client.release();
  }
};

/**
 * Bulk update review status
 */
exports.bulkUpdateStatus = async (req, res) => {
  const client = await pool.connect();

  try {
    const { review_ids, status } = req.body;

    if (!review_ids || !Array.isArray(review_ids) || review_ids.length === 0) {
      return res.status(400).json({
        success: false,
        message: 'review_ids array is required'
      });
    }

    if (!status || !['pending', 'approved', 'rejected'].includes(status)) {
      return res.status(400).json({
        success: false,
        message: 'Invalid status. Must be pending, approved, or rejected'
      });
    }

    const query = `
      UPDATE reviews
      SET status = $1, updated_at = CURRENT_TIMESTAMP
      WHERE review_id = ANY($2) AND deleted_at IS NULL
    `;

    const result = await client.query(query, [status, review_ids]);

    res.json({
      success: true,
      message: `${result.rowCount} review(s) updated successfully`,
      data: {
        updated_count: result.rowCount
      }
    });

  } catch (error) {
    console.error('Bulk update status error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to update review statuses',
      error: error.message
    });
  } finally {
    client.release();
  }
};

/**
 * Bulk delete reviews
 */
exports.bulkDeleteReviews = async (req, res) => {
  const client = await pool.connect();

  try {
    const { review_ids } = req.body;

    if (!review_ids || !Array.isArray(review_ids) || review_ids.length === 0) {
      return res.status(400).json({
        success: false,
        message: 'review_ids array is required'
      });
    }

    const query = `
      UPDATE reviews
      SET deleted_at = CURRENT_TIMESTAMP
      WHERE review_id = ANY($1) AND deleted_at IS NULL
    `;

    const result = await client.query(query, [review_ids]);

    res.json({
      success: true,
      message: `${result.rowCount} review(s) deleted successfully`,
      data: {
        deleted_count: result.rowCount
      }
    });

  } catch (error) {
    console.error('Bulk delete reviews error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to delete reviews',
      error: error.message
    });
  } finally {
    client.release();
  }
};
