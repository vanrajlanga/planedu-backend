const { pool } = require('../../config/database');

/**
 * @route GET /api/colleges
 * @desc Get public list of colleges with advanced filters
 * @access Public
 */
exports.getColleges = async (req, res) => {
  const client = await pool.connect();

  try {
    const {
      page = 1,
      limit = 12,
      search = '',
      state = '',
      city = '',
      college_type = '',
      ownership = '',
      min_rating = 0,
      max_rating = 5,
      is_featured = '',
      is_verified = '',
      sort_by = 'created_at',
      sort_order = 'DESC'
    } = req.query;

    const offset = (parseInt(page) - 1) * parseInt(limit);

    // Build WHERE clauses
    const conditions = ["c.status = 'active'", "c.deleted_at IS NULL"];
    const params = [];
    let paramCount = 1;

    // Search filter
    if (search) {
      conditions.push(`(
        c.college_name ILIKE $${paramCount} OR
        c.short_name ILIKE $${paramCount} OR
        c.description ILIKE $${paramCount} OR
        c.city ILIKE $${paramCount} OR
        c.state ILIKE $${paramCount}
      )`);
      params.push(`%${search}%`);
      paramCount++;
    }

    // Location filters
    if (state) {
      conditions.push(`c.state = $${paramCount}`);
      params.push(state);
      paramCount++;
    }

    if (city) {
      conditions.push(`c.city = $${paramCount}`);
      params.push(city);
      paramCount++;
    }

    // Type filters
    if (college_type) {
      conditions.push(`c.college_type = $${paramCount}`);
      params.push(college_type);
      paramCount++;
    }

    if (ownership) {
      conditions.push(`c.ownership = $${paramCount}`);
      params.push(ownership);
      paramCount++;
    }

    // Rating filter
    if (min_rating > 0 || max_rating < 5) {
      conditions.push(`c.avg_rating BETWEEN $${paramCount} AND $${paramCount + 1}`);
      params.push(parseFloat(min_rating), parseFloat(max_rating));
      paramCount += 2;
    }

    // Featured/Verified filters
    if (is_featured === 'true') {
      conditions.push(`c.is_featured = true`);
    }

    if (is_verified === 'true') {
      conditions.push(`c.is_verified = true`);
    }

    const whereClause = conditions.length > 0 ? `WHERE ${conditions.join(' AND ')}` : '';

    // Validate sort column to prevent SQL injection
    const allowedSortColumns = [
      'college_name',
      'created_at',
      'avg_rating',
      'total_reviews',
      'view_count'
    ];
    const sortColumn = allowedSortColumns.includes(sort_by) ? sort_by : 'created_at';
    const sortDirection = sort_order.toUpperCase() === 'ASC' ? 'ASC' : 'DESC';

    // Get total count
    const countQuery = `
      SELECT COUNT(*) as total
      FROM colleges c
      ${whereClause}
    `;

    const countResult = await client.query(countQuery, params);
    const total = parseInt(countResult.rows[0].total);

    // Get colleges
    const collegesQuery = `
      SELECT
        c.college_id,
        c.college_name,
        c.short_name,
        c.slug,
        c.established_year,
        c.college_type,
        c.ownership,
        c.state,
        c.city,
        c.pincode,
        c.description,
        c.logo_url,
        c.avg_rating,
        c.total_reviews,
        c.view_count,
        c.is_featured,
        c.is_verified,
        c.created_at
      FROM colleges c
      ${whereClause}
      ORDER BY c.${sortColumn} ${sortDirection}
      LIMIT $${paramCount} OFFSET $${paramCount + 1}
    `;

    params.push(parseInt(limit), offset);

    const collegesResult = await client.query(collegesQuery, params);

    res.json({
      success: true,
      data: collegesResult.rows,
      pagination: {
        current_page: parseInt(page),
        per_page: parseInt(limit),
        total: total,
        total_pages: Math.ceil(total / parseInt(limit))
      },
      filters: {
        search,
        state,
        city,
        college_type,
        ownership,
        min_rating,
        max_rating,
        is_featured,
        is_verified
      }
    });

  } catch (error) {
    console.error('Error fetching colleges:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch colleges',
      error: error.message
    });
  } finally {
    client.release();
  }
};

/**
 * @route GET /api/colleges/:slug
 * @desc Get single college by slug (public profile)
 * @access Public
 */
