const { pool } = require('../../config/database');

/**
 * Get all scholarships with pagination, search, and filters
 */
exports.getScholarships = async (req, res) => {
  const client = await pool.connect();

  try {
    const {
      page = 1,
      limit = 20,
      search = '',
      type,
      country,
      status = '',
      sort_by = 'created_at',
      sort_order = 'DESC'
    } = req.query;

    const offset = (page - 1) * limit;
    const conditions = ["s.deleted_at IS NULL"];
    const params = [];
    let paramCounter = 1;

    // Search filter
    if (search) {
      conditions.push(`(s.scholarship_name ILIKE $${paramCounter} OR s.provider_name ILIKE $${paramCounter} OR s.country ILIKE $${paramCounter})`);
      params.push(`%${search}%`);
      paramCounter++;
    }

    // Type filter
    if (type) {
      conditions.push(`s.scholarship_type = $${paramCounter}`);
      params.push(type);
      paramCounter++;
    }

    // Country filter
    if (country) {
      conditions.push(`s.country = $${paramCounter}`);
      params.push(country);
      paramCounter++;
    }

    // Status filter
    if (status) {
      const isActive = status === 'active' || status === 'true';
      conditions.push(`s.is_active = $${paramCounter}`);
      params.push(isActive);
      paramCounter++;
    }

    const whereClause = conditions.length > 0 ? `WHERE ${conditions.join(' AND ')}` : '';

    // Validate sort_by to prevent SQL injection
    const validSortColumns = ['scholarship_name', 'type', 'amount', 'application_deadline', 'created_at', 'updated_at'];
    const sortColumn = validSortColumns.includes(sort_by) ? sort_by : 'created_at';
    const sortDirection = sort_order.toUpperCase() === 'ASC' ? 'ASC' : 'DESC';

    // Get total count
    const countQuery = `
      SELECT COUNT(*) as total
      FROM scholarships s
      ${whereClause}
    `;
    const countResult = await client.query(countQuery, params);
    const total = parseInt(countResult.rows[0].total);

    // Get scholarships
    const scholarshipsQuery = `
      SELECT *
      FROM scholarships s
      ${whereClause}
      ORDER BY s.${sortColumn} ${sortDirection}
      LIMIT $${paramCounter} OFFSET $${paramCounter + 1}
    `;
    params.push(limit, offset);

    const scholarshipsResult = await client.query(scholarshipsQuery, params);

    res.json({
      success: true,
      data: scholarshipsResult.rows,
      pagination: {
        page: parseInt(page),
        limit: parseInt(limit),
        total,
        pages: Math.ceil(total / limit)
      }
    });

  } catch (error) {
    console.error('Get scholarships error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch scholarships',
      error: error.message
    });
  } finally {
    client.release();
  }
};

/**
 * Get a single scholarship by ID
 */
exports.getScholarship = async (req, res) => {
  const client = await pool.connect();

  try {
    const { id } = req.params;

    const query = `
      SELECT *
      FROM scholarships
      WHERE scholarship_id = $1 AND deleted_at IS NULL
    `;

    const result = await client.query(query, [id]);

    if (result.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Scholarship not found'
      });
    }

    res.json({
      success: true,
      data: result.rows[0]
    });

  } catch (error) {
    console.error('Get scholarship error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch scholarship',
      error: error.message
    });
  } finally {
    client.release();
  }
};

/**
 * Create a new scholarship
 */
exports.createScholarship = async (req, res) => {
  const client = await pool.connect();

  try {
    const {
      scholarship_name,
      type,
      provider,
      country,
      amount,
      currency,
      eligibility,
      application_deadline,
      status
    } = req.body;

    // Validate required fields
    if (!scholarship_name || !type || !provider) {
      return res.status(400).json({
        success: false,
        message: 'Scholarship name, type, and provider are required'
      });
    }

    // Generate slug from scholarship name if not provided
    const slug = scholarship_name
      .toLowerCase()
      .replace(/[^a-z0-9]+/g, '-')
      .replace(/^-|-$/g, '');

    const query = `
      INSERT INTO scholarships (
        scholarship_name, slug, provider_name, scholarship_type, country,
        scholarship_amount, currency, eligibility_criteria, application_deadline,
        is_active
      )
      VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10)
      RETURNING *
    `;

    const values = [
      scholarship_name,
      slug,
      provider,
      type,
      country || null,
      amount || null,
      currency || 'INR',
      eligibility || null,
      application_deadline === '' ? null : application_deadline,
      status === 'active' || status === true
    ];

    const result = await client.query(query, values);

    res.status(201).json({
      success: true,
      message: 'Scholarship created successfully',
      data: result.rows[0]
    });

  } catch (error) {
    console.error('Create scholarship error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to create scholarship',
      error: error.message
    });
  } finally {
    client.release();
  }
};

/**
 * Update a scholarship
 */
