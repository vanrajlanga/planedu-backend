-- Migration: Remove unused fields from course_page_content table
-- These fields are now handled via the full_content rich text editor
-- Run this migration after confirming the simplified system works

-- Drop unused columns
ALTER TABLE course_page_content DROP COLUMN IF EXISTS intro_text;
ALTER TABLE course_page_content DROP COLUMN IF EXISTS key_points;
ALTER TABLE course_page_content DROP COLUMN IF EXISTS table_of_contents;
ALTER TABLE course_page_content DROP COLUMN IF EXISTS highlights_data;

-- Add comment for documentation
COMMENT ON TABLE course_page_content IS 'Course page content managed via admin rich text editor. Only uses full_content for all content.';
