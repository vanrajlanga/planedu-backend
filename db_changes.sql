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
