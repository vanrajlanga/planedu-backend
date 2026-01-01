const { pool } = require('../../config/database');

/**
 * Get all rankings for a college with pagination
 */
exports.getRankingsByCollege = async (req, res) => {
  const client = await pool.connect();

  try {
    const college_id = req.params.collegeId;
    const {
      page = 1,
      limit = 50,
      agency_id,
      ranking_year,
    } = req.query;

    const offset = (page - 1) * limit;
    const conditions = ['cr.college_id = $1'];
    const params = [college_id];
    let paramCounter = 2;

    if (agency_id) {
      conditions.push(`cr.agency_id = $${paramCounter}`);
      params.push(agency_id);
      paramCounter++;
    }

    if (ranking_year) {
      conditions.push(`cr.ranking_year = $${paramCounter}`);
      params.push(ranking_year);
      paramCounter++;
    }

    const whereClause = `WHERE ${conditions.join(' AND ')}`;

    // Get total count
    const countQuery = `
      SELECT COUNT(*) as total
      FROM college_rankings cr
      ${whereClause}
    `;
    const countResult = await client.query(countQuery, params);
    const total = parseInt(countResult.rows[0].total);

    // Get rankings with agency info
    const rankingsQuery = `
      SELECT
        cr.*,
        ra.agency_name,
        ra.agency_code
      FROM college_rankings cr
      LEFT JOIN ranking_agencies ra ON cr.agency_id = ra.agency_id
      ${whereClause}
      ORDER BY cr.ranking_year DESC, ra.agency_name ASC, cr.category ASC
      LIMIT $${paramCounter} OFFSET $${paramCounter + 1}
    `;
    params.push(limit, offset);

    const rankingsResult = await client.query(rankingsQuery, params);

    res.json({
      success: true,
      data: {
        rankings: rankingsResult.rows,
        pagination: {
          page: parseInt(page),
          limit: parseInt(limit),
          total,
          pages: Math.ceil(total / limit)
        }
      }
    });

  } catch (error) {
    console.error('Get rankings error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch rankings',
      error: error.message
    });
  } finally {
    client.release();
  }
};

/**
 * Get a single ranking by ID
 */
exports.getRanking = async (req, res) => {
  const client = await pool.connect();

  try {
    const { id } = req.params;

    const query = `
      SELECT
        cr.*,
        ra.agency_name,
        ra.agency_code
      FROM college_rankings cr
      LEFT JOIN ranking_agencies ra ON cr.agency_id = ra.agency_id
      WHERE cr.ranking_id = $1
    `;

    const result = await client.query(query, [id]);

    if (result.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Ranking not found'
      });
    }

    res.json({
      success: true,
      data: result.rows[0]
    });

  } catch (error) {
    console.error('Get ranking error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch ranking',
      error: error.message
    });
  } finally {
    client.release();
  }
};

/**
 * Create a new ranking
 */
exports.createRanking = async (req, res) => {
  const client = await pool.connect();

  try {
    const college_id = req.params.collegeId;
    const {
      agency_id,
      ranking_year,
      category,
      rank_position,
      score,
    } = req.body;

    // Validate required fields
    if (!agency_id || !ranking_year) {
      return res.status(400).json({
        success: false,
        message: 'Agency and ranking year are required'
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

    // Check if agency exists
    const agencyCheck = await client.query(
      'SELECT agency_id FROM ranking_agencies WHERE agency_id = $1',
      [agency_id]
    );

    if (agencyCheck.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Ranking agency not found'
      });
    }

    const query = `
      INSERT INTO college_rankings (
        college_id, agency_id, ranking_year, category, rank_position, score
      )
      VALUES ($1, $2, $3, $4, $5, $6)
      RETURNING *
    `;

    const values = [
      college_id,
      agency_id,
      ranking_year,
      category || null,
      rank_position || null,
      score || null,
    ];

    const result = await client.query(query, values);

    // Fetch with agency info
    const fullResult = await client.query(`
      SELECT cr.*, ra.agency_name, ra.agency_code
      FROM college_rankings cr
      LEFT JOIN ranking_agencies ra ON cr.agency_id = ra.agency_id
      WHERE cr.ranking_id = $1
    `, [result.rows[0].ranking_id]);

    res.status(201).json({
      success: true,
      message: 'Ranking created successfully',
      data: fullResult.rows[0]
    });

  } catch (error) {
    console.error('Create ranking error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to create ranking',
      error: error.message
    });
  } finally {
    client.release();
  }
};

