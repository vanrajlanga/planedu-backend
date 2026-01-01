const { pool } = require('../../config/database');

/**
 * Get all hostels for a college
 */
exports.getHostelsByCollege = async (req, res) => {
  const client = await pool.connect();

  try {
    const college_id = req.params.collegeId;

    const query = `
      SELECT *
      FROM hostels
      WHERE college_id = $1
      ORDER BY hostel_type ASC, name ASC
    `;

    const result = await client.query(query, [college_id]);

    res.json({
      success: true,
      data: result.rows
    });

  } catch (error) {
    console.error('Get hostels error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch hostels',
      error: error.message
    });
  } finally {
    client.release();
  }
};

/**
 * Get a single hostel by ID
 */
exports.getHostel = async (req, res) => {
  const client = await pool.connect();

  try {
    const { id } = req.params;

    const query = `
      SELECT *
      FROM hostels
      WHERE id = $1
    `;

    const result = await client.query(query, [id]);

    if (result.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Hostel not found'
      });
    }

    res.json({
      success: true,
      data: result.rows[0]
    });

  } catch (error) {
    console.error('Get hostel error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch hostel',
      error: error.message
    });
  } finally {
    client.release();
  }
};

/**
 * Create a new hostel
 */
exports.createHostel = async (req, res) => {
  const client = await pool.connect();

  try {
    const college_id = req.params.collegeId;
    const {
      hostel_type,
      name,
      total_capacity,
      room_types,
      fee_per_semester,
      mess_fee_per_semester,
      amenities,
      description,
      status = 'active',
    } = req.body;

    // Validate required fields
    if (!hostel_type) {
      return res.status(400).json({
        success: false,
        message: 'Hostel type is required'
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
      INSERT INTO hostels (
        college_id, hostel_type, name, total_capacity, room_types,
        fee_per_semester, mess_fee_per_semester, amenities, description, status
      )
      VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10)
      RETURNING *
    `;

    const values = [
      college_id,
      hostel_type,
      name || null,
      total_capacity || null,
      room_types ? JSON.stringify(room_types) : null,
      fee_per_semester || null,
      mess_fee_per_semester || null,
      amenities ? JSON.stringify(amenities) : null,
      description || null,
      status,
    ];

    const result = await client.query(query, values);

    res.status(201).json({
      success: true,
      message: 'Hostel created successfully',
      data: result.rows[0]
    });

  } catch (error) {
    console.error('Create hostel error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to create hostel',
      error: error.message
    });
  } finally {
    client.release();
  }
};

/**
 * Update a hostel
 */
exports.updateHostel = async (req, res) => {
  const client = await pool.connect();

  try {
    const { id } = req.params;
    const updates = req.body;

    // Check if hostel exists
    const hostelCheck = await client.query(
      'SELECT id FROM hostels WHERE id = $1',
      [id]
    );

    if (hostelCheck.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Hostel not found'
      });
    }

    // Build dynamic update query
    const allowedFields = [
      'hostel_type', 'name', 'total_capacity', 'room_types',
      'fee_per_semester', 'mess_fee_per_semester', 'amenities', 'description', 'status'
    ];

    const updateFields = [];
    const values = [];
    let paramCounter = 1;

    for (const field of allowedFields) {
      if (updates.hasOwnProperty(field)) {
        updateFields.push(`${field} = $${paramCounter}`);
        // Handle JSONB fields
        if (field === 'room_types' || field === 'amenities') {
          values.push(updates[field] ? JSON.stringify(updates[field]) : null);
        } else {
          values.push(updates[field]);
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

    values.push(id);

    const query = `
      UPDATE hostels
      SET ${updateFields.join(', ')}
      WHERE id = $${paramCounter}
      RETURNING *
    `;

    const result = await client.query(query, values);

    res.json({
      success: true,
      message: 'Hostel updated successfully',
      data: result.rows[0]
    });

  } catch (error) {
    console.error('Update hostel error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to update hostel',
      error: error.message
    });
  } finally {
    client.release();
  }
};

/**
 * Delete a hostel
 */
exports.deleteHostel = async (req, res) => {
  const client = await pool.connect();

  try {
    const { id } = req.params;

    const query = `
      DELETE FROM hostels
      WHERE id = $1
      RETURNING id
    `;

    const result = await client.query(query, [id]);

    if (result.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Hostel not found'
      });
    }

    res.json({
      success: true,
      message: 'Hostel deleted successfully'
    });

  } catch (error) {
    console.error('Delete hostel error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to delete hostel',
      error: error.message
    });
  } finally {
    client.release();
  }
};
