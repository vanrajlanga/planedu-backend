const { pool } = require('../../config/database');

/**
 * Get all courses with pagination, search, and filters
 */
exports.getCourses = async (req, res) => {
  const client = await pool.connect();

  try {
    const {
      page = 1,
      limit = 20,
      search = '',
      college_id,
      degree_type,
      stream,
      course_mode,
      status = '',
      sort_by = 'created_at',
      sort_order = 'DESC'
    } = req.query;

    const offset = (page - 1) * limit;
    const conditions = ["c.deleted_at IS NULL"];
    const params = [];
    let paramCounter = 1;

    // Search filter
    if (search) {
      conditions.push(`(c.course_name ILIKE $${paramCounter} OR c.short_name ILIKE $${paramCounter} OR c.specialization ILIKE $${paramCounter})`);
      params.push(`%${search}%`);
      paramCounter++;
    }

    // College filter
    if (college_id) {
      conditions.push(`c.college_id = $${paramCounter}`);
      params.push(college_id);
      paramCounter++;
    }

    // Degree type filter
    if (degree_type) {
      conditions.push(`c.degree_type = $${paramCounter}`);
      params.push(degree_type);
      paramCounter++;
    }

    // Stream filter
    if (stream) {
      conditions.push(`c.stream = $${paramCounter}`);
      params.push(stream);
      paramCounter++;
    }

    // Course mode filter
    if (course_mode) {
      conditions.push(`c.course_mode = $${paramCounter}`);
      params.push(course_mode);
      paramCounter++;
    }

    // Status filter
    if (status) {
      conditions.push(`c.status = $${paramCounter}`);
      params.push(status);
      paramCounter++;
    }

    const whereClause = conditions.length > 0 ? `WHERE ${conditions.join(' AND ')}` : '';

    // Validate sort_by to prevent SQL injection
    const validSortColumns = ['course_name', 'degree_type', 'duration', 'total_fees', 'created_at', 'updated_at'];
    const sortColumn = validSortColumns.includes(sort_by) ? sort_by : 'created_at';
    const sortDirection = sort_order.toUpperCase() === 'ASC' ? 'ASC' : 'DESC';

    // Get total count
    const countQuery = `
      SELECT COUNT(*) as total
      FROM courses c
      ${whereClause}
    `;
    const countResult = await client.query(countQuery, params);
    const total = parseInt(countResult.rows[0].total);

    // Get courses with college info
    const coursesQuery = `
      SELECT
        c.*,
        col.college_name,
        col.short_name as college_short_name,
        col.city,
        col.state
      FROM courses c
      LEFT JOIN colleges col ON c.college_id = col.college_id
      ${whereClause}
      ORDER BY c.${sortColumn} ${sortDirection}
      LIMIT $${paramCounter} OFFSET $${paramCounter + 1}
    `;
    params.push(limit, offset);

    const coursesResult = await client.query(coursesQuery, params);

    res.json({
      success: true,
      data: coursesResult.rows,
      pagination: {
        page: parseInt(page),
        limit: parseInt(limit),
        total,
        pages: Math.ceil(total / limit)
      }
    });

  } catch (error) {
    console.error('Get courses error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch courses',
      error: error.message
    });
  } finally {
    client.release();
  }
};

/**
 * Get a single course by ID
 */
exports.getCourse = async (req, res) => {
  const client = await pool.connect();

  try {
    const { id } = req.params;

    const query = `
      SELECT
        c.*,
        col.college_name,
        col.short_name as college_short_name,
        col.city,
        col.state,
        col.website_url,
        col.logo_url
      FROM courses c
      LEFT JOIN colleges col ON c.college_id = col.college_id
      WHERE c.course_id = $1 AND c.deleted_at IS NULL
    `;

    const result = await client.query(query, [id]);

    if (result.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Course not found'
      });
    }

    res.json({
      success: true,
      data: result.rows[0]
    });

  } catch (error) {
    console.error('Get course error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch course',
      error: error.message
    });
  } finally {
    client.release();
  }
};

/**
 * Create a new course
 */
exports.createCourse = async (req, res) => {
  const client = await pool.connect();

  try {
    const {
      college_id,
      course_name,
      short_name,
      degree_type,
      duration,
      stream,
      specialization,
      total_fees,
      fees_type,
      eligibility,
      seats_available,
      course_mode,
      description,
      status,
      is_featured
    } = req.body;

    // Validate required fields
    if (!college_id || !course_name || !degree_type) {
      return res.status(400).json({
        success: false,
        message: 'College ID, course name, and degree type are required'
      });
    }

    // Check if college exists
    const collegeCheck = await client.query(
      'SELECT college_id FROM colleges WHERE college_id = $1 AND deleted_at IS NULL',
      [college_id]
    );

    if (collegeCheck.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'College not found'
      });
    }

    const query = `
      INSERT INTO courses (
        college_id, course_name, short_name, degree_type, duration, stream,
        specialization, total_fees, fees_type, eligibility, seats_available,
        course_mode, description, status, is_featured
      )
      VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15)
      RETURNING *
    `;

    const values = [
      college_id,
      course_name,
      short_name || null,
      degree_type,
      duration || null,
      stream || null,
      specialization || null,
      total_fees || null,
      fees_type || 'Per Year',
      eligibility || null,
      seats_available || null,
      course_mode || 'Full-time',
      description || null,
      status || 'active',
      is_featured || false
    ];

    const result = await client.query(query, values);

    res.status(201).json({
      success: true,
      message: 'Course created successfully',
      data: result.rows[0]
    });

  } catch (error) {
    console.error('Create course error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to create course',
      error: error.message
    });
  } finally {
    client.release();
  }
};