/**
 * Update a ranking
 */
exports.updateRanking = async (req, res) => {
  const client = await pool.connect();

  try {
    const { id } = req.params;
    const updates = req.body;

    // Check if ranking exists
    const rankingCheck = await client.query(
      'SELECT ranking_id FROM college_rankings WHERE ranking_id = $1',
      [id]
    );

    if (rankingCheck.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Ranking not found'
      });
    }

    // Build dynamic update query
    const allowedFields = [
      'agency_id', 'ranking_year', 'category', 'rank_position', 'score'
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
      UPDATE college_rankings
      SET ${updateFields.join(', ')}
      WHERE ranking_id = $${paramCounter}
      RETURNING *
    `;

    await client.query(query, values);

    // Fetch with agency info
    const fullResult = await client.query(`
      SELECT cr.*, ra.agency_name, ra.agency_code
      FROM college_rankings cr
      LEFT JOIN ranking_agencies ra ON cr.agency_id = ra.agency_id
      WHERE cr.ranking_id = $1
    `, [id]);

    res.json({
      success: true,
      message: 'Ranking updated successfully',
      data: fullResult.rows[0]
    });

  } catch (error) {
    console.error('Update ranking error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to update ranking',
      error: error.message
    });
  } finally {
    client.release();
  }
};

/**
 * Delete a ranking
 */
exports.deleteRanking = async (req, res) => {
  const client = await pool.connect();

  try {
    const { id } = req.params;

    const query = `
      DELETE FROM college_rankings
      WHERE ranking_id = $1
      RETURNING ranking_id
    `;

    const result = await client.query(query, [id]);

    if (result.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Ranking not found'
      });
    }

    res.json({
      success: true,
      message: 'Ranking deleted successfully'
    });

  } catch (error) {
    console.error('Delete ranking error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to delete ranking',
      error: error.message
    });
  } finally {
    client.release();
  }
};

/**
 * Bulk create rankings
 */
exports.bulkCreateRankings = async (req, res) => {
  const client = await pool.connect();

  try {
    const college_id = req.params.collegeId;
    const { rankings } = req.body;

    if (!rankings || !Array.isArray(rankings) || rankings.length === 0) {
      return res.status(400).json({
        success: false,
        message: 'Rankings array is required'
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

    const insertedRankings = [];

    for (const ranking of rankings) {
      const {
        agency_id,
        ranking_year,
        category,
        rank_position,
        score,
      } = ranking;

      if (!agency_id || !ranking_year) {
        continue; // Skip invalid entries
      }

      const query = `
        INSERT INTO college_rankings (
          college_id, agency_id, ranking_year, category, rank_position, score
        )
        VALUES ($1, $2, $3, $4, $5, $6)
        RETURNING *
      `;

      const values = [
        college_id,
        agency_id,
        ranking_year,
        category || null,
        rank_position || null,
        score || null,
      ];

      const result = await client.query(query, values);
      insertedRankings.push(result.rows[0]);
    }

    await client.query('COMMIT');

    res.status(201).json({
      success: true,
      message: `${insertedRankings.length} rankings created successfully`,
      data: insertedRankings
    });

  } catch (error) {
    await client.query('ROLLBACK');
    console.error('Bulk create rankings error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to create rankings',
      error: error.message
    });
  } finally {
    client.release();
  }
};

/**
 * Get filter options (years, agencies)
 */
exports.getFilterOptions = async (req, res) => {
  const client = await pool.connect();

  try {
    const college_id = req.params.collegeId;

    // Get distinct years
    const yearsQuery = `
      SELECT DISTINCT ranking_year
      FROM college_rankings
      WHERE college_id = $1
      ORDER BY ranking_year DESC
    `;
    const yearsResult = await client.query(yearsQuery, [college_id]);

    // Get all active agencies (not just those with rankings)
    const agenciesQuery = `
      SELECT agency_id, agency_name, agency_code
      FROM ranking_agencies
      WHERE is_active = true
      ORDER BY agency_name
    `;
    const agenciesResult = await client.query(agenciesQuery);

    res.json({
      success: true,
      data: {
        ranking_years: yearsResult.rows.map(r => r.ranking_year),
        agencies: agenciesResult.rows
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
