const express = require('express');
const router = express.Router();
const publicCourseController = require('../../controllers/public/publicCourseController');

// Public course routes for the courses menu
router.get('/courses/menu', publicCourseController.getCoursesMenu);
router.get('/courses/quick-tabs', publicCourseController.getQuickTabs);
router.get('/courses/study-goals', publicCourseController.getStudyGoals);
router.get('/courses/explore-programs', publicCourseController.getExploreProgramsData);
router.get('/courses/:degreeType/details', publicCourseController.getCourseDetails);
router.get('/courses/:degreeType/streams', publicCourseController.getCourseStreams);
router.get('/courses/:degreeType/cities', publicCourseController.getCourseCities);

module.exports = router;
