const { query } = require('../../config/database');
const ApiResponse = require('../../utils/response');

/**
 * Get dashboard statistics
 * GET /api/v1/admin/dashboard/stats
 */
const getDashboardStats = async (req, res, next) => {
  try {
    // Get total counts
    const [usersCount, collegesCount, reviewsCount, coursesCount] = await Promise.all([
      query('SELECT COUNT(*) as count FROM users WHERE status = $1', ['active']),
      query('SELECT COUNT(*) as count FROM colleges WHERE status = $1', ['active']),
      query('SELECT COUNT(*) as count FROM reviews'),
      query('SELECT COUNT(*) as count FROM courses'),
    ]);

    // Get new registrations breakdown
    const [todayUsers, weekUsers, monthUsers] = await Promise.all([
      query(`SELECT COUNT(*) as count FROM users
             WHERE DATE(created_at) = CURRENT_DATE
             AND status = $1`, ['active']),
      query(`SELECT COUNT(*) as count FROM users
             WHERE created_at >= CURRENT_DATE - INTERVAL '7 days'
             AND status = $1`, ['active']),
      query(`SELECT COUNT(*) as count FROM users
             WHERE created_at >= CURRENT_DATE - INTERVAL '30 days'
             AND status = $1`, ['active']),
    ]);

    // Get active admin sessions count
    const activeSessions = await query(
      `SELECT COUNT(*) as count FROM admin_sessions
       WHERE expires_at > NOW()
       AND is_active = true`
    );

    // Get recent user registrations (last 10)
    const recentUsers = await query(
      `SELECT u.user_id, up.first_name, up.last_name, u.email, u.phone,
              u.user_type, u.created_at
       FROM users u
       LEFT JOIN user_profiles up ON u.user_id = up.user_id
       WHERE u.status = $1
       ORDER BY u.created_at DESC
       LIMIT 10`,
      ['active']
    );

    // Get top colleges by review count
    const topColleges = await query(
      `SELECT c.college_id, c.college_name, c.city, c.state,
              COUNT(r.review_id) as review_count,
              AVG(r.overall_rating) as avg_rating
       FROM colleges c
       LEFT JOIN reviews r ON c.college_id = r.college_id
       WHERE c.status = $1
       GROUP BY c.college_id, c.college_name, c.city, c.state
       ORDER BY review_count DESC
       LIMIT 5`,
      ['active']
    );

    // Get recent reviews (last 10)
    const recentReviews = await query(
      `SELECT r.review_id, r.overall_rating, r.review_text, r.created_at,
              c.college_name,
              up.first_name, up.last_name
       FROM reviews r
       JOIN colleges c ON r.college_id = c.college_id
       JOIN users u ON r.user_id = u.user_id
       LEFT JOIN user_profiles up ON u.user_id = up.user_id
       ORDER BY r.created_at DESC
       LIMIT 10`
    );

    // Build response
    const stats = {
      totals: {
        users: parseInt(usersCount.rows[0].count),
        colleges: parseInt(collegesCount.rows[0].count),
        reviews: parseInt(reviewsCount.rows[0].count),
        courses: parseInt(coursesCount.rows[0].count),
      },
      newRegistrations: {
        today: parseInt(todayUsers.rows[0].count),
        thisWeek: parseInt(weekUsers.rows[0].count),
        thisMonth: parseInt(monthUsers.rows[0].count),
      },
      activeSessions: parseInt(activeSessions.rows[0].count),
      recentUsers: recentUsers.rows,
      topColleges: topColleges.rows.map(college => ({
        ...college,
        review_count: parseInt(college.review_count),
        avg_rating: college.avg_rating ? parseFloat(college.avg_rating).toFixed(2) : null,
      })),
      recentReviews: recentReviews.rows,
    };

    return ApiResponse.success(res, stats, 'Dashboard statistics retrieved successfully');
  } catch (error) {
    console.error('Get dashboard stats error:', error);
    next(error);
  }
};

/**
 * Get recent activity feed
 * GET /api/v1/admin/dashboard/recent-activity
 */
