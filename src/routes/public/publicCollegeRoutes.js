const express = require('express');
const router = express.Router();
const publicCollegeController = require('../../controllers/public/publicCollegeController');

// Public college routes
router.get('/colleges', publicCollegeController.getColleges);
router.get('/colleges/filter-options', publicCollegeController.getFilterOptions);
router.get('/colleges/:slug', publicCollegeController.getCollegeBySlug);

module.exports = router;
