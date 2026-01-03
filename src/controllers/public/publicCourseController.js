const { pool } = require('../../config/database');

/**
 * @route GET /api/courses/menu
 * @desc Get all degree types with college counts for the courses menu
 * @access Public
 */
exports.getCoursesMenu = async (req, res) => {
  const client = await pool.connect();

  try {
    // Get all distinct degree types with their college counts
    const query = `
      SELECT
        LOWER(REPLACE(REPLACE(co.degree_type, '.', ''), ' ', '-')) as id,
        co.degree_type as name,
        co.degree_type as full_name,
        CONCAT('/', LOWER(REPLACE(REPLACE(co.degree_type, '.', ''), ' ', '-')), '-colleges') as slug,
        COUNT(DISTINCT co.college_id) as college_count
      FROM courses co
      INNER JOIN colleges c ON co.college_id = c.college_id
      WHERE co.status = 'active'
        AND co.deleted_at IS NULL
        AND c.status = 'active'
        AND c.deleted_at IS NULL
        AND co.degree_type IS NOT NULL
        AND co.degree_type != ''
      GROUP BY co.degree_type
      ORDER BY college_count DESC, co.degree_type ASC
    `;

    const result = await client.query(query);

    // Map full names for common degree types
    const fullNameMap = {
      'B.Tech': 'Bachelor of Technology',
      'MBA': 'Master of Business Administration',
      'MBBS': 'Bachelor of Medicine, Bachelor of Surgery',
      'M.Tech': 'Master of Technology',
      'B.Sc': 'Bachelor of Science',
      'M.Sc': 'Master of Science',
      'BA': 'Bachelor of Arts',
      'MA': 'Master of Arts',
      'B.Com': 'Bachelor of Commerce',
      'M.Com': 'Master of Commerce',
      'BBA': 'Bachelor of Business Administration',
      'BCA': 'Bachelor of Computer Applications',
      'MCA': 'Master of Computer Applications',
      'LLB': 'Bachelor of Laws',
      'LLM': 'Master of Laws',
      'B.Ed': 'Bachelor of Education',
      'B.Pharm': 'Bachelor of Pharmacy',
      'M.Pharm': 'Master of Pharmacy',
      'B.Arch': 'Bachelor of Architecture',
      'PGDM': 'Post Graduate Diploma in Management',
      'PhD': 'Doctor of Philosophy',
    };

    const courses = result.rows.map(row => ({
      id: row.id,
      name: row.name,
      fullName: fullNameMap[row.name] || row.name,
      slug: row.slug,
      collegeCount: parseInt(row.college_count),
    }));

    res.json({
      success: true,
      data: courses,
    });

  } catch (error) {
    console.error('Error fetching courses menu:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch courses menu',
      error: error.message,
    });
  } finally {
    client.release();
  }
};

/**
 * @route GET /api/courses/:degreeType/streams
 * @desc Get all streams for a specific degree type with college counts
 * @access Public
 */
exports.getCourseStreams = async (req, res) => {
  const client = await pool.connect();

  try {
    const { degreeType } = req.params;

    // Convert URL-friendly format back to degree type (e.g., "btech" -> "B.Tech")
    const degreeTypeMap = {
      'btech': 'B.Tech',
      'mba': 'MBA',
      'mbbs': 'MBBS',
      'mtech': 'M.Tech',
      'bsc': 'B.Sc',
      'msc': 'M.Sc',
      'ba': 'BA',
      'ma': 'MA',
      'bcom': 'B.Com',
      'mcom': 'M.Com',
      'bba': 'BBA',
      'bca': 'BCA',
      'mca': 'MCA',
      'llb': 'LLB',
      'llm': 'LLM',
      'bed': 'B.Ed',
      'bpharm': 'B.Pharm',
      'mpharm': 'M.Pharm',
      'barch': 'B.Arch',
      'pgdm': 'PGDM',
      'phd': 'PhD',
    };

    const actualDegreeType = degreeTypeMap[degreeType.toLowerCase()] || degreeType;

    const query = `
      SELECT
        LOWER(REPLACE(REPLACE(COALESCE(co.stream, co.specialization, 'General'), ' ', '-'), '.', '')) as id,
        COALESCE(co.stream, co.specialization, 'General') as name,
        CONCAT('/', LOWER(REPLACE(REPLACE($1, '.', ''), ' ', '-')), '-colleges?stream=',
               LOWER(REPLACE(REPLACE(COALESCE(co.stream, co.specialization, 'General'), ' ', '-'), '.', ''))) as slug,
        COUNT(DISTINCT co.college_id) as count
      FROM courses co
      INNER JOIN colleges c ON co.college_id = c.college_id
      WHERE co.degree_type = $1
        AND co.status = 'active'
        AND co.deleted_at IS NULL
        AND c.status = 'active'
        AND c.deleted_at IS NULL
      GROUP BY COALESCE(co.stream, co.specialization, 'General')
      ORDER BY count DESC, name ASC
    `;

    const result = await client.query(query, [actualDegreeType]);

    const streams = result.rows.map(row => ({
      id: row.id,
      name: row.name,
      slug: row.slug,
      count: parseInt(row.count),
    }));

    res.json({
      success: true,
      data: streams,
      meta: {
        degreeType: actualDegreeType,
        total: streams.length,
      },
    });

  } catch (error) {
    console.error('Error fetching course streams:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch course streams',
      error: error.message,
    });
  } finally {
    client.release();
  }
};

