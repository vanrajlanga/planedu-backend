const pool = require('../../config/database');

// Get all course types
const getAllCourseTypes = async (req, res) => {
  try {
    const { status, category, level } = req.query;

    let query = `
      SELECT
        course_type_id,
        name,
        slug,
        full_name,
        category,
        level,
        duration_years,
        display_order,
        status,
        created_at,
        updated_at
      FROM course_types_master
      WHERE 1=1
    `;
    const params = [];
    let paramIndex = 1;

    if (status) {
      query += ` AND status = $${paramIndex++}`;
      params.push(status);
    }

    if (category) {
      query += ` AND category = $${paramIndex++}`;
      params.push(category);
    }

    if (level) {
      query += ` AND level = $${paramIndex++}`;
      params.push(level);
    }

    query += ` ORDER BY display_order ASC, name ASC`;

    const result = await pool.query(query, params);

    res.json({
      success: true,
      data: result.rows
    });
  } catch (error) {
    console.error('Error fetching course types:', error);
    res.status(500).json({
      success: false,
      error: { code: 'FETCH_ERROR', message: 'Failed to fetch course types' }
    });
  }
};

// Get single course type by ID
const getCourseTypeById = async (req, res) => {
  try {
    const { id } = req.params;

    const result = await pool.query(
      `SELECT * FROM course_types_master WHERE course_type_id = $1`,
      [id]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({
        success: false,
        error: { code: 'NOT_FOUND', message: 'Course type not found' }
      });
    }

    res.json({
      success: true,
      data: result.rows[0]
    });
  } catch (error) {
    console.error('Error fetching course type:', error);
    res.status(500).json({
      success: false,
      error: { code: 'FETCH_ERROR', message: 'Failed to fetch course type' }
    });
  }
};

// Create new course type
const createCourseType = async (req, res) => {
  try {
    const {
      name,
      slug,
      full_name,
      category,
      level,
      duration_years,
      display_order,
      status = 'active'
    } = req.body;

    // Validate required fields
    if (!name || !slug) {
      return res.status(400).json({
        success: false,
        error: { code: 'VALIDATION_ERROR', message: 'Name and slug are required' }
      });
    }

    // Check for duplicates
    const existing = await pool.query(
      `SELECT course_type_id FROM course_types_master WHERE name = $1 OR slug = $2`,
      [name, slug]
    );

    if (existing.rows.length > 0) {
      return res.status(400).json({
        success: false,
        error: { code: 'DUPLICATE', message: 'Course type with this name or slug already exists' }
      });
    }

    const result = await pool.query(
      `INSERT INTO course_types_master
        (name, slug, full_name, category, level, duration_years, display_order, status)
       VALUES ($1, $2, $3, $4, $5, $6, $7, $8)
       RETURNING *`,
      [name, slug, full_name, category, level, duration_years, display_order || 0, status]
    );

    res.status(201).json({
      success: true,
      data: result.rows[0],
      message: 'Course type created successfully'
    });
  } catch (error) {
    console.error('Error creating course type:', error);
    res.status(500).json({
      success: false,
      error: { code: 'CREATE_ERROR', message: 'Failed to create course type' }
    });
  }
};

