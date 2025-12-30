const { pool } = require('../../config/database');

/**
 * Get all exams with pagination, search, and filters
 */
exports.getExams = async (req, res) => {
  const client = await pool.connect();

  try {
    const {
      page = 1,
      limit = 20,
      search = '',
      level,
      mode,
      status = '',
      sort_by = 'created_at',
      sort_order = 'DESC'
    } = req.query;

    const offset = (page - 1) * limit;
    const conditions = ["e.deleted_at IS NULL"];
    const params = [];
    let paramCounter = 1;

    // Search filter
    if (search) {
      conditions.push(`(e.exam_name ILIKE $${paramCounter} OR e.short_name ILIKE $${paramCounter} OR e.conducting_body ILIKE $${paramCounter})`);
      params.push(`%${search}%`);
      paramCounter++;
    }

    // Level filter
    if (level) {
      conditions.push(`e.level = $${paramCounter}`);
      params.push(level);
      paramCounter++;
    }

    // Mode filter
    if (mode) {
      conditions.push(`e.mode = $${paramCounter}`);
      params.push(mode);
      paramCounter++;
    }

    // Status filter
    if (status) {
      conditions.push(`e.status = $${paramCounter}`);
      params.push(status);
      paramCounter++;
    }

    const whereClause = conditions.length > 0 ? `WHERE ${conditions.join(' AND ')}` : '';

    // Validate sort_by to prevent SQL injection
    const validSortColumns = ['exam_name', 'level', 'mode', 'exam_date', 'created_at', 'updated_at'];
    const sortColumn = validSortColumns.includes(sort_by) ? sort_by : 'created_at';
    const sortDirection = sort_order.toUpperCase() === 'ASC' ? 'ASC' : 'DESC';

    // Get total count
    const countQuery = `
      SELECT COUNT(*) as total
      FROM exams e
      ${whereClause}
    `;
    const countResult = await client.query(countQuery, params);
    const total = parseInt(countResult.rows[0].total);

    // Get exams
    const examsQuery = `
      SELECT *
      FROM exams e
      ${whereClause}
      ORDER BY e.${sortColumn} ${sortDirection}
      LIMIT $${paramCounter} OFFSET $${paramCounter + 1}
    `;
    params.push(limit, offset);

    const examsResult = await client.query(examsQuery, params);

    res.json({
      success: true,
      data: examsResult.rows,
      pagination: {
        page: parseInt(page),
        limit: parseInt(limit),
        total,
        pages: Math.ceil(total / limit)
      }
    });

  } catch (error) {
    console.error('Get exams error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch exams',
      error: error.message
    });
  } finally {
    client.release();
  }
};

/**
 * Get a single exam by ID
 */
exports.getExam = async (req, res) => {
  const client = await pool.connect();

  try {
    const { id } = req.params;

    const query = `
      SELECT *
      FROM exams
      WHERE exam_id = $1 AND deleted_at IS NULL
    `;

    const result = await client.query(query, [id]);

    if (result.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Exam not found'
      });
    }

    res.json({
      success: true,
      data: result.rows[0]
    });

  } catch (error) {
    console.error('Get exam error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch exam',
      error: error.message
    });
  } finally {
    client.release();
  }
};

/**
 * Create a new exam
 */
exports.createExam = async (req, res) => {
  const client = await pool.connect();

  try {
    const {
      exam_name,
      short_name,
      level,
      mode,
      conducting_body,
      exam_date,
      application_start_date,
      application_end_date,
      eligibility,
      exam_pattern,
      syllabus,
      website_url,
      description,
      status
    } = req.body;

    // Validate required fields
    if (!exam_name || !level || !mode) {
      return res.status(400).json({
        success: false,
        message: 'Exam name, level, and mode are required'
      });
    }

    const query = `
      INSERT INTO exams (
        exam_name, short_name, level, mode, conducting_body, exam_date,
        application_start_date, application_end_date, eligibility, exam_pattern,
        syllabus, website_url, description, status
      )
      VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14)
      RETURNING *
    `;

    const values = [
      exam_name,
      short_name || null,
      level,
      mode,
      conducting_body || null,
      exam_date || null,
      application_start_date || null,
      application_end_date || null,
      eligibility || null,
      exam_pattern || null,
      syllabus || null,
      website_url || null,
      description || null,
      status || 'active'
    ];

    const result = await client.query(query, values);

    res.status(201).json({
      success: true,
      message: 'Exam created successfully',
      data: result.rows[0]
    });

  } catch (error) {
    console.error('Create exam error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to create exam',
      error: error.message
    });
  } finally {
    client.release();
  }
};

