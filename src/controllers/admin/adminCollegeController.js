const { pool } = require('../../config/database');

/**
 * Admin College Management Controller
 * Handles all college CRUD operations for admin panel
 */

// Get all colleges with pagination, search, and filters
exports.getColleges = async (req, res) => {
  const client = await pool.connect();

  try {
    const {
      page = 1,
      limit = 10,
      search = '',
      college_type = '',
      ownership = '',
      state = '',
      status = '',
      is_featured = '',
      is_verified = '',
      sort_by = 'created_at',
      sort_order = 'desc'
    } = req.query;

    const offset = (page - 1) * limit;

    // Build WHERE clause dynamically
    const conditions = ['deleted_at IS NULL'];
    const params = [];
    let paramCount = 1;

    // Search filter (college name, city, state)
    if (search) {
      conditions.push(`(
        LOWER(college_name) LIKE LOWER($${paramCount}) OR
        LOWER(city) LIKE LOWER($${paramCount}) OR
        LOWER(state) LIKE LOWER($${paramCount})
      )`);
      params.push(`%${search}%`);
      paramCount++;
    }

    // College type filter
    if (college_type) {
      conditions.push(`college_type = $${paramCount}`);
      params.push(college_type);
      paramCount++;
    }

    // Ownership filter
    if (ownership) {
      conditions.push(`ownership = $${paramCount}`);
      params.push(ownership);
      paramCount++;
    }

    // State filter
    if (state) {
      conditions.push(`state = $${paramCount}`);
      params.push(state);
      paramCount++;
    }

    // Status filter
    if (status) {
      conditions.push(`status = $${paramCount}`);
      params.push(status);
      paramCount++;
    }

    // Featured filter
    if (is_featured !== '') {
      conditions.push(`is_featured = $${paramCount}`);
      params.push(is_featured === 'true');
      paramCount++;
    }

    // Verified filter
    if (is_verified !== '') {
      conditions.push(`is_verified = $${paramCount}`);
      params.push(is_verified === 'true');
      paramCount++;
    }

    const whereClause = conditions.length > 0 ? `WHERE ${conditions.join(' AND ')}` : '';

    // Validate sort column to prevent SQL injection
    const allowedSortColumns = ['created_at', 'college_name', 'established_year', 'total_reviews', 'avg_rating', 'view_count'];
    const sortColumn = allowedSortColumns.includes(sort_by) ? sort_by : 'created_at';
    const sortDirection = sort_order.toLowerCase() === 'asc' ? 'ASC' : 'DESC';

    // Get total count
    const countQuery = `
      SELECT COUNT(*) as total
      FROM colleges
      ${whereClause}
    `;
    const countResult = await client.query(countQuery, params);
    const totalColleges = parseInt(countResult.rows[0].total);

    // Get paginated colleges
    const collegesQuery = `
      SELECT
        college_id,
        college_name,
        slug,
        short_name,
        established_year,
        college_type,
        ownership,
        country,
        state,
        city,
        pincode,
        address,
        website_url,
        phone,
        email,
        logo_url,
        is_featured,
        is_verified,
        status,
        avg_rating,
        total_reviews,
        view_count,
        created_at,
        updated_at
      FROM colleges
      ${whereClause}
      ORDER BY ${sortColumn} ${sortDirection}
      LIMIT $${paramCount} OFFSET $${paramCount + 1}
    `;

    params.push(parseInt(limit), offset);
    const collegesResult = await client.query(collegesQuery, params);

    // Log admin action
    await client.query(
      `INSERT INTO admin_audit_logs (admin_id, action, resource_type, details)
       VALUES ($1, $2, $3, $4)`,
      [
        req.admin.admin_id,
        'VIEW',
        'colleges',
        JSON.stringify({ page, limit, search, filters: { college_type, ownership, state, status } })
      ]
    );

    res.json({
      success: true,
      data: {
        colleges: collegesResult.rows,
        pagination: {
          current_page: parseInt(page),
          per_page: parseInt(limit),
          total_items: totalColleges,
          total_pages: Math.ceil(totalColleges / limit),
          has_next: page * limit < totalColleges,
          has_prev: page > 1
        },
        filters_applied: {
          search,
          college_type,
          ownership,
          state,
          status,
          is_featured,
          is_verified
        }
      }
    });

  } catch (error) {
    console.error('Get colleges error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch colleges',
      error: error.message
    });
  } finally {
    client.release();
  }
};

