const { pool } = require('../../config/database');

/**
 * Get all cutoffs for a college with pagination
 */
exports.getCutoffsByCollege = async (req, res) => {
  const client = await pool.connect();

  try {
    const college_id = req.params.collegeId;
    const {
      page = 1,
      limit = 50,
      exam_id,
      academic_year,
      category,
    } = req.query;

    const offset = (page - 1) * limit;
    const conditions = ['ec.college_id = $1'];
    const params = [college_id];
    let paramCounter = 2;

    if (exam_id) {
      conditions.push(`ec.exam_id = $${paramCounter}`);
      params.push(exam_id);
      paramCounter++;
    }

    if (academic_year) {
      conditions.push(`ec.academic_year = $${paramCounter}`);
      params.push(academic_year);
      paramCounter++;
    }

    if (category) {
      conditions.push(`ec.category = $${paramCounter}`);
      params.push(category);
      paramCounter++;
    }

    const whereClause = `WHERE ${conditions.join(' AND ')}`;

    // Get total count
    const countQuery = `
      SELECT COUNT(*) as total
      FROM exam_cutoffs ec
      ${whereClause}
    `;
    const countResult = await client.query(countQuery, params);
    const total = parseInt(countResult.rows[0].total);

    // Get cutoffs with exam and course info
    const cutoffsQuery = `
      SELECT
        ec.*,
        e.exam_name,
        e.short_name as exam_short_name,
        c.course_name
      FROM exam_cutoffs ec
      LEFT JOIN exams e ON ec.exam_id = e.exam_id
      LEFT JOIN courses c ON ec.course_id = c.course_id
      ${whereClause}
      ORDER BY ec.academic_year DESC, e.exam_name ASC, ec.round ASC, ec.category ASC
      LIMIT $${paramCounter} OFFSET $${paramCounter + 1}
    `;
    params.push(limit, offset);

    const cutoffsResult = await client.query(cutoffsQuery, params);

    res.json({
      success: true,
      data: {
        cutoffs: cutoffsResult.rows,
        pagination: {
          page: parseInt(page),
          limit: parseInt(limit),
          total,
          pages: Math.ceil(total / limit)
        }
      }
    });

  } catch (error) {
    console.error('Get cutoffs error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch cutoffs',
      error: error.message
    });
  } finally {
    client.release();
  }
};

/**
 * Get a single cutoff by ID
 */
exports.getCutoff = async (req, res) => {
  const client = await pool.connect();

  try {
    const { id } = req.params;

    const query = `
      SELECT
        ec.*,
        e.exam_name,
        e.short_name as exam_short_name,
        c.course_name
      FROM exam_cutoffs ec
      LEFT JOIN exams e ON ec.exam_id = e.exam_id
      LEFT JOIN courses c ON ec.course_id = c.course_id
      WHERE ec.cutoff_id = $1
    `;

    const result = await client.query(query, [id]);

    if (result.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Cutoff not found'
      });
    }

    res.json({
      success: true,
      data: result.rows[0]
    });

  } catch (error) {
    console.error('Get cutoff error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch cutoff',
      error: error.message
    });
  } finally {
    client.release();
  }
};

/**
 * Create a new cutoff
 */
exports.createCutoff = async (req, res) => {
  const client = await pool.connect();

  try {
    const college_id = req.params.collegeId;
    const {
      exam_id,
      course_id,
      academic_year,
      category,
      cutoff_type,
      cutoff_value,
      opening_rank,
      closing_rank,
      round,
      specialization,
    } = req.body;

    // Validate required fields
    if (!exam_id || !academic_year || !category) {
      return res.status(400).json({
        success: false,
        message: 'Exam, academic year, and category are required'
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

    // Check if exam exists
    const examCheck = await client.query(
      'SELECT exam_id FROM exams WHERE exam_id = $1 AND deleted_at IS NULL',
      [exam_id]
    );

    if (examCheck.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Exam not found'
      });
    }

    const query = `
      INSERT INTO exam_cutoffs (
        college_id, exam_id, course_id, academic_year, category,
        cutoff_type, cutoff_value, opening_rank, closing_rank, round, specialization
      )
      VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11)
      RETURNING *
    `;

    const values = [
      college_id,
      exam_id,
      course_id || null,
      academic_year,
      category,
      cutoff_type || null,
      cutoff_value || null,
      opening_rank || null,
      closing_rank || null,
      round || 1,
      specialization || null,
    ];

    const result = await client.query(query, values);

    res.status(201).json({
      success: true,
      message: 'Cutoff created successfully',
      data: result.rows[0]
    });

  } catch (error) {
    console.error('Create cutoff error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to create cutoff',
      error: error.message
    });
  } finally {
    client.release();
  }
};

/**
 * Update a cutoff
 */
