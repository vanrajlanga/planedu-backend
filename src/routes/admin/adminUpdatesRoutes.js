const express = require('express');
const router = express.Router({ mergeParams: true }); // Important: mergeParams to access :collegeId from parent router
const {
  getUpdates,
  getUpdateById,
  createUpdate,
  updateUpdate,
  deleteUpdate,
  togglePin,
} = require('../../controllers/admin/adminUpdatesController');
const { authenticateAdmin } = require('../../middleware/admin/adminAuth');

// All updates routes require admin authentication
router.use(authenticateAdmin);

// Get all updates for a college
// GET /api/v1/admin/colleges/:collegeId/updates
router.get('/', getUpdates);

// Get single update
// GET /api/v1/admin/colleges/:collegeId/updates/:id
router.get('/:id', getUpdateById);

// Create new update
// POST /api/v1/admin/colleges/:collegeId/updates
router.post('/', createUpdate);

// Update existing update
// PUT /api/v1/admin/colleges/:collegeId/updates/:id
router.put('/:id', updateUpdate);

// Toggle pin status
// PUT /api/v1/admin/colleges/:collegeId/updates/:id/pin
router.put('/:id/pin', togglePin);

// Delete update
// DELETE /api/v1/admin/colleges/:collegeId/updates/:id
router.delete('/:id', deleteUpdate);

module.exports = router;
