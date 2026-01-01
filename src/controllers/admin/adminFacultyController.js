const { pool } = require('../../config/database');

/**
 * Get all faculty for a college
 */
exports.getFacultyByCollege = async (req, res) => {
  const client = await pool.connect();

  try {
    const college_id = req.params.collegeId;
    const { department } = req.query;

    let query = `
      SELECT *
      FROM faculty_members
      WHERE college_id = $1
    `;
    const params = [college_id];

    if (department) {
      query += ` AND department = $2`;
      params.push(department);
    }

    query += ` ORDER BY display_order ASC, name ASC`;

    const result = await client.query(query, params);

    // Get distinct departments for filtering
    const deptQuery = `
      SELECT DISTINCT department
      FROM faculty_members
      WHERE college_id = $1 AND department IS NOT NULL
      ORDER BY department
    `;
    const deptResult = await client.query(deptQuery, [college_id]);

    res.json({
      success: true,
      data: {
        faculty: result.rows,
        departments: deptResult.rows.map(r => r.department)
      }
    });

  } catch (error) {
    console.error('Get faculty error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch faculty',
      error: error.message
    });
  } finally {
    client.release();
  }
};

/**
 * Get a single faculty member by ID
 */
exports.getFaculty = async (req, res) => {
  const client = await pool.connect();

  try {
    const { id } = req.params;

    const query = `
      SELECT *
      FROM faculty_members
      WHERE id = $1
    `;

    const result = await client.query(query, [id]);

    if (result.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Faculty member not found'
      });
    }

    res.json({
      success: true,
      data: result.rows[0]
    });

  } catch (error) {
    console.error('Get faculty error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch faculty member',
      error: error.message
    });
  } finally {
    client.release();
  }
};

/**
 * Create a new faculty member
 */
exports.createFaculty = async (req, res) => {
  const client = await pool.connect();

  try {
    const college_id = req.params.collegeId;
    const {
      name,
      designation,
      department,
      qualification,
      specialization,
      experience_years,
      profile_image_url,
      email,
      phone,
      profile_url,
      status = 'active',
      display_order = 0,
    } = req.body;

    // Validate required fields
    if (!name) {
      return res.status(400).json({
        success: false,
        message: 'Name is required'
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
      INSERT INTO faculty_members (
        college_id, name, designation, department, qualification,
        specialization, experience_years, profile_image_url, email, phone, profile_url, status, display_order
      )
      VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13)
      RETURNING *
    `;

    const values = [
      college_id,
      name,
      designation || null,
      department || null,
      qualification || null,
      specialization || null,
      experience_years || null,
      profile_image_url || null,
      email || null,
      phone || null,
      profile_url || null,
      status,
      display_order,
    ];

    const result = await client.query(query, values);

    res.status(201).json({
      success: true,
      message: 'Faculty member added successfully',
      data: result.rows[0]
    });

  } catch (error) {
    console.error('Create faculty error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to create faculty member',
      error: error.message
    });
  } finally {
    client.release();
  }
};

/**
 * Update a faculty member
 */
exports.updateFaculty = async (req, res) => {
  const client = await pool.connect();

  try {
    const { id } = req.params;
    const updates = req.body;

    // Check if faculty exists
    const facultyCheck = await client.query(
      'SELECT id FROM faculty_members WHERE id = $1',
      [id]
    );

    if (facultyCheck.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Faculty member not found'
      });
    }

    // Build dynamic update query
    const allowedFields = [
      'name', 'designation', 'department', 'qualification',
      'specialization', 'experience_years', 'profile_image_url',
      'email', 'phone', 'profile_url', 'status', 'display_order'
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
      UPDATE faculty_members
      SET ${updateFields.join(', ')}
      WHERE id = $${paramCounter}
      RETURNING *
    `;

    const result = await client.query(query, values);

    res.json({
      success: true,
      message: 'Faculty member updated successfully',
      data: result.rows[0]
    });

  } catch (error) {
    console.error('Update faculty error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to update faculty member',
      error: error.message
    });
  } finally {
    client.release();
  }
};

/**
 * Delete a faculty member
 */
exports.deleteFaculty = async (req, res) => {
  const client = await pool.connect();

  try {
    const { id } = req.params;

    const query = `
      DELETE FROM faculty_members
      WHERE id = $1
      RETURNING id
    `;

    const result = await client.query(query, [id]);

    if (result.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Faculty member not found'
      });
    }

    res.json({
      success: true,
      message: 'Faculty member deleted successfully'
    });

  } catch (error) {
    console.error('Delete faculty error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to delete faculty member',
      error: error.message
    });
  } finally {
    client.release();
  }
};
