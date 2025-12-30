const express = require('express');
const router = express.Router();
const {
  getNewsArticles,
  getNewsArticleById,
  createNewsArticle,
  updateNewsArticle,
  deleteNewsArticle,
  getNewsCategories,
  bulkUpdateStatus,
  getNewsStats,
} = require('../../controllers/admin/adminNewsController');
const { authenticateAdmin } = require('../../middleware/admin/adminAuth');

// All news routes require admin authentication
router.use(authenticateAdmin);

// Get all news articles with pagination and filters
router.get('/', getNewsArticles);

// Get news categories (must come before /:id)
router.get('/categories', getNewsCategories);

// Get news statistics (must come before /:id)
router.get('/stats', getNewsStats);

// Bulk update status
router.post('/bulk-status', bulkUpdateStatus);

// Get single news article
router.get('/:id', getNewsArticleById);

// Create new news article
router.post('/', createNewsArticle);

// Update news article
router.put('/:id', updateNewsArticle);

// Delete news article
router.delete('/:id', deleteNewsArticle);

module.exports = router;
