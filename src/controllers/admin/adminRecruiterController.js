const { pool } = require('../../config/database');

/**
 * Get all recruiters for a placement
 */
exports.getRecruiters = async (req, res) => {
  const client = await pool.connect();

  try {
    const { placementId } = req.params;

    const query = `
      SELECT *
      FROM placement_recruiters
      WHERE placement_id = $1
      ORDER BY offers_count DESC NULLS LAST, company_name ASC
    `;

    const result = await client.query(query, [placementId]);

    res.json({
      success: true,
      data: result.rows
    });

  } catch (error) {
    console.error('Get recruiters error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch recruiters',
      error: error.message
    });
  } finally {
    client.release();
  }
};

/**
 * Get a single recruiter by ID
 */
exports.getRecruiter = async (req, res) => {
  const client = await pool.connect();

  try {
    const { id } = req.params;

    const query = `
      SELECT *
      FROM placement_recruiters
      WHERE id = $1
    `;

    const result = await client.query(query, [id]);

    if (result.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Recruiter not found'
      });
    }

    res.json({
      success: true,
      data: result.rows[0]
    });

  } catch (error) {
    console.error('Get recruiter error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch recruiter',
      error: error.message
    });
  } finally {
    client.release();
  }
};

/**
 * Create a new recruiter
 */
exports.createRecruiter = async (req, res) => {
  const client = await pool.connect();

  try {
    const { placementId } = req.params;
    const {
      company_name,
      company_logo_url,
      sector,
      offers_count,
      package_offered
    } = req.body;

    // Validate required fields
    if (!company_name) {
      return res.status(400).json({
        success: false,
        message: 'Company name is required'
      });
    }

    // Check if placement exists
    const placementCheck = await client.query(
      'SELECT placement_id FROM placements WHERE placement_id = $1',
      [placementId]
    );

    if (placementCheck.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Placement not found'
      });
    }

    const query = `
      INSERT INTO placement_recruiters (
        placement_id, company_name, company_logo_url, sector, offers_count, package_offered
      )
      VALUES ($1, $2, $3, $4, $5, $6)
      RETURNING *
    `;

    const values = [
      placementId,
      company_name,
      company_logo_url || null,
      sector || null,
      offers_count || null,
      package_offered || null
    ];

    const result = await client.query(query, values);

    res.status(201).json({
      success: true,
      message: 'Recruiter added successfully',
      data: result.rows[0]
    });

  } catch (error) {
    console.error('Create recruiter error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to create recruiter',
      error: error.message
    });
  } finally {
    client.release();
  }
};

/**
 * Update a recruiter
 */
exports.updateRecruiter = async (req, res) => {
  const client = await pool.connect();

  try {
    const { id } = req.params;
    const updates = req.body;

    // Check if recruiter exists
    const recruiterCheck = await client.query(
      'SELECT id FROM placement_recruiters WHERE id = $1',
      [id]
    );

    if (recruiterCheck.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Recruiter not found'
      });
    }

    // Build dynamic update query
    const allowedFields = [
      'company_name', 'company_logo_url', 'sector', 'offers_count', 'package_offered'
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
      UPDATE placement_recruiters
      SET ${updateFields.join(', ')}
      WHERE id = $${paramCounter}
      RETURNING *
    `;

    const result = await client.query(query, values);

    res.json({
      success: true,
      message: 'Recruiter updated successfully',
      data: result.rows[0]
    });

  } catch (error) {
    console.error('Update recruiter error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to update recruiter',
      error: error.message
    });
  } finally {
    client.release();
  }
};

/**
 * Delete a recruiter
 */
exports.deleteRecruiter = async (req, res) => {
  const client = await pool.connect();

  try {
    const { id } = req.params;

    const query = `
      DELETE FROM placement_recruiters
      WHERE id = $1
      RETURNING id
    `;

    const result = await client.query(query, [id]);

    if (result.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Recruiter not found'
      });
    }

    res.json({
      success: true,
      message: 'Recruiter deleted successfully'
    });

  } catch (error) {
    console.error('Delete recruiter error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to delete recruiter',
      error: error.message
    });
  } finally {
    client.release();
  }
};

/**
 * Bulk create recruiters
 */
exports.bulkCreateRecruiters = async (req, res) => {
  const client = await pool.connect();

  try {
    const { placementId } = req.params;
    const { recruiters } = req.body;

    if (!recruiters || !Array.isArray(recruiters) || recruiters.length === 0) {
      return res.status(400).json({
        success: false,
        message: 'Recruiters array is required'
      });
    }

    // Check if placement exists
    const placementCheck = await client.query(
      'SELECT placement_id FROM placements WHERE placement_id = $1',
      [placementId]
    );

    if (placementCheck.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Placement not found'
      });
    }

    await client.query('BEGIN');

    const createdRecruiters = [];

    for (const recruiter of recruiters) {
      if (!recruiter.company_name) continue;

      const query = `
        INSERT INTO placement_recruiters (
          placement_id, company_name, company_logo_url, sector, offers_count, package_offered
        )
        VALUES ($1, $2, $3, $4, $5, $6)
        RETURNING *
      `;

      const values = [
        placementId,
        recruiter.company_name,
        recruiter.company_logo_url || null,
        recruiter.sector || null,
        recruiter.offers_count || null,
        recruiter.package_offered || null
      ];

      const result = await client.query(query, values);
      createdRecruiters.push(result.rows[0]);
    }

    await client.query('COMMIT');

    res.status(201).json({
      success: true,
      message: `${createdRecruiters.length} recruiter(s) added successfully`,
      data: createdRecruiters
    });

  } catch (error) {
    await client.query('ROLLBACK');
    console.error('Bulk create recruiters error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to create recruiters',
      error: error.message
    });
  } finally {
    client.release();
  }
};

/**
 * Get sector options
 */
exports.getSectorOptions = async (req, res) => {
  res.json({
    success: true,
    data: [
      'IT/Software',
      'Consulting',
      'BFSI',
      'FMCG',
      'Core Engineering',
      'Analytics',
      'E-Commerce',
      'Healthcare',
      'Automobile',
      'Others'
    ]
  });
};