/**
 * @route GET /api/courses/:degreeType/cities
 * @desc Get all cities for a specific degree type with college counts
 * @access Public
 */
exports.getCourseCities = async (req, res) => {
  const client = await pool.connect();

  try {
    const { degreeType } = req.params;

    // Convert URL-friendly format back to degree type
    const degreeTypeMap = {
      'btech': 'B.Tech',
      'mba': 'MBA',
      'mbbs': 'MBBS',
      'mtech': 'M.Tech',
      'bsc': 'B.Sc',
      'msc': 'M.Sc',
      'ba': 'BA',
      'ma': 'MA',
      'bcom': 'B.Com',
      'mcom': 'M.Com',
      'bba': 'BBA',
      'bca': 'BCA',
      'mca': 'MCA',
      'llb': 'LLB',
      'llm': 'LLM',
      'bed': 'B.Ed',
      'bpharm': 'B.Pharm',
      'mpharm': 'M.Pharm',
      'barch': 'B.Arch',
      'pgdm': 'PGDM',
      'phd': 'PhD',
    };

    const actualDegreeType = degreeTypeMap[degreeType.toLowerCase()] || degreeType;

    const query = `
      SELECT
        LOWER(REPLACE(c.city, ' ', '-')) as id,
        c.city as name,
        c.state,
        CONCAT('/', LOWER(REPLACE(REPLACE($1, '.', ''), ' ', '-')), '/',
               LOWER(REPLACE(c.city, ' ', '-')), '-colleges') as slug,
        COUNT(DISTINCT c.college_id) as count
      FROM colleges c
      INNER JOIN courses co ON c.college_id = co.college_id
      WHERE co.degree_type = $1
        AND co.status = 'active'
        AND co.deleted_at IS NULL
        AND c.status = 'active'
        AND c.deleted_at IS NULL
        AND c.city IS NOT NULL
        AND c.city != ''
      GROUP BY c.city, c.state
      ORDER BY count DESC, c.city ASC
    `;

    const result = await client.query(query, [actualDegreeType]);

    const cities = result.rows.map(row => ({
      id: row.id,
      name: row.name,
      state: row.state,
      slug: row.slug,
      count: parseInt(row.count),
    }));

    res.json({
      success: true,
      data: cities,
      meta: {
        degreeType: actualDegreeType,
        total: cities.length,
      },
    });

  } catch (error) {
    console.error('Error fetching course cities:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch course cities',
      error: error.message,
    });
  } finally {
    client.release();
  }
};

/**
 * @route GET /api/courses/:degreeType/details
 * @desc Get complete details for a specific degree type (streams + cities)
 * @access Public
 */
