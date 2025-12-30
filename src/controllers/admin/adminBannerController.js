const { query, getClient } = require('../../config/database');
const ApiResponse = require('../../utils/response');

/**
 * Get all banners with pagination and filters
 * GET /api/v1/admin/banners
 */
const getBanners = async (req, res, next) => {
  try {
    const page = parseInt(req.query.page) || 1;
    const limit = Math.min(parseInt(req.query.limit) || 25, 100);
    const offset = (page - 1) * limit;
    const search = req.query.search?.trim() || '';
    const placement = req.query.placement || '';
    const page_type = req.query.page_type || '';
    const is_active = req.query.is_active;

    // Build WHERE clause
    const conditions = [];
    const params = [];
    let paramIndex = 1;

    if (search) {
      conditions.push(`title ILIKE $${paramIndex}`);
      params.push(`%${search}%`);
      paramIndex++;
    }

    if (placement) {
      conditions.push(`placement = $${paramIndex}`);
      params.push(placement);
      paramIndex++;
    }

    if (page_type) {
      conditions.push(`page_type = $${paramIndex}`);
      params.push(page_type);
      paramIndex++;
    }

    if (is_active !== undefined && is_active !== '') {
      conditions.push(`is_active = $${paramIndex}`);
      params.push(is_active === 'true');
      paramIndex++;
    }

    // Filter for current valid banners
    const include_expired = req.query.include_expired === 'true';
    if (!include_expired) {
      conditions.push(`(valid_to IS NULL OR valid_to >= CURRENT_TIMESTAMP)`);
      conditions.push(`(valid_from IS NULL OR valid_from <= CURRENT_TIMESTAMP)`);
    }

    const whereClause = conditions.length > 0 ? `WHERE ${conditions.join(' AND ')}` : '';

    // Get total count
    const countQuery = `SELECT COUNT(*) as total FROM banners ${whereClause}`;
    const countResult = await query(countQuery, params);
    const total = parseInt(countResult.rows[0].total);

    // Get banners
    const bannersQuery = `
      SELECT *
      FROM banners
      ${whereClause}
      ORDER BY priority DESC, created_at DESC
      LIMIT $${paramIndex} OFFSET $${paramIndex + 1}
    `;
    params.push(limit, offset);

    const bannersResult = await query(bannersQuery, params);

    return ApiResponse.success(res, {
      banners: bannersResult.rows,
      pagination: {
        page,
        limit,
        total,
        totalPages: Math.ceil(total / limit),
        hasNext: page < Math.ceil(total / limit),
        hasPrev: page > 1,
      }
    }, 'Banners retrieved successfully');
  } catch (error) {
    console.error('Get banners error:', error);
    next(error);
  }
};

/**
 * Get single banner by ID
 * GET /api/v1/admin/banners/:id
 */
const getBannerById = async (req, res, next) => {
  try {
    const { id } = req.params;

    const result = await query(
      'SELECT * FROM banners WHERE id = $1',
      [id]
    );

    if (result.rows.length === 0) {
      return ApiResponse.error(res, 'Banner not found', 404);
    }

    return ApiResponse.success(res, result.rows[0], 'Banner retrieved successfully');
  } catch (error) {
    console.error('Get banner error:', error);
    next(error);
  }
};

/**
 * Create new banner
 * POST /api/v1/admin/banners
 */
const createBanner = async (req, res, next) => {
  try {
    const {
      title,
      image_url,
      link_url,
      placement,
      page_type,
      target_audience,
      priority,
      valid_from,
      valid_to,
      is_active
    } = req.body;

    // Validation
    if (!title || !image_url) {
      return ApiResponse.error(res, 'Title and image URL are required', 400);
    }

    const insertQuery = `
      INSERT INTO banners (
        title, image_url, link_url, placement, page_type, target_audience,
        priority, valid_from, valid_to, is_active, created_by
      )
      VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11)
      RETURNING *
    `;

    const result = await query(insertQuery, [
      title,
      image_url,
      link_url || null,
      placement || null,
      page_type || null,
      target_audience || null,
      priority || 0,
      valid_from || null,
      valid_to || null,
      is_active !== undefined ? is_active : true,
      req.admin.admin_id
    ]);

    return ApiResponse.success(res, result.rows[0], 'Banner created successfully', 201);
  } catch (error) {
    console.error('Create banner error:', error);
    next(error);
  }
};

/**
 * Update banner
 * PUT /api/v1/admin/banners/:id
 */
