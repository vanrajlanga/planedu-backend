const { pool } = require('../../config/database');

/**
 * @route GET /api/v1/admin/quick-tabs
 * @desc Get all quick tabs for admin management
 * @access Admin
 */
exports.getQuickTabs = async (req, res) => {
  const client = await pool.connect();

  try {
    const query = `
      SELECT
        qt.*,
        COALESCE(counts.college_count, 0) as college_count
      FROM quick_tabs qt
      LEFT JOIN (
        SELECT
          co.degree_type,
          COUNT(DISTINCT co.college_id) as college_count
        FROM courses co
        INNER JOIN colleges c ON co.college_id = c.college_id
        WHERE co.status = 'active'
          AND co.deleted_at IS NULL
          AND c.status = 'active'
          AND c.deleted_at IS NULL
        GROUP BY co.degree_type
      ) counts ON qt.degree_type = counts.degree_type
      ORDER BY qt.display_order ASC
    `;

    const result = await client.query(query);

    res.json({
      success: true,
      data: result.rows,
    });
  } catch (error) {
    console.error('Error fetching quick tabs:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch quick tabs',
      error: error.message,
    });
  } finally {
    client.release();
  }
};

/**
 * @route GET /api/v1/admin/quick-tabs/available
 * @desc Get all available degree types that can be added to quick tabs
 * @access Admin
 */
exports.getAvailableDegreeTypes = async (req, res) => {
  const client = await pool.connect();

  try {
    const query = `
      SELECT
        co.degree_type,
        COUNT(DISTINCT co.college_id) as college_count
      FROM courses co
      INNER JOIN colleges c ON co.college_id = c.college_id
      WHERE co.status = 'active'
        AND co.deleted_at IS NULL
        AND c.status = 'active'
        AND c.deleted_at IS NULL
        AND co.degree_type IS NOT NULL
        AND co.degree_type != ''
        AND co.degree_type NOT IN (SELECT degree_type FROM quick_tabs)
      GROUP BY co.degree_type
      ORDER BY college_count DESC
    `;

    const result = await client.query(query);

    res.json({
      success: true,
      data: result.rows,
    });
  } catch (error) {
    console.error('Error fetching available degree types:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch available degree types',
      error: error.message,
    });
  } finally {
    client.release();
  }
};

/**
 * @route POST /api/v1/admin/quick-tabs
 * @desc Add a new quick tab
 * @access Admin
 */
exports.createQuickTab = async (req, res) => {
  const client = await pool.connect();

  try {
    const { degree_type, display_name, is_active = true } = req.body;

    if (!degree_type) {
      return res.status(400).json({
        success: false,
        message: 'Degree type is required',
      });
    }

    // Generate slug from degree type
    const slug = `/${degree_type.toLowerCase().replace(/\./g, '').replace(/\s+/g, '-')}-colleges`;

    // Get the next display order
    const orderResult = await client.query('SELECT COALESCE(MAX(display_order), 0) + 1 as next_order FROM quick_tabs');
    const nextOrder = orderResult.rows[0].next_order;

    const query = `
      INSERT INTO quick_tabs (degree_type, display_name, slug, display_order, is_active)
      VALUES ($1, $2, $3, $4, $5)
      RETURNING *
    `;

    const result = await client.query(query, [
      degree_type,
      display_name || degree_type,
      slug,
      nextOrder,
      is_active,
    ]);

    res.status(201).json({
      success: true,
      message: 'Quick tab created successfully',
      data: result.rows[0],
    });
  } catch (error) {
    if (error.code === '23505') {
      return res.status(400).json({
        success: false,
        message: 'This degree type already exists in quick tabs',
      });
    }
    console.error('Error creating quick tab:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to create quick tab',
      error: error.message,
    });
  } finally {
    client.release();
  }
};

/**
 * @route PUT /api/v1/admin/quick-tabs/:id
 * @desc Update a quick tab
 * @access Admin
 */
exports.updateQuickTab = async (req, res) => {
  const client = await pool.connect();

  try {
    const { id } = req.params;
    const { display_name, is_active } = req.body;

    const query = `
      UPDATE quick_tabs
      SET
        display_name = COALESCE($1, display_name),
        is_active = COALESCE($2, is_active),
        updated_at = CURRENT_TIMESTAMP
      WHERE id = $3
      RETURNING *
    `;

    const result = await client.query(query, [display_name, is_active, id]);

    if (result.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Quick tab not found',
      });
    }

    res.json({
      success: true,
      message: 'Quick tab updated successfully',
      data: result.rows[0],
    });
  } catch (error) {
    console.error('Error updating quick tab:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to update quick tab',
      error: error.message,
    });
  } finally {
    client.release();
  }
};

/**
 * @route PUT /api/v1/admin/quick-tabs/reorder
 * @desc Reorder quick tabs
 * @access Admin
 */
exports.reorderQuickTabs = async (req, res) => {
  const client = await pool.connect();

  try {
    const { order } = req.body; // Array of { id, display_order }

    if (!Array.isArray(order)) {
      return res.status(400).json({
        success: false,
        message: 'Order must be an array',
      });
    }

    await client.query('BEGIN');

    for (const item of order) {
      await client.query(
        'UPDATE quick_tabs SET display_order = $1, updated_at = CURRENT_TIMESTAMP WHERE id = $2',
        [item.display_order, item.id]
      );
    }

    await client.query('COMMIT');

    // Fetch updated list
    const result = await client.query('SELECT * FROM quick_tabs ORDER BY display_order ASC');

    res.json({
      success: true,
      message: 'Quick tabs reordered successfully',
      data: result.rows,
    });
  } catch (error) {
    await client.query('ROLLBACK');
    console.error('Error reordering quick tabs:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to reorder quick tabs',
      error: error.message,
    });
  } finally {
    client.release();
  }
};

/**
 * @route DELETE /api/v1/admin/quick-tabs/:id
 * @desc Delete a quick tab
 * @access Admin
 */
exports.deleteQuickTab = async (req, res) => {
  const client = await pool.connect();

  try {
    const { id } = req.params;

    const result = await client.query(
      'DELETE FROM quick_tabs WHERE id = $1 RETURNING *',
      [id]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Quick tab not found',
      });
    }

    res.json({
      success: true,
      message: 'Quick tab deleted successfully',
      data: result.rows[0],
    });
  } catch (error) {
    console.error('Error deleting quick tab:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to delete quick tab',
      error: error.message,
    });
  } finally {
    client.release();
  }
};

/**
 * @route PUT /api/v1/admin/quick-tabs/:id/toggle
 * @desc Toggle quick tab active status
 * @access Admin
 */
exports.toggleQuickTab = async (req, res) => {
  const client = await pool.connect();

  try {
    const { id } = req.params;

    const result = await client.query(
      `UPDATE quick_tabs
       SET is_active = NOT is_active, updated_at = CURRENT_TIMESTAMP
       WHERE id = $1
       RETURNING *`,
      [id]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Quick tab not found',
      });
    }

    res.json({
      success: true,
      message: `Quick tab ${result.rows[0].is_active ? 'activated' : 'deactivated'} successfully`,
      data: result.rows[0],
    });
  } catch (error) {
    console.error('Error toggling quick tab:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to toggle quick tab',
      error: error.message,
    });
  } finally {
    client.release();
  }
};