exports.getCourseDetails = async (req, res) => {
  const client = await pool.connect();

  try {
    const { degreeType } = req.params;

    // Convert URL-friendly format back to degree type
    const degreeTypeMap = {
      'btech': 'B.Tech',
      'mba': 'MBA',
      'mbbs': 'MBBS',
      'mtech': 'M.Tech',
      'bsc': 'B.Sc',
      'msc': 'M.Sc',
      'ba': 'BA',
      'ma': 'MA',
      'bcom': 'B.Com',
      'mcom': 'M.Com',
      'bba': 'BBA',
      'bca': 'BCA',
      'mca': 'MCA',
      'llb': 'LLB',
      'llm': 'LLM',
      'bed': 'B.Ed',
      'bpharm': 'B.Pharm',
      'mpharm': 'M.Pharm',
      'barch': 'B.Arch',
      'pgdm': 'PGDM',
      'phd': 'PhD',
    };

    const fullNameMap = {
      'B.Tech': 'Bachelor of Technology',
      'MBA': 'Master of Business Administration',
      'MBBS': 'Bachelor of Medicine, Bachelor of Surgery',
      'M.Tech': 'Master of Technology',
      'B.Sc': 'Bachelor of Science',
      'M.Sc': 'Master of Science',
      'BA': 'Bachelor of Arts',
      'MA': 'Master of Arts',
      'B.Com': 'Bachelor of Commerce',
      'M.Com': 'Master of Commerce',
      'BBA': 'Bachelor of Business Administration',
      'BCA': 'Bachelor of Computer Applications',
      'MCA': 'Master of Computer Applications',
      'LLB': 'Bachelor of Laws',
      'LLM': 'Master of Laws',
      'B.Ed': 'Bachelor of Education',
      'B.Pharm': 'Bachelor of Pharmacy',
      'M.Pharm': 'Master of Pharmacy',
      'B.Arch': 'Bachelor of Architecture',
      'PGDM': 'Post Graduate Diploma in Management',
      'PhD': 'Doctor of Philosophy',
    };

    const actualDegreeType = degreeTypeMap[degreeType.toLowerCase()] || degreeType;

    // Get streams
    const streamsQuery = `
      SELECT
        LOWER(REPLACE(REPLACE(COALESCE(co.stream, co.specialization, 'General'), ' ', '-'), '.', '')) as id,
        COALESCE(co.stream, co.specialization, 'General') as name,
        CONCAT('/', LOWER(REPLACE(REPLACE($1, '.', ''), ' ', '-')), '-colleges?stream=',
               LOWER(REPLACE(REPLACE(COALESCE(co.stream, co.specialization, 'General'), ' ', '-'), '.', ''))) as slug,
        COUNT(DISTINCT co.college_id) as count
      FROM courses co
      INNER JOIN colleges c ON co.college_id = c.college_id
      WHERE co.degree_type = $1
        AND co.status = 'active'
        AND co.deleted_at IS NULL
        AND c.status = 'active'
        AND c.deleted_at IS NULL
      GROUP BY COALESCE(co.stream, co.specialization, 'General')
      ORDER BY count DESC, name ASC
    `;

    // Get cities
    const citiesQuery = `
      SELECT
        LOWER(REPLACE(c.city, ' ', '-')) as id,
        c.city as name,
        c.state,
        CONCAT('/', LOWER(REPLACE(REPLACE($1, '.', ''), ' ', '-')), '/',
               LOWER(REPLACE(c.city, ' ', '-')), '-colleges') as slug,
        COUNT(DISTINCT c.college_id) as count
      FROM colleges c
      INNER JOIN courses co ON c.college_id = co.college_id
      WHERE co.degree_type = $1
        AND co.status = 'active'
        AND co.deleted_at IS NULL
        AND c.status = 'active'
        AND c.deleted_at IS NULL
        AND c.city IS NOT NULL
        AND c.city != ''
      GROUP BY c.city, c.state
      ORDER BY count DESC, c.city ASC
    `;

    // Get total college count
    const countQuery = `
      SELECT COUNT(DISTINCT co.college_id) as total
      FROM courses co
      INNER JOIN colleges c ON co.college_id = c.college_id
      WHERE co.degree_type = $1
        AND co.status = 'active'
        AND co.deleted_at IS NULL
        AND c.status = 'active'
        AND c.deleted_at IS NULL
    `;

    const [streamsResult, citiesResult, countResult] = await Promise.all([
      client.query(streamsQuery, [actualDegreeType]),
      client.query(citiesQuery, [actualDegreeType]),
      client.query(countQuery, [actualDegreeType]),
    ]);

    const streams = streamsResult.rows.map(row => ({
      id: row.id,
      name: row.name,
      slug: row.slug,
      count: parseInt(row.count),
    }));

    const cities = citiesResult.rows.map(row => ({
      id: row.id,
      name: row.name,
      state: row.state,
      slug: row.slug,
      count: parseInt(row.count),
    }));

    res.json({
      success: true,
      data: {
        id: degreeType.toLowerCase(),
        name: actualDegreeType,
        fullName: fullNameMap[actualDegreeType] || actualDegreeType,
        slug: `/${degreeType.toLowerCase()}-colleges`,
        collegeCount: parseInt(countResult.rows[0].total),
        streams,
        cities,
      },
    });

  } catch (error) {
    console.error('Error fetching course details:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch course details',
      error: error.message,
    });
  } finally {
    client.release();
  }
};