exports.updateScholarship = async (req, res) => {
  const client = await pool.connect();

  try {
    const { id } = req.params;
    const updates = req.body;

    // Check if scholarship exists
    const scholarshipCheck = await client.query(
      'SELECT scholarship_id FROM scholarships WHERE scholarship_id = $1 AND deleted_at IS NULL',
      [id]
    );

    if (scholarshipCheck.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Scholarship not found'
      });
    }

    // Map frontend field names to database column names
    const fieldMapping = {
      'scholarship_name': 'scholarship_name',
      'type': 'scholarship_type',
      'provider': 'provider_name',
      'country': 'country',
      'amount': 'scholarship_amount',
      'currency': 'currency',
      'eligibility': 'eligibility_criteria',
      'application_deadline': 'application_deadline',
      'status': 'is_active'
    };

    const updateFields = [];
    const values = [];
    let paramCounter = 1;

    for (const [frontendField, dbColumn] of Object.entries(fieldMapping)) {
      if (updates.hasOwnProperty(frontendField)) {
        // Special handling for status field
        if (frontendField === 'status') {
          updateFields.push(`${dbColumn} = $${paramCounter}`);
          values.push(updates[frontendField] === 'active' || updates[frontendField] === true);
        }
        // Special handling for date fields - convert empty string to null
        else if (frontendField === 'application_deadline') {
          updateFields.push(`${dbColumn} = $${paramCounter}`);
          values.push(updates[frontendField] === '' ? null : updates[frontendField]);
        }
        else {
          updateFields.push(`${dbColumn} = $${paramCounter}`);
          values.push(updates[frontendField]);
        }
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
      UPDATE scholarships
      SET ${updateFields.join(', ')}
      WHERE scholarship_id = $${paramCounter} AND deleted_at IS NULL
      RETURNING *
    `;

    const result = await client.query(query, values);

    res.json({
      success: true,
      message: 'Scholarship updated successfully',
      data: result.rows[0]
    });

  } catch (error) {
    console.error('Update scholarship error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to update scholarship',
      error: error.message
    });
  } finally {
    client.release();
  }
};

/**
 * Delete a scholarship (soft delete)
 */
exports.deleteScholarship = async (req, res) => {
  const client = await pool.connect();

  try {
    const { id } = req.params;

    const query = `
      UPDATE scholarships
      SET deleted_at = CURRENT_TIMESTAMP
      WHERE scholarship_id = $1 AND deleted_at IS NULL
      RETURNING scholarship_id
    `;

    const result = await client.query(query, [id]);

    if (result.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Scholarship not found'
      });
    }

    res.json({
      success: true,
      message: 'Scholarship deleted successfully'
    });

  } catch (error) {
    console.error('Delete scholarship error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to delete scholarship',
      error: error.message
    });
  } finally {
    client.release();
  }
};

/**
 * Update scholarship status
 */
exports.updateScholarshipStatus = async (req, res) => {
  const client = await pool.connect();

  try {
    const { id } = req.params;
    const { status } = req.body;

    if (!status || !['active', 'inactive', 'closed', 'upcoming'].includes(status)) {
      return res.status(400).json({
        success: false,
        message: 'Invalid status. Must be active, inactive, closed, or upcoming'
      });
    }

    const query = `
      UPDATE scholarships
      SET status = $1, updated_at = CURRENT_TIMESTAMP
      WHERE scholarship_id = $2 AND deleted_at IS NULL
      RETURNING *
    `;

    const result = await client.query(query, [status, id]);

    if (result.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Scholarship not found'
      });
    }

    res.json({
      success: true,
      message: 'Scholarship status updated successfully',
      data: result.rows[0]
    });

  } catch (error) {
    console.error('Update scholarship status error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to update scholarship status',
      error: error.message
    });
  } finally {
    client.release();
  }
};

/**
 * Bulk update scholarship status
 */
exports.bulkUpdateStatus = async (req, res) => {
  const client = await pool.connect();

  try {
    const { scholarship_ids, status } = req.body;

    if (!scholarship_ids || !Array.isArray(scholarship_ids) || scholarship_ids.length === 0) {
      return res.status(400).json({
        success: false,
        message: 'scholarship_ids array is required'
      });
    }

    if (!status || !['active', 'inactive', 'closed', 'upcoming'].includes(status)) {
      return res.status(400).json({
        success: false,
        message: 'Invalid status. Must be active, inactive, closed, or upcoming'
      });
    }

    const query = `
      UPDATE scholarships
      SET status = $1, updated_at = CURRENT_TIMESTAMP
      WHERE scholarship_id = ANY($2) AND deleted_at IS NULL
    `;

    const result = await client.query(query, [status, scholarship_ids]);

    res.json({
      success: true,
      message: `${result.rowCount} scholarship(s) updated successfully`,
      data: {
        updated_count: result.rowCount
      }
    });

  } catch (error) {
    console.error('Bulk update status error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to update scholarship statuses',
      error: error.message
    });
  } finally {
    client.release();
  }
};
