-- ============================================================
-- Database Changes Log for PlanEdu
-- ============================================================

-- ============================================================
-- 2026-01-05: Remove Authors Module - Use Admin Users as Authors
-- ============================================================
-- The content_authors table is being deprecated. Instead of a separate
-- authors table, the logged-in admin user (from admin_users table) is
-- automatically assigned as the content author when saving.
--
-- IMPORTANT: The author_id columns in content tables now reference
-- admin_users.admin_id instead of content_authors.id
-- ============================================================

-- Step 1: Update existing content to migrate author_id from content_authors to admin_users
-- (Run this BEFORE dropping the content_authors table if you want to preserve author data)

-- Migrate college_content author_id to use admin_users
-- First, set all existing author_id to a default admin (e.g., admin_id = 1 for Super Admin)
UPDATE college_content SET author_id = 1 WHERE author_id IS NOT NULL;

-- Migrate course_page_content author_id
UPDATE course_page_content SET author_id = 1 WHERE author_id IS NOT NULL;

-- Migrate course_location_content author_id
UPDATE course_location_content SET author_id = 1 WHERE author_id IS NOT NULL;

-- Migrate degree_type_content author_id (if exists)
UPDATE degree_type_content SET author_id = 1 WHERE author_id IS NOT NULL;

-- Step 2: Drop the content_authors table (OPTIONAL - only if you want to fully remove it)
-- WARNING: This is irreversible. Make sure all migrations are complete first.

-- DROP TABLE IF EXISTS content_authors CASCADE;

-- Step 3: Update foreign key constraints (OPTIONAL)
-- If you want to enforce referential integrity with admin_users

-- For college_content
-- ALTER TABLE college_content DROP CONSTRAINT IF EXISTS college_content_author_id_fkey;
-- ALTER TABLE college_content ADD CONSTRAINT college_content_author_id_fkey
--   FOREIGN KEY (author_id) REFERENCES admin_users(admin_id) ON DELETE SET NULL;

-- For course_page_content
-- ALTER TABLE course_page_content DROP CONSTRAINT IF EXISTS course_page_content_author_id_fkey;
-- ALTER TABLE course_page_content ADD CONSTRAINT course_page_content_author_id_fkey
--   FOREIGN KEY (author_id) REFERENCES admin_users(admin_id) ON DELETE SET NULL;

-- For course_location_content
-- ALTER TABLE course_location_content DROP CONSTRAINT IF EXISTS course_location_content_author_id_fkey;
-- ALTER TABLE course_location_content ADD CONSTRAINT course_location_content_author_id_fkey
--   FOREIGN KEY (author_id) REFERENCES admin_users(admin_id) ON DELETE SET NULL;

-- ============================================================
-- Summary of Code Changes Made:
-- ============================================================
--
-- Backend Controllers Updated (content_authors -> admin_users):
-- 1. adminContentController.js - All SQL JOINs updated
-- 2. adminCoursePageContentController.js - getAllCoursePageContent, getCoursePageContentByType
-- 3. courseLocationContentController.js - getAll, getOne
-- 4. publicCollegeController.js - getCoursePageContent, getCourseLocationContent
--
-- Frontend Files Updated (currentUser?.id -> currentUser?.admin_id):
-- 1. app/colleges/[id]/content/page.js
-- 2. app/components/SectionContentEditor.js
-- 3. app/course-content/page.js
-- 4. app/degree-types/page.js
-- 5. app/location-content/page.js
--
-- SQL JOIN Changes:
-- Before: LEFT JOIN content_authors ca ON [table].author_id = ca.id
-- After:  LEFT JOIN admin_users au ON [table].author_id = au.admin_id
--
-- Column Mapping:
-- ca.name -> au.name
-- ca.designation -> au.role
-- ca.profile_image_url -> NULL (admin_users doesn't have profile images)
-- ca.is_verified -> true (all admins are verified)
-- ============================================================

-- ============================================================
-- 2026-01-06: Frontend User Authentication (OTP-based)
-- ============================================================
-- Make email column nullable to support phone-only registration.
-- Users can now register/login with just their phone number.
-- OTP is sent to the phone and verified for authentication.
-- ============================================================

-- Make email nullable for phone-only registration
ALTER TABLE users ALTER COLUMN email DROP NOT NULL;

-- ============================================================
-- Summary of Authentication Implementation:
-- ============================================================
--
-- Backend Changes:
-- 1. authValidator.js - Made city and course fields optional
-- 2. authController.js - Register/Login with phone, OTP generation
-- 3. authRoutes.js - /register, /verify-otp, /resend-otp, /me, /logout
--
-- Frontend Changes:
-- 1. context/AuthContext.jsx - Global auth state management
-- 2. components/auth/AuthModal.jsx - Login modal with OTP flow
-- 3. components/auth/UserDropdown.jsx - User menu after login
-- 4. components/layout/Header.jsx - Conditional login/user display
--
-- Auth Flow:
-- 1. User enters phone number -> POST /api/v1/auth/register
-- 2. Backend generates 6-digit OTP (logged in dev, SMS in prod)
-- 3. User enters OTP -> POST /api/v1/auth/verify-otp
-- 4. Backend returns JWT token + user data
-- 5. Frontend stores token in localStorage as 'auth_token'
-- 6. Subsequent requests include Authorization: Bearer <token>
-- ============================================================
