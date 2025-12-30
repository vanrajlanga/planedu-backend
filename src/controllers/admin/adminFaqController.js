const { query, getClient } = require('../../config/database');
const ApiResponse = require('../../utils/response');

/**
 * Get all FAQs with pagination and filters
 * GET /api/v1/admin/faqs
 */
const getFaqs = async (req, res, next) => {
  try {
    const page = parseInt(req.query.page) || 1;
    const limit = Math.min(parseInt(req.query.limit) || 25, 100);
    const offset = (page - 1) * limit;
    const search = req.query.search?.trim() || '';
    const category = req.query.category || '';
    const is_active = req.query.is_active;

    // Build WHERE clause
    const conditions = [];
    const params = [];
    let paramIndex = 1;

    if (search) {
      conditions.push(`(question ILIKE $${paramIndex} OR answer ILIKE $${paramIndex})`);
      params.push(`%${search}%`);
      paramIndex++;
    }

    if (category) {
      conditions.push(`category = $${paramIndex}`);
      params.push(category);
      paramIndex++;
    }

    if (is_active !== undefined && is_active !== '') {
      conditions.push(`is_active = $${paramIndex}`);
      params.push(is_active === 'true');
      paramIndex++;
    }

    const whereClause = conditions.length > 0 ? `WHERE ${conditions.join(' AND ')}` : '';

    // Get total count
    const countQuery = `SELECT COUNT(*) as total FROM faqs ${whereClause}`;
    const countResult = await query(countQuery, params);
    const total = parseInt(countResult.rows[0].total);

    // Get FAQs
    const faqsQuery = `
      SELECT *
      FROM faqs
      ${whereClause}
      ORDER BY display_order ASC, created_at DESC
      LIMIT $${paramIndex} OFFSET $${paramIndex + 1}
    `;
    params.push(limit, offset);

    const faqsResult = await query(faqsQuery, params);

    return ApiResponse.success(res, {
      faqs: faqsResult.rows,
      pagination: {
        page,
        limit,
        total,
        totalPages: Math.ceil(total / limit),
        hasNext: page < Math.ceil(total / limit),
        hasPrev: page > 1,
      }
    }, 'FAQs retrieved successfully');
  } catch (error) {
    console.error('Get FAQs error:', error);
    next(error);
  }
};

/**
 * Get single FAQ by ID
 * GET /api/v1/admin/faqs/:id
 */
const getFaqById = async (req, res, next) => {
  try {
    const { id } = req.params;

    const result = await query('SELECT * FROM faqs WHERE id = $1', [id]);

    if (result.rows.length === 0) {
      return ApiResponse.error(res, 'FAQ not found', 404);
    }

    return ApiResponse.success(res, result.rows[0], 'FAQ retrieved successfully');
  } catch (error) {
    console.error('Get FAQ error:', error);
    next(error);
  }
};

/**
 * Create new FAQ
 * POST /api/v1/admin/faqs
 */
const createFaq = async (req, res, next) => {
  try {
    const { category, question, answer, display_order, is_active } = req.body;

    // Validation
    if (!question || !answer) {
      return ApiResponse.error(res, 'Question and answer are required', 400);
    }

    const insertQuery = `
      INSERT INTO faqs (category, question, answer, display_order, is_active)
      VALUES ($1, $2, $3, $4, $5)
      RETURNING *
    `;

    const result = await query(insertQuery, [
      category || null,
      question,
      answer,
      display_order || 0,
      is_active !== undefined ? is_active : true
    ]);

    return ApiResponse.success(res, result.rows[0], 'FAQ created successfully', 201);
  } catch (error) {
    console.error('Create FAQ error:', error);
    next(error);
  }
};

/**
 * Update FAQ
 * PUT /api/v1/admin/faqs/:id
 */
const updateFaq = async (req, res, next) => {
  try {
    const { id } = req.params;
    const { category, question, answer, display_order, is_active } = req.body;

    // Check if FAQ exists
    const checkResult = await query('SELECT id FROM faqs WHERE id = $1', [id]);
    if (checkResult.rows.length === 0) {
      return ApiResponse.error(res, 'FAQ not found', 404);
    }

    const updateQuery = `
      UPDATE faqs
      SET category = $1, question = $2, answer = $3,
          display_order = $4, is_active = $5
      WHERE id = $6
      RETURNING *
    `;

    const result = await query(updateQuery, [
      category || null,
      question,
      answer,
      display_order || 0,
      is_active,
      id
    ]);

    return ApiResponse.success(res, result.rows[0], 'FAQ updated successfully');
  } catch (error) {
    console.error('Update FAQ error:', error);
    next(error);
  }
};

/**
 * Delete FAQ
 * DELETE /api/v1/admin/faqs/:id
 */
const deleteFaq = async (req, res, next) => {
  try {
    const { id } = req.params;

    const deleteResult = await query('DELETE FROM faqs WHERE id = $1 RETURNING id', [id]);

    if (deleteResult.rows.length === 0) {
      return ApiResponse.error(res, 'FAQ not found', 404);
    }

    return ApiResponse.success(res, { id }, 'FAQ deleted successfully');
  } catch (error) {
    console.error('Delete FAQ error:', error);
    next(error);
  }
};

/**
 * Get FAQ categories
 * GET /api/v1/admin/faqs/categories
 */
const getFaqCategories = async (req, res, next) => {
  try {
    const result = await query(
      'SELECT DISTINCT category FROM faqs WHERE category IS NOT NULL ORDER BY category'
    );

    return ApiResponse.success(res, result.rows.map(r => r.category), 'Categories retrieved successfully');
  } catch (error) {
    console.error('Get categories error:', error);
    next(error);
  }
};

/**
 * Reorder FAQs
 * POST /api/v1/admin/faqs/reorder
 */
const reorderFaqs = async (req, res, next) => {
  const client = await getClient();

  try {
    const { faqs } = req.body; // Array of {id, display_order}

    if (!Array.isArray(faqs) || faqs.length === 0) {
      return ApiResponse.error(res, 'FAQs array is required', 400);
    }

    await client.query('BEGIN');

    // Update each FAQ's display order
    for (const faq of faqs) {
      await client.query(
        'UPDATE faqs SET display_order = $1 WHERE id = $2',
        [faq.display_order, faq.id]
      );
    }

    await client.query('COMMIT');

    return ApiResponse.success(res, null, 'FAQs reordered successfully');
  } catch (error) {
    await client.query('ROLLBACK');
    console.error('Reorder FAQs error:', error);
    next(error);
  } finally {
    client.release();
  }
};

module.exports = {
  getFaqs,
  getFaqById,
  createFaq,
  updateFaq,
  deleteFaq,
  getFaqCategories,
  reorderFaqs,
};
