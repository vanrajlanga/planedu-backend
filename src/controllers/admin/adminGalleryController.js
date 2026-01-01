const { pool } = require('../../config/database');

const VALID_CATEGORIES = ['campus', 'hostel', 'facilities', 'events', 'library', 'labs', 'sports'];

/**
 * Get all gallery images for a college
 */
exports.getGallery = async (req, res) => {
  const client = await pool.connect();

  try {
    const { collegeId } = req.params;
    const { category } = req.query;

    let query = `
      SELECT *
      FROM college_gallery
      WHERE college_id = $1
    `;
    const params = [collegeId];

    if (category) {
      query += ` AND category = $2`;
      params.push(category);
    }

    query += ` ORDER BY category, display_order ASC, created_at DESC`;

    const result = await client.query(query, params);

    // Get category counts
    const categoryQuery = `
      SELECT category, COUNT(*) as count
      FROM college_gallery
      WHERE college_id = $1
      GROUP BY category
      ORDER BY category
    `;
    const categoryResult = await client.query(categoryQuery, [collegeId]);

    res.json({
      success: true,
      data: {
        images: result.rows,
        categories: categoryResult.rows,
        total: result.rows.length
      }
    });

  } catch (error) {
    console.error('Get gallery error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch gallery',
      error: error.message
    });
  } finally {
    client.release();
  }
};

/**
 * Get a single gallery image by ID
 */
exports.getGalleryImage = async (req, res) => {
  const client = await pool.connect();

  try {
    const { id } = req.params;

    const query = `
      SELECT *
      FROM college_gallery
      WHERE id = $1
    `;

    const result = await client.query(query, [id]);

    if (result.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Image not found'
      });
    }

    res.json({
      success: true,
      data: result.rows[0]
    });

  } catch (error) {
    console.error('Get gallery image error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch image',
      error: error.message
    });
  } finally {
    client.release();
  }
};

/**
 * Add a new gallery image
 */
exports.createGalleryImage = async (req, res) => {
  const client = await pool.connect();

  try {
    const { collegeId } = req.params;
    const {
      image_url,
      category,
      caption,
      display_order = 0
    } = req.body;

    // Validate required fields
    if (!image_url || !category) {
      return res.status(400).json({
        success: false,
        message: 'Image URL and category are required'
      });
    }

    if (!VALID_CATEGORIES.includes(category)) {
      return res.status(400).json({
        success: false,
        message: `Invalid category. Valid options: ${VALID_CATEGORIES.join(', ')}`
      });
    }

    // Check if college exists
    const collegeCheck = await client.query(
      'SELECT college_id FROM colleges WHERE college_id = $1 AND deleted_at IS NULL',
      [collegeId]
    );

    if (collegeCheck.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'College not found'
      });
    }

    const query = `
      INSERT INTO college_gallery (
        college_id, image_url, category, caption, display_order
      )
      VALUES ($1, $2, $3, $4, $5)
      RETURNING *
    `;

    const values = [
      collegeId,
      image_url,
      category,
      caption || null,
      display_order
    ];

    const result = await client.query(query, values);

    res.status(201).json({
      success: true,
      message: 'Image added to gallery successfully',
      data: result.rows[0]
    });

  } catch (error) {
    console.error('Create gallery image error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to add image',
      error: error.message
    });
  } finally {
    client.release();
  }
};

/**
 * Update a gallery image
 */
exports.updateGalleryImage = async (req, res) => {
  const client = await pool.connect();

  try {
    const { id } = req.params;
    const updates = req.body;

    // Check if image exists
    const imageCheck = await client.query(
      'SELECT id FROM college_gallery WHERE id = $1',
      [id]
    );

    if (imageCheck.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Image not found'
      });
    }

    // Validate category if being updated
    if (updates.category && !VALID_CATEGORIES.includes(updates.category)) {
      return res.status(400).json({
        success: false,
        message: `Invalid category. Valid options: ${VALID_CATEGORIES.join(', ')}`
      });
    }

    // Build dynamic update query
    const allowedFields = ['image_url', 'category', 'caption', 'display_order'];

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
      UPDATE college_gallery
      SET ${updateFields.join(', ')}
      WHERE id = $${paramCounter}
      RETURNING *
    `;

    const result = await client.query(query, values);

    res.json({
      success: true,
      message: 'Image updated successfully',
      data: result.rows[0]
    });

  } catch (error) {
    console.error('Update gallery image error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to update image',
      error: error.message
    });
  } finally {
    client.release();
  }
};

/**
 * Delete a gallery image
 */
exports.deleteGalleryImage = async (req, res) => {
  const client = await pool.connect();

  try {
    const { id } = req.params;

    const query = `
      DELETE FROM college_gallery
      WHERE id = $1
      RETURNING id
    `;

    const result = await client.query(query, [id]);

    if (result.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Image not found'
      });
    }

    res.json({
      success: true,
      message: 'Image deleted successfully'
    });

  } catch (error) {
    console.error('Delete gallery image error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to delete image',
      error: error.message
    });
  } finally {
    client.release();
  }
};

/**
 * Reorder gallery images
 */
exports.reorderGallery = async (req, res) => {
  const client = await pool.connect();

  try {
    const { collegeId } = req.params;
    const { images } = req.body;

    if (!images || !Array.isArray(images) || images.length === 0) {
      return res.status(400).json({
        success: false,
        message: 'Images array is required'
      });
    }

    await client.query('BEGIN');

    for (let i = 0; i < images.length; i++) {
      await client.query(
        'UPDATE college_gallery SET display_order = $1 WHERE id = $2 AND college_id = $3',
        [i, images[i].id, collegeId]
      );
    }

    await client.query('COMMIT');

    res.json({
      success: true,
      message: 'Gallery reordered successfully'
    });

  } catch (error) {
    await client.query('ROLLBACK');
    console.error('Reorder gallery error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to reorder gallery',
      error: error.message
    });
  } finally {
    client.release();
  }
};

/**
 * Get valid categories
 */
exports.getCategories = async (req, res) => {
  res.json({
    success: true,
    data: VALID_CATEGORIES
  });
};
