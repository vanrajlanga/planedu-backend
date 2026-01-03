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
 * @route GET /api/colleges/top
 * @desc Get top 10 colleges filtered by course/degree type
 * @access Public
 */
exports.getTopColleges = async (req, res) => {
  const client = await pool.connect();

  try {
    const { course_type = '', limit = 10 } = req.query;

    // Map frontend filter values to degree types
    const degreeTypeMap = {
      'btech': ['B.Tech', 'BE', 'B.E.', 'Bachelor of Technology', 'Bachelor of Engineering'],
      'mba': ['MBA', 'PGDM', 'Master of Business Administration'],
      'mbbs': ['MBBS', 'Bachelor of Medicine'],
      'mtech': ['M.Tech', 'ME', 'M.E.', 'Master of Technology', 'Master of Engineering'],
      'bsc': ['B.Sc', 'BSc', 'Bachelor of Science'],
      'ba': ['BA', 'B.A.', 'Bachelor of Arts'],
      'bcom': ['B.Com', 'BCom', 'Bachelor of Commerce'],
      'bca': ['BCA', 'Bachelor of Computer Applications'],
      'bba': ['BBA', 'BMS', 'Bachelor of Business Administration', 'Bachelor of Management Studies'],
    };

    // Base query to get colleges
    let query;
    let params = [];
    let paramCount = 1;

    if (course_type && degreeTypeMap[course_type]) {
      const degreeTypes = degreeTypeMap[course_type];
      const placeholders = degreeTypes.map((_, i) => `$${paramCount + i}`).join(', ');
      params = [...degreeTypes];
      paramCount += degreeTypes.length;

      query = `
        SELECT DISTINCT ON (c.college_id)
          c.college_id,
          c.college_name,
          c.short_name,
          c.slug,
          c.city,
          c.state,
          c.logo_url,
          c.avg_rating,
          c.total_reviews,
          c.is_featured,
          c.is_verified,
          co.total_fees,
          co.application_end_date
        FROM colleges c
        LEFT JOIN courses co ON c.college_id = co.college_id
          AND co.status = 'active'
          AND co.deleted_at IS NULL
          AND co.degree_type IN (${placeholders})
        WHERE c.status = 'active'
          AND c.deleted_at IS NULL
          AND co.course_id IS NOT NULL
        ORDER BY c.college_id, c.avg_rating DESC
        LIMIT $${paramCount}
      `;
      params.push(parseInt(limit));
    } else {
      query = `
        SELECT DISTINCT ON (c.college_id)
          c.college_id,
          c.college_name,
          c.short_name,
          c.slug,
          c.city,
          c.state,
          c.logo_url,
          c.avg_rating,
          c.total_reviews,
          c.is_featured,
          c.is_verified,
          (
            SELECT co.total_fees
            FROM courses co
            WHERE co.college_id = c.college_id AND co.status = 'active'
            ORDER BY co.total_fees ASC LIMIT 1
          ) as total_fees,
          (
            SELECT co.application_end_date
            FROM courses co
            WHERE co.college_id = c.college_id AND co.status = 'active'
              AND co.application_end_date IS NOT NULL
            ORDER BY
              CASE WHEN co.application_end_date >= CURRENT_DATE THEN 0 ELSE 1 END,
              co.application_end_date ASC
            LIMIT 1
          ) as application_end_date
        FROM colleges c
        WHERE c.status = 'active' AND c.deleted_at IS NULL
        ORDER BY c.college_id, c.avg_rating DESC
        LIMIT $1
      `;
      params = [parseInt(limit)];
    }

    const result = await client.query(query, params);
    const collegeIds = result.rows.map(c => c.college_id);

    // Fetch rankings for all colleges
    let rankingsMap = {};
    if (collegeIds.length > 0) {
      const rankingsQuery = `
        SELECT
          cr.college_id,
          cr.rank_position,
          cr.category,
          ra.agency_code
        FROM college_rankings cr
        JOIN ranking_agencies ra ON cr.agency_id = ra.agency_id
        WHERE cr.college_id = ANY($1)
          AND cr.ranking_year >= EXTRACT(YEAR FROM CURRENT_DATE) - 1
        ORDER BY cr.college_id, cr.ranking_year DESC, cr.rank_position ASC
      `;
      const rankingsResult = await client.query(rankingsQuery, [collegeIds]);

      rankingsResult.rows.forEach(r => {
        if (!rankingsMap[r.college_id]) {
          rankingsMap[r.college_id] = r;
        }
      });
    }

    // Fetch cutoffs for all colleges
    let cutoffsMap = {};
    if (collegeIds.length > 0) {
      const cutoffsQuery = `
        SELECT
          ec.college_id,
          ec.cutoff_value,
          ec.closing_rank,
          ec.cutoff_type,
          ec.category,
          e.exam_name,
          e.short_name as exam_short_name,
          CASE
            WHEN e.exam_name ILIKE '%Advanced%' THEN 'JEE Adv'
            WHEN e.exam_name ILIKE '%Main%' THEN 'JEE Main'
            WHEN e.exam_name ILIKE '%NEET%' THEN 'NEET'
            WHEN e.exam_name ILIKE '%NCHMCT%' OR e.exam_name ILIKE '%Hotel Management%' THEN 'NCHMCT'
            WHEN e.exam_name ILIKE '%CLAT%' OR e.exam_name ILIKE '%Common Law%' THEN 'CLAT'
            WHEN e.exam_name ILIKE '%CUET%' OR e.exam_name ILIKE '%Common University%' THEN 'CUET'
            WHEN e.exam_name ILIKE '%INI-CET%' OR e.exam_name ILIKE '%Institute of National%' THEN 'INI-CET'
            WHEN e.short_name = 'CAT' OR e.exam_name ILIKE '%Common Admission Test%' THEN 'CAT'
            WHEN e.exam_name ILIKE '%GATE%' OR e.exam_name ILIKE '%Graduate Aptitude%' THEN 'GATE'
            WHEN e.exam_name ILIKE '%XAT%' THEN 'XAT'
            WHEN e.exam_name ILIKE '%MAT%' THEN 'MAT'
            ELSE COALESCE(e.short_name, SUBSTRING(e.exam_name FROM 1 FOR 10))
          END as exam_short
        FROM exam_cutoffs ec
        JOIN exams e ON ec.exam_id = e.exam_id
        WHERE ec.college_id = ANY($1)
          AND ec.category = 'General'
        ORDER BY ec.college_id, ec.academic_year DESC
      `;
      const cutoffsResult = await client.query(cutoffsQuery, [collegeIds]);

      cutoffsResult.rows.forEach(c => {
        if (!cutoffsMap[c.college_id]) {
          cutoffsMap[c.college_id] = c;
        }
      });
    }

    // Format the response
    const colleges = result.rows.map((college, index) => {
      const ranking = rankingsMap[college.college_id];
      const cutoff = cutoffsMap[college.college_id];

      // Format cutoff string based on cutoff_type
      let cutoffStr = null;
      if (cutoff) {
        if (cutoff.cutoff_type === 'Rank' && cutoff.closing_rank) {
          cutoffStr = `${cutoff.exam_short}: Rank ${cutoff.closing_rank}`;
        } else if (cutoff.cutoff_type === 'Percentile' && cutoff.cutoff_value) {
          cutoffStr = `${cutoff.exam_short}: ${cutoff.cutoff_value}%`;
        } else if (cutoff.cutoff_type === 'Score' && cutoff.cutoff_value) {
          cutoffStr = `${cutoff.exam_short}: ${Math.round(cutoff.cutoff_value)}`;
        } else if (cutoff.closing_rank) {
          cutoffStr = `${cutoff.exam_short}: Rank ${cutoff.closing_rank}`;
        } else if (cutoff.cutoff_value) {
          cutoffStr = `${cutoff.exam_short}: ${cutoff.cutoff_value}`;
        }
      }

      // Format ranking string
      let rankingInfo = null;
      if (ranking) {
        rankingInfo = `${ranking.agency_code} #${ranking.rank_position}`;
      }

      return {
        id: college.college_id,
        rank: index + 1,
        name: college.college_name,
        shortName: college.short_name,
        slug: college.slug,
        location: `${college.city || ''}${college.city && college.state ? ', ' : ''}${college.state || ''}`,
        logoUrl: college.logo_url,
        rating: parseFloat(college.avg_rating) || 0,
        reviewCount: college.total_reviews || 0,
        rankingInfo: rankingInfo,
        cutoff: cutoffStr,
        fees: college.total_fees ? `₹${(college.total_fees / 100000).toFixed(1)}L/year` : null,
        deadline: college.application_end_date
          ? new Date(college.application_end_date).toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' })
          : null,
        isFeatured: college.is_featured,
        isVerified: college.is_verified,
        href: `/colleges/${college.slug}`,
      };
    });

    // Sort by ranking position, then rating
    colleges.sort((a, b) => {
      const aRank = rankingsMap[a.id]?.rank_position || 999;
      const bRank = rankingsMap[b.id]?.rank_position || 999;
      if (aRank !== bRank) return aRank - bRank;
      return b.rating - a.rating;
    });

    // Re-assign display ranks after sorting
    colleges.forEach((c, i) => c.rank = i + 1);

    res.json({
      success: true,
      data: colleges,
      meta: {
        course_type: course_type || 'all',
        total: colleges.length
      }
    });

  } catch (error) {
    console.error('Error fetching top colleges:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch top colleges',
      error: error.message
    });
  } finally {
    client.release();
  }
};

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

