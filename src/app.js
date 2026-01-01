const express = require('express');
const cors = require('cors');
const helmet = require('helmet');
const morgan = require('morgan');
const path = require('path');
require('dotenv').config();

const { errorHandler, notFoundHandler } = require('./middleware/errorHandler');

// Import routes
const authRoutes = require('./routes/authRoutes');
const collegeRoutes = require('./routes/collegeRoutes');

// Import public routes
const publicCollegeRoutes = require('./routes/public/publicCollegeRoutes');

// Import admin routes
const adminAuthRoutes = require('./routes/admin/adminAuthRoutes');
const adminDashboardRoutes = require('./routes/admin/adminDashboardRoutes');
const adminUserRoutes = require('./routes/admin/adminUserRoutes');
const adminCollegeRoutes = require('./routes/admin/adminCollegeRoutes');
const adminCourseRoutes = require('./routes/admin/adminCourseRoutes');
const adminExamRoutes = require('./routes/admin/adminExamRoutes');
const adminScholarshipRoutes = require('./routes/admin/adminScholarshipRoutes');
const adminPlacementRoutes = require('./routes/admin/adminPlacementRoutes');
const adminReviewRoutes = require('./routes/admin/adminReviewRoutes');
const adminFaqRoutes = require('./routes/admin/adminFaqRoutes');
const adminNewsRoutes = require('./routes/admin/adminNewsRoutes');
const adminBannerRoutes = require('./routes/admin/adminBannerRoutes');
const adminUploadRoutes = require('./routes/admin/uploadRoutes');
const adminSettingsRoutes = require('./routes/admin/adminSettingsRoutes');

// New CMS routes
const adminAuthorRoutes = require('./routes/admin/adminAuthorRoutes');
const adminContentRoutes = require('./routes/admin/adminContentRoutes');
const adminUpdatesRoutes = require('./routes/admin/adminUpdatesRoutes');
const adminCutoffRoutes = require('./routes/admin/adminCutoffRoutes');
const adminRankingRoutes = require('./routes/admin/adminRankingRoutes');
const adminHostelRoutes = require('./routes/admin/adminHostelRoutes');
const adminFacultyRoutes = require('./routes/admin/adminFacultyRoutes');
const adminRecruiterRoutes = require('./routes/admin/adminRecruiterRoutes');
const adminGalleryRoutes = require('./routes/admin/adminGalleryRoutes');

const app = express();

// Security middleware
app.use(helmet());

// CORS configuration - Allow all origins
app.use(cors({
  origin: true,
  credentials: true
}));

// Body parser middleware
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Logging middleware
if (process.env.NODE_ENV !== 'production') {
  app.use(morgan('dev'));
} else {
  app.use(morgan('combined'));
}

// Serve uploaded files
app.use('/uploads', express.static(path.join(__dirname, '../uploads')));

// Health check endpoint
app.get('/health', (req, res) => {
  res.status(200).json({
    status: 'OK',
    message: 'PlanEdu API is running',
    timestamp: new Date().toISOString(),
    environment: process.env.NODE_ENV || 'development'
  });
});

// API Routes
app.use('/api/v1/auth', authRoutes);
app.use('/api/v1/colleges', collegeRoutes);

// Public API Routes
app.use('/api', publicCollegeRoutes);

// Admin API Routes
app.use('/api/v1/admin/auth', adminAuthRoutes);
app.use('/api/v1/admin/dashboard', adminDashboardRoutes);
app.use('/api/v1/admin/users', adminUserRoutes);
app.use('/api/v1/admin/colleges', adminCollegeRoutes);
app.use('/api/v1/admin', adminCourseRoutes);
app.use('/api/v1/admin', adminExamRoutes);
app.use('/api/v1/admin', adminScholarshipRoutes);
app.use('/api/v1/admin', adminPlacementRoutes);
app.use('/api/v1/admin', adminReviewRoutes);
app.use('/api/v1/admin/faqs', adminFaqRoutes);
app.use('/api/v1/admin/news', adminNewsRoutes);
app.use('/api/v1/admin/banners', adminBannerRoutes);
app.use('/api/v1/admin/upload', adminUploadRoutes);
app.use('/api/v1/admin/settings', adminSettingsRoutes);

// CMS Routes
app.use('/api/v1/admin/authors', adminAuthorRoutes);
app.use('/api/v1/admin/colleges/:collegeId/content', adminContentRoutes);
app.use('/api/v1/admin/colleges/:collegeId/updates', adminUpdatesRoutes);
app.use('/api/v1/admin/colleges/:collegeId/cutoffs', adminCutoffRoutes);
app.use('/api/v1/admin/colleges/:collegeId/rankings', adminRankingRoutes);
app.use('/api/v1/admin/colleges/:collegeId/hostels', adminHostelRoutes);
app.use('/api/v1/admin/colleges/:collegeId/faculty', adminFacultyRoutes);
app.use('/api/v1/admin/colleges/:collegeId/gallery', adminGalleryRoutes);
app.use('/api/v1/admin/placements', adminRecruiterRoutes);
// Standalone content sections endpoint
app.use('/api/v1/admin/content', adminContentRoutes);

// 404 handler
app.use(notFoundHandler);

// Global error handler
app.use(errorHandler);

module.exports = app;
