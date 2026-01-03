const express = require('express');
const router = express.Router();
const quickTabsController = require('../../controllers/admin/adminQuickTabsController');
const { authenticateAdmin } = require('../../middleware/admin/adminAuth');

// All routes require admin authentication
router.use(authenticateAdmin);

// Get all quick tabs
router.get('/', quickTabsController.getQuickTabs);

// Get available degree types (not yet in quick tabs)
router.get('/available', quickTabsController.getAvailableDegreeTypes);

// Create a new quick tab
router.post('/', quickTabsController.createQuickTab);

// Update a quick tab
router.put('/:id', quickTabsController.updateQuickTab);

// Reorder quick tabs
router.put('/reorder', quickTabsController.reorderQuickTabs);

// Toggle quick tab active status
router.put('/:id/toggle', quickTabsController.toggleQuickTab);

// Delete a quick tab
router.delete('/:id', quickTabsController.deleteQuickTab);

module.exports = router;
