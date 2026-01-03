const express = require('express');
const router = express.Router();
const publicCollegeController = require('../../controllers/public/publicCollegeController');

// Public college routes
router.get('/colleges', publicCollegeController.getColleges);
router.get('/colleges/top', publicCollegeController.getTopColleges);
router.get('/colleges/filter-options', publicCollegeController.getFilterOptions);

// Course-specific college listing routes (must be before :slug to avoid conflict)
router.get('/colleges/by-course/:courseType', publicCollegeController.getCollegesByCourse);
router.get('/colleges/filter-options/:courseType', publicCollegeController.getFilterOptionsByCourse);

// Course page content route
router.get('/courses/:courseType/content', publicCollegeController.getCoursePageContent);

// Course location content route (for city/state specific pages)
router.get('/courses/:courseType/location/:locationSlug/content', publicCollegeController.getCourseLocationContent);

// College detail route (keep at end as it catches all slugs)
router.get('/colleges/:slug', publicCollegeController.getCollegeBySlug);

module.exports = router;
