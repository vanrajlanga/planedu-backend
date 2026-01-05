const { pool } = require('../../config/database');

/**
 * @route GET /api/v1/admin/course-location-content
 * @desc Get all course location content entries
 * @access Admin
 */
exports.getAll = async (req, res) => {
  const client = await pool.connect();

  try {
    const { course_type, location_type, status, page = 1, limit = 50 } = req.query;
    const offset = (page - 1) * limit;

    let query = `
      SELECT
        clc.*,
        au.name as author_name
      FROM course_location_content clc
      LEFT JOIN admin_users au ON clc.author_id = au.admin_id
      WHERE 1=1
    `;
    const params = [];
    let paramIndex = 1;

    if (course_type) {
      query += ` AND clc.course_type = $${paramIndex++}`;
      params.push(course_type);
    }

    if (location_type) {
      query += ` AND clc.location_type = $${paramIndex++}`;
      params.push(location_type);
    }

    if (status) {
      query += ` AND clc.status = $${paramIndex++}`;
      params.push(status);
    }

    query += ` ORDER BY clc.course_type, clc.location_name`;
    query += ` LIMIT $${paramIndex++} OFFSET $${paramIndex++}`;
    params.push(limit, offset);

    const result = await client.query(query, params);

    // Get total count
    let countQuery = `SELECT COUNT(*) FROM course_location_content WHERE 1=1`;
    const countParams = [];
    let countParamIndex = 1;

    if (course_type) {
      countQuery += ` AND course_type = $${countParamIndex++}`;
      countParams.push(course_type);
    }
    if (location_type) {
      countQuery += ` AND location_type = $${countParamIndex++}`;
      countParams.push(location_type);
    }
    if (status) {
      countQuery += ` AND status = $${countParamIndex++}`;
      countParams.push(status);
    }

    const countResult = await client.query(countQuery, countParams);
    const total = parseInt(countResult.rows[0].count);

    res.json({
      success: true,
      data: result.rows,
      pagination: {
        current_page: parseInt(page),
        per_page: parseInt(limit),
        total,
        total_pages: Math.ceil(total / limit)
      }
    });

  } catch (error) {
    console.error('Error fetching course location content:', error);
    res.status(500).json({
      success: false,
      error: { message: 'Failed to fetch course location content', details: error.message }
    });
  } finally {
    client.release();
  }
};

/**
 * @route GET /api/v1/admin/course-location-content/:courseType/:locationSlug
 * @desc Get specific course location content
 * @access Admin
 */
exports.getOne = async (req, res) => {
  const client = await pool.connect();

  try {
    const { courseType, locationSlug } = req.params;

    const query = `
      SELECT
        clc.*,
        au.name as author_name
      FROM course_location_content clc
      LEFT JOIN admin_users au ON clc.author_id = au.admin_id
      WHERE clc.course_type = $1 AND clc.location_slug = $2
    `;

    const result = await client.query(query, [courseType, locationSlug]);

    if (result.rows.length === 0) {
      return res.status(404).json({
        success: false,
        error: { message: 'Content not found' }
      });
    }

    res.json({
      success: true,
      data: result.rows[0]
    });

  } catch (error) {
    console.error('Error fetching course location content:', error);
    res.status(500).json({
      success: false,
      error: { message: 'Failed to fetch course location content', details: error.message }
    });
  } finally {
    client.release();
  }
};

/**
 * @route POST /api/v1/admin/course-location-content
 * @desc Create new course location content
 * @access Admin
 */
exports.create = async (req, res) => {
  const client = await pool.connect();

  try {
    const {
      course_type,
      location_type = 'city',
      location_name,
      location_slug,
      page_title,
      full_content,
      author_id,
      meta_title,
      meta_description,
      banners = [],
      status = 'draft'
    } = req.body;

    // Validate required fields
    if (!course_type || !location_name || !location_slug) {
      return res.status(400).json({
        success: false,
        error: { message: 'course_type, location_name, and location_slug are required' }
      });
    }

    // Check if content already exists
    const existingCheck = await client.query(
      'SELECT content_id FROM course_location_content WHERE course_type = $1 AND location_slug = $2',
      [course_type, location_slug]
    );

    if (existingCheck.rows.length > 0) {
      return res.status(409).json({
        success: false,
        error: { message: 'Content for this course and location already exists' }
      });
    }

    const query = `
      INSERT INTO course_location_content (
        course_type, location_type, location_name, location_slug,
        page_title, full_content, author_id, meta_title, meta_description,
        banners, status
      ) VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11)
      RETURNING *
    `;

    const result = await client.query(query, [
      course_type, location_type, location_name, location_slug,
      page_title, full_content, author_id || null, meta_title, meta_description,
      JSON.stringify(banners), status
    ]);

    res.status(201).json({
      success: true,
      data: result.rows[0],
      message: 'Content created successfully'
    });

  } catch (error) {
    console.error('Error creating course location content:', error);
    res.status(500).json({
      success: false,
      error: { message: 'Failed to create content', details: error.message }
    });
  } finally {
    client.release();
  }
};

/**
 * @route PUT /api/v1/admin/course-location-content/:courseType/:locationSlug
 * @desc Update course location content
 * @access Admin
 */
