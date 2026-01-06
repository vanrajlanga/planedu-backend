const express = require('express');
const router = express.Router();
const { authenticate } = require('../middleware/auth');
const userController = require('../controllers/userController');

// All routes require authentication
router.use(authenticate);

// Dashboard stats
router.get('/stats', userController.getStats);

// Applications
router.get('/applications', userController.getApplications);
router.post('/applications', userController.createApplication);

// Favorites
router.get('/favorites', userController.getFavorites);
router.post('/favorites', userController.addFavorite);
router.delete('/favorites', userController.removeFavorite);

// Reviews
router.get('/reviews', userController.getReviews);

module.exports = router;
