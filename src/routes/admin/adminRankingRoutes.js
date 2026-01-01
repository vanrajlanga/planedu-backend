const express = require('express');
const router = express.Router({ mergeParams: true });
const adminRankingController = require('../../controllers/admin/adminRankingController');

// Routes for college-specific rankings
// Base path: /api/v1/admin/colleges/:collegeId/rankings

// Get all rankings for a college
router.get('/', adminRankingController.getRankingsByCollege);

// Get filter options (years, agencies)
router.get('/filters', adminRankingController.getFilterOptions);

// Get a single ranking
router.get('/:id', adminRankingController.getRanking);

// Create a new ranking
router.post('/', adminRankingController.createRanking);

// Bulk create rankings
router.post('/bulk', adminRankingController.bulkCreateRankings);

// Update a ranking
router.put('/:id', adminRankingController.updateRanking);

// Delete a ranking
router.delete('/:id', adminRankingController.deleteRanking);

module.exports = router;
