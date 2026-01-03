const express = require('express');
const router = express.Router();
const adminCourseTypesController = require('../../controllers/admin/adminCourseTypesController');
const { authenticateAdmin } = require('../../middleware/admin/adminAuth');

// All routes require admin authentication
router.use(authenticateAdmin);

// Category management routes (must be before /:id routes)
router.get('/categories', adminCourseTypesController.getCategories);
router.get('/categories/all', adminCourseTypesController.getAllCategories);
router.post('/categories', adminCourseTypesController.createCategory);
router.put('/categories/:id', adminCourseTypesController.updateCategory);
router.delete('/categories/:id', adminCourseTypesController.deleteCategory);

// Reorder course types
router.post('/reorder', adminCourseTypesController.reorderCourseTypes);

// CRUD operations for degree types
router.get('/', adminCourseTypesController.getAllCourseTypes);
router.get('/:id', adminCourseTypesController.getCourseTypeById);
router.post('/', adminCourseTypesController.createCourseType);
router.put('/:id', adminCourseTypesController.updateCourseType);
router.delete('/:id', adminCourseTypesController.deleteCourseType);

module.exports = router;
