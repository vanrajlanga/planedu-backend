const { query } = require('../config/database');
const ApiResponse = require('../utils/response');

/**
 * Get All Colleges (Search & Filter)
 * GET /api/v1/colleges
 */
const getAllColleges = async (req, res, next) => {
  try {
    const {
      page = 1,
      limit = 20,
      city,
      state,
      country = 'India',
      stream,
      college_type,
      ownership,
      min_rating,
      search,
      sort_by = 'rating',
      sort_order = 'desc'
    } = req.query;

    const offset = (parseInt(page) - 1) * parseInt(limit);

    // Build WHERE clause dynamically
    const conditions = ['c.status = $1'];
    const params = ['active'];
    let paramCount = 1;

    if (city) {
      paramCount++;
      conditions.push(`c.city = $${paramCount}`);
      params.push(city);
    }

    if (state) {
      paramCount++;
      conditions.push(`c.state = $${paramCount}`);
      params.push(state);
    }

    if (country) {
      paramCount++;
      conditions.push(`c.country = $${paramCount}`);
      params.push(country);
    }

    if (college_type) {
      paramCount++;
      conditions.push(`c.college_type = $${paramCount}`);
      params.push(college_type);
    }

    if (ownership) {
      paramCount++;
      conditions.push(`c.ownership = $${paramCount}`);
      params.push(ownership);
    }

    if (min_rating) {
      paramCount++;
      conditions.push(`c.avg_rating >= $${paramCount}`);
      params.push(parseFloat(min_rating));
    }

    if (search) {
      paramCount++;
      conditions.push(`to_tsvector('english', c.college_name) @@ plainto_tsquery('english', $${paramCount})`);
      params.push(search);
    }

    const whereClause = conditions.join(' AND ');

    // Get total count
    const countResult = await query(
      `SELECT COUNT(*) as total FROM colleges c WHERE ${whereClause}`,
      params
    );
    const totalResults = parseInt(countResult.rows[0].total);

    // Build ORDER BY clause
    let orderByClause = '';
    if (sort_by === 'rating') {
      orderByClause = `c.avg_rating ${sort_order.toUpperCase()}`;
    } else if (sort_by === 'name') {
      orderByClause = `c.college_name ${sort_order.toUpperCase()}`;
    } else {
      orderByClause = `c.is_featured DESC, c.avg_rating DESC`;
    }

    // Get paginated results
    const collegesQuery = `
      SELECT
        c.college_id,
        c.college_name,
        c.slug,
        c.short_name,
        c.college_type,
        c.ownership,
        c.city,
        c.state,
        c.country,
        c.logo_url,
        c.avg_rating,
        c.total_reviews,
        c.established_year,
        c.is_featured,
        c.is_verified,
        -- Aggregate rankings
        (
          SELECT json_agg(
            json_build_object(
              'agency', subq.agency_name,
              'rank', subq.rank_position,
              'year', subq.ranking_year
            )
          )
          FROM (
            SELECT ra.agency_name, cr.rank_position, cr.ranking_year
            FROM college_rankings cr
            JOIN ranking_agencies ra ON cr.agency_id = ra.agency_id
            WHERE cr.college_id = c.college_id
            ORDER BY cr.ranking_year DESC
            LIMIT 3
          ) subq
        ) as rankings,
        -- Latest placement data
        (
          SELECT json_build_object(
            'highest_package', p.highest_package,
            'average_package', p.average_package,
            'placement_percentage', p.placement_percentage
          )
          FROM placements p
          WHERE p.college_id = c.college_id
          ORDER BY p.academic_year DESC
          LIMIT 1
        ) as latest_placement
      FROM colleges c
      WHERE ${whereClause}
      ORDER BY ${orderByClause}
      LIMIT $${paramCount + 1} OFFSET $${paramCount + 2}
    `;

    params.push(parseInt(limit), offset);

    const colleges = await query(collegesQuery, params);

    const pagination = {
      current_page: parseInt(page),
      per_page: parseInt(limit),
      total_results: totalResults,
      total_pages: Math.ceil(totalResults / parseInt(limit))
    };

    return ApiResponse.paginated(
      res,
      colleges.rows,
      pagination,
      'Colleges retrieved successfully'
    );

  } catch (error) {
    console.error('Get colleges error:', error);
    next(error);
  }
};