// Get single college by ID
exports.getCollegeById = async (req, res) => {
  const client = await pool.connect();

  try {
    const { id } = req.params;

    const query = `
      SELECT
        college_id,
        college_name,
        slug,
        short_name,
        established_year,
        college_type,
        ownership,
        country,
        state,
        city,
        pincode,
        address,
        latitude,
        longitude,
        website_url,
        phone,
        email,
        description,
        logo_url,
        is_featured,
        is_verified,
        status,
        avg_rating,
        total_reviews,
        view_count,
        created_at,
        updated_at
      FROM colleges
      WHERE college_id = $1 AND deleted_at IS NULL
    `;

    const result = await client.query(query, [id]);

    if (result.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'College not found'
      });
    }

    // Log admin action
    await client.query(
      `INSERT INTO admin_audit_logs (admin_id, action, resource_type, resource_id)
       VALUES ($1, $2, $3, $4)`,
      [req.admin.admin_id, 'VIEW', 'college', id]
    );

    res.json({
      success: true,
      data: result.rows[0]
    });

  } catch (error) {
    console.error('Get college by ID error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch college',
      error: error.message
    });
  } finally {
    client.release();
  }
};

// Create new college
exports.createCollege = async (req, res) => {
  const client = await pool.connect();

  try {
    await client.query('BEGIN');

    const {
      college_name,
      short_name,
      established_year,
      college_type,
      ownership,
      country = 'India',
      state,
      city,
      pincode,
      address,
      latitude,
      longitude,
      website_url,
      phone,
      email,
      description,
      logo_url,
      is_featured = false,
      is_verified = false,
      status = 'active'
    } = req.body;

    // Validation
    if (!college_name || !state || !city || !college_type) {
      return res.status(400).json({
        success: false,
        message: 'Missing required fields: college_name, state, city, college_type'
      });
    }

    // Generate slug from college name
    const slug = college_name
      .toLowerCase()
      .replace(/[^a-z0-9]+/g, '-')
      .replace(/^-+|-+$/g, '');

    // Check if slug already exists
    const slugCheck = await client.query(
      'SELECT college_id FROM colleges WHERE slug = $1 AND deleted_at IS NULL',
      [slug]
    );

    if (slugCheck.rows.length > 0) {
      return res.status(409).json({
        success: false,
        message: 'A college with this name already exists'
      });
    }

    // Insert college
    const insertQuery = `
      INSERT INTO colleges (
        college_name, slug, short_name, established_year, college_type, ownership,
        country, state, city, pincode, address, latitude, longitude,
        website_url, phone, email, description, logo_url,
        is_featured, is_verified, status
      )
      VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16, $17, $18, $19, $20, $21)
      RETURNING college_id, college_name, slug, state, city, status, created_at
    `;

    const values = [
      college_name, slug, short_name, established_year, college_type, ownership,
      country, state, city, pincode, address, latitude, longitude,
      website_url, phone, email, description, logo_url,
      is_featured, is_verified, status
    ];

    const result = await client.query(insertQuery, values);
    const newCollege = result.rows[0];

    // Log admin action
    await client.query(
      `INSERT INTO admin_audit_logs (admin_id, action, resource_type, resource_id, details)
       VALUES ($1, $2, $3, $4, $5)`,
      [
        req.admin.admin_id,
        'CREATE',
        'college',
        newCollege.college_id,
        JSON.stringify({ college_name, state, city })
      ]
    );

    await client.query('COMMIT');

    res.status(201).json({
      success: true,
      message: 'College created successfully',
      data: newCollege
    });

  } catch (error) {
    await client.query('ROLLBACK');
    console.error('Create college error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to create college',
      error: error.message
    });
  } finally {
    client.release();
  }
};