/**
 * @route GET /api/courses/study-goals
 * @desc Get study goal categories with college counts and courses for homepage
 * @access Public
 */
exports.getStudyGoals = async (req, res) => {
  const client = await pool.connect();

  try {
    // Get categories with college counts
    const categoriesQuery = `
      SELECT
        dc.category_id,
        dc.name,
        dc.slug,
        dc.icon,
        dc.display_order,
        COUNT(DISTINCT c.college_id) as college_count
      FROM degree_categories dc
      LEFT JOIN course_types_master ctm ON ctm.category = dc.name
      LEFT JOIN courses co ON co.degree_type = ctm.name AND co.status = 'active' AND co.deleted_at IS NULL
      LEFT JOIN colleges c ON co.college_id = c.college_id AND c.status = 'active' AND c.deleted_at IS NULL
      WHERE dc.status = 'active'
      GROUP BY dc.category_id, dc.name, dc.slug, dc.icon, dc.display_order
      ORDER BY dc.display_order ASC
    `;

    // Get courses grouped by category
    const coursesQuery = `
      SELECT
        ctm.category,
        ctm.name,
        ctm.slug,
        ctm.full_name,
        COUNT(DISTINCT c.college_id) as college_count
      FROM course_types_master ctm
      LEFT JOIN courses co ON co.degree_type = ctm.name AND co.status = 'active' AND co.deleted_at IS NULL
      LEFT JOIN colleges c ON co.college_id = c.college_id AND c.status = 'active' AND c.deleted_at IS NULL
      WHERE ctm.status = 'active'
      GROUP BY ctm.category, ctm.name, ctm.slug, ctm.full_name, ctm.display_order
      ORDER BY ctm.display_order ASC
    `;

    const [categoriesResult, coursesResult] = await Promise.all([
      client.query(categoriesQuery),
      client.query(coursesQuery),
    ]);

    // Group courses by category
    const coursesByCategory = {};
    coursesResult.rows.forEach(course => {
      if (!coursesByCategory[course.category]) {
        coursesByCategory[course.category] = [];
      }
      coursesByCategory[course.category].push({
        label: course.name,
        href: `/${course.slug}-colleges`,
        collegeCount: parseInt(course.college_count) || 0,
      });
    });

    // Build final response
    const studyGoals = categoriesResult.rows.map(cat => ({
      id: cat.slug,
      icon: cat.icon || 'folder',
      title: cat.name,
      collegeCount: parseInt(cat.college_count) || 0,
      courses: coursesByCategory[cat.name] || [],
      href: `/colleges?category=${cat.slug}`,
    }));

    res.json({
      success: true,
      data: studyGoals,
    });

  } catch (error) {
    console.error('Error fetching study goals:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch study goals',
      error: error.message,
    });
  } finally {
    client.release();
  }
};

/**
 * @route GET /api/courses/explore-programs
 * @desc Get data for Explore Programs section on homepage
 * @access Public
 */