/**
 * Get College by Slug
 * GET /api/v1/colleges/:slug
 */
const getCollegeBySlug = async (req, res, next) => {
  try {
    const { slug } = req.params;

    const collegeQuery = `
      SELECT
        c.*,
        -- Approvals (from discovery schema)
        (
          SELECT json_agg(json_build_object(
            'approval_body', ia.approval_body,
            'approval_year', ia.approval_year,
            'valid_until', ia.valid_until
          ))
          FROM discovery.institution_approvals ia
          WHERE ia.institution_id = c.college_id
        ) as approvals,
        -- Affiliations
        (
          SELECT json_agg(json_build_object(
            'affiliated_university', iaf.affiliated_university,
            'affiliation_type', iaf.affiliation_type
          ))
          FROM discovery.institution_affiliations iaf
          WHERE iaf.institution_id = c.college_id
        ) as affiliations,
        -- Facilities
        (
          SELECT json_agg(json_build_object(
            'facility_name', f.facility_name,
            'icon', f.icon
          ))
          FROM discovery.institution_facilities instf
          JOIN discovery.facilities f ON instf.facility_id = f.facility_id
          WHERE instf.institution_id = c.college_id AND instf.is_available = true
        ) as facilities,
        -- Highlights
        (
          SELECT json_agg(json_build_object(
            'highlight_type', ih.highlight_type,
            'value', ih.value,
            'label', ih.label
          ))
          FROM discovery.institution_highlights ih
          WHERE ih.institution_id = c.college_id
        ) as highlights,
        -- Media gallery
        (
          SELECT json_agg(json_build_object(
            'media_type', cm.media_type,
            'media_url', cm.media_url,
            'thumbnail_url', cm.thumbnail_url,
            'title', cm.title
          ))
          FROM college_media cm
          WHERE cm.college_id = c.college_id
          ORDER BY cm.display_order
        ) as media,
        -- Placement data (last 3 years)
        (
          SELECT json_agg(json_build_object(
            'year', p.academic_year,
            'highest_package', p.highest_package,
            'average_package', p.average_package,
            'median_package', p.median_package,
            'placement_percentage', p.placement_percentage,
            'top_recruiters', p.top_recruiters
          ))
          FROM placements p
          WHERE p.college_id = c.college_id
          ORDER BY p.academic_year DESC
          LIMIT 3
        ) as placements,
        -- Rankings
        (
          SELECT json_agg(json_build_object(
            'agency', ra.agency_name,
            'year', cr.ranking_year,
            'rank', cr.rank_position,
            'category', cr.category,
            'score', cr.score
          ))
          FROM college_rankings cr
          JOIN ranking_agencies ra ON cr.agency_id = ra.agency_id
          WHERE cr.college_id = c.college_id
          ORDER BY cr.ranking_year DESC, ra.agency_id
        ) as rankings,
        -- Review summary
        (
          SELECT json_build_object(
            'total_reviews', COUNT(*),
            'avg_overall', ROUND(AVG(overall_rating)::numeric, 2),
            'avg_academic', ROUND(AVG(academic_rating)::numeric, 2),
            'avg_infrastructure', ROUND(AVG(infrastructure_rating)::numeric, 2),
            'avg_placement', ROUND(AVG(placement_rating)::numeric, 2),
            'avg_faculty', ROUND(AVG(faculty_rating)::numeric, 2)
          )
          FROM reviews
          WHERE college_id = c.college_id AND status = 'approved'
        ) as review_summary
      FROM colleges c
      WHERE c.slug = $1 AND c.status = 'active'
    `;

    const result = await query(collegeQuery, [slug]);

    if (result.rows.length === 0) {
      return ApiResponse.error(res, 'College not found', 404);
    }

    // Increment view count (async, don't wait)
    query('UPDATE colleges SET view_count = view_count + 1 WHERE college_id = $1', [result.rows[0].college_id])
      .catch(err => console.error('Error updating view count:', err));

    return ApiResponse.success(
      res,
      result.rows[0],
      'College details retrieved successfully'
    );

  } catch (error) {
    console.error('Get college by slug error:', error);
    next(error);
  }
};

