const { query } = require('../config/database');
const ApiResponse = require('../utils/response');

/**
 * Get User Dashboard Stats
 * GET /api/v1/user/stats
 */
const getStats = async (req, res, next) => {
  try {
    const userId = req.user.user_id;

    // Get application count
    const applicationsResult = await query(
      `SELECT COUNT(*) as count FROM discovery.applications WHERE user_id = $1`,
      [userId]
    );

    // Get saved colleges count
    const savedResult = await query(
      `SELECT COUNT(*) as count FROM discovery.user_favorites WHERE user_id = $1 AND entity_type = 'college'`,
      [userId]
    );

    // Get reviews count
    const reviewsResult = await query(
      `SELECT COUNT(*) as count FROM reviews WHERE user_id = $1 AND deleted_at IS NULL`,
      [userId]
    );

    return ApiResponse.success(res, {
      applications: parseInt(applicationsResult.rows[0]?.count || 0),
      savedColleges: parseInt(savedResult.rows[0]?.count || 0),
      reviews: parseInt(reviewsResult.rows[0]?.count || 0),
    });

  } catch (error) {
    console.error('Get user stats error:', error);
    next(error);
  }
};

/**
 * Get User Applications
 * GET /api/v1/user/applications
 */
const getApplications = async (req, res, next) => {
  try {
    const userId = req.user.user_id;

    const result = await query(
      `SELECT
        a.id,
        a.status,
        a.academic_year,
        a.submitted_at,
        a.created_at,
        ic.id as institution_course_id,
        c.course_name,
        c.degree_type,
        col.college_id,
        col.name as college_name,
        col.slug as college_slug,
        col.logo_url as college_logo,
        col.city,
        col.state
       FROM discovery.applications a
       LEFT JOIN discovery.institution_courses ic ON a.institution_course_id = ic.id
       LEFT JOIN courses c ON ic.course_id = c.course_id
       LEFT JOIN colleges col ON ic.institution_id = col.college_id
       WHERE a.user_id = $1
       ORDER BY a.created_at DESC`,
      [userId]
    );

    return ApiResponse.success(res, result.rows);

  } catch (error) {
    console.error('Get user applications error:', error);
    next(error);
  }
};

/**
 * Get User Favorites
 * GET /api/v1/user/favorites?type=college
 */
const getFavorites = async (req, res, next) => {
  try {
    const userId = req.user.user_id;
    const { type = 'college' } = req.query;

    if (type === 'college') {
      const result = await query(
        `SELECT
          c.college_id,
          c.name,
          c.slug,
          c.logo_url,
          c.banner_image,
          c.city,
          c.state,
          c.type,
          c.rating,
          uf.created_at as saved_at
         FROM discovery.user_favorites uf
         JOIN colleges c ON uf.entity_id = c.college_id
         WHERE uf.user_id = $1 AND uf.entity_type = 'college'
         ORDER BY uf.created_at DESC`,
        [userId]
      );

      return ApiResponse.success(res, result.rows);
    }

    return ApiResponse.success(res, []);

  } catch (error) {
    console.error('Get user favorites error:', error);
    next(error);
  }
};

/**
 * Add Favorite
 * POST /api/v1/user/favorites
 */
const addFavorite = async (req, res, next) => {
  try {
    const userId = req.user.user_id;
    const { entity_type, entity_id } = req.body;

    if (!entity_type || !entity_id) {
      return ApiResponse.error(res, 'entity_type and entity_id are required', 400);
    }

    // Check if already favorited
    const existing = await query(
      `SELECT * FROM discovery.user_favorites WHERE user_id = $1 AND entity_type = $2 AND entity_id = $3`,
      [userId, entity_type, entity_id]
    );

    if (existing.rows.length > 0) {
      return ApiResponse.error(res, 'Already added to favorites', 400);
    }

    await query(
      `INSERT INTO discovery.user_favorites (user_id, entity_type, entity_id, created_at)
       VALUES ($1, $2, $3, NOW())`,
      [userId, entity_type, entity_id]
    );

    return ApiResponse.success(res, { added: true }, 'Added to favorites');

  } catch (error) {
    console.error('Add favorite error:', error);
    next(error);
  }
};