const updateBanner = async (req, res, next) => {
  try {
    const { id } = req.params;
    const {
      title,
      image_url,
      link_url,
      placement,
      page_type,
      target_audience,
      priority,
      valid_from,
      valid_to,
      is_active
    } = req.body;

    // Check if banner exists
    const checkResult = await query('SELECT id FROM banners WHERE id = $1', [id]);
    if (checkResult.rows.length === 0) {
      return ApiResponse.error(res, 'Banner not found', 404);
    }

    const updateQuery = `
      UPDATE banners
      SET
        title = COALESCE($1, title),
        image_url = COALESCE($2, image_url),
        link_url = COALESCE($3, link_url),
        placement = COALESCE($4, placement),
        page_type = COALESCE($5, page_type),
        target_audience = COALESCE($6, target_audience),
        priority = COALESCE($7, priority),
        valid_from = COALESCE($8, valid_from),
        valid_to = COALESCE($9, valid_to),
        is_active = COALESCE($10, is_active),
        updated_at = CURRENT_TIMESTAMP
      WHERE id = $11
      RETURNING *
    `;

    const result = await query(updateQuery, [
      title,
      image_url,
      link_url,
      placement,
      page_type,
      target_audience,
      priority,
      valid_from,
      valid_to,
      is_active,
      id
    ]);

    return ApiResponse.success(res, result.rows[0], 'Banner updated successfully');
  } catch (error) {
    console.error('Update banner error:', error);
    next(error);
  }
};

/**
 * Delete banner
 * DELETE /api/v1/admin/banners/:id
 */
const deleteBanner = async (req, res, next) => {
  try {
    const { id } = req.params;

    const deleteResult = await query(
      'DELETE FROM banners WHERE id = $1 RETURNING id',
      [id]
    );

    if (deleteResult.rows.length === 0) {
      return ApiResponse.error(res, 'Banner not found', 404);
    }

    return ApiResponse.success(res, { id }, 'Banner deleted successfully');
  } catch (error) {
    console.error('Delete banner error:', error);
    next(error);
  }
};

/**
 * Get banner placements
 * GET /api/v1/admin/banners/placements
 */
const getBannerPlacements = async (req, res, next) => {
  try {
    const result = await query(
      'SELECT DISTINCT placement FROM banners WHERE placement IS NOT NULL ORDER BY placement'
    );

    return ApiResponse.success(res, result.rows.map(r => r.placement), 'Placements retrieved successfully');
  } catch (error) {
    console.error('Get placements error:', error);
    next(error);
  }
};

/**
 * Get banner page types
 * GET /api/v1/admin/banners/page-types
 */
const getBannerPageTypes = async (req, res, next) => {
  try {
    const result = await query(
      'SELECT DISTINCT page_type FROM banners WHERE page_type IS NOT NULL ORDER BY page_type'
    );

    return ApiResponse.success(res, result.rows.map(r => r.page_type), 'Page types retrieved successfully');
  } catch (error) {
    console.error('Get page types error:', error);
    next(error);
  }
};

/**
 * Bulk update status
 * POST /api/v1/admin/banners/bulk-status
 */
const bulkUpdateStatus = async (req, res, next) => {
  const client = await getClient();

  try {
    const { banner_ids, is_active } = req.body;

    if (!Array.isArray(banner_ids) || banner_ids.length === 0) {
      return ApiResponse.error(res, 'banner_ids array is required', 400);
    }

    if (is_active === undefined) {
      return ApiResponse.error(res, 'is_active is required', 400);
    }

    await client.query('BEGIN');

    await client.query(
      'UPDATE banners SET is_active = $1 WHERE id = ANY($2::int[])',
      [is_active, banner_ids]
    );

    await client.query('COMMIT');

    return ApiResponse.success(res, { updated: banner_ids.length }, 'Banners status updated successfully');
  } catch (error) {
    await client.query('ROLLBACK');
    console.error('Bulk update status error:', error);
    next(error);
  } finally {
    client.release();
  }
};

/**
 * Get banner statistics
 * GET /api/v1/admin/banners/stats
 */
const getBannerStats = async (req, res, next) => {
  try {
    const statsQuery = `
      SELECT
        COUNT(*) as total,
        COUNT(*) FILTER (WHERE is_active = true) as active,
        COUNT(*) FILTER (WHERE is_active = false) as inactive,
        COUNT(*) FILTER (
          WHERE is_active = true
          AND (valid_from IS NULL OR valid_from <= CURRENT_TIMESTAMP)
          AND (valid_to IS NULL OR valid_to >= CURRENT_TIMESTAMP)
        ) as currently_showing,
        SUM(click_count) as total_clicks,
        SUM(view_count) as total_views
      FROM banners
    `;

    const result = await query(statsQuery);

    return ApiResponse.success(res, result.rows[0], 'Statistics retrieved successfully');
  } catch (error) {
    console.error('Get banner stats error:', error);
    next(error);
  }
};

module.exports = {
  getBanners,
  getBannerById,
  createBanner,
  updateBanner,
  deleteBanner,
  getBannerPlacements,
  getBannerPageTypes,
  bulkUpdateStatus,
  getBannerStats,
};
