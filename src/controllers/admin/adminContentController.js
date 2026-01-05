const { query, getClient } = require('../../config/database');
const ApiResponse = require('../../utils/response');

// Valid section types
const VALID_SECTIONS = [
  'overview',
  'courses',
  'admission',
  'cutoff',
  'placement',
  'ranking',
  'scholarship',
  'hostel',
  'faculty',
  'gallery'
];

/**
 * Get all content sections for a college
 * GET /api/v1/admin/colleges/:collegeId/content
 */
const getAllContent = async (req, res, next) => {
  try {
    const { collegeId } = req.params;

    // Check if college exists
    const collegeCheck = await query(
      'SELECT college_id, college_name FROM colleges WHERE college_id = $1 AND deleted_at IS NULL',
      [collegeId]
    );

    if (collegeCheck.rows.length === 0) {
      return ApiResponse.error(res, 'College not found', 404);
    }

    // Get all content sections with author info from admin_users
    const contentQuery = `
      SELECT
        cc.*,
        au.name as author_name,
        au.role as author_designation,
        NULL as author_image
      FROM college_content cc
      LEFT JOIN admin_users au ON cc.author_id = au.admin_id
      WHERE cc.college_id = $1
      ORDER BY cc.section_type ASC
    `;

    const result = await query(contentQuery, [collegeId]);

    // Create a map of existing sections
    const contentMap = {};
    result.rows.forEach(row => {
      contentMap[row.section_type] = row;
    });

    // Return all sections (existing + empty ones)
    const sections = VALID_SECTIONS.map(section => ({
      section_type: section,
      ...contentMap[section] || {
        id: null,
        college_id: parseInt(collegeId),
        title: null,
        content: null,
        author_id: null,
        author_name: null,
        meta_title: null,
        meta_description: null,
        status: 'draft',
        published_at: null,
        updated_at: null
      }
    }));

    return ApiResponse.success(res, {
      college: collegeCheck.rows[0],
      sections
    }, 'Content retrieved successfully');
  } catch (error) {
    console.error('Get all content error:', error);
    next(error);
  }
};

/**
 * Get single content section
 * GET /api/v1/admin/colleges/:collegeId/content/:section
 */
const getContentSection = async (req, res, next) => {
  try {
    const { collegeId, section } = req.params;

    // Validate section type
    if (!VALID_SECTIONS.includes(section)) {
      return ApiResponse.error(res, `Invalid section type. Valid types: ${VALID_SECTIONS.join(', ')}`, 400);
    }

    // Check if college exists
    const collegeCheck = await query(
      'SELECT college_id, college_name FROM colleges WHERE college_id = $1 AND deleted_at IS NULL',
      [collegeId]
    );

    if (collegeCheck.rows.length === 0) {
      return ApiResponse.error(res, 'College not found', 404);
    }

    // Get content section with author info from admin_users
    const contentQuery = `
      SELECT
        cc.*,
        au.name as author_name,
        au.email as author_slug,
        au.role as author_designation,
        NULL as author_image
      FROM college_content cc
      LEFT JOIN admin_users au ON cc.author_id = au.admin_id
      WHERE cc.college_id = $1 AND cc.section_type = $2
    `;

    const result = await query(contentQuery, [collegeId, section]);

    // Return existing or empty content
    const content = result.rows[0] || {
      id: null,
      college_id: parseInt(collegeId),
      section_type: section,
      title: null,
      content: null,
      table_of_contents: null,
      author_id: null,
      author_name: null,
      meta_title: null,
      meta_description: null,
      status: 'draft',
      published_at: null,
      created_at: null,
      updated_at: null
    };

    return ApiResponse.success(res, {
      college: collegeCheck.rows[0],
      content
    }, 'Content section retrieved successfully');
  } catch (error) {
    console.error('Get content section error:', error);
    next(error);
  }
};

/**
 * Update or create content section (upsert)
 * PUT /api/v1/admin/colleges/:collegeId/content/:section
 */
