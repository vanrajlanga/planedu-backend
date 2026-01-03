-- Add banners JSONB column to course_page_content table
-- Banners structure: [{ id: number, image: string, alt: string, href: string }]

ALTER TABLE course_page_content
ADD COLUMN IF NOT EXISTS banners JSONB DEFAULT '[]'::jsonb;

-- Add comment for documentation
COMMENT ON COLUMN course_page_content.banners IS 'Array of banner objects with id, image (URL), alt text, and href link';
