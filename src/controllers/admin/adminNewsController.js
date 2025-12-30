const { query, getClient } = require('../../config/database');
const ApiResponse = require('../../utils/response');

/**
 * Get all news articles with pagination and filters
 * GET /api/v1/admin/news
 */
const getNewsArticles = async (req, res, next) => {
  try {
    const page = parseInt(req.query.page) || 1;
    const limit = Math.min(parseInt(req.query.limit) || 25, 100);
    const offset = (page - 1) * limit;
    const search = req.query.search?.trim() || '';
    const category = req.query.category || '';
    const status = req.query.status || '';
    const is_featured = req.query.is_featured;

    // Build WHERE clause
    const conditions = [];
    const params = [];
    let paramIndex = 1;

    if (search) {
      conditions.push(`(title ILIKE $${paramIndex} OR content ILIKE $${paramIndex})`);
      params.push(`%${search}%`);
      paramIndex++;
    }

    if (category) {
      conditions.push(`category = $${paramIndex}`);
      params.push(category);
      paramIndex++;
    }

    if (status) {
      conditions.push(`status = $${paramIndex}`);
      params.push(status);
      paramIndex++;
    }

    if (is_featured !== undefined) {
      conditions.push(`is_featured = $${paramIndex}`);
      params.push(is_featured === 'true');
      paramIndex++;
    }

    const whereClause = conditions.length > 0 ? `WHERE ${conditions.join(' AND ')}` : '';

    // Get total count
    const countQuery = `SELECT COUNT(*) as total FROM news_articles ${whereClause}`;
    const countResult = await query(countQuery, params);
    const total = parseInt(countResult.rows[0].total);

    // Get news articles with author info
    const newsQuery = `
      SELECT
        na.*,
        up.first_name || ' ' || up.last_name as author_name,
        u.email as author_email
      FROM news_articles na
      LEFT JOIN users u ON na.author_id = u.user_id
      LEFT JOIN user_profiles up ON u.user_id = up.user_id
      ${whereClause}
      ORDER BY
        CASE WHEN na.published_at IS NULL THEN na.created_at ELSE na.published_at END DESC
      LIMIT $${paramIndex} OFFSET $${paramIndex + 1}
    `;
    params.push(limit, offset);

    const newsResult = await query(newsQuery, params);

    return ApiResponse.success(res, {
      articles: newsResult.rows,
      pagination: {
        page,
        limit,
        total,
        totalPages: Math.ceil(total / limit),
        hasNext: page < Math.ceil(total / limit),
        hasPrev: page > 1,
      }
    }, 'News articles retrieved successfully');
  } catch (error) {
    console.error('Get news articles error:', error);
    next(error);
  }
};

/**
 * Get single news article by ID
 * GET /api/v1/admin/news/:id
 */
const getNewsArticleById = async (req, res, next) => {
  try {
    const { id } = req.params;

    const result = await query(
      `SELECT
        na.*,
        up.first_name || ' ' || up.last_name as author_name,
        u.email as author_email
       FROM news_articles na
       LEFT JOIN users u ON na.author_id = u.user_id
       LEFT JOIN user_profiles up ON u.user_id = up.user_id
       WHERE na.article_id = $1`,
      [id]
    );

    if (result.rows.length === 0) {
      return ApiResponse.error(res, 'News article not found', 404);
    }

    return ApiResponse.success(res, result.rows[0], 'News article retrieved successfully');
  } catch (error) {
    console.error('Get news article error:', error);
    next(error);
  }
};

/**
 * Create new news article
 * POST /api/v1/admin/news
 */
const createNewsArticle = async (req, res, next) => {
  try {
    const {
      title,
      slug,
      content,
      category,
      is_featured,
      status
    } = req.body;

    // Validation
    if (!title || !content) {
      return ApiResponse.error(res, 'Title and content are required', 400);
    }

    // Generate slug if not provided
    let articleSlug = slug;
    if (!articleSlug) {
      articleSlug = title
        .toLowerCase()
        .replace(/[^a-z0-9]+/g, '-')
        .replace(/(^-|-$)/g, '');
    }

    // Check if slug already exists
    const slugCheck = await query(
      'SELECT article_id FROM news_articles WHERE slug = $1',
      [articleSlug]
    );

    if (slugCheck.rows.length > 0) {
      return ApiResponse.error(res, 'Slug already exists. Please use a different slug.', 400);
    }

    const insertQuery = `
      INSERT INTO news_articles (
        title, slug, content, category, author_id, is_featured, status, published_at
      )
      VALUES ($1, $2, $3, $4, $5, $6, $7, $8)
      RETURNING *
    `;

    const result = await query(insertQuery, [
      title,
      articleSlug,
      content,
      category || null,
      null, // author_id set to NULL since admin table is separate from users table
      is_featured || false,
      status || 'draft',
      status === 'published' ? new Date() : null
    ]);

    return ApiResponse.success(res, result.rows[0], 'News article created successfully', 201);
  } catch (error) {
    console.error('Create news article error:', error);
    next(error);
  }
};

/**
 * Update news article
 * PUT /api/v1/admin/news/:id
 */