exports.getExploreProgramsData = async (req, res) => {
  const client = await pool.connect();

  try {
    // Get program filter tabs from course_types_master
    const filtersQuery = `
      SELECT
        LOWER(REPLACE(REPLACE(ctm.name, '.', ''), ' ', '-')) as value,
        ctm.name as label,
        ctm.display_order
      FROM course_types_master ctm
      WHERE ctm.status = 'active'
      ORDER BY ctm.display_order ASC
      LIMIT 12
    `;

    // Get course counts by type
    const courseCountsQuery = `
      SELECT
        co.degree_type as name,
        LOWER(REPLACE(REPLACE(co.degree_type, '.', ''), ' ', '-')) as slug,
        COUNT(DISTINCT co.college_id) as count
      FROM courses co
      INNER JOIN colleges c ON co.college_id = c.college_id
      WHERE co.status = 'active'
        AND co.deleted_at IS NULL
        AND c.status = 'active'
        AND c.deleted_at IS NULL
      GROUP BY co.degree_type
      ORDER BY count DESC
      LIMIT 6
    `;

    // Get popular exams
    const examsQuery = `
      SELECT
        exam_id,
        exam_name,
        slug,
        short_name,
        exam_category
      FROM exams
      WHERE is_active = true
        AND deleted_at IS NULL
      ORDER BY exam_id ASC
      LIMIT 8
    `;

    // Get ranking agencies with college counts
    const rankingsQuery = `
      SELECT
        ra.agency_id,
        ra.agency_name,
        ra.agency_code,
        COUNT(DISTINCT cr.college_id) as college_count
      FROM ranking_agencies ra
      LEFT JOIN college_rankings cr ON ra.agency_id = cr.agency_id
      WHERE ra.is_active = true
      GROUP BY ra.agency_id, ra.agency_name, ra.agency_code
      ORDER BY college_count DESC
      LIMIT 4
    `;

    // Get total colleges count
    const totalCollegesQuery = `
      SELECT COUNT(*) as total
      FROM colleges
      WHERE status = 'active' AND deleted_at IS NULL
    `;

    const [filtersResult, courseCountsResult, examsResult, rankingsResult, totalCollegesResult] = await Promise.all([
      client.query(filtersQuery),
      client.query(courseCountsQuery),
      client.query(examsQuery),
      client.query(rankingsQuery),
      client.query(totalCollegesQuery),
    ]);

    // Build filter tabs with "All" first
    const filters = [
      { value: 'all', label: 'All' },
      ...filtersResult.rows.map(row => ({
        value: row.value,
        label: row.label,
      })),
    ];

    // Build courses for Course Finder card
    const courseCounts = courseCountsResult.rows.map(row => ({
      name: row.name,
      slug: row.slug,
      count: parseInt(row.count),
    }));

    // Build exams list
    const exams = examsResult.rows.map(row => ({
      id: row.exam_id,
      name: row.exam_name,
      shortName: row.short_name,
      slug: row.slug,
      category: row.exam_category,
    }));

    // Build rankings list
    const rankings = rankingsResult.rows.map(row => ({
      id: row.agency_id,
      name: row.agency_name,
      code: row.agency_code,
      collegeCount: parseInt(row.college_count) || 0,
    }));

    // College predictor exams (subset)
    const predictorExams = exams
      .filter(e => ['jee-main', 'jee-advanced', 'neet-ug', 'cat', 'gate'].includes(e.slug))
      .slice(0, 4);

    res.json({
      success: true,
      data: {
        filters,
        courseCounts,
        exams,
        rankings,
        predictorExams,
        totalColleges: parseInt(totalCollegesResult.rows[0].total),
      },
    });

  } catch (error) {
    console.error('Error fetching explore programs data:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to fetch explore programs data',
      error: error.message,
    });
  } finally {
    client.release();
  }
};

/**
 * @route GET /api/courses/quick-tabs
 * @desc Get quick tabs for the secondary navigation (from admin-managed settings)
 * @access Public
 */
exports.getQuickTabs = async (req, res) => {
  const client = await pool.connect();

  try {
    // Get quick tabs from the admin-managed quick_tabs table
    const query = `
      SELECT
        LOWER(REPLACE(REPLACE(qt.degree_type, '.', ''), ' ', '-')) as id,
        qt.display_name as name,
        qt.slug
      FROM quick_tabs qt
      WHERE qt.is_active = true
      ORDER BY qt.display_order ASC
    `;

    const result = await client.query(query);

    const tabs = result.rows.map(row => ({
      id: row.id,
      name: row.name,
      slug: row.slug,
    }));

    res.json({
      success: true,
      data: tabs,
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
