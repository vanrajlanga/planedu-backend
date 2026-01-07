const express = require('express');
const router = express.Router();
const brochureController = require('../../controllers/public/brochureController');
const { optionalAuth } = require('../../middleware/auth');

// Download brochure (tracks download and returns URL)
router.post('/download', optionalAuth, brochureController.downloadBrochure);

// Get download stats for a college
router.get('/stats/:college_id', brochureController.getBrochureStats);

module.exports = router;