/**
 * Update an exam
 */
exports.updateExam = async (req, res) => {
  const client = await pool.connect();

  try {
    const { id } = req.params;
    const updates = req.body;

    // Check if exam exists
    const examCheck = await client.query(
      'SELECT exam_id FROM exams WHERE exam_id = $1 AND deleted_at IS NULL',
      [id]
    );

    if (examCheck.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Exam not found'
      });
    }

    // Build dynamic update query
    const allowedFields = [
      'exam_name', 'short_name', 'level', 'mode', 'conducting_body', 'exam_date',
      'application_start_date', 'application_end_date', 'eligibility', 'exam_pattern',
      'syllabus', 'website_url', 'description', 'status'
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
      UPDATE exams
      SET ${updateFields.join(', ')}
      WHERE exam_id = $${paramCounter} AND deleted_at IS NULL
      RETURNING *
    `;

    const result = await client.query(query, values);

    res.json({
      success: true,
      message: 'Exam updated successfully',
      data: result.rows[0]
    });

  } catch (error) {
    console.error('Update exam error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to update exam',
      error: error.message
    });
  } finally {
    client.release();
  }
};

/**
 * Delete an exam (soft delete)
 */
exports.deleteExam = async (req, res) => {
  const client = await pool.connect();

  try {
    const { id } = req.params;

    const query = `
      UPDATE exams
      SET deleted_at = CURRENT_TIMESTAMP
      WHERE exam_id = $1 AND deleted_at IS NULL
      RETURNING exam_id
    `;

    const result = await client.query(query, [id]);

    if (result.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Exam not found'
      });
    }

    res.json({
      success: true,
      message: 'Exam deleted successfully'
    });

  } catch (error) {
    console.error('Delete exam error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to delete exam',
      error: error.message
    });
  } finally {
    client.release();
  }
};

/**
 * Update exam status
 */
exports.updateExamStatus = async (req, res) => {
  const client = await pool.connect();

  try {
    const { id } = req.params;
    const { status } = req.body;

    if (!status || !['active', 'inactive', 'upcoming', 'completed'].includes(status)) {
      return res.status(400).json({
        success: false,
        message: 'Invalid status. Must be active, inactive, upcoming, or completed'
      });
    }

    const query = `
      UPDATE exams
      SET status = $1, updated_at = CURRENT_TIMESTAMP
      WHERE exam_id = $2 AND deleted_at IS NULL
      RETURNING *
    `;

    const result = await client.query(query, [status, id]);

    if (result.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Exam not found'
      });
    }

    res.json({
      success: true,
      message: 'Exam status updated successfully',
      data: result.rows[0]
    });

  } catch (error) {
    console.error('Update exam status error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to update exam status',
      error: error.message
    });
  } finally {
    client.release();
  }
};

/**
 * Bulk update exam status
 */
exports.bulkUpdateStatus = async (req, res) => {
  const client = await pool.connect();

  try {
    const { exam_ids, status } = req.body;

    if (!exam_ids || !Array.isArray(exam_ids) || exam_ids.length === 0) {
      return res.status(400).json({
        success: false,
        message: 'exam_ids array is required'
      });
    }

    if (!status || !['active', 'inactive', 'upcoming', 'completed'].includes(status)) {
      return res.status(400).json({
        success: false,
        message: 'Invalid status. Must be active, inactive, upcoming, or completed'
      });
    }

    const query = `
      UPDATE exams
      SET status = $1, updated_at = CURRENT_TIMESTAMP
      WHERE exam_id = ANY($2) AND deleted_at IS NULL
    `;

    const result = await client.query(query, [status, exam_ids]);

    res.json({
      success: true,
      message: `${result.rowCount} exam(s) updated successfully`,
      data: {
        updated_count: result.rowCount
      }
    });

  } catch (error) {
    console.error('Bulk update status error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to update exam statuses',
      error: error.message
    });
  } finally {
    client.release();
  }
};