exports.update = async (req, res) => {
  const client = await pool.connect();

  try {
    const { courseType, locationSlug } = req.params;
    const {
      page_title,
      full_content,
      author_id,
      meta_title,
      meta_description,
      banners,
      status
    } = req.body;

    const query = `
      UPDATE course_location_content SET
        page_title = COALESCE($1, page_title),
        full_content = COALESCE($2, full_content),
        author_id = $3,
        meta_title = COALESCE($4, meta_title),
        meta_description = COALESCE($5, meta_description),
        banners = COALESCE($6, banners),
        status = COALESCE($7, status),
        updated_at = CURRENT_TIMESTAMP
      WHERE course_type = $8 AND location_slug = $9
      RETURNING *
    `;

    const result = await client.query(query, [
      page_title, full_content, author_id || null, meta_title, meta_description,
      banners ? JSON.stringify(banners) : null, status,
      courseType, locationSlug
    ]);

    if (result.rows.length === 0) {
      return res.status(404).json({
        success: false,
        error: { message: 'Content not found' }
      });
    }

    res.json({
      success: true,
      data: result.rows[0],
      message: 'Content updated successfully'
    });

  } catch (error) {
    console.error('Error updating course location content:', error);
    res.status(500).json({
      success: false,
      error: { message: 'Failed to update content', details: error.message }
    });
  } finally {
    client.release();
  }
};

/**
 * @route DELETE /api/v1/admin/course-location-content/:courseType/:locationSlug
 * @desc Delete course location content
 * @access Admin
 */
exports.delete = async (req, res) => {
  const client = await pool.connect();

  try {
    const { courseType, locationSlug } = req.params;

    const result = await client.query(
      'DELETE FROM course_location_content WHERE course_type = $1 AND location_slug = $2 RETURNING content_id',
      [courseType, locationSlug]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({
        success: false,
        error: { message: 'Content not found' }
      });
    }

    res.json({
      success: true,
      message: 'Content deleted successfully'
    });

  } catch (error) {
    console.error('Error deleting course location content:', error);
    res.status(500).json({
      success: false,
      error: { message: 'Failed to delete content', details: error.message }
    });
  } finally {
    client.release();
  }
};

/**
 * @route GET /api/v1/admin/course-location-content/available-locations/:courseType
 * @desc Get available locations for a course type (from colleges data)
 * @access Admin
 */
exports.getAvailableLocations = async (req, res) => {
  const client = await pool.connect();

  try {
    const { courseType } = req.params;

    // Map URL-friendly format to degree type
    const degreeTypeMap = {
      'btech': 'B.Tech', 'mba': 'MBA', 'mbbs': 'MBBS', 'mtech': 'M.Tech',
      'bsc': 'B.Sc', 'msc': 'M.Sc', 'ba': 'BA', 'ma': 'MA',
      'bcom': 'B.Com', 'mcom': 'M.Com', 'bba': 'BBA', 'bca': 'BCA',
      'mca': 'MCA', 'llb': 'LLB', 'llm': 'LLM', 'bed': 'B.Ed',
      'bpharm': 'B.Pharm', 'mpharm': 'M.Pharm', 'barch': 'B.Arch',
      'pgdm': 'PGDM', 'phd': 'PhD'
    };

    const actualDegreeType = degreeTypeMap[courseType.toLowerCase()] || courseType;

    // Get cities with colleges for this course type
    const citiesQuery = `
      SELECT
        c.city as name,
        LOWER(REPLACE(c.city, ' ', '-')) as slug,
        c.state,
        'city' as location_type,
        COUNT(DISTINCT c.college_id) as college_count,
        EXISTS(
          SELECT 1 FROM course_location_content clc
          WHERE clc.course_type = $1
          AND clc.location_slug = LOWER(REPLACE(c.city, ' ', '-')) || '-colleges'
        ) as has_content
      FROM colleges c
      INNER JOIN courses co ON c.college_id = co.college_id
      WHERE co.degree_type = $2
        AND c.status = 'active'
        AND co.status = 'active'
        AND c.city IS NOT NULL
        AND c.city != ''
      GROUP BY c.city, c.state
      ORDER BY college_count DESC, c.city ASC
    `;

    // Get states with colleges for this course type
    const statesQuery = `
      SELECT
        c.state as name,
        LOWER(REPLACE(c.state, ' ', '-')) as slug,
        'state' as location_type,
        COUNT(DISTINCT c.college_id) as college_count,
        EXISTS(
          SELECT 1 FROM course_location_content clc
          WHERE clc.course_type = $1
          AND clc.location_slug = LOWER(REPLACE(c.state, ' ', '-')) || '-colleges'
        ) as has_content
      FROM colleges c
      INNER JOIN courses co ON c.college_id = co.college_id
      WHERE co.degree_type = $2
        AND c.status = 'active'
        AND co.status = 'active'
        AND c.state IS NOT NULL
        AND c.state != ''
      GROUP BY c.state
      ORDER BY college_count DESC, c.state ASC
    `;

    const [citiesResult, statesResult] = await Promise.all([
      client.query(citiesQuery, [courseType, actualDegreeType]),
      client.query(statesQuery, [courseType, actualDegreeType])
    ]);

    res.json({
      success: true,
      data: {
        cities: citiesResult.rows,
        states: statesResult.rows
      }
    });

  } catch (error) {
    console.error('Error fetching available locations:', error);
    res.status(500).json({
      success: false,
      error: { message: 'Failed to fetch available locations', details: error.message }
    });
  } finally {
    client.release();
  }
};
