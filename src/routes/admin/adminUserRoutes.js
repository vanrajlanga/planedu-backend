const express = require('express');
const router = express.Router();
const {
  getUsers,
  getUserById,
  updateUser,
  updateUserStatus,
  deleteUser,
  bulkUpdateStatus,
  exportUsers,
  getAllRoles,
  assignUserRole,
  removeUserRole,
  getUserActivity,
  initiatePasswordReset,
} = require('../../controllers/admin/adminUserController');
const { authenticateAdmin } = require('../../middleware/admin/adminAuth');

// All user management routes require admin authentication
router.use(authenticateAdmin);

// List users with pagination, search, filtering
router.get('/', getUsers);

// Export users to CSV (must come before /:id)
router.get('/export', exportUsers);

// Get all available roles (must come before /:id)
router.get('/roles', getAllRoles);

// Bulk update user status (must come before /:id)
router.post('/bulk-status', bulkUpdateStatus);

// Get single user
router.get('/:id', getUserById);

// Update user
router.put('/:id', updateUser);

// Update user status
router.put('/:id/status', updateUserStatus);

// Delete user (soft delete)
router.delete('/:id', deleteUser);

// Get user activity logs
router.get('/:id/activity', getUserActivity);

// Initiate password reset
router.post('/:id/reset-password', initiatePasswordReset);

// Assign role to user
router.post('/:id/roles', assignUserRole);

// Remove role from user
router.delete('/:id/roles/:roleId', removeUserRole);

module.exports = router;
