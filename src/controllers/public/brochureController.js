const { pool } = require('../../config/database');

/**
 * @route POST /api/v1/brochures/download
 * @desc Track brochure download and return download URL
 * @access Public
 */
exports.downloadBrochure = async (req, res) => {
  const client = await pool.connect();

  try {
    const { college_id } = req.body;

    if (!college_id) {
      return res.status(400).json({
        success: false,
        message: 'College ID is required'
      });
    }

    // Get college brochure URL
    const collegeResult = await client.query(`
      SELECT college_id, college_name, brochure_url
      FROM colleges
      WHERE college_id = $1 AND status = 'active' AND deleted_at IS NULL
    `, [college_id]);

    if (collegeResult.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'College not found'
      });
    }

    const college = collegeResult.rows[0];

    // Track the download
    const userId = req.user?.user_id || null;
    const ipAddress = req.headers['x-forwarded-for'] || req.socket.remoteAddress || null;
    const userAgent = req.headers['user-agent'] || null;

    await client.query(`
      INSERT INTO brochure_downloads (college_id, user_id, ip_address, user_agent)
      VALUES ($1, $2, $3, $4)
    `, [college_id, userId, ipAddress, userAgent]);

    // Return the brochure URL (or placeholder if not set)
    const brochureUrl = college.brochure_url || generatePlaceholderBrochure(college);

    res.json({
      success: true,
      data: {
        college_id: college.college_id,
        college_name: college.college_name,
        brochure_url: brochureUrl,
        has_brochure: !!college.brochure_url
      }
    });

  } catch (error) {
    console.error('Error downloading brochure:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to process brochure download',
      error: error.message
    });
  } finally {
    client.release();
  }
};

/**
 * @route GET /api/v1/brochures/stats/:college_id
 * @desc Get brochure download stats for a college
 * @access Public
 */
exports.getBrochureStats = async (req, res) => {
  const client = await pool.connect();

  try {
    const { college_id } = req.params;

    const statsResult = await client.query(`
      SELECT
        COUNT(*) as total_downloads,
        COUNT(DISTINCT user_id) FILTER (WHERE user_id IS NOT NULL) as unique_user_downloads,
        COUNT(*) FILTER (WHERE downloaded_at >= NOW() - INTERVAL '30 days') as last_30_days
      FROM brochure_downloads
      WHERE college_id = $1
    `, [college_id]);

    res.json({
      success: true,
      data: statsResult.rows[0]
    });

  } catch (error) {
    console.error('Error fetching brochure stats:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch brochure stats',
      error: error.message
    });
  } finally {
    client.release();
  }
};

/**
 * Generate a placeholder brochure message/URL for colleges without brochures
 */
function generatePlaceholderBrochure(college) {
  // Return null to indicate no brochure available
  // Frontend will handle this appropriately
  return null;
}

module.exports = exports;
