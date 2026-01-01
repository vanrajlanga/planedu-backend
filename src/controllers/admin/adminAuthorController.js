const multer = require('multer');
const path = require('path');
const fs = require('fs');
const { query, getClient } = require('../../config/database');
const ApiResponse = require('../../utils/response');

// Configure storage for author profile images
const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    const uploadPath = path.join(__dirname, '../../../uploads/authors');
    if (!fs.existsSync(uploadPath)) {
      fs.mkdirSync(uploadPath, { recursive: true });
    }
    cb(null, uploadPath);
  },
  filename: function (req, file, cb) {
    const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
    cb(null, 'author-' + uniqueSuffix + path.extname(file.originalname));
  }
});

const fileFilter = (req, file, cb) => {
  const allowedTypes = /jpeg|jpg|png|gif|webp/;
  const extname = allowedTypes.test(path.extname(file.originalname).toLowerCase());
  const mimetype = allowedTypes.test(file.mimetype);
  if (mimetype && extname) {
    return cb(null, true);
  } else {
    cb(new Error('Only image files are allowed (jpeg, jpg, png, gif, webp)'));
  }
};

const upload = multer({
  storage: storage,
  limits: { fileSize: 2 * 1024 * 1024 }, // 2MB limit
  fileFilter: fileFilter
});

/**
 * Generate slug from name
 */
const generateSlug = (name) => {
  return name
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-+|-+$/g, '');
};

/**
 * Get all authors with pagination and filters
 * GET /api/v1/admin/authors
 */
const getAuthors = async (req, res, next) => {
  try {
    const page = parseInt(req.query.page) || 1;
    const limit = Math.min(parseInt(req.query.limit) || 25, 100);
    const offset = (page - 1) * limit;
    const search = req.query.search?.trim() || '';
    const status = req.query.status || '';

    const conditions = [];
    const params = [];
    let paramIndex = 1;

    if (search) {
      conditions.push(`(name ILIKE $${paramIndex} OR email ILIKE $${paramIndex} OR designation ILIKE $${paramIndex})`);
      params.push(`%${search}%`);
      paramIndex++;
    }

    if (status) {
      conditions.push(`status = $${paramIndex}`);
      params.push(status);
      paramIndex++;
    }

    const whereClause = conditions.length > 0 ? `WHERE ${conditions.join(' AND ')}` : '';

    // Get total count
    const countQuery = `SELECT COUNT(*) as total FROM content_authors ${whereClause}`;
    const countResult = await query(countQuery, params);
    const total = parseInt(countResult.rows[0].total);

    // Get authors
    const authorsQuery = `
      SELECT *
      FROM content_authors
      ${whereClause}
      ORDER BY created_at DESC
      LIMIT $${paramIndex} OFFSET $${paramIndex + 1}
    `;
    params.push(limit, offset);

    const authorsResult = await query(authorsQuery, params);

    return ApiResponse.success(res, {
      authors: authorsResult.rows,
      pagination: {
        page,
        limit,
        total,
        totalPages: Math.ceil(total / limit),
        hasNext: page < Math.ceil(total / limit),
        hasPrev: page > 1,
      }
    }, 'Authors retrieved successfully');
  } catch (error) {
    console.error('Get authors error:', error);
    next(error);
  }
};

/**
 * Get single author by ID
 * GET /api/v1/admin/authors/:id
 */
const getAuthorById = async (req, res, next) => {
  try {
    const { id } = req.params;
    const result = await query('SELECT * FROM content_authors WHERE id = $1', [id]);

    if (result.rows.length === 0) {
      return ApiResponse.error(res, 'Author not found', 404);
    }

    return ApiResponse.success(res, result.rows[0], 'Author retrieved successfully');
  } catch (error) {
    console.error('Get author error:', error);
    next(error);
  }
};

/**
 * Create new author
 * POST /api/v1/admin/authors
 */
const createAuthor = async (req, res, next) => {
  try {
    const { name, email, designation, bio, is_verified, status } = req.body;

    if (!name) {
      return ApiResponse.error(res, 'Name is required', 400);
    }

    // Generate slug
    let slug = generateSlug(name);

    // Check if slug exists and make it unique
    const slugCheck = await query('SELECT id FROM content_authors WHERE slug = $1', [slug]);
    if (slugCheck.rows.length > 0) {
      slug = `${slug}-${Date.now()}`;
    }

    // Get profile image URL if uploaded
    const profile_image_url = req.file ? `/uploads/authors/${req.file.filename}` : null;

    const insertQuery = `
      INSERT INTO content_authors (name, slug, email, profile_image_url, designation, bio, is_verified, status)
      VALUES ($1, $2, $3, $4, $5, $6, $7, $8)
      RETURNING *
    `;

    const result = await query(insertQuery, [
      name,
      slug,
      email || null,
      profile_image_url,
      designation || 'Content Writer',
      bio || null,
      is_verified === 'true' || is_verified === true,
      status || 'active'
    ]);

    return ApiResponse.success(res, result.rows[0], 'Author created successfully', 201);
  } catch (error) {
    console.error('Create author error:', error);
    next(error);
  }
};