// Update college
exports.updateCollege = async (req, res) => {
  const client = await pool.connect();

  try {
    await client.query('BEGIN');

    const { id } = req.params;
    const updateFields = req.body;

    // Check if college exists
    const checkQuery = 'SELECT college_id, college_name FROM colleges WHERE college_id = $1 AND deleted_at IS NULL';
    const checkResult = await client.query(checkQuery, [id]);

    if (checkResult.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'College not found'
      });
    }

    const oldCollegeName = checkResult.rows[0].college_name;

    // If college_name is being updated, regenerate slug
    if (updateFields.college_name && updateFields.college_name !== oldCollegeName) {
      const newSlug = updateFields.college_name
        .toLowerCase()
        .replace(/[^a-z0-9]+/g, '-')
        .replace(/^-+|-+$/g, '');

      // Check if new slug already exists
      const slugCheck = await client.query(
        'SELECT college_id FROM colleges WHERE slug = $1 AND college_id != $2 AND deleted_at IS NULL',
        [newSlug, id]
      );

      if (slugCheck.rows.length > 0) {
        return res.status(409).json({
          success: false,
          message: 'A college with this name already exists'
        });
      }

      updateFields.slug = newSlug;
    }

    // Build dynamic UPDATE query
    const allowedFields = [
      'college_name', 'slug', 'short_name', 'established_year', 'college_type', 'ownership',
      'country', 'state', 'city', 'pincode', 'address', 'latitude', 'longitude',
      'website_url', 'phone', 'email', 'description', 'logo_url',
      'is_featured', 'is_verified', 'status'
    ];

    const updates = [];
    const values = [];
    let paramCount = 1;

    Object.keys(updateFields).forEach(field => {
      if (allowedFields.includes(field)) {
        updates.push(`${field} = $${paramCount}`);
        values.push(updateFields[field]);
        paramCount++;
      }
    });

    if (updates.length === 0) {
      return res.status(400).json({
        success: false,
        message: 'No valid fields to update'
      });
    }

    // Add updated_at
    updates.push(`updated_at = NOW()`);
    values.push(id);

    const updateQuery = `
      UPDATE colleges
      SET ${updates.join(', ')}
      WHERE college_id = $${paramCount}
      RETURNING college_id, college_name, slug, state, city, status, updated_at
    `;

    const result = await client.query(updateQuery, values);
    const updatedCollege = result.rows[0];

    // Log admin action
    await client.query(
      `INSERT INTO admin_audit_logs (admin_id, action, resource_type, resource_id, details)
       VALUES ($1, $2, $3, $4, $5)`,
      [
        req.admin.admin_id,
        'UPDATE',
        'college',
        id,
        JSON.stringify({ updated_fields: Object.keys(updateFields) })
      ]
    );

    await client.query('COMMIT');

    res.json({
      success: true,
      message: 'College updated successfully',
      data: updatedCollege
    });

  } catch (error) {
    await client.query('ROLLBACK');
    console.error('Update college error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to update college',
      error: error.message
    });
  } finally {
    client.release();
  }
};

// Update college status
exports.updateCollegeStatus = async (req, res) => {
  const client = await pool.connect();

  try {
    await client.query('BEGIN');

    const { id } = req.params;
    const { status } = req.body;

    // Validate status
    const validStatuses = ['active', 'inactive', 'pending'];
    if (!status || !validStatuses.includes(status)) {
      return res.status(400).json({
        success: false,
        message: 'Invalid status. Must be: active, inactive, or pending'
      });
    }

    // Check if college exists
    const checkQuery = 'SELECT college_id, status FROM colleges WHERE college_id = $1 AND deleted_at IS NULL';
    const checkResult = await client.query(checkQuery, [id]);

    if (checkResult.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'College not found'
      });
    }

    const oldStatus = checkResult.rows[0].status;

    // Update status
    const updateQuery = `
      UPDATE colleges
      SET status = $1, updated_at = NOW()
      WHERE college_id = $2
      RETURNING college_id, college_name, status, updated_at
    `;

    const result = await client.query(updateQuery, [status, id]);

    // Log admin action
    await client.query(
      `INSERT INTO admin_audit_logs (admin_id, action, resource_type, resource_id, details)
       VALUES ($1, $2, $3, $4, $5)`,
      [
        req.admin.admin_id,
        'UPDATE_STATUS',
        'college',
        id,
        JSON.stringify({ old_status: oldStatus, new_status: status })
      ]
    );

    await client.query('COMMIT');

    res.json({
      success: true,
      message: 'College status updated successfully',
      data: result.rows[0]
    });

  } catch (error) {
    await client.query('ROLLBACK');
    console.error('Update college status error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to update college status',
      error: error.message
    });
  } finally {
    client.release();
  }
};

