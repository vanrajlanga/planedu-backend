const express = require('express');
const router = express.Router();
const {
  getFaqs,
  getFaqById,
  createFaq,
  updateFaq,
  deleteFaq,
  getFaqCategories,
  reorderFaqs,
} = require('../../controllers/admin/adminFaqController');
const { authenticateAdmin } = require('../../middleware/admin/adminAuth');

// All FAQ routes require admin authentication
router.use(authenticateAdmin);

// Get all FAQs with pagination and filters
router.get('/', getFaqs);

// Get FAQ categories (must come before /:id)
router.get('/categories', getFaqCategories);

// Reorder FAQs
router.post('/reorder', reorderFaqs);

// Get single FAQ
router.get('/:id', getFaqById);

// Create new FAQ
router.post('/', createFaq);

// Update FAQ
router.put('/:id', updateFaq);

// Delete FAQ
router.delete('/:id', deleteFaq);

module.exports = router;