// Update course type
const updateCourseType = async (req, res) => {
  try {
    const { id } = req.params;
    const {
      name,
      slug,
      full_name,
      category,
      level,
      duration_years,
      display_order,
      status
    } = req.body;

    // Check if exists
    const existing = await pool.query(
      `SELECT course_type_id FROM course_types_master WHERE course_type_id = $1`,
      [id]
    );

    if (existing.rows.length === 0) {
      return res.status(404).json({
        success: false,
        error: { code: 'NOT_FOUND', message: 'Course type not found' }
      });
    }

    // Check for duplicate name/slug (excluding current record)
    if (name || slug) {
      const duplicate = await pool.query(
        `SELECT course_type_id FROM course_types_master
         WHERE (name = $1 OR slug = $2) AND course_type_id != $3`,
        [name, slug, id]
      );

      if (duplicate.rows.length > 0) {
        return res.status(400).json({
          success: false,
          error: { code: 'DUPLICATE', message: 'Course type with this name or slug already exists' }
        });
      }
    }

    const result = await pool.query(
      `UPDATE course_types_master SET
        name = COALESCE($1, name),
        slug = COALESCE($2, slug),
        full_name = COALESCE($3, full_name),
        category = COALESCE($4, category),
        level = COALESCE($5, level),
        duration_years = COALESCE($6, duration_years),
        display_order = COALESCE($7, display_order),
        status = COALESCE($8, status),
        updated_at = CURRENT_TIMESTAMP
       WHERE course_type_id = $9
       RETURNING *`,
      [name, slug, full_name, category, level, duration_years, display_order, status, id]
    );

    res.json({
      success: true,
      data: result.rows[0],
      message: 'Course type updated successfully'
    });
  } catch (error) {
    console.error('Error updating course type:', error);
    res.status(500).json({
      success: false,
      error: { code: 'UPDATE_ERROR', message: 'Failed to update course type' }
    });
  }
};

// Delete course type
const deleteCourseType = async (req, res) => {
  try {
    const { id } = req.params;

    // Check if used in courses table
    const inUse = await pool.query(
      `SELECT COUNT(*) as count FROM courses WHERE degree_type = (
        SELECT name FROM course_types_master WHERE course_type_id = $1
      )`,
      [id]
    );

    if (parseInt(inUse.rows[0].count) > 0) {
      return res.status(400).json({
        success: false,
        error: {
          code: 'IN_USE',
          message: `Cannot delete: This course type is used by ${inUse.rows[0].count} courses`
        }
      });
    }

    const result = await pool.query(
      `DELETE FROM course_types_master WHERE course_type_id = $1 RETURNING *`,
      [id]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({
        success: false,
        error: { code: 'NOT_FOUND', message: 'Course type not found' }
      });
    }

    res.json({
      success: true,
      message: 'Course type deleted successfully'
    });
  } catch (error) {
    console.error('Error deleting course type:', error);
    res.status(500).json({
      success: false,
      error: { code: 'DELETE_ERROR', message: 'Failed to delete course type' }
    });
  }
};

// Get all categories from degree_categories table
const getCategories = async (req, res) => {
  try {
    const result = await pool.query(
      `SELECT category_id, name, display_order, status, created_at
       FROM degree_categories
       WHERE status = 'active'
       ORDER BY display_order ASC, name ASC`
    );

    res.json({
      success: true,
      data: result.rows
    });
  } catch (error) {
    console.error('Error fetching categories:', error);
    res.status(500).json({
      success: false,
      error: { code: 'FETCH_ERROR', message: 'Failed to fetch categories' }
    });
  }
};

// Get all categories (including inactive) for admin
const getAllCategories = async (req, res) => {
  try {
    const result = await pool.query(
      `SELECT category_id, name, display_order, status, created_at
       FROM degree_categories
       ORDER BY display_order ASC, name ASC`
    );

    res.json({
      success: true,
      data: result.rows
    });
  } catch (error) {
    console.error('Error fetching categories:', error);
    res.status(500).json({
      success: false,
      error: { code: 'FETCH_ERROR', message: 'Failed to fetch categories' }
    });
  }
};

// Create new category
const createCategory = async (req, res) => {
  try {
    const { name, display_order, status = 'active' } = req.body;

    if (!name) {
      return res.status(400).json({
        success: false,
        error: { code: 'VALIDATION_ERROR', message: 'Category name is required' }
      });
    }

    // Check for duplicates
    const existing = await pool.query(
      `SELECT category_id FROM degree_categories WHERE name = $1`,
      [name]
    );

    if (existing.rows.length > 0) {
      return res.status(400).json({
        success: false,
        error: { code: 'DUPLICATE', message: 'Category with this name already exists' }
      });
    }

    const result = await pool.query(
      `INSERT INTO degree_categories (name, display_order, status)
       VALUES ($1, $2, $3)
       RETURNING *`,
      [name, display_order || 0, status]
    );

    res.status(201).json({
      success: true,
      data: result.rows[0],
      message: 'Category created successfully'
    });
  } catch (error) {
    console.error('Error creating category:', error);
    res.status(500).json({
      success: false,
      error: { code: 'CREATE_ERROR', message: 'Failed to create category' }
    });
  }
};

