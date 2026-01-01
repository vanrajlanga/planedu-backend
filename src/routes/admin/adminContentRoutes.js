const express = require('express');
const router = express.Router({ mergeParams: true }); // Important: mergeParams to access :collegeId from parent router
const {
  getAllContent,
  getContentSection,
  upsertContentSection,
  getSectionTypes,
} = require('../../controllers/admin/adminContentController');
const { authenticateAdmin } = require('../../middleware/admin/adminAuth');

// All content routes require admin authentication
router.use(authenticateAdmin);

// Get valid section types (standalone route, not nested)
// This will be mounted at /api/v1/admin/content/sections
router.get('/sections', getSectionTypes);

// Get all content sections for a college
// GET /api/v1/admin/colleges/:collegeId/content
router.get('/', getAllContent);

// Get specific section content
// GET /api/v1/admin/colleges/:collegeId/content/:section
router.get('/:section', getContentSection);

// Update/create section content
// PUT /api/v1/admin/colleges/:collegeId/content/:section
router.put('/:section', upsertContentSection);

module.exports = router;