/**
 * Get College Reviews
 * GET /api/v1/colleges/:college_id/reviews
 */
const getCollegeReviews = async (req, res, next) => {
  try {
    const { college_id } = req.params;
    const {
      page = 1,
      limit = 10,
      sort_by = 'recent',
      rating_filter
    } = req.query;

    const offset = (parseInt(page) - 1) * parseInt(limit);

    // Build WHERE clause
    const conditions = ['r.college_id = $1', 'r.status = $2'];
    const params = [parseInt(college_id), 'approved'];
    let paramCount = 2;

    if (rating_filter) {
      const ratings = rating_filter.split(',').map(r => parseFloat(r));
      paramCount++;
      conditions.push(`r.overall_rating = ANY($${paramCount}::decimal[])`);
      params.push(ratings);
    }

    const whereClause = conditions.join(' AND ');

    // Get total count
    const countResult = await query(
      `SELECT COUNT(*) as total FROM reviews r WHERE ${whereClause}`,
      params
    );
    const totalResults = parseInt(countResult.rows[0].total);

    // Build ORDER BY
    let orderByClause = 'r.created_at DESC';
    if (sort_by === 'helpful') {
      orderByClause = 'r.helpful_count DESC, r.created_at DESC';
    } else if (sort_by === 'rating') {
      orderByClause = 'r.overall_rating DESC, r.created_at DESC';
    }

    // Get reviews
    const reviewsQuery = `
      SELECT
        r.review_id,
        r.overall_rating,
        r.academic_rating,
        r.infrastructure_rating,
        r.faculty_rating,
        r.placement_rating,
        r.hostel_rating,
        r.review_title,
        r.review_text,
        r.pros,
        r.cons,
        r.helpful_count,
        r.unhelpful_count,
        r.created_at,
        -- User info (conditional based on is_anonymous)
        CASE
          WHEN r.is_anonymous = false THEN json_build_object(
            'user_id', u.user_id,
            'name', up.first_name || ' ' || up.last_name,
            'profile_photo', up.profile_photo_url
          )
          ELSE json_build_object(
            'name', 'Anonymous',
            'profile_photo', null
          )
        END as reviewer,
        -- Course info
        json_build_object(
          'course_name', co.course_name,
          'course_type', co.course_type
        ) as course_info
      FROM reviews r
      LEFT JOIN users u ON r.user_id = u.user_id
      LEFT JOIN user_profiles up ON u.user_id = up.user_id
      LEFT JOIN courses co ON r.course_id = co.course_id
      WHERE ${whereClause}
      ORDER BY ${orderByClause}
      LIMIT $${paramCount + 1} OFFSET $${paramCount + 2}
    `;

    params.push(parseInt(limit), offset);

    const reviews = await query(reviewsQuery, params);

    const pagination = {
      current_page: parseInt(page),
      per_page: parseInt(limit),
      total_results: totalResults,
      total_pages: Math.ceil(totalResults / parseInt(limit))
    };

    return ApiResponse.paginated(
      res,
      reviews.rows,
      pagination,
      'Reviews retrieved successfully'
    );

  } catch (error) {
    console.error('Get college reviews error:', error);
    next(error);
  }
};

module.exports = {
  getAllColleges,
  getCollegeBySlug,
  getCollegeReviews
};
