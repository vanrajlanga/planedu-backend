const { pool } = require('../../config/database');

/**
 * Get all placements with pagination, search, and filters
 */
exports.getPlacements = async (req, res) => {
  const client = await pool.connect();

  try {
    const {
      page = 1,
      limit = 20,
      search = '',
      college_id,
      academic_year,
      sort_by = 'created_at',
      sort_order = 'DESC'
    } = req.query;

    const offset = (page - 1) * limit;
    const conditions = ["p.deleted_at IS NULL"];
    const params = [];
    let paramCounter = 1;

    // Search filter (searches in college name and academic year)
    if (search) {
      conditions.push(`(c.college_name ILIKE $${paramCounter} OR p.academic_year ILIKE $${paramCounter})`);
      params.push(`%${search}%`);
      paramCounter++;
    }

    // College filter
    if (college_id) {
      conditions.push(`p.college_id = $${paramCounter}`);
      params.push(college_id);
      paramCounter++;
    }

    // Academic year filter
    if (academic_year) {
      conditions.push(`p.academic_year = $${paramCounter}`);
      params.push(academic_year);
      paramCounter++;
    }

    const whereClause = conditions.length > 0 ? `WHERE ${conditions.join(' AND ')}` : '';

    // Validate sort_by to prevent SQL injection
    const validSortColumns = ['academic_year', 'placement_percentage', 'highest_package', 'average_package', 'created_at', 'updated_at'];
    const sortColumn = validSortColumns.includes(sort_by) ? sort_by : 'created_at';
    const sortDirection = sort_order.toUpperCase() === 'ASC' ? 'ASC' : 'DESC';

    // Get total count
    const countQuery = `
      SELECT COUNT(*) as total
      FROM placements p
      LEFT JOIN colleges c ON p.college_id = c.college_id
      ${whereClause}
    `;
    const countResult = await client.query(countQuery, params);
    const total = parseInt(countResult.rows[0].total);

    // Get placements with college info
    const placementsQuery = `
      SELECT
        p.*,
        c.college_name,
        c.short_name as college_short_name,
        c.city,
        c.state,
        co.course_name
      FROM placements p
      LEFT JOIN colleges c ON p.college_id = c.college_id
      LEFT JOIN courses co ON p.course_id = co.course_id
      ${whereClause}
      ORDER BY p.${sortColumn} ${sortDirection}
      LIMIT $${paramCounter} OFFSET $${paramCounter + 1}
    `;
    params.push(limit, offset);

    const placementsResult = await client.query(placementsQuery, params);

    res.json({
      success: true,
      data: placementsResult.rows,
      pagination: {
        page: parseInt(page),
        limit: parseInt(limit),
        total,
        pages: Math.ceil(total / limit)
      }
    });

  } catch (error) {
    console.error('Get placements error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch placements',
      error: error.message
    });
  } finally {
    client.release();
  }
};

/**
 * Get a single placement by ID
 */
exports.getPlacement = async (req, res) => {
  const client = await pool.connect();

  try {
    const { id } = req.params;

    const query = `
      SELECT
        p.*,
        c.college_name,
        c.short_name as college_short_name,
        c.city,
        c.state,
        co.course_name
      FROM placements p
      LEFT JOIN colleges c ON p.college_id = c.college_id
      LEFT JOIN courses co ON p.course_id = co.course_id
      WHERE p.placement_id = $1 AND p.deleted_at IS NULL
    `;

    const result = await client.query(query, [id]);

    if (result.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Placement not found'
      });
    }

    res.json({
      success: true,
      data: result.rows[0]
    });

  } catch (error) {
    console.error('Get placement error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch placement',
      error: error.message
    });
  } finally {
    client.release();
  }
};

/**
 * Create a new placement
 */