const upsertContentSection = async (req, res, next) => {
  const client = await getClient();

  try {
    const { collegeId, section } = req.params;
    const { title, content, table_of_contents, author_id, meta_title, meta_description, status } = req.body;

    // Validate section type
    if (!VALID_SECTIONS.includes(section)) {
      return ApiResponse.error(res, `Invalid section type. Valid types: ${VALID_SECTIONS.join(', ')}`, 400);
    }

    // Check if college exists
    const collegeCheck = await query(
      'SELECT college_id, college_name FROM colleges WHERE college_id = $1 AND deleted_at IS NULL',
      [collegeId]
    );

    if (collegeCheck.rows.length === 0) {
      return ApiResponse.error(res, 'College not found', 404);
    }

    // If author_id provided, verify it exists in admin_users
    if (author_id) {
      const authorCheck = await query('SELECT admin_id FROM admin_users WHERE admin_id = $1', [author_id]);
      if (authorCheck.rows.length === 0) {
        return ApiResponse.error(res, 'Author not found', 404);
      }
    }

    await client.query('BEGIN');

    // Check if content exists
    const existingContent = await client.query(
      'SELECT id FROM college_content WHERE college_id = $1 AND section_type = $2',
      [collegeId, section]
    );

    let result;
    const published_at = status === 'published' ? 'CURRENT_TIMESTAMP' : null;

    if (existingContent.rows.length > 0) {
      // Update existing
      const updateQuery = `
        UPDATE college_content
        SET
          title = $1,
          content = $2,
          table_of_contents = $3,
          author_id = $4,
          meta_title = $5,
          meta_description = $6,
          status = $7::varchar,
          published_at = CASE WHEN $7::varchar = 'published' AND published_at IS NULL THEN CURRENT_TIMESTAMP ELSE published_at END,
          updated_at = CURRENT_TIMESTAMP
        WHERE college_id = $8 AND section_type = $9
        RETURNING *
      `;

      const statusValue = status || 'draft';
      result = await client.query(updateQuery, [
        title || null,
        content || null,
        table_of_contents ? JSON.stringify(table_of_contents) : null,
        author_id || null,
        meta_title || null,
        meta_description || null,
        statusValue,
        collegeId,
        section
      ]);
    } else {
      // Insert new
      const statusValue = status || 'draft';
      const publishedAtValue = statusValue === 'published' ? new Date() : null;

      const insertQuery = `
        INSERT INTO college_content
          (college_id, section_type, title, content, table_of_contents, author_id, meta_title, meta_description, status, published_at)
        VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10)
        RETURNING *
      `;

      result = await client.query(insertQuery, [
        collegeId,
        section,
        title || null,
        content || null,
        table_of_contents ? JSON.stringify(table_of_contents) : null,
        author_id || null,
        meta_title || null,
        meta_description || null,
        statusValue,
        publishedAtValue
      ]);
    }

    // Get author info from admin_users for response
    let authorInfo = null;
    if (result.rows[0].author_id) {
      const authorResult = await client.query(
        'SELECT name, role as designation FROM admin_users WHERE admin_id = $1',
        [result.rows[0].author_id]
      );
      if (authorResult.rows.length > 0) {
        authorInfo = authorResult.rows[0];
      }
    }

    await client.query('COMMIT');

    return ApiResponse.success(res, {
      ...result.rows[0],
      author_name: authorInfo?.name,
      author_designation: authorInfo?.designation,
      author_image: authorInfo?.profile_image_url
    }, 'Content saved successfully');
  } catch (error) {
    await client.query('ROLLBACK');
    console.error('Upsert content error:', error);
    next(error);
  } finally {
    client.release();
  }
};

/**
 * Get valid section types
 * GET /api/v1/admin/content/sections
 */
const getSectionTypes = async (req, res, next) => {
  try {
    const sections = VALID_SECTIONS.map(section => ({
      value: section,
      label: section.charAt(0).toUpperCase() + section.slice(1).replace(/_/g, ' ')
    }));

    return ApiResponse.success(res, sections, 'Section types retrieved successfully');
  } catch (error) {
    console.error('Get section types error:', error);
    next(error);
  }
};

module.exports = {
  getAllContent,
  getContentSection,
  upsertContentSection,
  getSectionTypes,
  VALID_SECTIONS,
};
