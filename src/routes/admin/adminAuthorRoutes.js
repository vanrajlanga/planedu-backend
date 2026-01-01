const express = require('express');
const router = express.Router();
const {
  upload,
  getAuthors,
  getAuthorById,
  createAuthor,
  updateAuthor,
  deleteAuthor,
  uploadAuthorImage,
  getAuthorsList,
} = require('../../controllers/admin/adminAuthorController');
const { authenticateAdmin } = require('../../middleware/admin/adminAuth');

// All author routes require admin authentication
router.use(authenticateAdmin);

// Get all authors with pagination
router.get('/', getAuthors);

// Get simple list for dropdowns (must come before /:id)
router.get('/list', getAuthorsList);

// Upload author image
router.post('/upload', upload.single('image'), uploadAuthorImage);

// Get single author
router.get('/:id', getAuthorById);

// Create new author (with optional image upload)
router.post('/', upload.single('image'), createAuthor);

// Update author (with optional image upload)
router.put('/:id', upload.single('image'), updateAuthor);

// Delete author
router.delete('/:id', deleteAuthor);

module.exports = router;