exports.getCollegeBySlug = async (req, res) => {
  const client = await pool.connect();

  try {
    const { slug } = req.params;

    // Get college details
    const collegeQuery = `
      SELECT
        c.college_id,
        c.college_name,
        c.short_name,
        c.slug,
        c.established_year,
        c.college_type,
        c.ownership,
        c.country,
        c.state,
        c.city,
        c.pincode,
        c.address,
        c.latitude,
        c.longitude,
        c.website_url,
        c.phone,
        c.email,
        c.description,
        c.logo_url,
        c.avg_rating,
        c.total_reviews,
        c.view_count,
        c.is_featured,
        c.is_verified,
        c.created_at,
        c.updated_at
      FROM colleges c
      WHERE c.slug = $1
        AND c.status = 'active'
        AND c.deleted_at IS NULL
    `;

    const collegeResult = await client.query(collegeQuery, [slug]);

    if (collegeResult.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'College not found'
      });
    }

    const college = collegeResult.rows[0];

    // Increment view count (async, don't wait)
    pool.query(
      'UPDATE colleges SET view_count = view_count + 1 WHERE college_id = $1',
      [college.college_id]
    ).catch(err => console.error('Error incrementing view count:', err));

    // Get courses offered by this college (if courses table has college_id)
    // This is a placeholder - adjust based on your schema
    const coursesQuery = `
      SELECT
        course_id,
        course_name,
        stream,
        level,
        duration,
        eligibility
      FROM courses
      WHERE college_id = $1
        AND status = 'active'
        AND deleted_at IS NULL
      LIMIT 10
    `;

    let courses = [];
    try {
      const coursesResult = await client.query(coursesQuery, [college.college_id]);
      courses = coursesResult.rows;
    } catch (err) {
      // Courses table might not have college_id yet
      console.log('Could not fetch courses:', err.message);
    }

    // Get recent reviews (top 5)
    const reviewsQuery = `
      SELECT
        r.review_id,
        r.rating,
        r.review_text,
        r.pros,
        r.cons,
        r.created_at,
        u.full_name as reviewer_name,
        up.course as reviewer_course,
        up.batch_year as reviewer_batch
      FROM reviews r
      LEFT JOIN users u ON r.user_id = u.user_id
      LEFT JOIN user_profiles up ON r.user_id = up.user_id
      WHERE r.college_id = $1
        AND r.status = 'approved'
        AND r.deleted_at IS NULL
      ORDER BY r.created_at DESC
      LIMIT 5
    `;

    let reviews = [];
    try {
      const reviewsResult = await client.query(reviewsQuery, [college.college_id]);
      reviews = reviewsResult.rows;
    } catch (err) {
      console.log('Could not fetch reviews:', err.message);
    }

    res.json({
      success: true,
      data: {
        ...college,
        courses,
        recent_reviews: reviews
      }
    });

  } catch (error) {
    console.error('Error fetching college:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch college',
      error: error.message
    });
  } finally {
    client.release();
  }
};

/**
 * @route GET /api/colleges/filter-options
 * @desc Get available filter options for public college search
 * @access Public
 */
exports.getFilterOptions = async (req, res) => {
  const client = await pool.connect();

  try {
    // Get unique states
    const statesQuery = `
      SELECT DISTINCT state
      FROM colleges
      WHERE status = 'active'
        AND deleted_at IS NULL
        AND state IS NOT NULL
        AND state != ''
      ORDER BY state ASC
    `;

    // Get unique college types
    const typesQuery = `
      SELECT DISTINCT college_type
      FROM colleges
      WHERE status = 'active'
        AND deleted_at IS NULL
        AND college_type IS NOT NULL
      ORDER BY college_type ASC
    `;

    // Get unique ownership types
    const ownershipQuery = `
      SELECT DISTINCT ownership
      FROM colleges
      WHERE status = 'active'
        AND deleted_at IS NULL
        AND ownership IS NOT NULL
      ORDER BY ownership ASC
    `;

    const [statesResult, typesResult, ownershipResult] = await Promise.all([
      client.query(statesQuery),
      client.query(typesQuery),
      client.query(ownershipQuery)
    ]);

    res.json({
      success: true,
      data: {
        states: statesResult.rows.map(row => row.state),
        college_types: typesResult.rows.map(row => row.college_type),
        ownership_types: ownershipResult.rows.map(row => row.ownership)
      }
    });

  } catch (error) {
    console.error('Error fetching filter options:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch filter options',
      error: error.message
    });
  } finally {
    client.release();
  }
};
