const { query, getClient } = require('../../config/database');
const ApiResponse = require('../../utils/response');

/**
 * Get all settings grouped by category
 * GET /api/v1/admin/settings
 */
const getAllSettings = async (req, res, next) => {
  try {
    const category = req.query.category || '';

    let whereClause = '';
    const params = [];

    if (category) {
      whereClause = 'WHERE category = $1';
      params.push(category);
    }

    const settingsQuery = `
      SELECT * FROM system_settings
      ${whereClause}
      ORDER BY category, setting_key
    `;

    const result = await query(settingsQuery, params);

    // Group settings by category
    const groupedSettings = result.rows.reduce((acc, setting) => {
      const cat = setting.category || 'other';
      if (!acc[cat]) {
        acc[cat] = [];
      }
      acc[cat].push(setting);
      return acc;
    }, {});

    return ApiResponse.success(res, {
      settings: result.rows,
      grouped: groupedSettings
    }, 'Settings retrieved successfully');
  } catch (error) {
    console.error('Get settings error:', error);
    next(error);
  }
};

/**
 * Get single setting by key
 * GET /api/v1/admin/settings/:key
 */
const getSettingByKey = async (req, res, next) => {
  try {
    const { key } = req.params;

    const result = await query(
      'SELECT * FROM system_settings WHERE setting_key = $1',
      [key]
    );

    if (result.rows.length === 0) {
      return ApiResponse.error(res, 'Setting not found', 404);
    }

    return ApiResponse.success(res, result.rows[0], 'Setting retrieved successfully');
  } catch (error) {
    console.error('Get setting error:', error);
    next(error);
  }
};

/**
 * Update setting value
 * PUT /api/v1/admin/settings/:key
 */
const updateSetting = async (req, res, next) => {
  try {
    const { key } = req.params;
    const { setting_value } = req.body;

    if (setting_value === undefined) {
      return ApiResponse.error(res, 'Setting value is required', 400);
    }

    // Check if setting exists
    const checkResult = await query(
      'SELECT id FROM system_settings WHERE setting_key = $1',
      [key]
    );

    if (checkResult.rows.length === 0) {
      return ApiResponse.error(res, 'Setting not found', 404);
    }

    const updateQuery = `
      UPDATE system_settings
      SET setting_value = $1, updated_at = CURRENT_TIMESTAMP
      WHERE setting_key = $2
      RETURNING *
    `;

    const result = await query(updateQuery, [setting_value, key]);

    return ApiResponse.success(res, result.rows[0], 'Setting updated successfully');
  } catch (error) {
    console.error('Update setting error:', error);
    next(error);
  }
};

/**
 * Bulk update settings
 * PUT /api/v1/admin/settings/bulk
 */
const bulkUpdateSettings = async (req, res, next) => {
  const client = await getClient();

  try {
    const { settings } = req.body;

    if (!Array.isArray(settings) || settings.length === 0) {
      return ApiResponse.error(res, 'Settings array is required', 400);
    }

    await client.query('BEGIN');

    for (const setting of settings) {
      if (!setting.setting_key || setting.setting_value === undefined) {
        continue;
      }

      await client.query(
        'UPDATE system_settings SET setting_value = $1, updated_at = CURRENT_TIMESTAMP WHERE setting_key = $2',
        [setting.setting_value, setting.setting_key]
      );
    }

    await client.query('COMMIT');

    return ApiResponse.success(res, { updated: settings.length }, 'Settings updated successfully');
  } catch (error) {
    await client.query('ROLLBACK');
    console.error('Bulk update settings error:', error);
    next(error);
  } finally {
    client.release();
  }
};

/**
 * Get public settings (for frontend)
 * GET /api/v1/settings/public
 */
const getPublicSettings = async (req, res, next) => {
  try {
    const result = await query(
      'SELECT setting_key, setting_value, setting_type, category FROM system_settings WHERE is_public = true ORDER BY category, setting_key'
    );

    // Convert to key-value object
    const settingsObj = result.rows.reduce((acc, setting) => {
      acc[setting.setting_key] = setting.setting_value;
      return acc;
    }, {});

    return ApiResponse.success(res, settingsObj, 'Public settings retrieved successfully');
  } catch (error) {
    console.error('Get public settings error:', error);
    next(error);
  }
};

/**
 * Get setting categories
 * GET /api/v1/admin/settings/categories
 */
const getCategories = async (req, res, next) => {
  try {
    const result = await query(
      'SELECT DISTINCT category FROM system_settings WHERE category IS NOT NULL ORDER BY category'
    );

    return ApiResponse.success(res, result.rows.map(r => r.category), 'Categories retrieved successfully');
  } catch (error) {
    console.error('Get categories error:', error);
    next(error);
  }
};

/**
 * Create new setting
 * POST /api/v1/admin/settings
 */
const createSetting = async (req, res, next) => {
  try {
    const {
      setting_key,
      setting_value,
      setting_type,
      category,
      description,
      is_public
    } = req.body;

    if (!setting_key) {
      return ApiResponse.error(res, 'Setting key is required', 400);
    }

    const insertQuery = `
      INSERT INTO system_settings (
        setting_key, setting_value, setting_type, category, description, is_public
      )
      VALUES ($1, $2, $3, $4, $5, $6)
      RETURNING *
    `;

    const result = await query(insertQuery, [
      setting_key,
      setting_value || '',
      setting_type || 'text',
      category || null,
      description || null,
      is_public || false
    ]);

    return ApiResponse.success(res, result.rows[0], 'Setting created successfully', 201);
  } catch (error) {
    if (error.code === '23505') { // Unique violation
      return ApiResponse.error(res, 'Setting key already exists', 400);
    }
    console.error('Create setting error:', error);
    next(error);
  }
};

/**
 * Delete setting
 * DELETE /api/v1/admin/settings/:key
 */
const deleteSetting = async (req, res, next) => {
  try {
    const { key } = req.params;

    const deleteResult = await query(
      'DELETE FROM system_settings WHERE setting_key = $1 RETURNING setting_key',
      [key]
    );

    if (deleteResult.rows.length === 0) {
      return ApiResponse.error(res, 'Setting not found', 404);
    }

    return ApiResponse.success(res, { setting_key: key }, 'Setting deleted successfully');
  } catch (error) {
    console.error('Delete setting error:', error);
    next(error);
  }
};

module.exports = {
  getAllSettings,
  getSettingByKey,
  updateSetting,
  bulkUpdateSettings,
  getPublicSettings,
  getCategories,
  createSetting,
  deleteSetting,
};