/**
 * Remove Favorite
 * DELETE /api/v1/user/favorites
 */
const removeFavorite = async (req, res, next) => {
  try {
    const userId = req.user.user_id;
    const { entity_type, entity_id } = req.body;

    if (!entity_type || !entity_id) {
      return ApiResponse.error(res, 'entity_type and entity_id are required', 400);
    }

    await query(
      `DELETE FROM discovery.user_favorites WHERE user_id = $1 AND entity_type = $2 AND entity_id = $3`,
      [userId, entity_type, entity_id]
    );

    return ApiResponse.success(res, { removed: true }, 'Removed from favorites');

  } catch (error) {
    console.error('Remove favorite error:', error);
    next(error);
  }
};

/**
 * Get User Reviews
 * GET /api/v1/user/reviews
 */
const getReviews = async (req, res, next) => {
  try {
    const userId = req.user.user_id;

    const result = await query(
      `SELECT
        r.review_id,
        r.overall_rating,
        r.academic_rating,
        r.infrastructure_rating,
        r.faculty_rating,
        r.placement_rating,
        r.review_title,
        r.review_text,
        r.pros,
        r.cons,
        r.status,
        r.helpful_count,
        r.admin_reply,
        r.replied_at,
        r.created_at,
        c.college_id,
        c.name as college_name,
        c.slug as college_slug,
        c.logo_url as college_logo
       FROM reviews r
       JOIN colleges c ON r.college_id = c.college_id
       WHERE r.user_id = $1 AND r.deleted_at IS NULL
       ORDER BY r.created_at DESC`,
      [userId]
    );

    return ApiResponse.success(res, result.rows);

  } catch (error) {
    console.error('Get user reviews error:', error);
    next(error);
  }
};

/**
 * Create Application
 * POST /api/v1/user/applications
 */
const createApplication = async (req, res, next) => {
  try {
    const userId = req.user.user_id;
    const { college_id, course_id, academic_year } = req.body;

    if (!college_id) {
      return ApiResponse.error(res, 'college_id is required', 400);
    }

    // Find institution_course_id if course_id provided, otherwise use first available
    let institutionCourseId = null;

    if (course_id) {
      const courseResult = await query(
        `SELECT id FROM discovery.institution_courses WHERE institution_id = $1 AND course_id = $2 LIMIT 1`,
        [college_id, course_id]
      );
      institutionCourseId = courseResult.rows[0]?.id;
    } else {
      const courseResult = await query(
        `SELECT id FROM discovery.institution_courses WHERE institution_id = $1 LIMIT 1`,
        [college_id]
      );
      institutionCourseId = courseResult.rows[0]?.id;
    }

    // Check for existing application
    const existing = await query(
      `SELECT id FROM discovery.applications
       WHERE user_id = $1 AND institution_course_id = $2`,
      [userId, institutionCourseId]
    );

    if (existing.rows.length > 0) {
      return ApiResponse.error(res, 'You have already applied to this course', 400);
    }

    // Create application
    const result = await query(
      `INSERT INTO discovery.applications (user_id, institution_course_id, academic_year, status, submitted_at, created_at, updated_at)
       VALUES ($1, $2, $3, 'submitted', NOW(), NOW(), NOW())
       RETURNING id`,
      [userId, institutionCourseId, academic_year || new Date().getFullYear().toString()]
    );

    return ApiResponse.success(
      res,
      { application_id: result.rows[0].id },
      'Application submitted successfully',
      201
    );

  } catch (error) {
    console.error('Create application error:', error);
    next(error);
  }
};

module.exports = {
  getStats,
  getApplications,
  getFavorites,
  addFavorite,
  removeFavorite,
  getReviews,
  createApplication,
};