const updateNewsArticle = async (req, res, next) => {
  try {
    const { id } = req.params;
    const {
      title,
      slug,
      content,
      category,
      is_featured,
      status
    } = req.body;

    // Check if article exists
    const checkResult = await query(
      'SELECT article_id, status FROM news_articles WHERE article_id = $1',
      [id]
    );

    if (checkResult.rows.length === 0) {
      return ApiResponse.error(res, 'News article not found', 404);
    }

    const currentArticle = checkResult.rows[0];

    // Check if slug is being changed and if new slug already exists
    if (slug) {
      const slugCheck = await query(
        'SELECT article_id FROM news_articles WHERE slug = $1 AND article_id != $2',
        [slug, id]
      );

      if (slugCheck.rows.length > 0) {
        return ApiResponse.error(res, 'Slug already exists. Please use a different slug.', 400);
      }
    }

    // Determine if article should be published now
    let published_at = null;
    if (status === 'published' && currentArticle.status !== 'published') {
      published_at = new Date();
    }

    const updateQuery = `
      UPDATE news_articles
      SET
        title = COALESCE($1, title),
        slug = COALESCE($2, slug),
        content = COALESCE($3, content),
        category = COALESCE($4, category),
        is_featured = COALESCE($5, is_featured),
        status = COALESCE($6, status),
        published_at = COALESCE($7, published_at)
      WHERE article_id = $8
      RETURNING *
    `;

    const result = await query(updateQuery, [
      title,
      slug,
      content,
      category,
      is_featured,
      status,
      published_at,
      id
    ]);

    return ApiResponse.success(res, result.rows[0], 'News article updated successfully');
  } catch (error) {
    console.error('Update news article error:', error);
    next(error);
  }
};

/**
 * Delete news article (soft delete if supported, otherwise hard delete)
 * DELETE /api/v1/admin/news/:id
 */
const deleteNewsArticle = async (req, res, next) => {
  try {
    const { id } = req.params;

    const deleteResult = await query(
      'DELETE FROM news_articles WHERE article_id = $1 RETURNING article_id',
      [id]
    );

    if (deleteResult.rows.length === 0) {
      return ApiResponse.error(res, 'News article not found', 404);
    }

    return ApiResponse.success(res, { article_id: id }, 'News article deleted successfully');
  } catch (error) {
    console.error('Delete news article error:', error);
    next(error);
  }
};

/**
 * Get news categories
 * GET /api/v1/admin/news/categories
 */
const getNewsCategories = async (req, res, next) => {
  try {
    const result = await query(
      'SELECT DISTINCT category FROM news_articles WHERE category IS NOT NULL ORDER BY category'
    );

    return ApiResponse.success(res, result.rows.map(r => r.category), 'Categories retrieved successfully');
  } catch (error) {
    console.error('Get categories error:', error);
    next(error);
  }
};

/**
 * Bulk update status
 * POST /api/v1/admin/news/bulk-status
 */
const bulkUpdateStatus = async (req, res, next) => {
  const client = await getClient();

  try {
    const { article_ids, status } = req.body;

    if (!Array.isArray(article_ids) || article_ids.length === 0) {
      return ApiResponse.error(res, 'article_ids array is required', 400);
    }

    if (!status) {
      return ApiResponse.error(res, 'status is required', 400);
    }

    await client.query('BEGIN');

    // Update status and set published_at if changing to published
    let updateQuery;
    let params;

    if (status === 'published') {
      updateQuery = `
        UPDATE news_articles
        SET status = $1,
            published_at = CASE
              WHEN published_at IS NULL THEN CURRENT_TIMESTAMP
              ELSE published_at
            END
        WHERE article_id = ANY($2::bigint[])
      `;
      params = [status, article_ids];
    } else {
      updateQuery = `
        UPDATE news_articles
        SET status = $1
        WHERE article_id = ANY($2::bigint[])
      `;
      params = [status, article_ids];
    }

    await client.query(updateQuery, params);

    await client.query('COMMIT');

    return ApiResponse.success(res, { updated: article_ids.length }, 'Articles status updated successfully');
  } catch (error) {
    await client.query('ROLLBACK');
    console.error('Bulk update status error:', error);
    next(error);
  } finally {
    client.release();
  }
};

/**
 * Get news statistics
 * GET /api/v1/admin/news/stats
 */
const getNewsStats = async (req, res, next) => {
  try {
    const statsQuery = `
      SELECT
        COUNT(*) as total,
        COUNT(*) FILTER (WHERE status = 'published') as published,
        COUNT(*) FILTER (WHERE status = 'draft') as draft,
        COUNT(*) FILTER (WHERE is_featured = true) as featured,
        SUM(view_count) as total_views
      FROM news_articles
    `;

    const result = await query(statsQuery);

    return ApiResponse.success(res, result.rows[0], 'Statistics retrieved successfully');
  } catch (error) {
    console.error('Get news stats error:', error);
    next(error);
  }
};

module.exports = {
  getNewsArticles,
  getNewsArticleById,
  createNewsArticle,
  updateNewsArticle,
  deleteNewsArticle,
  getNewsCategories,
  bulkUpdateStatus,
  getNewsStats,
};