const getRecentActivity = async (req, res, next) => {
  try {
    const limit = parseInt(req.query.limit) || 20;

    // Get recent activities from audit logs
    const activities = await query(
      `SELECT al.log_id, al.action, al.resource_type, al.resource_id,
              al.details, al.ip_address, al.created_at,
              au.email as admin_email, au.full_name as admin_name
       FROM admin_audit_logs al
       JOIN admin_users au ON al.admin_id = au.admin_id
       ORDER BY al.created_at DESC
       LIMIT $1`,
      [limit]
    );

    return ApiResponse.success(res, activities.rows, 'Recent activity retrieved successfully');
  } catch (error) {
    console.error('Get recent activity error:', error);
    next(error);
  }
};

/**
 * Get analytics data for charts
 * GET /api/v1/admin/dashboard/analytics
 */
const getAnalytics = async (req, res, next) => {
  try {
    const days = parseInt(req.query.days) || 30;

    // User growth over time
    const userGrowth = await query(
      `SELECT DATE(created_at) as date, COUNT(*) as count
       FROM users
       WHERE created_at >= CURRENT_DATE - INTERVAL '${days} days'
       AND status = $1
       GROUP BY DATE(created_at)
       ORDER BY date ASC`,
      ['active']
    );

    // College growth over time
    const collegeGrowth = await query(
      `SELECT DATE(created_at) as date, COUNT(*) as count
       FROM colleges
       WHERE created_at >= CURRENT_DATE - INTERVAL '${days} days'
       AND status = $1
       GROUP BY DATE(created_at)
       ORDER BY date ASC`,
      ['active']
    );

    // Reviews over time
    const reviewsOverTime = await query(
      `SELECT DATE(created_at) as date, COUNT(*) as count,
              AVG(overall_rating) as avg_rating
       FROM reviews
       WHERE created_at >= CURRENT_DATE - INTERVAL '${days} days'
       GROUP BY DATE(created_at)
       ORDER BY date ASC`
    );

    // Reviews distribution by rating
    const reviewsDistribution = await query(
      `SELECT overall_rating, COUNT(*) as count
       FROM reviews
       GROUP BY overall_rating
       ORDER BY overall_rating DESC`
    );

    // Top courses by user interest
    const topCourses = await query(
      `SELECT up.target_course as course, COUNT(*) as count
       FROM user_profiles up
       JOIN users u ON up.user_id = u.user_id
       WHERE up.target_course IS NOT NULL
       AND u.status = $1
       GROUP BY up.target_course
       ORDER BY count DESC
       LIMIT 10`,
      ['active']
    );

    // Cities with most users
    const topCities = await query(
      `SELECT up.city, COUNT(*) as count
       FROM user_profiles up
       JOIN users u ON up.user_id = u.user_id
       WHERE up.city IS NOT NULL
       AND u.status = $1
       GROUP BY up.city
       ORDER BY count DESC
       LIMIT 10`,
      ['active']
    );

    const analytics = {
      userGrowth: userGrowth.rows.map(row => ({
        date: row.date,
        count: parseInt(row.count),
      })),
      collegeGrowth: collegeGrowth.rows.map(row => ({
        date: row.date,
        count: parseInt(row.count),
      })),
      reviewsOverTime: reviewsOverTime.rows.map(row => ({
        date: row.date,
        count: parseInt(row.count),
        avgRating: row.avg_rating ? parseFloat(row.avg_rating).toFixed(2) : null,
      })),
      reviewsDistribution: reviewsDistribution.rows.map(row => ({
        rating: parseFloat(row.overall_rating),
        count: parseInt(row.count),
      })),
      topCourses: topCourses.rows.map(row => ({
        course: row.course,
        count: parseInt(row.count),
      })),
      topCities: topCities.rows.map(row => ({
        city: row.city,
        count: parseInt(row.count),
      })),
    };

    return ApiResponse.success(res, analytics, 'Analytics data retrieved successfully');
  } catch (error) {
    console.error('Get analytics error:', error);
    next(error);
  }
};

module.exports = {
  getDashboardStats,
  getRecentActivity,
  getAnalytics,
};