/**
 * Update a course
 */
exports.updateCourse = async (req, res) => {
  const client = await pool.connect();

  try {
    const { id } = req.params;
    const updates = req.body;

    // Check if course exists
    const courseCheck = await client.query(
      'SELECT course_id FROM courses WHERE course_id = $1 AND deleted_at IS NULL',
      [id]
    );

    if (courseCheck.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Course not found'
      });
    }

    // If college_id is being updated, verify the new college exists
    if (updates.college_id) {
      const collegeCheck = await client.query(
        'SELECT college_id FROM colleges WHERE college_id = $1 AND deleted_at IS NULL',
        [updates.college_id]
      );

      if (collegeCheck.rows.length === 0) {
        return res.status(404).json({
          success: false,
          message: 'College not found'
        });
      }
    }

    // Build dynamic update query
    const allowedFields = [
      'college_id', 'course_name', 'short_name', 'degree_type', 'duration',
      'stream', 'specialization', 'total_fees', 'fees_type', 'eligibility',
      'seats_available', 'course_mode', 'description', 'status', 'is_featured'
    ];

    const updateFields = [];
    const values = [];
    let paramCounter = 1;

    for (const field of allowedFields) {
      if (updates.hasOwnProperty(field)) {
        updateFields.push(`${field} = $${paramCounter}`);
        values.push(updates[field]);
        paramCounter++;
      }
    }

    if (updateFields.length === 0) {
      return res.status(400).json({
        success: false,
        message: 'No valid fields to update'
      });
    }

    // Add updated_at
    updateFields.push(`updated_at = CURRENT_TIMESTAMP`);
    values.push(id);

    const query = `
      UPDATE courses
      SET ${updateFields.join(', ')}
      WHERE course_id = $${paramCounter} AND deleted_at IS NULL
      RETURNING *
    `;

    const result = await client.query(query, values);

    res.json({
      success: true,
      message: 'Course updated successfully',
      data: result.rows[0]
    });

  } catch (error) {
    console.error('Update course error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to update course',
      error: error.message
    });
  } finally {
    client.release();
  }
};

/**
 * Delete a course (soft delete)
 */
exports.deleteCourse = async (req, res) => {
  const client = await pool.connect();

  try {
    const { id } = req.params;

    const query = `
      UPDATE courses
      SET deleted_at = CURRENT_TIMESTAMP
      WHERE course_id = $1 AND deleted_at IS NULL
      RETURNING course_id
    `;

    const result = await client.query(query, [id]);

    if (result.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Course not found'
      });
    }

    res.json({
      success: true,
      message: 'Course deleted successfully'
    });

  } catch (error) {
    console.error('Delete course error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to delete course',
      error: error.message
    });
  } finally {
    client.release();
  }
};

/**
 * Update course status
 */
exports.updateCourseStatus = async (req, res) => {
  const client = await pool.connect();

  try {
    const { id } = req.params;
    const { status } = req.body;

    if (!status || !['active', 'inactive', 'pending'].includes(status)) {
      return res.status(400).json({
        success: false,
        message: 'Invalid status. Must be active, inactive, or pending'
      });
    }

    const query = `
      UPDATE courses
      SET status = $1, updated_at = CURRENT_TIMESTAMP
      WHERE course_id = $2 AND deleted_at IS NULL
      RETURNING *
    `;

    const result = await client.query(query, [status, id]);

    if (result.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Course not found'
      });
    }

    res.json({
      success: true,
      message: 'Course status updated successfully',
      data: result.rows[0]
    });

  } catch (error) {
    console.error('Update course status error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to update course status',
      error: error.message
    });
  } finally {
    client.release();
  }
};

/**
 * Get filter options for courses
 */
exports.getFilterOptions = async (req, res) => {
  const client = await pool.connect();

  try {
    const query = `
      SELECT DISTINCT
        degree_type,
        stream,
        course_mode
      FROM courses
      WHERE deleted_at IS NULL AND degree_type IS NOT NULL
      ORDER BY degree_type, stream, course_mode
    `;

    const result = await client.query(query);

    const degreeTypes = [...new Set(result.rows.map(r => r.degree_type).filter(Boolean))];
    const streams = [...new Set(result.rows.map(r => r.stream).filter(Boolean))];
    const courseModes = [...new Set(result.rows.map(r => r.course_mode).filter(Boolean))];

    res.json({
      success: true,
      data: {
        degree_types: degreeTypes,
        streams: streams,
        course_modes: courseModes
      }
    });

  } catch (error) {
    console.error('Get filter options error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch filter options',
      error: error.message
    });
  } finally {
    client.release();
  }
};

/**
 * Bulk update course status
 */
exports.bulkUpdateStatus = async (req, res) => {
  const client = await pool.connect();

  try {
    const { course_ids, status } = req.body;

    if (!course_ids || !Array.isArray(course_ids) || course_ids.length === 0) {
      return res.status(400).json({
        success: false,
        message: 'course_ids array is required'
      });
    }

    if (!status || !['active', 'inactive', 'pending'].includes(status)) {
      return res.status(400).json({
        success: false,
        message: 'Invalid status. Must be active, inactive, or pending'
      });
    }

    const query = `
      UPDATE courses
      SET status = $1, updated_at = CURRENT_TIMESTAMP
      WHERE course_id = ANY($2) AND deleted_at IS NULL
    `;

    const result = await client.query(query, [status, course_ids]);

    res.json({
      success: true,
      message: `${result.rowCount} course(s) updated successfully`,
      data: {
        updated_count: result.rowCount
      }
    });

  } catch (error) {
    console.error('Bulk update status error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to update course statuses',
      error: error.message
    });
  } finally {
    client.release();
  }
};