exports.updateCutoff = async (req, res) => {
  const client = await pool.connect();

  try {
    const { id } = req.params;
    const updates = req.body;

    // Check if cutoff exists
    const cutoffCheck = await client.query(
      'SELECT cutoff_id FROM exam_cutoffs WHERE cutoff_id = $1',
      [id]
    );

    if (cutoffCheck.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Cutoff not found'
      });
    }

    // Build dynamic update query
    const allowedFields = [
      'exam_id', 'course_id', 'academic_year', 'category',
      'cutoff_type', 'cutoff_value', 'opening_rank', 'closing_rank', 'round', 'specialization'
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

    values.push(id);

    const query = `
      UPDATE exam_cutoffs
      SET ${updateFields.join(', ')}
      WHERE cutoff_id = $${paramCounter}
      RETURNING *
    `;

    const result = await client.query(query, values);

    res.json({
      success: true,
      message: 'Cutoff updated successfully',
      data: result.rows[0]
    });

  } catch (error) {
    console.error('Update cutoff error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to update cutoff',
      error: error.message
    });
  } finally {
    client.release();
  }
};

/**
 * Delete a cutoff
 */
exports.deleteCutoff = async (req, res) => {
  const client = await pool.connect();

  try {
    const { id } = req.params;

    const query = `
      DELETE FROM exam_cutoffs
      WHERE cutoff_id = $1
      RETURNING cutoff_id
    `;

    const result = await client.query(query, [id]);

    if (result.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Cutoff not found'
      });
    }

    res.json({
      success: true,
      message: 'Cutoff deleted successfully'
    });

  } catch (error) {
    console.error('Delete cutoff error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to delete cutoff',
      error: error.message
    });
  } finally {
    client.release();
  }
};

/**
 * Bulk create cutoffs
 */
exports.bulkCreateCutoffs = async (req, res) => {
  const client = await pool.connect();

  try {
    const college_id = req.params.collegeId;
    const { cutoffs } = req.body;

    if (!cutoffs || !Array.isArray(cutoffs) || cutoffs.length === 0) {
      return res.status(400).json({
        success: false,
        message: 'Cutoffs array is required'
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

    await client.query('BEGIN');

    const insertedCutoffs = [];

    for (const cutoff of cutoffs) {
      const {
        exam_id,
        course_id,
        academic_year,
        category,
        cutoff_type,
        cutoff_value,
        opening_rank,
        closing_rank,
        round,
        specialization,
      } = cutoff;

      if (!exam_id || !academic_year || !category) {
        continue; // Skip invalid entries
      }

      const query = `
        INSERT INTO exam_cutoffs (
          college_id, exam_id, course_id, academic_year, category,
          cutoff_type, cutoff_value, opening_rank, closing_rank, round, specialization
        )
        VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11)
        RETURNING *
      `;

      const values = [
        college_id,
        exam_id,
        course_id || null,
        academic_year,
        category,
        cutoff_type || null,
        cutoff_value || null,
        opening_rank || null,
        closing_rank || null,
        round || 1,
        specialization || null,
      ];

      const result = await client.query(query, values);
      insertedCutoffs.push(result.rows[0]);
    }

    await client.query('COMMIT');

    res.status(201).json({
      success: true,
      message: `${insertedCutoffs.length} cutoffs created successfully`,
      data: insertedCutoffs
    });

  } catch (error) {
    await client.query('ROLLBACK');
    console.error('Bulk create cutoffs error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to create cutoffs',
      error: error.message
    });
  } finally {
    client.release();
  }
};

/**
 * Get filter options (years, categories, exams)
 */
exports.getFilterOptions = async (req, res) => {
  const client = await pool.connect();

  try {
    const college_id = req.params.collegeId;

    // Get distinct years
    const yearsQuery = `
      SELECT DISTINCT academic_year
      FROM exam_cutoffs
      WHERE college_id = $1
      ORDER BY academic_year DESC
    `;
    const yearsResult = await client.query(yearsQuery, [college_id]);

    // Get distinct categories
    const categoriesQuery = `
      SELECT DISTINCT category
      FROM exam_cutoffs
      WHERE college_id = $1
      ORDER BY category
    `;
    const categoriesResult = await client.query(categoriesQuery, [college_id]);

    // Get exams with cutoffs for this college
    const examsQuery = `
      SELECT DISTINCT e.exam_id, e.exam_name, e.short_name
      FROM exam_cutoffs ec
      JOIN exams e ON ec.exam_id = e.exam_id
      WHERE ec.college_id = $1
      ORDER BY e.exam_name
    `;
    const examsResult = await client.query(examsQuery, [college_id]);

    res.json({
      success: true,
      data: {
        academic_years: yearsResult.rows.map(r => r.academic_year),
        categories: categoriesResult.rows.map(r => r.category),
        exams: examsResult.rows
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