/**
 * Update author
 * PUT /api/v1/admin/authors/:id
 */
const updateAuthor = async (req, res, next) => {
  try {
    const { id } = req.params;
    const { name, email, designation, bio, is_verified, status } = req.body;

    // Check if author exists
    const checkResult = await query('SELECT * FROM content_authors WHERE id = $1', [id]);
    if (checkResult.rows.length === 0) {
      return ApiResponse.error(res, 'Author not found', 404);
    }

    const existingAuthor = checkResult.rows[0];

    // Generate new slug if name changed
    let slug = existingAuthor.slug;
    if (name && name !== existingAuthor.name) {
      slug = generateSlug(name);
      const slugCheck = await query('SELECT id FROM content_authors WHERE slug = $1 AND id != $2', [slug, id]);
      if (slugCheck.rows.length > 0) {
        slug = `${slug}-${Date.now()}`;
      }
    }

    // Handle profile image
    let profile_image_url = existingAuthor.profile_image_url;
    if (req.file) {
      // Delete old image if exists
      if (existingAuthor.profile_image_url) {
        const oldPath = path.join(__dirname, '../../../', existingAuthor.profile_image_url);
        if (fs.existsSync(oldPath)) {
          fs.unlinkSync(oldPath);
        }
      }
      profile_image_url = `/uploads/authors/${req.file.filename}`;
    }

    const updateQuery = `
      UPDATE content_authors
      SET name = $1, slug = $2, email = $3, profile_image_url = $4,
          designation = $5, bio = $6, is_verified = $7, status = $8
      WHERE id = $9
      RETURNING *
    `;

    const result = await query(updateQuery, [
      name || existingAuthor.name,
      slug,
      email !== undefined ? email : existingAuthor.email,
      profile_image_url,
      designation || existingAuthor.designation,
      bio !== undefined ? bio : existingAuthor.bio,
      is_verified !== undefined ? (is_verified === 'true' || is_verified === true) : existingAuthor.is_verified,
      status || existingAuthor.status,
      id
    ]);

    return ApiResponse.success(res, result.rows[0], 'Author updated successfully');
  } catch (error) {
    console.error('Update author error:', error);
    next(error);
  }
};

/**
 * Delete author
 * DELETE /api/v1/admin/authors/:id
 */
const deleteAuthor = async (req, res, next) => {
  try {
    const { id } = req.params;

    // Get author to check for profile image
    const authorResult = await query('SELECT * FROM content_authors WHERE id = $1', [id]);
    if (authorResult.rows.length === 0) {
      return ApiResponse.error(res, 'Author not found', 404);
    }

    const author = authorResult.rows[0];

    // Delete profile image if exists
    if (author.profile_image_url) {
      const imagePath = path.join(__dirname, '../../../', author.profile_image_url);
      if (fs.existsSync(imagePath)) {
        fs.unlinkSync(imagePath);
      }
    }

    // Delete author
    await query('DELETE FROM content_authors WHERE id = $1', [id]);

    return ApiResponse.success(res, { id }, 'Author deleted successfully');
  } catch (error) {
    console.error('Delete author error:', error);
    next(error);
  }
};

/**
 * Upload author profile image
 * POST /api/v1/admin/authors/upload
 */
const uploadAuthorImage = async (req, res, next) => {
  try {
    if (!req.file) {
      return ApiResponse.error(res, 'No file uploaded', 400);
    }

    const fileUrl = `/uploads/authors/${req.file.filename}`;

    return ApiResponse.success(res, {
      filename: req.file.filename,
      originalName: req.file.originalname,
      size: req.file.size,
      url: fileUrl
    }, 'Image uploaded successfully', 201);
  } catch (error) {
    console.error('Upload error:', error);
    next(error);
  }
};

/**
 * Get all authors (simple list for dropdowns)
 * GET /api/v1/admin/authors/list
 */
const getAuthorsList = async (req, res, next) => {
  try {
    const result = await query(
      'SELECT id, name, designation, profile_image_url FROM content_authors WHERE status = $1 ORDER BY name ASC',
      ['active']
    );

    return ApiResponse.success(res, result.rows, 'Authors list retrieved successfully');
  } catch (error) {
    console.error('Get authors list error:', error);
    next(error);
  }
};

module.exports = {
  upload,
  getAuthors,
  getAuthorById,
  createAuthor,
  updateAuthor,
  deleteAuthor,
  uploadAuthorImage,
  getAuthorsList,
};
