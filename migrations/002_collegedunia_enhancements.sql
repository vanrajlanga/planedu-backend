-- Migration: 002_collegedunia_enhancements.sql
-- Description: Add enhancements inspired by Collegedunia comparison
-- Date: 2025-12-30

-- 1. Faculty phone field
ALTER TABLE faculty_members ADD COLUMN IF NOT EXISTS phone VARCHAR(50);

-- 2. Hostel photos (JSONB array of photo objects)
ALTER TABLE hostels ADD COLUMN IF NOT EXISTS photos JSONB DEFAULT '[]';

-- 3. College gallery table
CREATE TABLE IF NOT EXISTS college_gallery (
  id SERIAL PRIMARY KEY,
  college_id BIGINT REFERENCES colleges(college_id) ON DELETE CASCADE,
  category VARCHAR(50) NOT NULL, -- 'campus', 'hostel', 'facilities', 'events'
  image_url TEXT NOT NULL,
  caption VARCHAR(255),
  display_order INT DEFAULT 0,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create index for efficient queries
CREATE INDEX IF NOT EXISTS idx_college_gallery_college ON college_gallery(college_id);
CREATE INDEX IF NOT EXISTS idx_college_gallery_category ON college_gallery(college_id, category);

-- 4. Placement recruiters table
CREATE TABLE IF NOT EXISTS placement_recruiters (
  id SERIAL PRIMARY KEY,
  placement_id BIGINT REFERENCES placements(placement_id) ON DELETE CASCADE,
  company_name VARCHAR(200) NOT NULL,
  company_logo_url TEXT,
  sector VARCHAR(100), -- 'IT', 'Consulting', 'BFSI', 'FMCG', 'Core', 'Analytics', 'Others'
  offers_count INT,
  package_offered NUMERIC(12,2),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create index for efficient queries
CREATE INDEX IF NOT EXISTS idx_placement_recruiters_placement ON placement_recruiters(placement_id);

-- 5. Course enhancements - application dates and brochure
ALTER TABLE courses ADD COLUMN IF NOT EXISTS application_start_date DATE;
ALTER TABLE courses ADD COLUMN IF NOT EXISTS application_end_date DATE;
ALTER TABLE courses ADD COLUMN IF NOT EXISTS brochure_url TEXT;
