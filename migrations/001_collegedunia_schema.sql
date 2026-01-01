-- Migration: 001_collegedunia_schema.sql
-- Description: Add CMS tables for Collegedunia-like content management
-- Date: 2025-12-30

-- =============================================
-- 1. CONTENT AUTHORS TABLE
-- =============================================
CREATE TABLE IF NOT EXISTS content_authors (
    id SERIAL PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    slug VARCHAR(200) UNIQUE NOT NULL,
    email VARCHAR(255),
    profile_image_url TEXT,
    designation VARCHAR(100), -- 'Content Writer', 'Senior Content Specialist'
    bio TEXT,
    is_verified BOOLEAN DEFAULT false,
    status VARCHAR(20) DEFAULT 'active', -- 'active', 'inactive'
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Index for faster lookups
CREATE INDEX IF NOT EXISTS idx_content_authors_slug ON content_authors(slug);
CREATE INDEX IF NOT EXISTS idx_content_authors_status ON content_authors(status);

-- =============================================
-- 2. COLLEGE CONTENT TABLE (CMS for sections)
-- =============================================
CREATE TABLE IF NOT EXISTS college_content (
    id SERIAL PRIMARY KEY,
    college_id BIGINT NOT NULL REFERENCES colleges(college_id) ON DELETE CASCADE,
    section_type VARCHAR(50) NOT NULL, -- 'overview', 'courses', 'admission', 'cutoff', 'placement', 'ranking', 'scholarship', 'hostel', 'faculty', 'gallery'
    title VARCHAR(500),
    content TEXT, -- Rich HTML content from TipTap editor
    table_of_contents JSONB, -- Auto-generated TOC structure
    author_id INT REFERENCES content_authors(id) ON DELETE SET NULL,
    meta_title VARCHAR(200),
    meta_description TEXT,
    status VARCHAR(20) DEFAULT 'draft', -- 'draft', 'published'
    published_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(college_id, section_type)
);

-- Indexes for college content
CREATE INDEX IF NOT EXISTS idx_college_content_college ON college_content(college_id);
CREATE INDEX IF NOT EXISTS idx_college_content_section ON college_content(section_type);
CREATE INDEX IF NOT EXISTS idx_college_content_author ON college_content(author_id);
CREATE INDEX IF NOT EXISTS idx_college_content_status ON college_content(status);

-- =============================================
-- 3. COLLEGE UPDATES TABLE (Key Updates/News)
-- =============================================
CREATE TABLE IF NOT EXISTS college_updates (
    id SERIAL PRIMARY KEY,
    college_id BIGINT NOT NULL REFERENCES colleges(college_id) ON DELETE CASCADE,
    update_type VARCHAR(20) DEFAULT 'key_update', -- 'key_update', 'other'
    title VARCHAR(300) NOT NULL,
    content TEXT NOT NULL, -- Rich text content with dates, links
    source_url TEXT, -- Link to external news article
    event_date DATE, -- Related event date (exam date, result date, etc.)
    is_pinned BOOLEAN DEFAULT false,
    published_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    expires_at TIMESTAMP, -- Auto-hide after this date
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Indexes for college updates
CREATE INDEX IF NOT EXISTS idx_college_updates_college ON college_updates(college_id);
CREATE INDEX IF NOT EXISTS idx_college_updates_type ON college_updates(update_type);
CREATE INDEX IF NOT EXISTS idx_college_updates_pinned ON college_updates(is_pinned);
CREATE INDEX IF NOT EXISTS idx_college_updates_expires ON college_updates(expires_at);

-- =============================================
-- 4. PLACEMENT RECRUITERS TABLE
-- =============================================
CREATE TABLE IF NOT EXISTS placement_recruiters (
    id SERIAL PRIMARY KEY,
    placement_id BIGINT NOT NULL REFERENCES placements(placement_id) ON DELETE CASCADE,
    company_name VARCHAR(200) NOT NULL,
    company_logo_url TEXT,
    sector VARCHAR(100), -- 'IT', 'Consulting', 'BFSI', 'FMCG', 'Core Engineering'
    offers_count INT,
    package_offered NUMERIC(12,2), -- Package in INR
    is_top_recruiter BOOLEAN DEFAULT false,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Index for recruiters
CREATE INDEX IF NOT EXISTS idx_placement_recruiters_placement ON placement_recruiters(placement_id);
CREATE INDEX IF NOT EXISTS idx_placement_recruiters_sector ON placement_recruiters(sector);

-- =============================================
-- 5. HOSTELS TABLE
-- =============================================
CREATE TABLE IF NOT EXISTS hostels (
    id SERIAL PRIMARY KEY,
    college_id BIGINT NOT NULL REFERENCES colleges(college_id) ON DELETE CASCADE,
    hostel_type VARCHAR(20), -- 'boys', 'girls', 'co-ed'
    name VARCHAR(200),
    total_capacity INT,
    room_types JSONB, -- [{type: 'single', count: 100, fee: 50000}, {type: 'double', count: 200, fee: 35000}]
    fee_per_semester NUMERIC(10,2),
    mess_fee_per_semester NUMERIC(10,2),
    amenities JSONB, -- ['wifi', 'ac', 'gym', 'laundry', 'common_room', 'reading_room']
    description TEXT,
    status VARCHAR(20) DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Index for hostels
CREATE INDEX IF NOT EXISTS idx_hostels_college ON hostels(college_id);
CREATE INDEX IF NOT EXISTS idx_hostels_type ON hostels(hostel_type);

-- =============================================
-- 6. FACULTY MEMBERS TABLE
-- =============================================
CREATE TABLE IF NOT EXISTS faculty_members (
    id SERIAL PRIMARY KEY,
    college_id BIGINT NOT NULL REFERENCES colleges(college_id) ON DELETE CASCADE,
    name VARCHAR(200) NOT NULL,
    designation VARCHAR(100), -- 'Professor', 'Associate Professor', 'Assistant Professor'
    department VARCHAR(200),
    qualification VARCHAR(300), -- 'Ph.D. from IIT Delhi', 'M.Tech from NIT'
    specialization VARCHAR(300),
    experience_years INT,
    profile_image_url TEXT,
    email VARCHAR(255),
    profile_url TEXT, -- Link to faculty's personal/university page
    status VARCHAR(20) DEFAULT 'active',
    display_order INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Indexes for faculty
CREATE INDEX IF NOT EXISTS idx_faculty_college ON faculty_members(college_id);
CREATE INDEX IF NOT EXISTS idx_faculty_department ON faculty_members(department);
CREATE INDEX IF NOT EXISTS idx_faculty_designation ON faculty_members(designation);

-- =============================================
-- 7. ENHANCE EXISTING TABLES
-- =============================================

-- Enhance colleges table
ALTER TABLE colleges
    ADD COLUMN IF NOT EXISTS cover_image_url TEXT,
    ADD COLUMN IF NOT EXISTS accreditation VARCHAR(100),
    ADD COLUMN IF NOT EXISTS affiliation VARCHAR(200),
    ADD COLUMN IF NOT EXISTS campus_size VARCHAR(50);

-- Enhance placements table
ALTER TABLE placements
    ADD COLUMN IF NOT EXISTS companies_participated INT,
    ADD COLUMN IF NOT EXISTS ppos_offered INT,
    ADD COLUMN IF NOT EXISTS ppos_accepted INT,
    ADD COLUMN IF NOT EXISTS international_offers INT,
    ADD COLUMN IF NOT EXISTS highest_international_package NUMERIC(12,2),
    ADD COLUMN IF NOT EXISTS top_sectors JSONB;

-- Enhance exam_cutoffs table
ALTER TABLE exam_cutoffs
    ADD COLUMN IF NOT EXISTS round INT DEFAULT 1,
    ADD COLUMN IF NOT EXISTS opening_rank INT,
    ADD COLUMN IF NOT EXISTS specialization VARCHAR(200);

-- =============================================
-- 8. TRIGGER FOR updated_at
-- =============================================
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Apply triggers to new tables
DROP TRIGGER IF EXISTS update_content_authors_updated_at ON content_authors;
CREATE TRIGGER update_content_authors_updated_at
    BEFORE UPDATE ON content_authors
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

DROP TRIGGER IF EXISTS update_college_content_updated_at ON college_content;
CREATE TRIGGER update_college_content_updated_at
    BEFORE UPDATE ON college_content
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

DROP TRIGGER IF EXISTS update_hostels_updated_at ON hostels;
CREATE TRIGGER update_hostels_updated_at
    BEFORE UPDATE ON hostels
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

DROP TRIGGER IF EXISTS update_faculty_members_updated_at ON faculty_members;
CREATE TRIGGER update_faculty_members_updated_at
    BEFORE UPDATE ON faculty_members
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- =============================================
-- 9. SAMPLE DATA (Optional - for testing)
-- =============================================

-- Insert a sample author
INSERT INTO content_authors (name, slug, email, designation, is_verified, status)
VALUES ('Admin Writer', 'admin-writer', 'admin@planedu.com', 'Content Manager', true, 'active')
ON CONFLICT (slug) DO NOTHING;

-- =============================================
-- MIGRATION COMPLETE
-- =============================================
-- Run with: psql -d eduportal_db -f migrations/001_collegedunia_schema.sql