exports.createPlacement = async (req, res) => {
  const client = await pool.connect();

  try {
    const {
      college_id,
      course_id,
      academic_year,
      total_students,
      students_placed,
      highest_package,
      average_package,
      median_package,
      currency
    } = req.body;

    // Validate required fields
    if (!college_id || !academic_year || !total_students || !students_placed) {
      return res.status(400).json({
        success: false,
        message: 'College ID, academic year, total students, and students placed are required'
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

    // If course_id is provided, check if course exists
    if (course_id) {
      const courseCheck = await client.query(
        'SELECT course_id FROM courses WHERE course_id = $1 AND deleted_at IS NULL',
        [course_id]
      );

      if (courseCheck.rows.length === 0) {
        return res.status(404).json({
          success: false,
          message: 'Course not found'
        });
      }
    }

    // Calculate placement percentage
    const placement_percentage = total_students > 0
      ? ((students_placed / total_students) * 100).toFixed(2)
      : 0;

    const query = `
      INSERT INTO placements (
        college_id, course_id, academic_year, total_students, students_placed,
        placement_percentage, highest_package, average_package, median_package, currency
      )
      VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10)
      RETURNING *
    `;

    const values = [
      college_id,
      course_id || null,
      academic_year,
      total_students,
      students_placed,
      placement_percentage,
      highest_package || null,
      average_package || null,
      median_package || null,
      currency || 'INR'
    ];

    const result = await client.query(query, values);

    res.status(201).json({
      success: true,
      message: 'Placement created successfully',
      data: result.rows[0]
    });

  } catch (error) {
    console.error('Create placement error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to create placement',
      error: error.message
    });
  } finally {
    client.release();
  }
};

/**
 * Update a placement
 */
exports.updatePlacement = async (req, res) => {
  const client = await pool.connect();

  try {
    const { id } = req.params;
    const updates = req.body;

    // Check if placement exists
    const placementCheck = await client.query(
      'SELECT placement_id FROM placements WHERE placement_id = $1 AND deleted_at IS NULL',
      [id]
    );

    if (placementCheck.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Placement not found'
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

    // If course_id is being updated, verify the new course exists
    if (updates.course_id) {
      const courseCheck = await client.query(
        'SELECT course_id FROM courses WHERE course_id = $1 AND deleted_at IS NULL',
        [updates.course_id]
      );

      if (courseCheck.rows.length === 0) {
        return res.status(404).json({
          success: false,
          message: 'Course not found'
        });
      }
    }

    // Recalculate placement percentage if total_students or students_placed is updated
    if (updates.total_students || updates.students_placed) {
      const currentData = await client.query(
        'SELECT total_students, students_placed FROM placements WHERE placement_id = $1',
        [id]
      );

      const total = updates.total_students || currentData.rows[0].total_students;
      const placed = updates.students_placed || currentData.rows[0].students_placed;

      updates.placement_percentage = total > 0
        ? ((placed / total) * 100).toFixed(2)
        : 0;
    }

    // Build dynamic update query
    const allowedFields = [
      'college_id', 'course_id', 'academic_year', 'total_students', 'students_placed',
      'placement_percentage', 'highest_package', 'average_package', 'median_package', 'currency'
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
      UPDATE placements
      SET ${updateFields.join(', ')}
      WHERE placement_id = $${paramCounter} AND deleted_at IS NULL
      RETURNING *
    `;

    const result = await client.query(query, values);

    res.json({
      success: true,
      message: 'Placement updated successfully',
      data: result.rows[0]
    });

  } catch (error) {
    console.error('Update placement error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to update placement',
      error: error.message
    });
  } finally {
    client.release();
  }
};

/**
 * Delete a placement (soft delete)
 */
exports.deletePlacement = async (req, res) => {
  const client = await pool.connect();

  try {
    const { id } = req.params;

    const query = `
      UPDATE placements
      SET deleted_at = CURRENT_TIMESTAMP
      WHERE placement_id = $1 AND deleted_at IS NULL
      RETURNING placement_id
    `;

    const result = await client.query(query, [id]);

    if (result.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Placement not found'
      });
    }

    res.json({
      success: true,
      message: 'Placement deleted successfully'
    });

  } catch (error) {
    console.error('Delete placement error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to delete placement',
      error: error.message
    });
  } finally {
    client.release();
  }
};

/**
 * Get placement statistics by college
 */
exports.getPlacementStatsByCollege = async (req, res) => {
  const client = await pool.connect();

  try {
    const { college_id } = req.params;

    const query = `
      SELECT
        p.*,
        c.college_name,
        c.short_name as college_short_name
      FROM placements p
      LEFT JOIN colleges c ON p.college_id = c.college_id
      WHERE p.college_id = $1 AND p.deleted_at IS NULL
      ORDER BY p.academic_year DESC
    `;

    const result = await client.query(query, [college_id]);

    res.json({
      success: true,
      data: result.rows
    });

  } catch (error) {
    console.error('Get placement stats error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch placement statistics',
      error: error.message
    });
  } finally {
    client.release();
  }
};
