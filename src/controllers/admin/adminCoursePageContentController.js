const { pool } = require('../../config/database');

/**
 * @route GET /api/v1/admin/course-page-content
 * @desc Get all course page content entries
 * @access Admin
 */
exports.getAllCoursePageContent = async (req, res) => {
  const client = await pool.connect();

  try {
    const query = `
      SELECT
        cpc.*,
        au.name as author_name,
        au.role as author_designation,
        NULL as author_avatar
      FROM course_page_content cpc
      LEFT JOIN admin_users au ON cpc.author_id = au.admin_id
      ORDER BY cpc.course_type ASC
    `;

    const result = await client.query(query);

    res.json({
      success: true,
      data: result.rows,
    });
  } catch (error) {
    console.error('Error fetching course page content:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch course page content',
      error: error.message,
    });
  } finally {
    client.release();
  }
};

/**
 * @route GET /api/v1/admin/course-page-content/:courseType
 * @desc Get course page content by course type
 * @access Admin
 */
exports.getCoursePageContentByType = async (req, res) => {
  const client = await pool.connect();

  try {
    const { courseType } = req.params;

    const query = `
      SELECT
        cpc.*,
        au.name as author_name,
        au.role as author_designation,
        NULL as author_avatar
      FROM course_page_content cpc
      LEFT JOIN admin_users au ON cpc.author_id = au.admin_id
      WHERE cpc.course_type = $1
    `;

    const result = await client.query(query, [courseType]);

    if (result.rows.length === 0) {
      // Return empty template for new content
      return res.json({
        success: true,
        data: {
          content_id: null,
          course_type: courseType,
          page_title: '',
          full_content: '',
          author_id: null,
          meta_title: '',
          meta_description: '',
          banners: [],
          status: 'draft',
        },
      });
    }

    res.json({
      success: true,
      data: result.rows[0],
    });
  } catch (error) {
    console.error('Error fetching course page content:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch course page content',
      error: error.message,
    });
  } finally {
    client.release();
  }
};

/**
 * @route POST /api/v1/admin/course-page-content
 * @desc Create new course page content
 * @access Admin
 */
exports.createCoursePageContent = async (req, res) => {
  const client = await pool.connect();

  try {
    const {
      course_type,
      page_title,
      full_content,
      author_id,
      meta_title,
      meta_description,
      banners,
      status = 'draft',
    } = req.body;

    if (!course_type) {
      return res.status(400).json({
        success: false,
        message: 'Course type is required',
      });
    }

    const query = `
      INSERT INTO course_page_content (
        course_type, page_title, full_content, author_id, meta_title, meta_description, banners, status
      )
      VALUES ($1, $2, $3, $4, $5, $6, $7, $8)
      RETURNING *
    `;

    const result = await client.query(query, [
      course_type,
      page_title || null,
      full_content || null,
      author_id || null,
      meta_title || null,
      meta_description || null,
      JSON.stringify(banners || []),
      status,
    ]);

    res.status(201).json({
      success: true,
      message: 'Course page content created successfully',
      data: result.rows[0],
    });
  } catch (error) {
    if (error.code === '23505') {
      return res.status(400).json({
        success: false,
        message: 'Content for this course type already exists',
      });
    }
    console.error('Error creating course page content:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to create course page content',
      error: error.message,
    });
  } finally {
    client.release();
  }
};

/**
 * @route PUT /api/v1/admin/course-page-content/:courseType
 * @desc Update course page content (upsert)
 * @access Admin
 */
exports.updateCoursePageContent = async (req, res) => {
  const client = await pool.connect();

  try {
    const { courseType } = req.params;
    const {
      page_title,
      full_content,
      author_id,
      meta_title,
      meta_description,
      banners,
      status,
    } = req.body;

    // Check if content exists
    const existingCheck = await client.query(
      'SELECT content_id FROM course_page_content WHERE course_type = $1',
      [courseType]
    );

    let result;

    if (existingCheck.rows.length > 0) {
      // Update existing
      const query = `
        UPDATE course_page_content
        SET
          page_title = COALESCE($1, page_title),
          full_content = COALESCE($2, full_content),
          author_id = $3,
          meta_title = COALESCE($4, meta_title),
          meta_description = COALESCE($5, meta_description),
          banners = COALESCE($6, banners),
          status = COALESCE($7, status),
          updated_at = CURRENT_TIMESTAMP
        WHERE course_type = $8
        RETURNING *
      `;

      result = await client.query(query, [
        page_title,
        full_content,
        author_id || null,
        meta_title,
        meta_description,
        banners ? JSON.stringify(banners) : null,
        status,
        courseType,
      ]);
    } else {
      // Insert new
      const query = `
        INSERT INTO course_page_content (
          course_type, page_title, full_content, author_id, meta_title, meta_description, banners, status
        )
        VALUES ($1, $2, $3, $4, $5, $6, $7, $8)
        RETURNING *
      `;

      result = await client.query(query, [
        courseType,
        page_title || null,
        full_content || null,
        author_id || null,
        meta_title || null,
        meta_description || null,
        JSON.stringify(banners || []),
        status || 'draft',
      ]);
    }

    res.json({
      success: true,
      message: 'Course page content saved successfully',
      data: result.rows[0],
    });
  } catch (error) {
    console.error('Error updating course page content:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to update course page content',
      error: error.message,
    });
  } finally {
    client.release();
  }
};

/**
 * @route DELETE /api/v1/admin/course-page-content/:courseType
 * @desc Delete course page content
 * @access Admin
 */
exports.deleteCoursePageContent = async (req, res) => {
  const client = await pool.connect();

  try {
    const { courseType } = req.params;

    const result = await client.query(
      'DELETE FROM course_page_content WHERE course_type = $1 RETURNING *',
      [courseType]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Course page content not found',
      });
    }

    res.json({
      success: true,
      message: 'Course page content deleted successfully',
      data: result.rows[0],
    });
  } catch (error) {
    console.error('Error deleting course page content:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to delete course page content',
      error: error.message,
    });
  } finally {
    client.release();
  }
};

/**
 * @route GET /api/v1/admin/course-page-content/course-types
 * @desc Get available course types for content creation
 * @access Admin
 */
exports.getAvailableCourseTypes = async (req, res) => {
  const client = await pool.connect();

  try {
    // Get course types from quick_tabs that don't have content yet
    const query = `
      SELECT
        qt.degree_type as course_type,
        qt.display_name,
        CASE WHEN cpc.content_id IS NOT NULL THEN true ELSE false END as has_content
      FROM quick_tabs qt
      LEFT JOIN course_page_content cpc ON LOWER(qt.degree_type) = LOWER(cpc.course_type)
      WHERE qt.is_active = true
      ORDER BY qt.display_order ASC
    `;

    const result = await client.query(query);

    res.json({
      success: true,
      data: result.rows,
    });
  } catch (error) {
    console.error('Error fetching available course types:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch available course types',
      error: error.message,
    });
  } finally {
    client.release();
  }
};