// Update category
const updateCategory = async (req, res) => {
  try {
    const { id } = req.params;
    const { name, display_order, status } = req.body;

    // Check if exists
    const existing = await pool.query(
      `SELECT category_id FROM degree_categories WHERE category_id = $1`,
      [id]
    );

    if (existing.rows.length === 0) {
      return res.status(404).json({
        success: false,
        error: { code: 'NOT_FOUND', message: 'Category not found' }
      });
    }

    // Check for duplicate name (excluding current record)
    if (name) {
      const duplicate = await pool.query(
        `SELECT category_id FROM degree_categories WHERE name = $1 AND category_id != $2`,
        [name, id]
      );

      if (duplicate.rows.length > 0) {
        return res.status(400).json({
          success: false,
          error: { code: 'DUPLICATE', message: 'Category with this name already exists' }
        });
      }
    }

    const result = await pool.query(
      `UPDATE degree_categories SET
        name = COALESCE($1, name),
        display_order = COALESCE($2, display_order),
        status = COALESCE($3, status)
       WHERE category_id = $4
       RETURNING *`,
      [name, display_order, status, id]
    );

    res.json({
      success: true,
      data: result.rows[0],
      message: 'Category updated successfully'
    });
  } catch (error) {
    console.error('Error updating category:', error);
    res.status(500).json({
      success: false,
      error: { code: 'UPDATE_ERROR', message: 'Failed to update category' }
    });
  }
};

// Delete category
const deleteCategory = async (req, res) => {
  try {
    const { id } = req.params;

    // Check if used in course_types_master
    const inUse = await pool.query(
      `SELECT COUNT(*) as count FROM course_types_master WHERE category = (
        SELECT name FROM degree_categories WHERE category_id = $1
      )`,
      [id]
    );

    if (parseInt(inUse.rows[0].count) > 0) {
      return res.status(400).json({
        success: false,
        error: {
          code: 'IN_USE',
          message: `Cannot delete: This category is used by ${inUse.rows[0].count} degree types`
        }
      });
    }

    const result = await pool.query(
      `DELETE FROM degree_categories WHERE category_id = $1 RETURNING *`,
      [id]
    );

    if (result.rows.length === 0) {
      return res.status(404).json({
        success: false,
        error: { code: 'NOT_FOUND', message: 'Category not found' }
      });
    }

    res.json({
      success: true,
      message: 'Category deleted successfully'
    });
  } catch (error) {
    console.error('Error deleting category:', error);
    res.status(500).json({
      success: false,
      error: { code: 'DELETE_ERROR', message: 'Failed to delete category' }
    });
  }
};

// Reorder course types
const reorderCourseTypes = async (req, res) => {
  try {
    const { orders } = req.body; // Array of { course_type_id, display_order }

    if (!Array.isArray(orders)) {
      return res.status(400).json({
        success: false,
        error: { code: 'VALIDATION_ERROR', message: 'Orders must be an array' }
      });
    }

    // Update each course type's display order
    for (const order of orders) {
      await pool.query(
        `UPDATE course_types_master SET display_order = $1, updated_at = CURRENT_TIMESTAMP
         WHERE course_type_id = $2`,
        [order.display_order, order.course_type_id]
      );
    }

    res.json({
      success: true,
      message: 'Course types reordered successfully'
    });
  } catch (error) {
    console.error('Error reordering course types:', error);
    res.status(500).json({
      success: false,
      error: { code: 'REORDER_ERROR', message: 'Failed to reorder course types' }
    });
  }
};

module.exports = {
  getAllCourseTypes,
  getCourseTypeById,
  createCourseType,
  updateCourseType,
  deleteCourseType,
  getCategories,
  getAllCategories,
  createCategory,
  updateCategory,
  deleteCategory,
  reorderCourseTypes
};