/**
 * @route GET /api/colleges/by-course/:courseType
 * @desc Get colleges filtered by course/degree type with advanced filters
 * @access Public
 */
exports.getCollegesByCourse = async (req, res) => {
  const client = await pool.connect();

  try {
    const { courseType } = req.params;
    const {
      page = 1,
      limit = 20,
      search = '',
      state = '',
      city = '',
      stream = '',
      min_fees = '',
      max_fees = '',
      college_type = '',
      ownership = '',
      exam_accepted = '',
      sort_by = 'popularity',
      sort_order = 'DESC'
    } = req.query;

    // Map course type to degree types
    const degreeTypeMap = {
      'btech': ['B.Tech', 'BE', 'B.E.', 'Bachelor of Technology', 'Bachelor of Engineering'],
      'mba': ['MBA', 'PGDM', 'Master of Business Administration'],
      'mbbs': ['MBBS', 'Bachelor of Medicine'],
      'mtech': ['M.Tech', 'ME', 'M.E.', 'Master of Technology', 'Master of Engineering'],
      'bsc': ['B.Sc', 'BSc', 'Bachelor of Science'],
      'ba': ['BA', 'B.A.', 'Bachelor of Arts'],
      'bcom': ['B.Com', 'BCom', 'Bachelor of Commerce'],
      'bca': ['BCA', 'Bachelor of Computer Applications'],
      'bba': ['BBA', 'BMS', 'Bachelor of Business Administration', 'Bachelor of Management Studies'],
      'llb': ['LLB', 'LL.B.', 'Bachelor of Laws', 'BA LLB', 'BBA LLB'],
      'bed': ['B.Ed', 'BEd', 'Bachelor of Education'],
      'bsc-nursing': ['B.Sc Nursing', 'BSc Nursing', 'Bachelor of Science in Nursing'],
    };

    const degreeTypes = degreeTypeMap[courseType.toLowerCase()];
    if (!degreeTypes) {
      return res.status(400).json({
        success: false,
        message: `Invalid course type: ${courseType}. Valid types: ${Object.keys(degreeTypeMap).join(', ')}`
      });
    }

    const offset = (parseInt(page) - 1) * parseInt(limit);
    const conditions = [];
    const params = [];
    let paramCount = 1;

    // Course type filter (required)
    const degreePlaceholders = degreeTypes.map((_, i) => `$${paramCount + i}`).join(', ');
    conditions.push(`co.degree_type IN (${degreePlaceholders})`);
    params.push(...degreeTypes);
    paramCount += degreeTypes.length;

    // Base conditions
    conditions.push("c.status = 'active'");
    conditions.push("c.deleted_at IS NULL");
    conditions.push("co.status = 'active'");
    conditions.push("co.deleted_at IS NULL");

    // Search filter
    if (search) {
      conditions.push(`(
        c.college_name ILIKE $${paramCount} OR
        c.short_name ILIKE $${paramCount} OR
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

    // Stream/specialization filter
    if (stream) {
      conditions.push(`(co.stream ILIKE $${paramCount} OR co.specialization ILIKE $${paramCount})`);
      params.push(`%${stream}%`);
      paramCount++;
    }

    // Fees range filter
    if (min_fees) {
      conditions.push(`co.total_fees >= $${paramCount}`);
      params.push(parseFloat(min_fees));
      paramCount++;
    }

    if (max_fees) {
      conditions.push(`co.total_fees <= $${paramCount}`);
      params.push(parseFloat(max_fees));
      paramCount++;
    }

    // College type filter
    if (college_type) {
      conditions.push(`c.college_type = $${paramCount}`);
      params.push(college_type);
      paramCount++;
    }

    // Ownership filter
    if (ownership) {
      conditions.push(`c.ownership = $${paramCount}`);
      params.push(ownership);
      paramCount++;
    }

    const whereClause = conditions.length > 0 ? `WHERE ${conditions.join(' AND ')}` : '';

    // Sort mapping (use column names without table alias for CTE result)
    let orderByClause;
    switch (sort_by) {
      case 'rating':
        orderByClause = 'avg_rating DESC NULLS LAST, total_reviews DESC';
        break;
      case 'fees_high':
        orderByClause = 'total_fees DESC NULLS LAST';
        break;
      case 'fees_low':
        orderByClause = 'total_fees ASC NULLS LAST';
        break;
      case 'name':
        orderByClause = 'college_name ASC';
        break;
      case 'popularity':
      default:
        orderByClause = 'is_featured DESC, view_count DESC, avg_rating DESC NULLS LAST';
        break;
    }

    // Count query
    const countQuery = `
      SELECT COUNT(DISTINCT c.college_id) as total
      FROM colleges c
      INNER JOIN courses co ON c.college_id = co.college_id
      ${whereClause}
    `;

    const countResult = await client.query(countQuery, params);
    const total = parseInt(countResult.rows[0].total);

    // Main query with all data
    const mainQuery = `
      WITH ranked_colleges AS (
        SELECT DISTINCT ON (c.college_id)
          c.college_id,
          c.college_name,
          c.short_name,
          c.slug,
          c.city,
          c.state,
          c.logo_url,
          c.college_type,
          c.ownership,
          c.avg_rating,
          c.total_reviews,
          c.view_count,
          c.is_featured,
          c.is_verified,
          co.course_id,
          co.course_name,
          co.degree_type,
          co.stream,
          co.specialization,
          co.total_fees,
          co.duration
        FROM colleges c
        INNER JOIN courses co ON c.college_id = co.college_id
        ${whereClause}
        ORDER BY c.college_id, co.total_fees ASC NULLS LAST
      )
      SELECT * FROM ranked_colleges
      ORDER BY ${orderByClause}
      LIMIT $${paramCount} OFFSET $${paramCount + 1}
    `;

    params.push(parseInt(limit), offset);

    const collegesResult = await client.query(mainQuery, params);
    const collegeIds = collegesResult.rows.map(c => c.college_id);

    // Fetch placements for all colleges
    let placementsMap = {};
    if (collegeIds.length > 0) {
      const placementsQuery = `
        SELECT DISTINCT ON (college_id)
          college_id,
          average_package,
          highest_package,
          median_package,
          placement_percentage,
          academic_year
        FROM placements
        WHERE college_id = ANY($1)
          AND deleted_at IS NULL
        ORDER BY college_id, academic_year DESC
      `;
      const placementsResult = await client.query(placementsQuery, [collegeIds]);
      placementsResult.rows.forEach(p => {
        placementsMap[p.college_id] = p;
      });
    }

    // Fetch rankings for all colleges
    let rankingsMap = {};
    if (collegeIds.length > 0) {
      const rankingsQuery = `
        SELECT DISTINCT ON (cr.college_id)
          cr.college_id,
          cr.rank_position,
          cr.score,
          cr.category,
          cr.ranking_year,
          ra.agency_name,
          ra.agency_code
        FROM college_rankings cr
        JOIN ranking_agencies ra ON cr.agency_id = ra.agency_id
        WHERE cr.college_id = ANY($1)
        ORDER BY cr.college_id, cr.ranking_year DESC, cr.rank_position ASC
      `;
      const rankingsResult = await client.query(rankingsQuery, [collegeIds]);
      rankingsResult.rows.forEach(r => {
        rankingsMap[r.college_id] = r;
      });
    }

    // Format response
    const colleges = collegesResult.rows.map((college, index) => {
      const placement = placementsMap[college.college_id];
      const ranking = rankingsMap[college.college_id];

      return {
        college_id: college.college_id,
        college_name: college.college_name,
        short_name: college.short_name,
        slug: college.slug,
        logo_url: college.logo_url,
        city: college.city,
        state: college.state,
        college_type: college.college_type,
        ownership: college.ownership,
        avg_rating: parseFloat(college.avg_rating) || 0,
        total_reviews: college.total_reviews || 0,
        is_featured: college.is_featured,
        is_verified: college.is_verified,
        course: {
          course_id: college.course_id,
          course_name: college.course_name,
          degree_type: college.degree_type,
          stream: college.stream,
          specialization: college.specialization,
          total_fees: college.total_fees,
          duration: college.duration
        },
        placement: placement ? {
          average_package: placement.average_package,
          highest_package: placement.highest_package,
          median_package: placement.median_package,
          placement_percentage: placement.placement_percentage,
          academic_year: placement.academic_year
        } : null,
        ranking: ranking ? {
          agency_name: ranking.agency_name,
          agency_code: ranking.agency_code,
          rank_position: ranking.rank_position,
          score: ranking.score,
          category: ranking.category,
          ranking_year: ranking.ranking_year
        } : null,
        display_rank: index + 1 + offset
      };
    });

    res.json({
      success: true,
      data: colleges,
      pagination: {
        current_page: parseInt(page),
        per_page: parseInt(limit),
        total: total,
        total_pages: Math.ceil(total / parseInt(limit))
      },
      meta: {
        course_type: courseType,
        degree_types: degreeTypes,
        filters_applied: {
          search, state, city, stream, min_fees, max_fees, college_type, ownership, exam_accepted
        },
        sort_by,
        sort_order
      }
    });

  } catch (error) {
    console.error('Error fetching colleges by course:', error);
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
 * @route GET /api/colleges/filter-options/:courseType
 * @desc Get filter options with counts for a specific course type
 * @access Public
 */
exports.getFilterOptionsByCourse = async (req, res) => {
  const client = await pool.connect();

  try {
    const { courseType } = req.params;

    // Map course type to degree types
    const degreeTypeMap = {
      'btech': ['B.Tech', 'BE', 'B.E.', 'Bachelor of Technology', 'Bachelor of Engineering'],
      'mba': ['MBA', 'PGDM', 'Master of Business Administration'],
      'mbbs': ['MBBS', 'Bachelor of Medicine'],
      'mtech': ['M.Tech', 'ME', 'M.E.', 'Master of Technology', 'Master of Engineering'],
      'bsc': ['B.Sc', 'BSc', 'Bachelor of Science'],
      'ba': ['BA', 'B.A.', 'Bachelor of Arts'],
      'bcom': ['B.Com', 'BCom', 'Bachelor of Commerce'],
      'bca': ['BCA', 'Bachelor of Computer Applications'],
      'bba': ['BBA', 'BMS', 'Bachelor of Business Administration', 'Bachelor of Management Studies'],
      'llb': ['LLB', 'LL.B.', 'Bachelor of Laws', 'BA LLB', 'BBA LLB'],
      'bed': ['B.Ed', 'BEd', 'Bachelor of Education'],
      'bsc-nursing': ['B.Sc Nursing', 'BSc Nursing', 'Bachelor of Science in Nursing'],
    };

    const degreeTypes = degreeTypeMap[courseType.toLowerCase()];
    if (!degreeTypes) {
      return res.status(400).json({
        success: false,
        message: `Invalid course type: ${courseType}`
      });
    }

    const degreePlaceholders = degreeTypes.map((_, i) => `$${i + 1}`).join(', ');

    // Get states with counts
    const statesQuery = `
      SELECT c.state, COUNT(DISTINCT c.college_id) as count
      FROM colleges c
      INNER JOIN courses co ON c.college_id = co.college_id
      WHERE c.status = 'active'
        AND c.deleted_at IS NULL
        AND co.status = 'active'
        AND co.deleted_at IS NULL
        AND co.degree_type IN (${degreePlaceholders})
        AND c.state IS NOT NULL AND c.state != ''
      GROUP BY c.state
      ORDER BY count DESC, c.state ASC
    `;

    // Get cities with counts
    const citiesQuery = `
      SELECT c.city, c.state, COUNT(DISTINCT c.college_id) as count
      FROM colleges c
      INNER JOIN courses co ON c.college_id = co.college_id
      WHERE c.status = 'active'
        AND c.deleted_at IS NULL
        AND co.status = 'active'
        AND co.deleted_at IS NULL
        AND co.degree_type IN (${degreePlaceholders})
        AND c.city IS NOT NULL AND c.city != ''
      GROUP BY c.city, c.state
      ORDER BY count DESC, c.city ASC
      LIMIT 50
    `;

    // Get streams/specializations with counts
    const streamsQuery = `
      SELECT COALESCE(co.stream, co.specialization) as stream, COUNT(DISTINCT c.college_id) as count
      FROM colleges c
      INNER JOIN courses co ON c.college_id = co.college_id
      WHERE c.status = 'active'
        AND c.deleted_at IS NULL
        AND co.status = 'active'
        AND co.deleted_at IS NULL
        AND co.degree_type IN (${degreePlaceholders})
        AND (co.stream IS NOT NULL OR co.specialization IS NOT NULL)
      GROUP BY COALESCE(co.stream, co.specialization)
      ORDER BY count DESC
      LIMIT 30
    `;

    // Get college types with counts
    const collegeTypesQuery = `
      SELECT c.college_type, COUNT(DISTINCT c.college_id) as count
      FROM colleges c
      INNER JOIN courses co ON c.college_id = co.college_id
      WHERE c.status = 'active'
        AND c.deleted_at IS NULL
        AND co.status = 'active'
        AND co.deleted_at IS NULL
        AND co.degree_type IN (${degreePlaceholders})
        AND c.college_type IS NOT NULL
      GROUP BY c.college_type
      ORDER BY count DESC
    `;

    // Get ownership types with counts
    const ownershipQuery = `
      SELECT c.ownership, COUNT(DISTINCT c.college_id) as count
      FROM colleges c
      INNER JOIN courses co ON c.college_id = co.college_id
      WHERE c.status = 'active'
        AND c.deleted_at IS NULL
        AND co.status = 'active'
        AND co.deleted_at IS NULL
        AND co.degree_type IN (${degreePlaceholders})
        AND c.ownership IS NOT NULL
      GROUP BY c.ownership
      ORDER BY count DESC
    `;

    // Get fee ranges
    const feesQuery = `
      SELECT
        MIN(co.total_fees) as min_fees,
        MAX(co.total_fees) as max_fees,
        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY co.total_fees) as q1,
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY co.total_fees) as median,
        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY co.total_fees) as q3
      FROM colleges c
      INNER JOIN courses co ON c.college_id = co.college_id
      WHERE c.status = 'active'
        AND c.deleted_at IS NULL
        AND co.status = 'active'
        AND co.deleted_at IS NULL
        AND co.degree_type IN (${degreePlaceholders})
        AND co.total_fees IS NOT NULL
        AND co.total_fees > 0
    `;

    // Get total count
    const totalQuery = `
      SELECT COUNT(DISTINCT c.college_id) as total
      FROM colleges c
      INNER JOIN courses co ON c.college_id = co.college_id
      WHERE c.status = 'active'
        AND c.deleted_at IS NULL
        AND co.status = 'active'
        AND co.deleted_at IS NULL
        AND co.degree_type IN (${degreePlaceholders})
    `;

    // Get exams accepted
    const examsQuery = `
      SELECT DISTINCT e.exam_name, e.short_name, COUNT(DISTINCT c.college_id) as count
      FROM colleges c
      INNER JOIN courses co ON c.college_id = co.college_id
      INNER JOIN exam_cutoffs ec ON c.college_id = ec.college_id
      INNER JOIN exams e ON ec.exam_id = e.exam_id
      WHERE c.status = 'active'
        AND c.deleted_at IS NULL
        AND co.status = 'active'
        AND co.deleted_at IS NULL
        AND co.degree_type IN (${degreePlaceholders})
      GROUP BY e.exam_id, e.exam_name, e.short_name
      ORDER BY count DESC
      LIMIT 20
    `;

    const [
      statesResult,
      citiesResult,
      streamsResult,
      collegeTypesResult,
      ownershipResult,
      feesResult,
      totalResult,
      examsResult
    ] = await Promise.all([
      client.query(statesQuery, degreeTypes),
      client.query(citiesQuery, degreeTypes),
      client.query(streamsQuery, degreeTypes),
      client.query(collegeTypesQuery, degreeTypes),
      client.query(ownershipQuery, degreeTypes),
      client.query(feesQuery, degreeTypes),
      client.query(totalQuery, degreeTypes),
      client.query(examsQuery, degreeTypes)
    ]);

    const fees = feesResult.rows[0];

    res.json({
      success: true,
      data: {
        total_colleges: parseInt(totalResult.rows[0].total),
        states: statesResult.rows.map(r => ({ name: r.state, count: parseInt(r.count) })),
        cities: citiesResult.rows.map(r => ({ name: r.city, state: r.state, count: parseInt(r.count) })),
        streams: streamsResult.rows.filter(r => r.stream).map(r => ({ name: r.stream, count: parseInt(r.count) })),
        college_types: collegeTypesResult.rows.map(r => ({ name: r.college_type, count: parseInt(r.count) })),
        ownership_types: ownershipResult.rows.map(r => ({ name: r.ownership, count: parseInt(r.count) })),
        exams: examsResult.rows.map(r => ({
          name: r.exam_name,
          short_name: r.short_name,
          count: parseInt(r.count)
        })),
        fees_range: fees ? {
          min: parseFloat(fees.min_fees) || 0,
          max: parseFloat(fees.max_fees) || 0,
          q1: parseFloat(fees.q1) || 0,
          median: parseFloat(fees.median) || 0,
          q3: parseFloat(fees.q3) || 0
        } : null
      },
      meta: {
        course_type: courseType,
        degree_types: degreeTypes
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

/**
 * @route GET /api/v1/courses/:courseType/content
 * @desc Get course page content (blog/article) for a specific course type
 * @access Public
 */
exports.getCoursePageContent = async (req, res) => {
  const client = await pool.connect();

  try {
    const { courseType } = req.params;

    // Fetch course page content
    const result = await client.query(`
      SELECT
        cpc.content_id,
        cpc.course_type,
        cpc.page_title,
        cpc.full_content,
        cpc.banners,
        cpc.meta_title,
        cpc.meta_description,
        cpc.updated_at,
        ca.name as author_name,
        ca.designation as author_designation,
        ca.profile_image_url as author_avatar,
        ca.is_verified as author_verified
      FROM course_page_content cpc
      LEFT JOIN content_authors ca ON cpc.author_id = ca.id
      WHERE cpc.course_type = $1 AND cpc.status = 'published'
    `, [courseType]);

    if (result.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Course content not found'
      });
    }

    const content = result.rows[0];

    res.json({
      success: true,
      data: {
        content_id: content.content_id,
        course_type: content.course_type,
        page_title: content.page_title,
        full_content: content.full_content,
        banners: content.banners || [],
        meta: {
          title: content.meta_title,
          description: content.meta_description
        },
        author: content.author_name ? {
          name: content.author_name,
          designation: content.author_designation,
          avatar: content.author_avatar,
          is_verified: content.author_verified
        } : null,
        updated_at: content.updated_at
      }
    });

  } catch (error) {
    console.error('Error fetching course page content:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch course content',
      error: error.message
    });
  } finally {
    client.release();
  }
};

/**
 * @route GET /api/v1/courses/:courseType/location/:locationSlug/content
 * @desc Get course location page content (for city/state specific pages)
 * @access Public
 */
exports.getCourseLocationContent = async (req, res) => {
  const client = await pool.connect();

  try {
    const { courseType, locationSlug } = req.params;

    const result = await client.query(`
      SELECT
        clc.*,
        ca.name as author_name,
        ca.designation as author_designation,
        ca.profile_image_url as author_avatar,
        ca.is_verified as author_verified
      FROM course_location_content clc
      LEFT JOIN content_authors ca ON clc.author_id = ca.id
      WHERE clc.course_type = $1 AND clc.location_slug = $2 AND clc.status = 'published'
    `, [courseType, locationSlug]);

    if (result.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Location content not found'
      });
    }

    const content = result.rows[0];

    res.json({
      success: true,
      data: {
        content_id: content.content_id,
        course_type: content.course_type,
        location_type: content.location_type,
        location_name: content.location_name,
        location_slug: content.location_slug,
        page_title: content.page_title,
        full_content: content.full_content,
        banners: content.banners || [],
        meta: {
          title: content.meta_title,
          description: content.meta_description
        },
        author: content.author_name ? {
          name: content.author_name,
          designation: content.author_designation,
          avatar: content.author_avatar,
          is_verified: content.author_verified
        } : null,
        updated_at: content.updated_at
      }
    });

  } catch (error) {
    console.error('Error fetching course location content:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch location content',
      error: error.message
    });
  } finally {
    client.release();
  }
};