// Soft delete college
exports.deleteCollege = async (req, res) => {
  const client = await pool.connect();

  try {
    await client.query('BEGIN');

    const { id } = req.params;

    // Check if college exists
    const checkQuery = 'SELECT college_id, college_name FROM colleges WHERE college_id = $1 AND deleted_at IS NULL';
    const checkResult = await client.query(checkQuery, [id]);

    if (checkResult.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'College not found'
      });
    }

    const collegeName = checkResult.rows[0].college_name;

    // Soft delete
    const deleteQuery = `
      UPDATE colleges
      SET deleted_at = NOW(), status = 'inactive'
      WHERE college_id = $1
      RETURNING college_id, college_name
    `;

    await client.query(deleteQuery, [id]);

    // Log admin action
    await client.query(
      `INSERT INTO admin_audit_logs (admin_id, action, resource_type, resource_id, details)
       VALUES ($1, $2, $3, $4, $5)`,
      [
        req.admin.admin_id,
        'DELETE',
        'college',
        id,
        JSON.stringify({ college_name: collegeName })
      ]
    );

    await client.query('COMMIT');

    res.json({
      success: true,
      message: 'College deleted successfully'
    });

  } catch (error) {
    await client.query('ROLLBACK');
    console.error('Delete college error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to delete college',
      error: error.message
    });
  } finally {
    client.release();
  }
};

// Bulk status update
exports.bulkUpdateStatus = async (req, res) => {
  const client = await pool.connect();

  try {
    await client.query('BEGIN');

    const { college_ids, status } = req.body;

    // Validation
    if (!college_ids || !Array.isArray(college_ids) || college_ids.length === 0) {
      return res.status(400).json({
        success: false,
        message: 'college_ids array is required'
      });
    }

    const validStatuses = ['active', 'inactive', 'pending'];
    if (!status || !validStatuses.includes(status)) {
      return res.status(400).json({
        success: false,
        message: 'Invalid status. Must be: active, inactive, or pending'
      });
    }

    // Create placeholders for parameterized query
    const placeholders = college_ids.map((_, index) => `$${index + 1}`).join(',');

    const updateQuery = `
      UPDATE colleges
      SET status = $${college_ids.length + 1}, updated_at = NOW()
      WHERE college_id IN (${placeholders}) AND deleted_at IS NULL
      RETURNING college_id, college_name, status
    `;

    const result = await client.query(updateQuery, [...college_ids, status]);

    // Log admin action
    await client.query(
      `INSERT INTO admin_audit_logs (admin_id, action, resource_type, details)
       VALUES ($1, $2, $3, $4)`,
      [
        req.admin.admin_id,
        'BULK_UPDATE_STATUS',
        'colleges',
        JSON.stringify({ college_ids, status, updated_count: result.rows.length })
      ]
    );

    await client.query('COMMIT');

    res.json({
      success: true,
      message: `${result.rows.length} college(s) updated successfully`,
      data: {
        updated_count: result.rows.length,
        colleges: result.rows
      }
    });

  } catch (error) {
    await client.query('ROLLBACK');
    console.error('Bulk update status error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to update colleges',
      error: error.message
    });
  } finally {
    client.release();
  }
};

// Get filter options (for dropdown filters)
exports.getFilterOptions = async (req, res) => {
  const client = await pool.connect();

  try {
    // Get unique states
    const statesQuery = `
      SELECT DISTINCT state
      FROM colleges
      WHERE state IS NOT NULL AND deleted_at IS NULL
      ORDER BY state
    `;
    const statesResult = await client.query(statesQuery);

    // Get unique college types
    const typesQuery = `
      SELECT DISTINCT college_type
      FROM colleges
      WHERE college_type IS NOT NULL AND deleted_at IS NULL
      ORDER BY college_type
    `;
    const typesResult = await client.query(typesQuery);

    // Get unique ownership types
    const ownershipQuery = `
      SELECT DISTINCT ownership
      FROM colleges
      WHERE ownership IS NOT NULL AND deleted_at IS NULL
      ORDER BY ownership
    `;
    const ownershipResult = await client.query(ownershipQuery);

    res.json({
      success: true,
      data: {
        states: statesResult.rows.map(row => row.state),
        college_types: typesResult.rows.map(row => row.college_type),
        ownership_types: ownershipResult.rows.map(row => row.ownership),
        statuses: ['active', 'inactive', 'pending']
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
