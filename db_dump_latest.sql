--
-- PostgreSQL database dump
--

\restrict EakBiW8oR0OtUhMjMF9SbU6fpc4gcRE0ChpGxXas0RjeVhKTDSirfUyl3XlHD0L

-- Dumped from database version 17.7 (Homebrew)
-- Dumped by pg_dump version 17.7 (Homebrew)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE IF EXISTS ONLY public.user_verifications DROP CONSTRAINT IF EXISTS user_verifications_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.user_sessions DROP CONSTRAINT IF EXISTS user_sessions_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.user_roles DROP CONSTRAINT IF EXISTS user_roles_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.user_roles DROP CONSTRAINT IF EXISTS user_roles_role_id_fkey;
ALTER TABLE IF EXISTS ONLY public.user_profiles DROP CONSTRAINT IF EXISTS user_profiles_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.user_consents DROP CONSTRAINT IF EXISTS user_consents_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.tests DROP CONSTRAINT IF EXISTS tests_series_id_fkey;
ALTER TABLE IF EXISTS ONLY public.testimonials DROP CONSTRAINT IF EXISTS testimonials_institution_id_fkey;
ALTER TABLE IF EXISTS ONLY public.test_series DROP CONSTRAINT IF EXISTS test_series_exam_id_fkey;
ALTER TABLE IF EXISTS ONLY public.test_attempts DROP CONSTRAINT IF EXISTS test_attempts_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.test_attempts DROP CONSTRAINT IF EXISTS test_attempts_test_id_fkey;
ALTER TABLE IF EXISTS ONLY public.search_logs DROP CONSTRAINT IF EXISTS search_logs_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.saved_items DROP CONSTRAINT IF EXISTS saved_items_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.reviews DROP CONSTRAINT IF EXISTS reviews_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.reviews DROP CONSTRAINT IF EXISTS reviews_replied_by_fkey;
ALTER TABLE IF EXISTS ONLY public.reviews DROP CONSTRAINT IF EXISTS reviews_college_id_fkey;
ALTER TABLE IF EXISTS ONLY public.questions DROP CONSTRAINT IF EXISTS questions_test_id_fkey;
ALTER TABLE IF EXISTS ONLY public.placements DROP CONSTRAINT IF EXISTS placements_college_id_fkey;
ALTER TABLE IF EXISTS ONLY public.placement_recruiters DROP CONSTRAINT IF EXISTS placement_recruiters_placement_id_fkey;
ALTER TABLE IF EXISTS ONLY public.payments DROP CONSTRAINT IF EXISTS payments_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.password_resets DROP CONSTRAINT IF EXISTS password_resets_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.notifications DROP CONSTRAINT IF EXISTS notifications_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.notification_preferences DROP CONSTRAINT IF EXISTS notification_preferences_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.news_articles DROP CONSTRAINT IF EXISTS news_articles_author_id_fkey;
ALTER TABLE IF EXISTS ONLY public.institute_users DROP CONSTRAINT IF EXISTS institute_users_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.institute_users DROP CONSTRAINT IF EXISTS institute_users_institution_id_fkey;
ALTER TABLE IF EXISTS ONLY public.institute_accounts DROP CONSTRAINT IF EXISTS institute_accounts_institution_id_fkey;
ALTER TABLE IF EXISTS ONLY public.institute_accounts DROP CONSTRAINT IF EXISTS institute_accounts_account_manager_id_fkey;
ALTER TABLE IF EXISTS ONLY public.hostels DROP CONSTRAINT IF EXISTS hostels_college_id_fkey;
ALTER TABLE IF EXISTS ONLY public.faculty_members DROP CONSTRAINT IF EXISTS faculty_members_college_id_fkey;
ALTER TABLE IF EXISTS ONLY public.exam_schedules DROP CONSTRAINT IF EXISTS exam_schedules_exam_id_fkey;
ALTER TABLE IF EXISTS ONLY public.exam_cutoffs DROP CONSTRAINT IF EXISTS exam_cutoffs_exam_id_fkey;
ALTER TABLE IF EXISTS ONLY public.exam_cutoffs DROP CONSTRAINT IF EXISTS exam_cutoffs_college_id_fkey;
ALTER TABLE IF EXISTS ONLY public.courses DROP CONSTRAINT IF EXISTS courses_college_id_fkey;
ALTER TABLE IF EXISTS ONLY public.contact_queries DROP CONSTRAINT IF EXISTS contact_queries_assigned_to_fkey;
ALTER TABLE IF EXISTS ONLY public.community_questions DROP CONSTRAINT IF EXISTS community_questions_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.community_questions DROP CONSTRAINT IF EXISTS community_questions_college_id_fkey;
ALTER TABLE IF EXISTS ONLY public.community_answers DROP CONSTRAINT IF EXISTS community_answers_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.community_answers DROP CONSTRAINT IF EXISTS community_answers_question_id_fkey;
ALTER TABLE IF EXISTS ONLY public.college_updates DROP CONSTRAINT IF EXISTS college_updates_college_id_fkey;
ALTER TABLE IF EXISTS ONLY public.college_rankings DROP CONSTRAINT IF EXISTS college_rankings_college_id_fkey;
ALTER TABLE IF EXISTS ONLY public.college_rankings DROP CONSTRAINT IF EXISTS college_rankings_agency_id_fkey;
ALTER TABLE IF EXISTS ONLY public.college_media DROP CONSTRAINT IF EXISTS college_media_college_id_fkey;
ALTER TABLE IF EXISTS ONLY public.college_gallery DROP CONSTRAINT IF EXISTS college_gallery_college_id_fkey;
ALTER TABLE IF EXISTS ONLY public.college_facilities DROP CONSTRAINT IF EXISTS college_facilities_college_id_fkey;
ALTER TABLE IF EXISTS ONLY public.college_content DROP CONSTRAINT IF EXISTS college_content_college_id_fkey;
ALTER TABLE IF EXISTS ONLY public.banners DROP CONSTRAINT IF EXISTS banners_created_by_fkey;
ALTER TABLE IF EXISTS ONLY public.banner_analytics DROP CONSTRAINT IF EXISTS banner_analytics_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.banner_analytics DROP CONSTRAINT IF EXISTS banner_analytics_banner_id_fkey;
ALTER TABLE IF EXISTS ONLY public.audit_log DROP CONSTRAINT IF EXISTS audit_log_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.admin_sessions DROP CONSTRAINT IF EXISTS admin_sessions_admin_id_fkey;
ALTER TABLE IF EXISTS ONLY public.admin_audit_logs DROP CONSTRAINT IF EXISTS admin_audit_logs_admin_id_fkey;
ALTER TABLE IF EXISTS ONLY geo_master.states DROP CONSTRAINT IF EXISTS states_country_id_fkey;
ALTER TABLE IF EXISTS ONLY geo_master.cities DROP CONSTRAINT IF EXISTS cities_state_id_fkey;
ALTER TABLE IF EXISTS ONLY discovery.user_favorites DROP CONSTRAINT IF EXISTS user_favorites_user_id_fkey;
ALTER TABLE IF EXISTS ONLY discovery.review_moderation DROP CONSTRAINT IF EXISTS review_moderation_review_id_fkey;
ALTER TABLE IF EXISTS ONLY discovery.review_moderation DROP CONSTRAINT IF EXISTS review_moderation_moderated_by_fkey;
ALTER TABLE IF EXISTS ONLY discovery.qna_votes DROP CONSTRAINT IF EXISTS qna_votes_user_id_fkey;
ALTER TABLE IF EXISTS ONLY discovery.qna_votes DROP CONSTRAINT IF EXISTS qna_votes_qna_id_fkey;
ALTER TABLE IF EXISTS ONLY discovery.qna DROP CONSTRAINT IF EXISTS qna_user_id_fkey;
ALTER TABLE IF EXISTS ONLY discovery.qna DROP CONSTRAINT IF EXISTS qna_institution_id_fkey;
ALTER TABLE IF EXISTS ONLY discovery.qna DROP CONSTRAINT IF EXISTS qna_answered_by_fkey;
ALTER TABLE IF EXISTS ONLY discovery.institution_videos DROP CONSTRAINT IF EXISTS institution_videos_institution_id_fkey;
ALTER TABLE IF EXISTS ONLY discovery.institution_highlights DROP CONSTRAINT IF EXISTS institution_highlights_institution_id_fkey;
ALTER TABLE IF EXISTS ONLY discovery.institution_facilities DROP CONSTRAINT IF EXISTS institution_facilities_institution_id_fkey;
ALTER TABLE IF EXISTS ONLY discovery.institution_facilities DROP CONSTRAINT IF EXISTS institution_facilities_facility_id_fkey;
ALTER TABLE IF EXISTS ONLY discovery.institution_courses DROP CONSTRAINT IF EXISTS institution_courses_institution_id_fkey;
ALTER TABLE IF EXISTS ONLY discovery.institution_brochures DROP CONSTRAINT IF EXISTS institution_brochures_institution_id_fkey;
ALTER TABLE IF EXISTS ONLY discovery.institution_approvals DROP CONSTRAINT IF EXISTS institution_approvals_institution_id_fkey;
ALTER TABLE IF EXISTS ONLY discovery.institution_affiliations DROP CONSTRAINT IF EXISTS institution_affiliations_institution_id_fkey;
ALTER TABLE IF EXISTS ONLY discovery.course_specializations DROP CONSTRAINT IF EXISTS course_specializations_institution_course_id_fkey;
ALTER TABLE IF EXISTS ONLY discovery.course_fees DROP CONSTRAINT IF EXISTS course_fees_institution_course_id_fkey;
ALTER TABLE IF EXISTS ONLY discovery.course_admissions DROP CONSTRAINT IF EXISTS course_admissions_institution_course_id_fkey;
ALTER TABLE IF EXISTS ONLY discovery.applications DROP CONSTRAINT IF EXISTS applications_user_id_fkey;
ALTER TABLE IF EXISTS ONLY discovery.applications DROP CONSTRAINT IF EXISTS applications_institution_course_id_fkey;
ALTER TABLE IF EXISTS ONLY discovery.application_documents DROP CONSTRAINT IF EXISTS application_documents_verified_by_fkey;
ALTER TABLE IF EXISTS ONLY discovery.application_documents DROP CONSTRAINT IF EXISTS application_documents_application_id_fkey;
ALTER TABLE IF EXISTS ONLY analytics.user_activity DROP CONSTRAINT IF EXISTS user_activity_user_id_fkey;
ALTER TABLE IF EXISTS ONLY analytics.payments DROP CONSTRAINT IF EXISTS payments_user_id_fkey;
ALTER TABLE IF EXISTS ONLY analytics.payments DROP CONSTRAINT IF EXISTS payments_institution_id_fkey;
ALTER TABLE IF EXISTS ONLY analytics.leads DROP CONSTRAINT IF EXISTS leads_user_id_fkey;
ALTER TABLE IF EXISTS ONLY analytics.leads DROP CONSTRAINT IF EXISTS leads_institution_id_fkey;
ALTER TABLE IF EXISTS ONLY analytics.leads DROP CONSTRAINT IF EXISTS leads_assigned_to_fkey;
ALTER TABLE IF EXISTS ONLY analytics.lead_notes DROP CONSTRAINT IF EXISTS lead_notes_user_id_fkey;
ALTER TABLE IF EXISTS ONLY analytics.lead_notes DROP CONSTRAINT IF EXISTS lead_notes_lead_id_fkey;
ALTER TABLE IF EXISTS ONLY analytics.counselling_sessions DROP CONSTRAINT IF EXISTS counselling_sessions_lead_id_fkey;
ALTER TABLE IF EXISTS ONLY analytics.counselling_sessions DROP CONSTRAINT IF EXISTS counselling_sessions_counsellor_id_fkey;
DROP TRIGGER IF EXISTS update_hostels_updated_at ON public.hostels;
DROP TRIGGER IF EXISTS update_faculty_members_updated_at ON public.faculty_members;
DROP TRIGGER IF EXISTS update_college_content_updated_at ON public.college_content;
DROP INDEX IF EXISTS public.idx_users_type;
DROP INDEX IF EXISTS public.idx_users_phone;
DROP INDEX IF EXISTS public.idx_users_email;
DROP INDEX IF EXISTS public.idx_user_verifications_user;
DROP INDEX IF EXISTS public.idx_user_consents_user;
DROP INDEX IF EXISTS public.idx_test_series;
DROP INDEX IF EXISTS public.idx_site_notifications_active;
DROP INDEX IF EXISTS public.idx_session_user;
DROP INDEX IF EXISTS public.idx_session_token;
DROP INDEX IF EXISTS public.idx_series_exam;
DROP INDEX IF EXISTS public.idx_search_user;
DROP INDEX IF EXISTS public.idx_search_created;
DROP INDEX IF EXISTS public.idx_scholarship_type;
DROP INDEX IF EXISTS public.idx_schedule_exam;
DROP INDEX IF EXISTS public.idx_saved_user;
DROP INDEX IF EXISTS public.idx_reviews_user_id;
DROP INDEX IF EXISTS public.idx_reviews_status;
DROP INDEX IF EXISTS public.idx_reviews_deleted_at;
DROP INDEX IF EXISTS public.idx_reviews_created_at;
DROP INDEX IF EXISTS public.idx_reviews_college_id;
DROP INDEX IF EXISTS public.idx_review_user;
DROP INDEX IF EXISTS public.idx_review_status;
DROP INDEX IF EXISTS public.idx_review_college;
DROP INDEX IF EXISTS public.idx_ranking_year;
DROP INDEX IF EXISTS public.idx_ranking_college;
DROP INDEX IF EXISTS public.idx_quick_tabs_order;
DROP INDEX IF EXISTS public.idx_question_user;
DROP INDEX IF EXISTS public.idx_question_test;
DROP INDEX IF EXISTS public.idx_question_college;
DROP INDEX IF EXISTS public.idx_profile_user;
DROP INDEX IF EXISTS public.idx_placement_recruiters_sector;
DROP INDEX IF EXISTS public.idx_placement_recruiters_placement;
DROP INDEX IF EXISTS public.idx_placement_college;
DROP INDEX IF EXISTS public.idx_payment_user;
DROP INDEX IF EXISTS public.idx_payment_status;
DROP INDEX IF EXISTS public.idx_password_resets_user;
DROP INDEX IF EXISTS public.idx_notification_user;
DROP INDEX IF EXISTS public.idx_notification_status;
DROP INDEX IF EXISTS public.idx_newsletter_email;
DROP INDEX IF EXISTS public.idx_media_college;
DROP INDEX IF EXISTS public.idx_loan_provider;
DROP INDEX IF EXISTS public.idx_hostels_type;
DROP INDEX IF EXISTS public.idx_hostels_college;
DROP INDEX IF EXISTS public.idx_faqs_category;
DROP INDEX IF EXISTS public.idx_faculty_designation;
DROP INDEX IF EXISTS public.idx_faculty_department;
DROP INDEX IF EXISTS public.idx_faculty_college;
DROP INDEX IF EXISTS public.idx_facility_college;
DROP INDEX IF EXISTS public.idx_exam_slug;
DROP INDEX IF EXISTS public.idx_exam_category;
DROP INDEX IF EXISTS public.idx_cutoff_exam;
DROP INDEX IF EXISTS public.idx_cutoff_college;
DROP INDEX IF EXISTS public.idx_courses_stream;
DROP INDEX IF EXISTS public.idx_courses_status;
DROP INDEX IF EXISTS public.idx_courses_degree_type;
DROP INDEX IF EXISTS public.idx_courses_college_id;
DROP INDEX IF EXISTS public.idx_course_types_master_status;
DROP INDEX IF EXISTS public.idx_course_types_master_level;
DROP INDEX IF EXISTS public.idx_course_types_master_category;
DROP INDEX IF EXISTS public.idx_course_page_content_type;
DROP INDEX IF EXISTS public.idx_course_page_content_status;
DROP INDEX IF EXISTS public.idx_course_location_content_status;
DROP INDEX IF EXISTS public.idx_course_location_content_lookup;
DROP INDEX IF EXISTS public.idx_college_updates_type;
DROP INDEX IF EXISTS public.idx_college_updates_pinned;
DROP INDEX IF EXISTS public.idx_college_updates_expires;
DROP INDEX IF EXISTS public.idx_college_updates_college;
DROP INDEX IF EXISTS public.idx_college_slug;
DROP INDEX IF EXISTS public.idx_college_name_search;
DROP INDEX IF EXISTS public.idx_college_location;
DROP INDEX IF EXISTS public.idx_college_gallery_college;
DROP INDEX IF EXISTS public.idx_college_gallery_category;
DROP INDEX IF EXISTS public.idx_college_content_status;
DROP INDEX IF EXISTS public.idx_college_content_section;
DROP INDEX IF EXISTS public.idx_college_content_college;
DROP INDEX IF EXISTS public.idx_college_content_author;
DROP INDEX IF EXISTS public.idx_banners_placement;
DROP INDEX IF EXISTS public.idx_audit_user;
DROP INDEX IF EXISTS public.idx_attempt_user;
DROP INDEX IF EXISTS public.idx_attempt_test;
DROP INDEX IF EXISTS public.idx_article_slug;
DROP INDEX IF EXISTS public.idx_article_category;
DROP INDEX IF EXISTS public.idx_answer_question;
DROP INDEX IF EXISTS discovery.idx_videos_inst;
DROP INDEX IF EXISTS discovery.idx_qna_inst;
DROP INDEX IF EXISTS discovery.idx_institution_courses_inst_course;
DROP INDEX IF EXISTS discovery.idx_inst_highlights_inst;
DROP INDEX IF EXISTS discovery.idx_inst_facility_inst;
DROP INDEX IF EXISTS discovery.idx_inst_approvals_inst;
DROP INDEX IF EXISTS discovery.idx_inst_affiliation_inst;
DROP INDEX IF EXISTS discovery.idx_brochures_inst;
DROP INDEX IF EXISTS discovery.idx_applications_user;
DROP INDEX IF EXISTS analytics.idx_payments_user;
DROP INDEX IF EXISTS analytics.idx_leads_institution;
DROP INDEX IF EXISTS analytics.idx_leads_assigned_status;
DROP INDEX IF EXISTS analytics.idx_counselling_sessions_lead;
DROP INDEX IF EXISTS analytics.idx_activity_user_time;
ALTER TABLE IF EXISTS ONLY public.users DROP CONSTRAINT IF EXISTS users_username_key;
ALTER TABLE IF EXISTS ONLY public.users DROP CONSTRAINT IF EXISTS users_pkey;
ALTER TABLE IF EXISTS ONLY public.users DROP CONSTRAINT IF EXISTS users_phone_key;
ALTER TABLE IF EXISTS ONLY public.users DROP CONSTRAINT IF EXISTS users_email_key;
ALTER TABLE IF EXISTS ONLY public.user_verifications DROP CONSTRAINT IF EXISTS user_verifications_pkey;
ALTER TABLE IF EXISTS ONLY public.user_sessions DROP CONSTRAINT IF EXISTS user_sessions_session_token_key;
ALTER TABLE IF EXISTS ONLY public.user_sessions DROP CONSTRAINT IF EXISTS user_sessions_pkey;
ALTER TABLE IF EXISTS ONLY public.user_roles DROP CONSTRAINT IF EXISTS user_roles_pkey;
ALTER TABLE IF EXISTS ONLY public.user_profiles DROP CONSTRAINT IF EXISTS user_profiles_pkey;
ALTER TABLE IF EXISTS ONLY public.user_consents DROP CONSTRAINT IF EXISTS user_consents_pkey;
ALTER TABLE IF EXISTS ONLY public.tests DROP CONSTRAINT IF EXISTS tests_pkey;
ALTER TABLE IF EXISTS ONLY public.testimonials DROP CONSTRAINT IF EXISTS testimonials_pkey;
ALTER TABLE IF EXISTS ONLY public.test_series DROP CONSTRAINT IF EXISTS test_series_pkey;
ALTER TABLE IF EXISTS ONLY public.test_attempts DROP CONSTRAINT IF EXISTS test_attempts_pkey;
ALTER TABLE IF EXISTS ONLY public.team_members DROP CONSTRAINT IF EXISTS team_members_pkey;
ALTER TABLE IF EXISTS ONLY public.system_settings DROP CONSTRAINT IF EXISTS system_settings_setting_key_key;
ALTER TABLE IF EXISTS ONLY public.system_settings DROP CONSTRAINT IF EXISTS system_settings_pkey;
ALTER TABLE IF EXISTS ONLY public.site_notifications DROP CONSTRAINT IF EXISTS site_notifications_pkey;
ALTER TABLE IF EXISTS ONLY public.search_logs DROP CONSTRAINT IF EXISTS search_logs_pkey;
ALTER TABLE IF EXISTS ONLY public.scholarships DROP CONSTRAINT IF EXISTS scholarships_slug_key;
ALTER TABLE IF EXISTS ONLY public.scholarships DROP CONSTRAINT IF EXISTS scholarships_pkey;
ALTER TABLE IF EXISTS ONLY public.saved_items DROP CONSTRAINT IF EXISTS saved_items_user_id_item_type_item_id_key;
ALTER TABLE IF EXISTS ONLY public.saved_items DROP CONSTRAINT IF EXISTS saved_items_pkey;
ALTER TABLE IF EXISTS ONLY public.roles DROP CONSTRAINT IF EXISTS roles_pkey;
ALTER TABLE IF EXISTS ONLY public.roles DROP CONSTRAINT IF EXISTS roles_name_key;
ALTER TABLE IF EXISTS ONLY public.reviews DROP CONSTRAINT IF EXISTS reviews_pkey;
ALTER TABLE IF EXISTS ONLY public.ranking_agencies DROP CONSTRAINT IF EXISTS ranking_agencies_pkey;
ALTER TABLE IF EXISTS ONLY public.ranking_agencies DROP CONSTRAINT IF EXISTS ranking_agencies_agency_name_key;
ALTER TABLE IF EXISTS ONLY public.ranking_agencies DROP CONSTRAINT IF EXISTS ranking_agencies_agency_code_key;
ALTER TABLE IF EXISTS ONLY public.quick_tabs DROP CONSTRAINT IF EXISTS quick_tabs_pkey;
ALTER TABLE IF EXISTS ONLY public.quick_tabs DROP CONSTRAINT IF EXISTS quick_tabs_degree_type_key;
ALTER TABLE IF EXISTS ONLY public.questions DROP CONSTRAINT IF EXISTS questions_pkey;
ALTER TABLE IF EXISTS ONLY public.placements DROP CONSTRAINT IF EXISTS placements_pkey;
ALTER TABLE IF EXISTS ONLY public.placement_recruiters DROP CONSTRAINT IF EXISTS placement_recruiters_pkey;
ALTER TABLE IF EXISTS ONLY public.payments DROP CONSTRAINT IF EXISTS payments_pkey;
ALTER TABLE IF EXISTS ONLY public.payments DROP CONSTRAINT IF EXISTS payments_order_id_key;
ALTER TABLE IF EXISTS ONLY public.password_resets DROP CONSTRAINT IF EXISTS password_resets_pkey;
ALTER TABLE IF EXISTS ONLY public.notifications DROP CONSTRAINT IF EXISTS notifications_pkey;
ALTER TABLE IF EXISTS ONLY public.notification_preferences DROP CONSTRAINT IF EXISTS notification_preferences_user_id_key;
ALTER TABLE IF EXISTS ONLY public.notification_preferences DROP CONSTRAINT IF EXISTS notification_preferences_pkey;
ALTER TABLE IF EXISTS ONLY public.newsletter_subscribers DROP CONSTRAINT IF EXISTS newsletter_subscribers_pkey;
ALTER TABLE IF EXISTS ONLY public.newsletter_subscribers DROP CONSTRAINT IF EXISTS newsletter_subscribers_email_key;
ALTER TABLE IF EXISTS ONLY public.news_articles DROP CONSTRAINT IF EXISTS news_articles_slug_key;
ALTER TABLE IF EXISTS ONLY public.news_articles DROP CONSTRAINT IF EXISTS news_articles_pkey;
ALTER TABLE IF EXISTS ONLY public.job_postings DROP CONSTRAINT IF EXISTS job_postings_pkey;
ALTER TABLE IF EXISTS ONLY public.institute_users DROP CONSTRAINT IF EXISTS institute_users_pkey;
ALTER TABLE IF EXISTS ONLY public.institute_users DROP CONSTRAINT IF EXISTS institute_users_institution_id_user_id_key;
ALTER TABLE IF EXISTS ONLY public.institute_accounts DROP CONSTRAINT IF EXISTS institute_accounts_pkey;
ALTER TABLE IF EXISTS ONLY public.institute_accounts DROP CONSTRAINT IF EXISTS institute_accounts_institution_id_key;
ALTER TABLE IF EXISTS ONLY public.hostels DROP CONSTRAINT IF EXISTS hostels_pkey;
ALTER TABLE IF EXISTS ONLY public.faqs DROP CONSTRAINT IF EXISTS faqs_pkey;
ALTER TABLE IF EXISTS ONLY public.faculty_members DROP CONSTRAINT IF EXISTS faculty_members_pkey;
ALTER TABLE IF EXISTS ONLY public.exams DROP CONSTRAINT IF EXISTS exams_slug_key;
ALTER TABLE IF EXISTS ONLY public.exams DROP CONSTRAINT IF EXISTS exams_pkey;
ALTER TABLE IF EXISTS ONLY public.exam_schedules DROP CONSTRAINT IF EXISTS exam_schedules_pkey;
ALTER TABLE IF EXISTS ONLY public.exam_cutoffs DROP CONSTRAINT IF EXISTS exam_cutoffs_pkey;
ALTER TABLE IF EXISTS ONLY public.education_loans DROP CONSTRAINT IF EXISTS education_loans_pkey;
ALTER TABLE IF EXISTS ONLY public.degree_categories DROP CONSTRAINT IF EXISTS degree_categories_pkey;
ALTER TABLE IF EXISTS ONLY public.degree_categories DROP CONSTRAINT IF EXISTS degree_categories_name_key;
ALTER TABLE IF EXISTS ONLY public.courses DROP CONSTRAINT IF EXISTS courses_pkey;
ALTER TABLE IF EXISTS ONLY public.course_types_master DROP CONSTRAINT IF EXISTS course_types_master_slug_key;
ALTER TABLE IF EXISTS ONLY public.course_types_master DROP CONSTRAINT IF EXISTS course_types_master_pkey;
ALTER TABLE IF EXISTS ONLY public.course_types_master DROP CONSTRAINT IF EXISTS course_types_master_name_key;
ALTER TABLE IF EXISTS ONLY public.course_page_content DROP CONSTRAINT IF EXISTS course_page_content_pkey;
ALTER TABLE IF EXISTS ONLY public.course_page_content DROP CONSTRAINT IF EXISTS course_page_content_course_type_key;
ALTER TABLE IF EXISTS ONLY public.course_location_content DROP CONSTRAINT IF EXISTS course_location_content_pkey;
ALTER TABLE IF EXISTS ONLY public.course_location_content DROP CONSTRAINT IF EXISTS course_location_content_course_type_location_slug_key;
ALTER TABLE IF EXISTS ONLY public.contact_queries DROP CONSTRAINT IF EXISTS contact_queries_pkey;
ALTER TABLE IF EXISTS ONLY public.community_questions DROP CONSTRAINT IF EXISTS community_questions_pkey;
ALTER TABLE IF EXISTS ONLY public.community_answers DROP CONSTRAINT IF EXISTS community_answers_pkey;
ALTER TABLE IF EXISTS ONLY public.colleges DROP CONSTRAINT IF EXISTS colleges_slug_key;
ALTER TABLE IF EXISTS ONLY public.colleges DROP CONSTRAINT IF EXISTS colleges_pkey;
ALTER TABLE IF EXISTS ONLY public.college_updates DROP CONSTRAINT IF EXISTS college_updates_pkey;
ALTER TABLE IF EXISTS ONLY public.college_rankings DROP CONSTRAINT IF EXISTS college_rankings_pkey;
ALTER TABLE IF EXISTS ONLY public.college_media DROP CONSTRAINT IF EXISTS college_media_pkey;
ALTER TABLE IF EXISTS ONLY public.college_gallery DROP CONSTRAINT IF EXISTS college_gallery_pkey;
ALTER TABLE IF EXISTS ONLY public.college_facilities DROP CONSTRAINT IF EXISTS college_facilities_pkey;
ALTER TABLE IF EXISTS ONLY public.college_content DROP CONSTRAINT IF EXISTS college_content_pkey;
ALTER TABLE IF EXISTS ONLY public.college_content DROP CONSTRAINT IF EXISTS college_content_college_id_section_type_key;
ALTER TABLE IF EXISTS ONLY public.banners DROP CONSTRAINT IF EXISTS banners_pkey;
ALTER TABLE IF EXISTS ONLY public.banner_analytics DROP CONSTRAINT IF EXISTS banner_analytics_pkey;
ALTER TABLE IF EXISTS ONLY public.audit_log DROP CONSTRAINT IF EXISTS audit_log_pkey;
ALTER TABLE IF EXISTS ONLY public.admin_users DROP CONSTRAINT IF EXISTS admin_users_pkey;
ALTER TABLE IF EXISTS ONLY public.admin_users DROP CONSTRAINT IF EXISTS admin_users_email_key;
ALTER TABLE IF EXISTS ONLY public.admin_sessions DROP CONSTRAINT IF EXISTS admin_sessions_pkey;
ALTER TABLE IF EXISTS ONLY public.admin_audit_logs DROP CONSTRAINT IF EXISTS admin_audit_logs_pkey;
ALTER TABLE IF EXISTS ONLY geo_master.states DROP CONSTRAINT IF EXISTS states_pkey;
ALTER TABLE IF EXISTS ONLY geo_master.countries DROP CONSTRAINT IF EXISTS countries_pkey;
ALTER TABLE IF EXISTS ONLY geo_master.countries DROP CONSTRAINT IF EXISTS countries_country_name_key;
ALTER TABLE IF EXISTS ONLY geo_master.countries DROP CONSTRAINT IF EXISTS countries_country_code_key;
ALTER TABLE IF EXISTS ONLY geo_master.cities DROP CONSTRAINT IF EXISTS cities_pkey;
ALTER TABLE IF EXISTS ONLY discovery.user_favorites DROP CONSTRAINT IF EXISTS user_favorites_pkey;
ALTER TABLE IF EXISTS ONLY discovery.streams DROP CONSTRAINT IF EXISTS streams_pkey;
ALTER TABLE IF EXISTS ONLY discovery.streams DROP CONSTRAINT IF EXISTS streams_name_key;
ALTER TABLE IF EXISTS ONLY discovery.seo_metadata DROP CONSTRAINT IF EXISTS seo_metadata_pkey;
ALTER TABLE IF EXISTS ONLY discovery.seo_metadata DROP CONSTRAINT IF EXISTS seo_metadata_entity_type_entity_id_key;
ALTER TABLE IF EXISTS ONLY discovery.review_moderation DROP CONSTRAINT IF EXISTS review_moderation_pkey;
ALTER TABLE IF EXISTS ONLY discovery.recruiter_companies DROP CONSTRAINT IF EXISTS recruiter_companies_pkey;
ALTER TABLE IF EXISTS ONLY discovery.recruiter_companies DROP CONSTRAINT IF EXISTS recruiter_companies_name_key;
ALTER TABLE IF EXISTS ONLY discovery.qna_votes DROP CONSTRAINT IF EXISTS qna_votes_qna_id_user_id_key;
ALTER TABLE IF EXISTS ONLY discovery.qna_votes DROP CONSTRAINT IF EXISTS qna_votes_pkey;
ALTER TABLE IF EXISTS ONLY discovery.qna DROP CONSTRAINT IF EXISTS qna_pkey;
ALTER TABLE IF EXISTS ONLY discovery.institution_videos DROP CONSTRAINT IF EXISTS institution_videos_pkey;
ALTER TABLE IF EXISTS ONLY discovery.institution_highlights DROP CONSTRAINT IF EXISTS institution_highlights_pkey;
ALTER TABLE IF EXISTS ONLY discovery.institution_facilities DROP CONSTRAINT IF EXISTS institution_facilities_pkey;
ALTER TABLE IF EXISTS ONLY discovery.institution_courses DROP CONSTRAINT IF EXISTS institution_courses_pkey;
ALTER TABLE IF EXISTS ONLY discovery.institution_brochures DROP CONSTRAINT IF EXISTS institution_brochures_pkey;
ALTER TABLE IF EXISTS ONLY discovery.institution_approvals DROP CONSTRAINT IF EXISTS institution_approvals_pkey;
ALTER TABLE IF EXISTS ONLY discovery.institution_affiliations DROP CONSTRAINT IF EXISTS institution_affiliations_pkey;
ALTER TABLE IF EXISTS ONLY discovery.facilities DROP CONSTRAINT IF EXISTS facilities_pkey;
ALTER TABLE IF EXISTS ONLY discovery.facilities DROP CONSTRAINT IF EXISTS facilities_name_key;
ALTER TABLE IF EXISTS ONLY discovery.course_specializations DROP CONSTRAINT IF EXISTS course_specializations_pkey;
ALTER TABLE IF EXISTS ONLY discovery.course_specializations DROP CONSTRAINT IF EXISTS course_specializations_institution_course_id_name_key;
ALTER TABLE IF EXISTS ONLY discovery.course_fees DROP CONSTRAINT IF EXISTS course_fees_pkey;
ALTER TABLE IF EXISTS ONLY discovery.course_fees DROP CONSTRAINT IF EXISTS course_fees_institution_course_id_year_key;
ALTER TABLE IF EXISTS ONLY discovery.course_admissions DROP CONSTRAINT IF EXISTS course_admissions_pkey;
ALTER TABLE IF EXISTS ONLY discovery.applications DROP CONSTRAINT IF EXISTS applications_pkey;
ALTER TABLE IF EXISTS ONLY discovery.application_documents DROP CONSTRAINT IF EXISTS application_documents_pkey;
ALTER TABLE IF EXISTS ONLY analytics.user_activity DROP CONSTRAINT IF EXISTS user_activity_pkey;
ALTER TABLE IF EXISTS ONLY analytics.payments DROP CONSTRAINT IF EXISTS payments_pkey;
ALTER TABLE IF EXISTS ONLY analytics.leads DROP CONSTRAINT IF EXISTS leads_pkey;
ALTER TABLE IF EXISTS ONLY analytics.lead_notes DROP CONSTRAINT IF EXISTS lead_notes_pkey;
ALTER TABLE IF EXISTS ONLY analytics.counselling_sessions DROP CONSTRAINT IF EXISTS counselling_sessions_pkey;
ALTER TABLE IF EXISTS public.users ALTER COLUMN user_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.user_verifications ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.user_profiles ALTER COLUMN profile_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.user_consents ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.tests ALTER COLUMN test_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.testimonials ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.test_series ALTER COLUMN series_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.test_attempts ALTER COLUMN attempt_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.team_members ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.system_settings ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.site_notifications ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.search_logs ALTER COLUMN search_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.scholarships ALTER COLUMN scholarship_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.saved_items ALTER COLUMN saved_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.roles ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.reviews ALTER COLUMN review_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.ranking_agencies ALTER COLUMN agency_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.quick_tabs ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.questions ALTER COLUMN question_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.placements ALTER COLUMN placement_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.placement_recruiters ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.payments ALTER COLUMN payment_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.password_resets ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.notifications ALTER COLUMN notification_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.notification_preferences ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.newsletter_subscribers ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.news_articles ALTER COLUMN article_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.job_postings ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.institute_users ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.institute_accounts ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.hostels ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.faqs ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.faculty_members ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.exams ALTER COLUMN exam_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.exam_schedules ALTER COLUMN schedule_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.exam_cutoffs ALTER COLUMN cutoff_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.education_loans ALTER COLUMN loan_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.degree_categories ALTER COLUMN category_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.courses ALTER COLUMN course_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.course_types_master ALTER COLUMN course_type_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.course_page_content ALTER COLUMN content_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.course_location_content ALTER COLUMN content_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.contact_queries ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.community_questions ALTER COLUMN question_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.community_answers ALTER COLUMN answer_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.colleges ALTER COLUMN college_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.college_updates ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.college_rankings ALTER COLUMN ranking_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.college_media ALTER COLUMN media_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.college_gallery ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.college_facilities ALTER COLUMN facility_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.college_content ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.banners ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.banner_analytics ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.audit_log ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.admin_users ALTER COLUMN admin_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.admin_sessions ALTER COLUMN session_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.admin_audit_logs ALTER COLUMN log_id DROP DEFAULT;
ALTER TABLE IF EXISTS geo_master.states ALTER COLUMN state_id DROP DEFAULT;
ALTER TABLE IF EXISTS geo_master.countries ALTER COLUMN country_id DROP DEFAULT;
ALTER TABLE IF EXISTS geo_master.cities ALTER COLUMN city_id DROP DEFAULT;
ALTER TABLE IF EXISTS discovery.streams ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS discovery.seo_metadata ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS discovery.review_moderation ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS discovery.recruiter_companies ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS discovery.qna_votes ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS discovery.qna ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS discovery.institution_videos ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS discovery.institution_highlights ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS discovery.institution_courses ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS discovery.institution_brochures ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS discovery.institution_approvals ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS discovery.institution_affiliations ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS discovery.facilities ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS discovery.course_specializations ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS discovery.course_fees ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS discovery.course_admissions ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS discovery.applications ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS discovery.application_documents ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS analytics.user_activity ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS analytics.payments ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS analytics.leads ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS analytics.lead_notes ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS analytics.counselling_sessions ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE IF EXISTS public.users_user_id_seq;
DROP TABLE IF EXISTS public.users;
DROP SEQUENCE IF EXISTS public.user_verifications_id_seq;
DROP TABLE IF EXISTS public.user_verifications;
DROP TABLE IF EXISTS public.user_sessions;
DROP TABLE IF EXISTS public.user_roles;
DROP SEQUENCE IF EXISTS public.user_profiles_profile_id_seq;
DROP TABLE IF EXISTS public.user_profiles;
DROP SEQUENCE IF EXISTS public.user_consents_id_seq;
DROP TABLE IF EXISTS public.user_consents;
DROP SEQUENCE IF EXISTS public.tests_test_id_seq;
DROP TABLE IF EXISTS public.tests;
DROP SEQUENCE IF EXISTS public.testimonials_id_seq;
DROP TABLE IF EXISTS public.testimonials;
DROP SEQUENCE IF EXISTS public.test_series_series_id_seq;
DROP TABLE IF EXISTS public.test_series;
DROP SEQUENCE IF EXISTS public.test_attempts_attempt_id_seq;
DROP TABLE IF EXISTS public.test_attempts;
DROP SEQUENCE IF EXISTS public.team_members_id_seq;
DROP TABLE IF EXISTS public.team_members;
DROP SEQUENCE IF EXISTS public.system_settings_id_seq;
DROP TABLE IF EXISTS public.system_settings;
DROP SEQUENCE IF EXISTS public.site_notifications_id_seq;
DROP TABLE IF EXISTS public.site_notifications;
DROP SEQUENCE IF EXISTS public.search_logs_search_id_seq;
DROP TABLE IF EXISTS public.search_logs;
DROP SEQUENCE IF EXISTS public.scholarships_scholarship_id_seq;
DROP TABLE IF EXISTS public.scholarships;
DROP SEQUENCE IF EXISTS public.saved_items_saved_id_seq;
DROP TABLE IF EXISTS public.saved_items;
DROP SEQUENCE IF EXISTS public.roles_id_seq;
DROP TABLE IF EXISTS public.roles;
DROP SEQUENCE IF EXISTS public.reviews_review_id_seq;
DROP TABLE IF EXISTS public.reviews;
DROP SEQUENCE IF EXISTS public.ranking_agencies_agency_id_seq;
DROP TABLE IF EXISTS public.ranking_agencies;
DROP SEQUENCE IF EXISTS public.quick_tabs_id_seq;
DROP TABLE IF EXISTS public.quick_tabs;
DROP SEQUENCE IF EXISTS public.questions_question_id_seq;
DROP TABLE IF EXISTS public.questions;
DROP SEQUENCE IF EXISTS public.placements_placement_id_seq;
DROP TABLE IF EXISTS public.placements;
DROP SEQUENCE IF EXISTS public.placement_recruiters_id_seq;
DROP TABLE IF EXISTS public.placement_recruiters;
DROP SEQUENCE IF EXISTS public.payments_payment_id_seq;
DROP TABLE IF EXISTS public.payments;
DROP SEQUENCE IF EXISTS public.password_resets_id_seq;
DROP TABLE IF EXISTS public.password_resets;
DROP SEQUENCE IF EXISTS public.notifications_notification_id_seq;
DROP TABLE IF EXISTS public.notifications;
DROP SEQUENCE IF EXISTS public.notification_preferences_id_seq;
DROP TABLE IF EXISTS public.notification_preferences;
DROP SEQUENCE IF EXISTS public.newsletter_subscribers_id_seq;
DROP TABLE IF EXISTS public.newsletter_subscribers;
DROP SEQUENCE IF EXISTS public.news_articles_article_id_seq;
DROP TABLE IF EXISTS public.news_articles;
DROP SEQUENCE IF EXISTS public.job_postings_id_seq;
DROP TABLE IF EXISTS public.job_postings;
DROP SEQUENCE IF EXISTS public.institute_users_id_seq;
DROP TABLE IF EXISTS public.institute_users;
DROP SEQUENCE IF EXISTS public.institute_accounts_id_seq;
DROP TABLE IF EXISTS public.institute_accounts;
DROP SEQUENCE IF EXISTS public.hostels_id_seq;
DROP TABLE IF EXISTS public.hostels;
DROP SEQUENCE IF EXISTS public.faqs_id_seq;
DROP TABLE IF EXISTS public.faqs;
DROP SEQUENCE IF EXISTS public.faculty_members_id_seq;
DROP TABLE IF EXISTS public.faculty_members;
DROP SEQUENCE IF EXISTS public.exams_exam_id_seq;
DROP TABLE IF EXISTS public.exams;
DROP SEQUENCE IF EXISTS public.exam_schedules_schedule_id_seq;
DROP TABLE IF EXISTS public.exam_schedules;
DROP SEQUENCE IF EXISTS public.exam_cutoffs_cutoff_id_seq;
DROP TABLE IF EXISTS public.exam_cutoffs;
DROP SEQUENCE IF EXISTS public.education_loans_loan_id_seq;
DROP TABLE IF EXISTS public.education_loans;
DROP SEQUENCE IF EXISTS public.degree_categories_category_id_seq;
DROP TABLE IF EXISTS public.degree_categories;
DROP SEQUENCE IF EXISTS public.courses_course_id_seq;
DROP TABLE IF EXISTS public.courses;
DROP SEQUENCE IF EXISTS public.course_types_master_course_type_id_seq;
DROP TABLE IF EXISTS public.course_types_master;
DROP SEQUENCE IF EXISTS public.course_page_content_content_id_seq;
DROP TABLE IF EXISTS public.course_page_content;
DROP SEQUENCE IF EXISTS public.course_location_content_content_id_seq;
DROP TABLE IF EXISTS public.course_location_content;
DROP SEQUENCE IF EXISTS public.contact_queries_id_seq;
DROP TABLE IF EXISTS public.contact_queries;
DROP SEQUENCE IF EXISTS public.community_questions_question_id_seq;
DROP TABLE IF EXISTS public.community_questions;
DROP SEQUENCE IF EXISTS public.community_answers_answer_id_seq;
DROP TABLE IF EXISTS public.community_answers;
DROP SEQUENCE IF EXISTS public.colleges_college_id_seq;
DROP TABLE IF EXISTS public.colleges;
DROP SEQUENCE IF EXISTS public.college_updates_id_seq;
DROP TABLE IF EXISTS public.college_updates;
DROP SEQUENCE IF EXISTS public.college_rankings_ranking_id_seq;
DROP TABLE IF EXISTS public.college_rankings;
DROP SEQUENCE IF EXISTS public.college_media_media_id_seq;
DROP TABLE IF EXISTS public.college_media;
DROP SEQUENCE IF EXISTS public.college_gallery_id_seq;
DROP TABLE IF EXISTS public.college_gallery;
DROP SEQUENCE IF EXISTS public.college_facilities_facility_id_seq;
DROP TABLE IF EXISTS public.college_facilities;
DROP SEQUENCE IF EXISTS public.college_content_id_seq;
DROP TABLE IF EXISTS public.college_content;
DROP SEQUENCE IF EXISTS public.banners_id_seq;
DROP TABLE IF EXISTS public.banners;
DROP SEQUENCE IF EXISTS public.banner_analytics_id_seq;
DROP TABLE IF EXISTS public.banner_analytics;
DROP SEQUENCE IF EXISTS public.audit_log_id_seq;
DROP TABLE IF EXISTS public.audit_log;
DROP SEQUENCE IF EXISTS public.admin_users_admin_id_seq;
DROP TABLE IF EXISTS public.admin_users;
DROP SEQUENCE IF EXISTS public.admin_sessions_session_id_seq;
DROP TABLE IF EXISTS public.admin_sessions;
DROP SEQUENCE IF EXISTS public.admin_audit_logs_log_id_seq;
DROP TABLE IF EXISTS public.admin_audit_logs;
DROP SEQUENCE IF EXISTS geo_master.states_state_id_seq;
DROP TABLE IF EXISTS geo_master.states;
DROP SEQUENCE IF EXISTS geo_master.countries_country_id_seq;
DROP TABLE IF EXISTS geo_master.countries;
DROP SEQUENCE IF EXISTS geo_master.cities_city_id_seq;
DROP TABLE IF EXISTS geo_master.cities;
DROP TABLE IF EXISTS discovery.user_favorites;
DROP SEQUENCE IF EXISTS discovery.streams_id_seq;
DROP TABLE IF EXISTS discovery.streams;
DROP SEQUENCE IF EXISTS discovery.seo_metadata_id_seq;
DROP TABLE IF EXISTS discovery.seo_metadata;
DROP SEQUENCE IF EXISTS discovery.review_moderation_id_seq;
DROP TABLE IF EXISTS discovery.review_moderation;
DROP SEQUENCE IF EXISTS discovery.recruiter_companies_id_seq;
DROP TABLE IF EXISTS discovery.recruiter_companies;
DROP SEQUENCE IF EXISTS discovery.qna_votes_id_seq;
DROP TABLE IF EXISTS discovery.qna_votes;
DROP SEQUENCE IF EXISTS discovery.qna_id_seq;
DROP TABLE IF EXISTS discovery.qna;
DROP SEQUENCE IF EXISTS discovery.institution_videos_id_seq;
DROP TABLE IF EXISTS discovery.institution_videos;
DROP SEQUENCE IF EXISTS discovery.institution_highlights_id_seq;
DROP TABLE IF EXISTS discovery.institution_highlights;
DROP TABLE IF EXISTS discovery.institution_facilities;
DROP SEQUENCE IF EXISTS discovery.institution_courses_id_seq;
DROP TABLE IF EXISTS discovery.institution_courses;
DROP SEQUENCE IF EXISTS discovery.institution_brochures_id_seq;
DROP TABLE IF EXISTS discovery.institution_brochures;
DROP SEQUENCE IF EXISTS discovery.institution_approvals_id_seq;
DROP TABLE IF EXISTS discovery.institution_approvals;
DROP SEQUENCE IF EXISTS discovery.institution_affiliations_id_seq;
DROP TABLE IF EXISTS discovery.institution_affiliations;
DROP SEQUENCE IF EXISTS discovery.facilities_id_seq;
DROP TABLE IF EXISTS discovery.facilities;
DROP SEQUENCE IF EXISTS discovery.course_specializations_id_seq;
DROP TABLE IF EXISTS discovery.course_specializations;
DROP SEQUENCE IF EXISTS discovery.course_fees_id_seq;
DROP TABLE IF EXISTS discovery.course_fees;
DROP SEQUENCE IF EXISTS discovery.course_admissions_id_seq;
DROP TABLE IF EXISTS discovery.course_admissions;
DROP SEQUENCE IF EXISTS discovery.applications_id_seq;
DROP TABLE IF EXISTS discovery.applications;
DROP SEQUENCE IF EXISTS discovery.application_documents_id_seq;
DROP TABLE IF EXISTS discovery.application_documents;
DROP SEQUENCE IF EXISTS analytics.user_activity_id_seq;
DROP TABLE IF EXISTS analytics.user_activity;
DROP SEQUENCE IF EXISTS analytics.payments_id_seq;
DROP TABLE IF EXISTS analytics.payments;
DROP SEQUENCE IF EXISTS analytics.leads_id_seq;
DROP TABLE IF EXISTS analytics.leads;
DROP SEQUENCE IF EXISTS analytics.lead_notes_id_seq;
DROP TABLE IF EXISTS analytics.lead_notes;
DROP SEQUENCE IF EXISTS analytics.counselling_sessions_id_seq;
DROP TABLE IF EXISTS analytics.counselling_sessions;
DROP FUNCTION IF EXISTS public.update_updated_at_column();
DROP TYPE IF EXISTS public.user_type_enum;
DROP TYPE IF EXISTS public.user_status_enum;
DROP TYPE IF EXISTS public.review_status_enum;
DROP TYPE IF EXISTS public.payment_status_enum;
DROP TYPE IF EXISTS public.ownership_enum;
DROP TYPE IF EXISTS public.exam_mode_enum;
DROP TYPE IF EXISTS public.exam_level_enum;
DROP TYPE IF EXISTS public.degree_level_enum;
DROP TYPE IF EXISTS public.cutoff_type_enum;
DROP TYPE IF EXISTS public.course_mode_enum;
DROP TYPE IF EXISTS public.college_type_enum;
DROP EXTENSION IF EXISTS "uuid-ossp";
DROP EXTENSION IF EXISTS pgcrypto;
DROP EXTENSION IF EXISTS pg_trgm;
DROP EXTENSION IF EXISTS earthdistance;
DROP EXTENSION IF EXISTS cube;
DROP SCHEMA IF EXISTS geo_master;
DROP SCHEMA IF EXISTS discovery;
DROP SCHEMA IF EXISTS analytics;
--
-- Name: analytics; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA analytics;


--
-- Name: SCHEMA analytics; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA analytics IS 'Analytics, leads, tracking, payments';


--
-- Name: discovery; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA discovery;


--
-- Name: SCHEMA discovery; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA discovery IS 'Core discovery content (institutions, courses, exams, content)';


--
-- Name: geo_master; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA geo_master;


--
-- Name: SCHEMA geo_master; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA geo_master IS 'Geographic master data (countries, states, cities)';


--
-- Name: cube; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS cube WITH SCHEMA public;


--
-- Name: EXTENSION cube; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION cube IS 'data type for multidimensional cubes';


--
-- Name: earthdistance; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS earthdistance WITH SCHEMA public;


--
-- Name: EXTENSION earthdistance; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION earthdistance IS 'calculate great-circle distances on the surface of the Earth';


--
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;


--
-- Name: EXTENSION pg_trgm; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: college_type_enum; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.college_type_enum AS ENUM (
    'University',
    'College',
    'Institute',
    'Deemed University'
);


--
-- Name: course_mode_enum; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.course_mode_enum AS ENUM (
    'Full-time',
    'Part-time',
    'Distance',
    'Online',
    'Blended'
);


--
-- Name: cutoff_type_enum; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.cutoff_type_enum AS ENUM (
    'Rank',
    'Score',
    'Percentile'
);


--
-- Name: degree_level_enum; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.degree_level_enum AS ENUM (
    'Undergraduate',
    'Postgraduate',
    'Doctoral',
    'Diploma',
    'Certificate'
);


--
-- Name: exam_level_enum; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.exam_level_enum AS ENUM (
    'National',
    'State',
    'University',
    'International'
);


--
-- Name: exam_mode_enum; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.exam_mode_enum AS ENUM (
    'Online',
    'Offline',
    'Both'
);


--
-- Name: ownership_enum; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.ownership_enum AS ENUM (
    'Government',
    'Private',
    'Autonomous',
    'Public-Private'
);


--
-- Name: payment_status_enum; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.payment_status_enum AS ENUM (
    'initiated',
    'pending',
    'success',
    'failed',
    'refunded'
);


--
-- Name: review_status_enum; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.review_status_enum AS ENUM (
    'pending',
    'approved',
    'rejected',
    'flagged'
);


--
-- Name: user_status_enum; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.user_status_enum AS ENUM (
    'active',
    'suspended',
    'banned',
    'deleted',
    'inactive'
);


--
-- Name: user_type_enum; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public.user_type_enum AS ENUM (
    'student',
    'parent',
    'counsellor',
    'admin',
    'institution'
);


--
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: counselling_sessions; Type: TABLE; Schema: analytics; Owner: -
--

CREATE TABLE analytics.counselling_sessions (
    id bigint NOT NULL,
    lead_id bigint,
    counsellor_id bigint,
    session_type character varying(50),
    duration_minutes integer,
    notes text,
    outcome character varying(50),
    next_follow_up date,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: counselling_sessions_id_seq; Type: SEQUENCE; Schema: analytics; Owner: -
--

CREATE SEQUENCE analytics.counselling_sessions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: counselling_sessions_id_seq; Type: SEQUENCE OWNED BY; Schema: analytics; Owner: -
--

ALTER SEQUENCE analytics.counselling_sessions_id_seq OWNED BY analytics.counselling_sessions.id;


--
-- Name: lead_notes; Type: TABLE; Schema: analytics; Owner: -
--

CREATE TABLE analytics.lead_notes (
    id bigint NOT NULL,
    lead_id bigint,
    user_id bigint,
    note text,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: lead_notes_id_seq; Type: SEQUENCE; Schema: analytics; Owner: -
--

CREATE SEQUENCE analytics.lead_notes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: lead_notes_id_seq; Type: SEQUENCE OWNED BY; Schema: analytics; Owner: -
--

ALTER SEQUENCE analytics.lead_notes_id_seq OWNED BY analytics.lead_notes.id;


--
-- Name: leads; Type: TABLE; Schema: analytics; Owner: -
--

CREATE TABLE analytics.leads (
    id bigint NOT NULL,
    user_id bigint,
    institution_id integer,
    institution_course_id integer,
    student_name character varying(255),
    student_email character varying(255),
    student_phone character varying(32),
    message text,
    source character varying(100),
    website_origin character varying(255),
    utm_source character varying(100),
    utm_medium character varying(100),
    utm_campaign character varying(100),
    assigned_to bigint,
    status character varying(50) DEFAULT 'NEW'::character varying,
    priority character varying(20) DEFAULT 'medium'::character varying,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone
);


--
-- Name: leads_id_seq; Type: SEQUENCE; Schema: analytics; Owner: -
--

CREATE SEQUENCE analytics.leads_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: leads_id_seq; Type: SEQUENCE OWNED BY; Schema: analytics; Owner: -
--

ALTER SEQUENCE analytics.leads_id_seq OWNED BY analytics.leads.id;


--
-- Name: payments; Type: TABLE; Schema: analytics; Owner: -
--

CREATE TABLE analytics.payments (
    id bigint NOT NULL,
    user_id bigint,
    institution_id integer,
    amount numeric NOT NULL,
    currency character varying(10) DEFAULT 'INR'::character varying,
    purpose character varying(100),
    payment_gateway character varying(50),
    transaction_id character varying(255),
    gateway_response jsonb,
    status character varying(50),
    refund_id character varying(255),
    refunded_at timestamp without time zone,
    meta jsonb,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: payments_id_seq; Type: SEQUENCE; Schema: analytics; Owner: -
--

CREATE SEQUENCE analytics.payments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: payments_id_seq; Type: SEQUENCE OWNED BY; Schema: analytics; Owner: -
--

ALTER SEQUENCE analytics.payments_id_seq OWNED BY analytics.payments.id;


--
-- Name: user_activity; Type: TABLE; Schema: analytics; Owner: -
--

CREATE TABLE analytics.user_activity (
    id bigint NOT NULL,
    user_id bigint,
    session_id character varying(255),
    activity_type character varying(50) NOT NULL,
    entity_type character varying(50),
    entity_id bigint,
    search_query text,
    filters_applied jsonb,
    meta jsonb,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: user_activity_id_seq; Type: SEQUENCE; Schema: analytics; Owner: -
--

CREATE SEQUENCE analytics.user_activity_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_activity_id_seq; Type: SEQUENCE OWNED BY; Schema: analytics; Owner: -
--

ALTER SEQUENCE analytics.user_activity_id_seq OWNED BY analytics.user_activity.id;


--
-- Name: application_documents; Type: TABLE; Schema: discovery; Owner: -
--

CREATE TABLE discovery.application_documents (
    id integer NOT NULL,
    application_id bigint,
    document_type character varying(100),
    file_url text,
    is_verified boolean DEFAULT false,
    verified_by bigint,
    verified_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: application_documents_id_seq; Type: SEQUENCE; Schema: discovery; Owner: -
--

CREATE SEQUENCE discovery.application_documents_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: application_documents_id_seq; Type: SEQUENCE OWNED BY; Schema: discovery; Owner: -
--

ALTER SEQUENCE discovery.application_documents_id_seq OWNED BY discovery.application_documents.id;


--
-- Name: applications; Type: TABLE; Schema: discovery; Owner: -
--

CREATE TABLE discovery.applications (
    id bigint NOT NULL,
    user_id bigint,
    institution_course_id integer,
    academic_year character varying(20),
    status character varying(50) DEFAULT 'draft'::character varying,
    submitted_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


--
-- Name: applications_id_seq; Type: SEQUENCE; Schema: discovery; Owner: -
--

CREATE SEQUENCE discovery.applications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: applications_id_seq; Type: SEQUENCE OWNED BY; Schema: discovery; Owner: -
--

ALTER SEQUENCE discovery.applications_id_seq OWNED BY discovery.applications.id;


--
-- Name: course_admissions; Type: TABLE; Schema: discovery; Owner: -
--

CREATE TABLE discovery.course_admissions (
    id integer NOT NULL,
    institution_course_id integer,
    academic_year character varying(20),
    application_start date,
    application_end date,
    admission_mode character varying(100),
    process text,
    counseling text,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: course_admissions_id_seq; Type: SEQUENCE; Schema: discovery; Owner: -
--

CREATE SEQUENCE discovery.course_admissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: course_admissions_id_seq; Type: SEQUENCE OWNED BY; Schema: discovery; Owner: -
--

ALTER SEQUENCE discovery.course_admissions_id_seq OWNED BY discovery.course_admissions.id;


--
-- Name: course_fees; Type: TABLE; Schema: discovery; Owner: -
--

CREATE TABLE discovery.course_fees (
    id integer NOT NULL,
    institution_course_id integer,
    year integer NOT NULL,
    tuition_fee numeric,
    hostel_fee numeric,
    exam_fee numeric,
    other_fee numeric,
    total_fee numeric,
    currency character varying(10) DEFAULT 'INR'::character varying,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: course_fees_id_seq; Type: SEQUENCE; Schema: discovery; Owner: -
--

CREATE SEQUENCE discovery.course_fees_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: course_fees_id_seq; Type: SEQUENCE OWNED BY; Schema: discovery; Owner: -
--

ALTER SEQUENCE discovery.course_fees_id_seq OWNED BY discovery.course_fees.id;


--
-- Name: course_specializations; Type: TABLE; Schema: discovery; Owner: -
--

CREATE TABLE discovery.course_specializations (
    id integer NOT NULL,
    institution_course_id integer,
    name character varying(255) NOT NULL,
    seats integer
);


--
-- Name: course_specializations_id_seq; Type: SEQUENCE; Schema: discovery; Owner: -
--

CREATE SEQUENCE discovery.course_specializations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: course_specializations_id_seq; Type: SEQUENCE OWNED BY; Schema: discovery; Owner: -
--

ALTER SEQUENCE discovery.course_specializations_id_seq OWNED BY discovery.course_specializations.id;


--
-- Name: facilities; Type: TABLE; Schema: discovery; Owner: -
--

CREATE TABLE discovery.facilities (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


--
-- Name: facilities_id_seq; Type: SEQUENCE; Schema: discovery; Owner: -
--

CREATE SEQUENCE discovery.facilities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: facilities_id_seq; Type: SEQUENCE OWNED BY; Schema: discovery; Owner: -
--

ALTER SEQUENCE discovery.facilities_id_seq OWNED BY discovery.facilities.id;


--
-- Name: institution_affiliations; Type: TABLE; Schema: discovery; Owner: -
--

CREATE TABLE discovery.institution_affiliations (
    id integer NOT NULL,
    institution_id integer,
    affiliated_to character varying(255),
    notes text
);


--
-- Name: institution_affiliations_id_seq; Type: SEQUENCE; Schema: discovery; Owner: -
--

CREATE SEQUENCE discovery.institution_affiliations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: institution_affiliations_id_seq; Type: SEQUENCE OWNED BY; Schema: discovery; Owner: -
--

ALTER SEQUENCE discovery.institution_affiliations_id_seq OWNED BY discovery.institution_affiliations.id;


--
-- Name: institution_approvals; Type: TABLE; Schema: discovery; Owner: -
--

CREATE TABLE discovery.institution_approvals (
    id integer NOT NULL,
    institution_id integer,
    approval_type character varying(100),
    approval_number character varying(150),
    grade character varying(50),
    valid_from date,
    valid_to date,
    notes text,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: institution_approvals_id_seq; Type: SEQUENCE; Schema: discovery; Owner: -
--

CREATE SEQUENCE discovery.institution_approvals_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: institution_approvals_id_seq; Type: SEQUENCE OWNED BY; Schema: discovery; Owner: -
--

ALTER SEQUENCE discovery.institution_approvals_id_seq OWNED BY discovery.institution_approvals.id;


--
-- Name: institution_brochures; Type: TABLE; Schema: discovery; Owner: -
--

CREATE TABLE discovery.institution_brochures (
    id integer NOT NULL,
    institution_id integer,
    file_url text NOT NULL,
    title character varying(255),
    language character varying(20),
    academic_year character varying(20),
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: institution_brochures_id_seq; Type: SEQUENCE; Schema: discovery; Owner: -
--

CREATE SEQUENCE discovery.institution_brochures_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: institution_brochures_id_seq; Type: SEQUENCE OWNED BY; Schema: discovery; Owner: -
--

ALTER SEQUENCE discovery.institution_brochures_id_seq OWNED BY discovery.institution_brochures.id;


--
-- Name: institution_courses; Type: TABLE; Schema: discovery; Owner: -
--

CREATE TABLE discovery.institution_courses (
    id integer NOT NULL,
    institution_id integer,
    course_id integer,
    seats integer,
    mode character varying(50),
    affiliated_to character varying(255),
    approved_by character varying(255),
    view_count bigint DEFAULT 0,
    is_trending boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    deleted_at timestamp without time zone
);


--
-- Name: institution_courses_id_seq; Type: SEQUENCE; Schema: discovery; Owner: -
--

CREATE SEQUENCE discovery.institution_courses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: institution_courses_id_seq; Type: SEQUENCE OWNED BY; Schema: discovery; Owner: -
--

ALTER SEQUENCE discovery.institution_courses_id_seq OWNED BY discovery.institution_courses.id;


--
-- Name: institution_facilities; Type: TABLE; Schema: discovery; Owner: -
--

CREATE TABLE discovery.institution_facilities (
    institution_id integer NOT NULL,
    facility_id integer NOT NULL,
    details text
);


--
-- Name: institution_highlights; Type: TABLE; Schema: discovery; Owner: -
--

CREATE TABLE discovery.institution_highlights (
    id integer NOT NULL,
    institution_id integer,
    title character varying(255),
    value text
);


--
-- Name: institution_highlights_id_seq; Type: SEQUENCE; Schema: discovery; Owner: -
--

CREATE SEQUENCE discovery.institution_highlights_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: institution_highlights_id_seq; Type: SEQUENCE OWNED BY; Schema: discovery; Owner: -
--

ALTER SEQUENCE discovery.institution_highlights_id_seq OWNED BY discovery.institution_highlights.id;


--
-- Name: institution_videos; Type: TABLE; Schema: discovery; Owner: -
--

CREATE TABLE discovery.institution_videos (
    id integer NOT NULL,
    institution_id integer,
    video_url text NOT NULL,
    title character varying(255),
    description text,
    thumbnail_url text,
    duration_seconds integer,
    category character varying(50),
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: institution_videos_id_seq; Type: SEQUENCE; Schema: discovery; Owner: -
--

CREATE SEQUENCE discovery.institution_videos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: institution_videos_id_seq; Type: SEQUENCE OWNED BY; Schema: discovery; Owner: -
--

ALTER SEQUENCE discovery.institution_videos_id_seq OWNED BY discovery.institution_videos.id;


--
-- Name: qna; Type: TABLE; Schema: discovery; Owner: -
--

CREATE TABLE discovery.qna (
    id integer NOT NULL,
    institution_id integer,
    course_id integer,
    user_id bigint,
    question text NOT NULL,
    answer text,
    answered_by bigint,
    is_featured boolean DEFAULT false,
    helpful_count integer DEFAULT 0,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    answered_at timestamp without time zone
);


--
-- Name: qna_id_seq; Type: SEQUENCE; Schema: discovery; Owner: -
--

CREATE SEQUENCE discovery.qna_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: qna_id_seq; Type: SEQUENCE OWNED BY; Schema: discovery; Owner: -
--

ALTER SEQUENCE discovery.qna_id_seq OWNED BY discovery.qna.id;


--
-- Name: qna_votes; Type: TABLE; Schema: discovery; Owner: -
--

CREATE TABLE discovery.qna_votes (
    id integer NOT NULL,
    qna_id integer,
    user_id bigint,
    is_helpful boolean,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: qna_votes_id_seq; Type: SEQUENCE; Schema: discovery; Owner: -
--

CREATE SEQUENCE discovery.qna_votes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: qna_votes_id_seq; Type: SEQUENCE OWNED BY; Schema: discovery; Owner: -
--

ALTER SEQUENCE discovery.qna_votes_id_seq OWNED BY discovery.qna_votes.id;


--
-- Name: recruiter_companies; Type: TABLE; Schema: discovery; Owner: -
--

CREATE TABLE discovery.recruiter_companies (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    logo_url text,
    website character varying(255),
    industry character varying(100),
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: recruiter_companies_id_seq; Type: SEQUENCE; Schema: discovery; Owner: -
--

CREATE SEQUENCE discovery.recruiter_companies_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: recruiter_companies_id_seq; Type: SEQUENCE OWNED BY; Schema: discovery; Owner: -
--

ALTER SEQUENCE discovery.recruiter_companies_id_seq OWNED BY discovery.recruiter_companies.id;


--
-- Name: review_moderation; Type: TABLE; Schema: discovery; Owner: -
--

CREATE TABLE discovery.review_moderation (
    id integer NOT NULL,
    review_id integer,
    status character varying(50) DEFAULT 'pending'::character varying,
    moderated_by bigint,
    comments text,
    moderated_at timestamp without time zone
);


--
-- Name: review_moderation_id_seq; Type: SEQUENCE; Schema: discovery; Owner: -
--

CREATE SEQUENCE discovery.review_moderation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: review_moderation_id_seq; Type: SEQUENCE OWNED BY; Schema: discovery; Owner: -
--

ALTER SEQUENCE discovery.review_moderation_id_seq OWNED BY discovery.review_moderation.id;


--
-- Name: seo_metadata; Type: TABLE; Schema: discovery; Owner: -
--

CREATE TABLE discovery.seo_metadata (
    id integer NOT NULL,
    entity_type character varying(50),
    entity_id integer,
    meta_title character varying(255),
    meta_description text,
    meta_keywords text,
    canonical_url text,
    og_title character varying(255),
    og_description text,
    og_image text,
    schema_json jsonb,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


--
-- Name: seo_metadata_id_seq; Type: SEQUENCE; Schema: discovery; Owner: -
--

CREATE SEQUENCE discovery.seo_metadata_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: seo_metadata_id_seq; Type: SEQUENCE OWNED BY; Schema: discovery; Owner: -
--

ALTER SEQUENCE discovery.seo_metadata_id_seq OWNED BY discovery.seo_metadata.id;


--
-- Name: streams; Type: TABLE; Schema: discovery; Owner: -
--

CREATE TABLE discovery.streams (
    id integer NOT NULL,
    name character varying(150) NOT NULL,
    description text
);


--
-- Name: streams_id_seq; Type: SEQUENCE; Schema: discovery; Owner: -
--

CREATE SEQUENCE discovery.streams_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: streams_id_seq; Type: SEQUENCE OWNED BY; Schema: discovery; Owner: -
--

ALTER SEQUENCE discovery.streams_id_seq OWNED BY discovery.streams.id;


--
-- Name: user_favorites; Type: TABLE; Schema: discovery; Owner: -
--

CREATE TABLE discovery.user_favorites (
    user_id bigint NOT NULL,
    entity_type character varying(50) NOT NULL,
    entity_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: cities; Type: TABLE; Schema: geo_master; Owner: -
--

CREATE TABLE geo_master.cities (
    city_id integer NOT NULL,
    state_id integer,
    city_name character varying(100) NOT NULL,
    population integer,
    is_metro boolean DEFAULT false
);


--
-- Name: cities_city_id_seq; Type: SEQUENCE; Schema: geo_master; Owner: -
--

CREATE SEQUENCE geo_master.cities_city_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cities_city_id_seq; Type: SEQUENCE OWNED BY; Schema: geo_master; Owner: -
--

ALTER SEQUENCE geo_master.cities_city_id_seq OWNED BY geo_master.cities.city_id;


--
-- Name: countries; Type: TABLE; Schema: geo_master; Owner: -
--

CREATE TABLE geo_master.countries (
    country_id integer NOT NULL,
    country_name character varying(100) NOT NULL,
    country_code character varying(5) NOT NULL,
    currency character varying(10),
    is_study_destination boolean DEFAULT false
);


--
-- Name: countries_country_id_seq; Type: SEQUENCE; Schema: geo_master; Owner: -
--

CREATE SEQUENCE geo_master.countries_country_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: countries_country_id_seq; Type: SEQUENCE OWNED BY; Schema: geo_master; Owner: -
--

ALTER SEQUENCE geo_master.countries_country_id_seq OWNED BY geo_master.countries.country_id;


--
-- Name: states; Type: TABLE; Schema: geo_master; Owner: -
--

CREATE TABLE geo_master.states (
    state_id integer NOT NULL,
    country_id integer,
    state_name character varying(100) NOT NULL,
    state_code character varying(10)
);


--
-- Name: states_state_id_seq; Type: SEQUENCE; Schema: geo_master; Owner: -
--

CREATE SEQUENCE geo_master.states_state_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: states_state_id_seq; Type: SEQUENCE OWNED BY; Schema: geo_master; Owner: -
--

ALTER SEQUENCE geo_master.states_state_id_seq OWNED BY geo_master.states.state_id;


--
-- Name: admin_audit_logs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin_audit_logs (
    log_id integer NOT NULL,
    admin_id integer,
    action character varying(100),
    resource_type character varying(50),
    resource_id integer,
    details jsonb,
    ip_address character varying(50),
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: admin_audit_logs_log_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.admin_audit_logs_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admin_audit_logs_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.admin_audit_logs_log_id_seq OWNED BY public.admin_audit_logs.log_id;


--
-- Name: admin_sessions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin_sessions (
    session_id integer NOT NULL,
    admin_id integer,
    session_token text NOT NULL,
    ip_address character varying(50),
    expires_at timestamp without time zone,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: admin_sessions_session_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.admin_sessions_session_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admin_sessions_session_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.admin_sessions_session_id_seq OWNED BY public.admin_sessions.session_id;


--
-- Name: admin_users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.admin_users (
    admin_id integer NOT NULL,
    email character varying(255) NOT NULL,
    password_hash character varying(255) NOT NULL,
    name character varying(200),
    role character varying(50) DEFAULT 'admin'::character varying,
    status character varying(20) DEFAULT 'active'::character varying,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


--
-- Name: admin_users_admin_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.admin_users_admin_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admin_users_admin_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.admin_users_admin_id_seq OWNED BY public.admin_users.admin_id;


--
-- Name: audit_log; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.audit_log (
    id bigint NOT NULL,
    user_id bigint,
    action character varying(255) NOT NULL,
    entity character varying(255),
    entity_id bigint,
    old_values jsonb,
    new_values jsonb,
    meta jsonb,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: audit_log_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.audit_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: audit_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.audit_log_id_seq OWNED BY public.audit_log.id;


--
-- Name: banner_analytics; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.banner_analytics (
    id bigint NOT NULL,
    banner_id integer,
    event_type character varying(20),
    user_id bigint,
    session_id character varying(255),
    ip_address character varying(50),
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: banner_analytics_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.banner_analytics_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: banner_analytics_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.banner_analytics_id_seq OWNED BY public.banner_analytics.id;


--
-- Name: banners; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.banners (
    id integer NOT NULL,
    title character varying(255),
    image_url text,
    link_url text,
    placement character varying(100),
    page_type character varying(50),
    target_audience character varying(50),
    priority integer DEFAULT 0,
    valid_from timestamp without time zone,
    valid_to timestamp without time zone,
    is_active boolean DEFAULT true,
    click_count integer DEFAULT 0,
    view_count integer DEFAULT 0,
    created_by bigint,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: banners_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.banners_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: banners_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.banners_id_seq OWNED BY public.banners.id;


--
-- Name: college_content; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.college_content (
    id integer NOT NULL,
    college_id bigint NOT NULL,
    section_type character varying(50) NOT NULL,
    title character varying(500),
    content text,
    table_of_contents jsonb,
    author_id integer,
    meta_title character varying(200),
    meta_description text,
    status character varying(20) DEFAULT 'draft'::character varying,
    published_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: college_content_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.college_content_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: college_content_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.college_content_id_seq OWNED BY public.college_content.id;


--
-- Name: college_facilities; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.college_facilities (
    facility_id bigint NOT NULL,
    college_id bigint NOT NULL,
    facility_type character varying(100) NOT NULL,
    facility_name character varying(200),
    description text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: college_facilities_facility_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.college_facilities_facility_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: college_facilities_facility_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.college_facilities_facility_id_seq OWNED BY public.college_facilities.facility_id;


--
-- Name: college_gallery; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.college_gallery (
    id integer NOT NULL,
    college_id bigint,
    category character varying(50) NOT NULL,
    image_url text NOT NULL,
    caption character varying(255),
    display_order integer DEFAULT 0,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: college_gallery_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.college_gallery_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: college_gallery_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.college_gallery_id_seq OWNED BY public.college_gallery.id;


--
-- Name: college_media; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.college_media (
    media_id bigint NOT NULL,
    college_id bigint NOT NULL,
    media_type character varying(50),
    media_url text NOT NULL,
    title character varying(300),
    uploaded_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: college_media_media_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.college_media_media_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: college_media_media_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.college_media_media_id_seq OWNED BY public.college_media.media_id;


--
-- Name: college_rankings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.college_rankings (
    ranking_id bigint NOT NULL,
    college_id bigint NOT NULL,
    agency_id integer,
    ranking_year integer NOT NULL,
    category character varying(100),
    rank_position integer,
    score numeric(6,2),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: college_rankings_ranking_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.college_rankings_ranking_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: college_rankings_ranking_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.college_rankings_ranking_id_seq OWNED BY public.college_rankings.ranking_id;


--
-- Name: college_updates; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.college_updates (
    id integer NOT NULL,
    college_id bigint NOT NULL,
    update_type character varying(20) DEFAULT 'key_update'::character varying,
    title character varying(300) NOT NULL,
    content text NOT NULL,
    source_url text,
    event_date date,
    is_pinned boolean DEFAULT false,
    published_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    expires_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: college_updates_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.college_updates_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: college_updates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.college_updates_id_seq OWNED BY public.college_updates.id;


--
-- Name: colleges; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.colleges (
    college_id bigint NOT NULL,
    college_name character varying(300) NOT NULL,
    slug character varying(300) NOT NULL,
    short_name character varying(100),
    established_year integer,
    college_type public.college_type_enum,
    ownership public.ownership_enum,
    country character varying(100) DEFAULT 'India'::character varying,
    state character varying(100),
    city character varying(100),
    pincode character varying(20),
    address text,
    latitude numeric(10,8),
    longitude numeric(11,8),
    website_url text,
    phone character varying(100),
    email character varying(255),
    description text,
    logo_url text,
    is_featured boolean DEFAULT false,
    is_verified boolean DEFAULT false,
    status character varying(20) DEFAULT 'active'::character varying,
    avg_rating numeric(3,2) DEFAULT 0.00,
    total_reviews integer DEFAULT 0,
    view_count bigint DEFAULT 0,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    deleted_at timestamp without time zone,
    is_popular boolean DEFAULT false,
    cover_image_url text,
    accreditation character varying(100),
    affiliation character varying(200),
    campus_size character varying(50)
);


--
-- Name: colleges_college_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.colleges_college_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: colleges_college_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.colleges_college_id_seq OWNED BY public.colleges.college_id;


--
-- Name: community_answers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.community_answers (
    answer_id bigint NOT NULL,
    question_id bigint NOT NULL,
    user_id bigint,
    answer_text text NOT NULL,
    is_accepted boolean DEFAULT false,
    upvote_count integer DEFAULT 0,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: community_answers_answer_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.community_answers_answer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: community_answers_answer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.community_answers_answer_id_seq OWNED BY public.community_answers.answer_id;


--
-- Name: community_questions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.community_questions (
    question_id bigint NOT NULL,
    user_id bigint,
    title character varying(500) NOT NULL,
    question_text text NOT NULL,
    category character varying(100),
    college_id bigint,
    view_count integer DEFAULT 0,
    upvote_count integer DEFAULT 0,
    answer_count integer DEFAULT 0,
    status character varying(50) DEFAULT 'open'::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: community_questions_question_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.community_questions_question_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: community_questions_question_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.community_questions_question_id_seq OWNED BY public.community_questions.question_id;


--
-- Name: contact_queries; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.contact_queries (
    id bigint NOT NULL,
    name text,
    email text,
    phone text,
    subject character varying(255),
    message text NOT NULL,
    status character varying(30) DEFAULT 'new'::character varying,
    assigned_to bigint,
    response text,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    responded_at timestamp without time zone
);


--
-- Name: contact_queries_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.contact_queries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: contact_queries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.contact_queries_id_seq OWNED BY public.contact_queries.id;


--
-- Name: course_location_content; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.course_location_content (
    content_id integer NOT NULL,
    course_type character varying(50) NOT NULL,
    location_type character varying(20) DEFAULT 'city'::character varying NOT NULL,
    location_name character varying(100) NOT NULL,
    location_slug character varying(100) NOT NULL,
    page_title character varying(255),
    full_content text,
    author_id integer,
    meta_title character varying(200),
    meta_description character varying(500),
    banners jsonb DEFAULT '[]'::jsonb,
    status character varying(20) DEFAULT 'draft'::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT course_location_content_location_type_check CHECK (((location_type)::text = ANY ((ARRAY['city'::character varying, 'state'::character varying])::text[]))),
    CONSTRAINT course_location_content_status_check CHECK (((status)::text = ANY ((ARRAY['draft'::character varying, 'published'::character varying])::text[])))
);


--
-- Name: TABLE course_location_content; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.course_location_content IS 'Content for city/state specific course pages like /btech/mumbai-colleges';


--
-- Name: course_location_content_content_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.course_location_content_content_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: course_location_content_content_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.course_location_content_content_id_seq OWNED BY public.course_location_content.content_id;


--
-- Name: course_page_content; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.course_page_content (
    content_id integer NOT NULL,
    course_type character varying(50) NOT NULL,
    page_title character varying(255) NOT NULL,
    full_content text,
    author_id integer,
    meta_title character varying(255),
    meta_description text,
    status character varying(20) DEFAULT 'draft'::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    banners jsonb DEFAULT '[]'::jsonb,
    CONSTRAINT course_page_content_status_check CHECK (((status)::text = ANY ((ARRAY['draft'::character varying, 'published'::character varying])::text[])))
);


--
-- Name: TABLE course_page_content; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.course_page_content IS 'Course page content managed via admin rich text editor. Only uses full_content for all content.';


--
-- Name: course_page_content_content_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.course_page_content_content_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: course_page_content_content_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.course_page_content_content_id_seq OWNED BY public.course_page_content.content_id;


--
-- Name: course_types_master; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.course_types_master (
    course_type_id integer NOT NULL,
    name character varying(50) NOT NULL,
    slug character varying(50) NOT NULL,
    full_name character varying(255),
    category character varying(100),
    level character varying(50),
    duration_years numeric(3,1),
    display_order integer DEFAULT 0,
    status character varying(20) DEFAULT 'active'::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT course_types_master_level_check CHECK (((level)::text = ANY ((ARRAY['Undergraduate'::character varying, 'Postgraduate'::character varying, 'Diploma'::character varying, 'Certificate'::character varying, 'Doctoral'::character varying])::text[]))),
    CONSTRAINT course_types_master_status_check CHECK (((status)::text = ANY ((ARRAY['active'::character varying, 'inactive'::character varying])::text[])))
);


--
-- Name: course_types_master_course_type_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.course_types_master_course_type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: course_types_master_course_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.course_types_master_course_type_id_seq OWNED BY public.course_types_master.course_type_id;


--
-- Name: courses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.courses (
    course_id integer NOT NULL,
    college_id integer,
    course_name character varying(255) NOT NULL,
    short_name character varying(100),
    degree_type character varying(50) NOT NULL,
    duration character varying(50),
    stream character varying(100),
    specialization character varying(255),
    total_fees numeric(12,2),
    fees_type character varying(50) DEFAULT 'Per Year'::character varying,
    eligibility text,
    seats_available integer,
    course_mode character varying(50) DEFAULT 'Full-time'::character varying,
    description text,
    status character varying(20) DEFAULT 'active'::character varying,
    is_featured boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    deleted_at timestamp without time zone,
    application_start_date date,
    application_end_date date,
    brochure_url text
);


--
-- Name: courses_course_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.courses_course_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: courses_course_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.courses_course_id_seq OWNED BY public.courses.course_id;


--
-- Name: degree_categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.degree_categories (
    category_id integer NOT NULL,
    name character varying(100) NOT NULL,
    display_order integer DEFAULT 0,
    status character varying(20) DEFAULT 'active'::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    slug character varying(100),
    icon character varying(50),
    description text,
    CONSTRAINT degree_categories_status_check CHECK (((status)::text = ANY ((ARRAY['active'::character varying, 'inactive'::character varying])::text[])))
);


--
-- Name: degree_categories_category_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.degree_categories_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: degree_categories_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.degree_categories_category_id_seq OWNED BY public.degree_categories.category_id;


--
-- Name: education_loans; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.education_loans (
    loan_id bigint NOT NULL,
    loan_provider character varying(300) NOT NULL,
    provider_type character varying(50),
    country character varying(100),
    max_loan_amount numeric(15,2),
    currency character varying(10),
    interest_rate_min numeric(5,2),
    interest_rate_max numeric(5,2),
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: education_loans_loan_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.education_loans_loan_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: education_loans_loan_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.education_loans_loan_id_seq OWNED BY public.education_loans.loan_id;


--
-- Name: exam_cutoffs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.exam_cutoffs (
    cutoff_id bigint NOT NULL,
    exam_id bigint NOT NULL,
    college_id bigint NOT NULL,
    course_id bigint,
    academic_year character varying(20),
    category character varying(50),
    cutoff_type public.cutoff_type_enum,
    cutoff_value numeric(10,2),
    closing_rank integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    round integer DEFAULT 1,
    opening_rank integer,
    specialization character varying(200)
);


--
-- Name: exam_cutoffs_cutoff_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.exam_cutoffs_cutoff_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: exam_cutoffs_cutoff_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.exam_cutoffs_cutoff_id_seq OWNED BY public.exam_cutoffs.cutoff_id;


--
-- Name: exam_schedules; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.exam_schedules (
    schedule_id bigint NOT NULL,
    exam_id bigint NOT NULL,
    academic_year character varying(20) NOT NULL,
    application_start date,
    application_end date,
    exam_start_date date,
    exam_end_date date,
    result_date date,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: exam_schedules_schedule_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.exam_schedules_schedule_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: exam_schedules_schedule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.exam_schedules_schedule_id_seq OWNED BY public.exam_schedules.schedule_id;


--
-- Name: exams; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.exams (
    exam_id bigint NOT NULL,
    exam_name character varying(300) NOT NULL,
    slug character varying(300) NOT NULL,
    short_name character varying(100),
    exam_category character varying(100),
    exam_level public.exam_level_enum,
    exam_mode public.exam_mode_enum,
    conducting_body character varying(300),
    official_website text,
    description text,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    deleted_at timestamp without time zone
);


--
-- Name: exams_exam_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.exams_exam_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: exams_exam_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.exams_exam_id_seq OWNED BY public.exams.exam_id;


--
-- Name: faculty_members; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.faculty_members (
    id integer NOT NULL,
    college_id bigint NOT NULL,
    name character varying(200) NOT NULL,
    designation character varying(100),
    department character varying(200),
    qualification character varying(300),
    specialization character varying(300),
    experience_years integer,
    profile_image_url text,
    email character varying(255),
    profile_url text,
    status character varying(20) DEFAULT 'active'::character varying,
    display_order integer DEFAULT 0,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    phone character varying(50)
);


--
-- Name: faculty_members_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.faculty_members_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: faculty_members_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.faculty_members_id_seq OWNED BY public.faculty_members.id;


--
-- Name: faqs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.faqs (
    id integer NOT NULL,
    category character varying(100),
    question text NOT NULL,
    answer text NOT NULL,
    display_order integer DEFAULT 0,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: faqs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.faqs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: faqs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.faqs_id_seq OWNED BY public.faqs.id;


--
-- Name: hostels; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.hostels (
    id integer NOT NULL,
    college_id bigint NOT NULL,
    hostel_type character varying(20),
    name character varying(200),
    total_capacity integer,
    room_types jsonb,
    fee_per_semester numeric(10,2),
    mess_fee_per_semester numeric(10,2),
    amenities jsonb,
    description text,
    status character varying(20) DEFAULT 'active'::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    photos jsonb DEFAULT '[]'::jsonb
);


--
-- Name: hostels_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.hostels_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: hostels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.hostels_id_seq OWNED BY public.hostels.id;


--
-- Name: institute_accounts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.institute_accounts (
    id integer NOT NULL,
    institution_id integer NOT NULL,
    subscription_plan character varying(100),
    contract_start date,
    contract_end date,
    status character varying(50) DEFAULT 'ACTIVE'::character varying,
    account_manager_id bigint,
    features jsonb,
    max_users integer DEFAULT 1,
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now()
);


--
-- Name: institute_accounts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.institute_accounts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: institute_accounts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.institute_accounts_id_seq OWNED BY public.institute_accounts.id;


--
-- Name: institute_users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.institute_users (
    id integer NOT NULL,
    institution_id integer,
    user_id bigint,
    role character varying(50) DEFAULT 'editor'::character varying,
    permissions jsonb,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: institute_users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.institute_users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: institute_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.institute_users_id_seq OWNED BY public.institute_users.id;


--
-- Name: job_postings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.job_postings (
    id integer NOT NULL,
    title character varying(255),
    department character varying(100),
    location character varying(255),
    job_type character varying(50),
    experience_required character varying(100),
    description text,
    requirements text,
    responsibilities text,
    salary_range character varying(100),
    is_active boolean DEFAULT true,
    posted_date date,
    application_deadline date,
    apply_url text,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: job_postings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.job_postings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: job_postings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.job_postings_id_seq OWNED BY public.job_postings.id;


--
-- Name: news_articles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.news_articles (
    article_id bigint NOT NULL,
    title character varying(500) NOT NULL,
    slug character varying(500) NOT NULL,
    content text NOT NULL,
    category character varying(100),
    author_id bigint,
    is_featured boolean DEFAULT false,
    status character varying(50) DEFAULT 'draft'::character varying,
    view_count integer DEFAULT 0,
    published_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: news_articles_article_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.news_articles_article_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: news_articles_article_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.news_articles_article_id_seq OWNED BY public.news_articles.article_id;


--
-- Name: newsletter_subscribers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.newsletter_subscribers (
    id integer NOT NULL,
    email character varying(255) NOT NULL,
    phone character varying(32),
    name character varying(255),
    subscribed_at timestamp without time zone DEFAULT now(),
    is_active boolean DEFAULT true,
    unsubscribed_at timestamp without time zone,
    source character varying(100)
);


--
-- Name: newsletter_subscribers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.newsletter_subscribers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: newsletter_subscribers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.newsletter_subscribers_id_seq OWNED BY public.newsletter_subscribers.id;


--
-- Name: notification_preferences; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.notification_preferences (
    id integer NOT NULL,
    user_id bigint,
    email_notifications boolean DEFAULT true,
    exam_alerts boolean DEFAULT true,
    admission_alerts boolean DEFAULT true,
    newsletter boolean DEFAULT true,
    sms_notifications boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now()
);


--
-- Name: notification_preferences_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.notification_preferences_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: notification_preferences_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.notification_preferences_id_seq OWNED BY public.notification_preferences.id;


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.notifications (
    notification_id bigint NOT NULL,
    user_id bigint NOT NULL,
    notification_type character varying(100) NOT NULL,
    title character varying(300),
    message text NOT NULL,
    link_url text,
    status character varying(50) DEFAULT 'pending'::character varying,
    sent_at timestamp without time zone,
    read_at timestamp without time zone,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: notifications_notification_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.notifications_notification_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: notifications_notification_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.notifications_notification_id_seq OWNED BY public.notifications.notification_id;


--
-- Name: password_resets; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.password_resets (
    id bigint NOT NULL,
    user_id bigint,
    otp_code character varying(20),
    expires_at timestamp without time zone,
    used boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


--
-- Name: password_resets_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.password_resets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: password_resets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.password_resets_id_seq OWNED BY public.password_resets.id;


--
-- Name: payments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.payments (
    payment_id bigint NOT NULL,
    user_id bigint,
    order_id character varying(100) NOT NULL,
    payment_gateway character varying(50),
    amount numeric(10,2) NOT NULL,
    currency character varying(10) DEFAULT 'INR'::character varying,
    payment_status public.payment_status_enum DEFAULT 'initiated'::public.payment_status_enum,
    transaction_date timestamp without time zone,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: payments_payment_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.payments_payment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: payments_payment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.payments_payment_id_seq OWNED BY public.payments.payment_id;


--
-- Name: placement_recruiters; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.placement_recruiters (
    id integer NOT NULL,
    placement_id bigint NOT NULL,
    company_name character varying(200) NOT NULL,
    company_logo_url text,
    sector character varying(100),
    offers_count integer,
    package_offered numeric(12,2),
    is_top_recruiter boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: placement_recruiters_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.placement_recruiters_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: placement_recruiters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.placement_recruiters_id_seq OWNED BY public.placement_recruiters.id;


--
-- Name: placements; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.placements (
    placement_id bigint NOT NULL,
    college_id bigint NOT NULL,
    course_id bigint,
    academic_year character varying(20) NOT NULL,
    total_students integer,
    students_placed integer,
    placement_percentage numeric(5,2),
    highest_package numeric(12,2),
    average_package numeric(12,2),
    median_package numeric(12,2),
    currency character varying(10) DEFAULT 'INR'::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    deleted_at timestamp without time zone,
    companies_participated integer,
    ppos_offered integer,
    ppos_accepted integer,
    international_offers integer,
    highest_international_package numeric(12,2),
    top_sectors jsonb
);


--
-- Name: placements_placement_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.placements_placement_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: placements_placement_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.placements_placement_id_seq OWNED BY public.placements.placement_id;


--
-- Name: questions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.questions (
    question_id bigint NOT NULL,
    test_id bigint NOT NULL,
    question_text text NOT NULL,
    question_type character varying(50),
    marks numeric(4,2),
    option_a text,
    option_b text,
    option_c text,
    option_d text,
    correct_answer text,
    explanation text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: questions_question_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.questions_question_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: questions_question_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.questions_question_id_seq OWNED BY public.questions.question_id;


--
-- Name: quick_tabs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.quick_tabs (
    id integer NOT NULL,
    degree_type character varying(100) NOT NULL,
    display_name character varying(100) NOT NULL,
    slug character varying(200) NOT NULL,
    display_order integer DEFAULT 0 NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: TABLE quick_tabs; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.quick_tabs IS 'Stores which degree types appear in the navbar quick tabs';


--
-- Name: quick_tabs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.quick_tabs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: quick_tabs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.quick_tabs_id_seq OWNED BY public.quick_tabs.id;


--
-- Name: ranking_agencies; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ranking_agencies (
    agency_id integer NOT NULL,
    agency_name character varying(200) NOT NULL,
    agency_code character varying(50),
    country character varying(100),
    website_url text,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: ranking_agencies_agency_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.ranking_agencies_agency_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ranking_agencies_agency_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.ranking_agencies_agency_id_seq OWNED BY public.ranking_agencies.agency_id;


--
-- Name: reviews; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.reviews (
    review_id bigint NOT NULL,
    college_id bigint NOT NULL,
    user_id bigint,
    overall_rating numeric(2,1),
    academic_rating numeric(2,1),
    infrastructure_rating numeric(2,1),
    faculty_rating numeric(2,1),
    placement_rating numeric(2,1),
    review_title character varying(300),
    review_text text NOT NULL,
    pros text,
    cons text,
    is_verified boolean DEFAULT false,
    status public.review_status_enum DEFAULT 'pending'::public.review_status_enum,
    helpful_count integer DEFAULT 0,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    title character varying(255),
    admin_reply text,
    replied_at timestamp without time zone,
    replied_by integer,
    deleted_at timestamp without time zone,
    CONSTRAINT reviews_overall_rating_check CHECK (((overall_rating >= (0)::numeric) AND (overall_rating <= (5)::numeric)))
);


--
-- Name: reviews_review_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.reviews_review_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: reviews_review_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.reviews_review_id_seq OWNED BY public.reviews.review_id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.roles (
    id bigint NOT NULL,
    name character varying(100) NOT NULL,
    description text
);


--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- Name: saved_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.saved_items (
    saved_id bigint NOT NULL,
    user_id bigint NOT NULL,
    item_type character varying(50) NOT NULL,
    item_id bigint NOT NULL,
    notes text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: saved_items_saved_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.saved_items_saved_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: saved_items_saved_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.saved_items_saved_id_seq OWNED BY public.saved_items.saved_id;


--
-- Name: scholarships; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.scholarships (
    scholarship_id bigint NOT NULL,
    scholarship_name character varying(300) NOT NULL,
    slug character varying(300),
    provider_name character varying(300),
    scholarship_type character varying(100),
    country character varying(100),
    scholarship_amount numeric(12,2),
    currency character varying(10),
    eligibility_criteria text,
    application_deadline date,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    deleted_at timestamp without time zone
);


--
-- Name: scholarships_scholarship_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.scholarships_scholarship_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: scholarships_scholarship_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.scholarships_scholarship_id_seq OWNED BY public.scholarships.scholarship_id;


--
-- Name: search_logs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.search_logs (
    search_id bigint NOT NULL,
    user_id bigint,
    search_query text NOT NULL,
    search_type character varying(50),
    results_count integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: search_logs_search_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.search_logs_search_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: search_logs_search_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.search_logs_search_id_seq OWNED BY public.search_logs.search_id;


--
-- Name: site_notifications; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.site_notifications (
    id integer NOT NULL,
    title character varying(255),
    message text,
    type character varying(50),
    priority integer DEFAULT 0,
    link_url text,
    is_active boolean DEFAULT true,
    valid_from timestamp without time zone,
    valid_to timestamp without time zone,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: site_notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.site_notifications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: site_notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.site_notifications_id_seq OWNED BY public.site_notifications.id;


--
-- Name: system_settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.system_settings (
    id integer NOT NULL,
    setting_key character varying(100) NOT NULL,
    setting_value text,
    setting_type character varying(50) DEFAULT 'text'::character varying,
    category character varying(50),
    description text,
    is_public boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: system_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.system_settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: system_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.system_settings_id_seq OWNED BY public.system_settings.id;


--
-- Name: team_members; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.team_members (
    id integer NOT NULL,
    name character varying(255),
    designation character varying(255),
    photo_url text,
    bio text,
    linkedin_url text,
    twitter_url text,
    display_order integer DEFAULT 0,
    is_leadership boolean DEFAULT false,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: team_members_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.team_members_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: team_members_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.team_members_id_seq OWNED BY public.team_members.id;


--
-- Name: test_attempts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.test_attempts (
    attempt_id bigint NOT NULL,
    test_id bigint NOT NULL,
    user_id bigint NOT NULL,
    start_time timestamp without time zone NOT NULL,
    end_time timestamp without time zone,
    score numeric(8,2),
    percentage numeric(5,2),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: test_attempts_attempt_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.test_attempts_attempt_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: test_attempts_attempt_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.test_attempts_attempt_id_seq OWNED BY public.test_attempts.attempt_id;


--
-- Name: test_series; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.test_series (
    series_id bigint NOT NULL,
    series_name character varying(300) NOT NULL,
    exam_id bigint,
    price numeric(10,2) DEFAULT 0.00,
    total_tests integer,
    description text,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: test_series_series_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.test_series_series_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: test_series_series_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.test_series_series_id_seq OWNED BY public.test_series.series_id;


--
-- Name: testimonials; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.testimonials (
    id integer NOT NULL,
    student_name character varying(255),
    student_image text,
    institution_id integer,
    course_id integer,
    testimonial text,
    rating numeric(3,2),
    designation character varying(255),
    is_featured boolean DEFAULT false,
    is_approved boolean DEFAULT false,
    display_order integer DEFAULT 0,
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: testimonials_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.testimonials_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: testimonials_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.testimonials_id_seq OWNED BY public.testimonials.id;


--
-- Name: tests; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tests (
    test_id bigint NOT NULL,
    series_id bigint NOT NULL,
    test_name character varying(300) NOT NULL,
    test_type character varying(50),
    total_questions integer NOT NULL,
    total_marks numeric(6,2),
    duration_minutes integer,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: tests_test_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tests_test_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tests_test_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tests_test_id_seq OWNED BY public.tests.test_id;


--
-- Name: user_consents; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_consents (
    id integer NOT NULL,
    user_id bigint,
    consent_type character varying(100),
    consented boolean,
    ip_address character varying(50),
    created_at timestamp without time zone DEFAULT now()
);


--
-- Name: user_consents_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_consents_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_consents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.user_consents_id_seq OWNED BY public.user_consents.id;


--
-- Name: user_profiles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_profiles (
    profile_id bigint NOT NULL,
    user_id bigint NOT NULL,
    first_name character varying(100),
    last_name character varying(100),
    date_of_birth date,
    gender character varying(20),
    profile_photo_url text,
    country character varying(100) DEFAULT 'India'::character varying,
    state character varying(100),
    city character varying(100),
    pincode character varying(20),
    address text,
    academic_level character varying(50),
    stream character varying(100),
    target_course character varying(100),
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
-- Name: user_profiles_profile_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_profiles_profile_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_profiles_profile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.user_profiles_profile_id_seq OWNED BY public.user_profiles.profile_id;


--
-- Name: user_roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_roles (
    user_id bigint NOT NULL,
    role_id bigint NOT NULL
);


--
-- Name: user_sessions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_sessions (
    session_id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id bigint NOT NULL,
    session_token character varying(500) NOT NULL,
    ip_address inet,
    is_active boolean DEFAULT true,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    expires_at timestamp without time zone NOT NULL
);


--
-- Name: user_verifications; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_verifications (
    id bigint NOT NULL,
    user_id bigint,
    code character varying(20) NOT NULL,
    type character varying(20) NOT NULL,
    expires_at timestamp without time zone NOT NULL,
    consumed boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT user_verifications_type_check CHECK (((type)::text = ANY (ARRAY[('email'::character varying)::text, ('phone'::character varying)::text])))
);


--
-- Name: user_verifications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_verifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_verifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.user_verifications_id_seq OWNED BY public.user_verifications.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    user_id bigint NOT NULL,
    username character varying(100),
    email character varying(255) NOT NULL,
    phone character varying(20),
    password_hash character varying(255),
    user_type public.user_type_enum DEFAULT 'student'::public.user_type_enum NOT NULL,
    email_verified boolean DEFAULT false,
    phone_verified boolean DEFAULT false,
    status public.user_status_enum DEFAULT 'active'::public.user_status_enum,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    last_login timestamp without time zone,
    login_count integer DEFAULT 0,
    deleted_at timestamp without time zone
);


--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: counselling_sessions id; Type: DEFAULT; Schema: analytics; Owner: -
--

ALTER TABLE ONLY analytics.counselling_sessions ALTER COLUMN id SET DEFAULT nextval('analytics.counselling_sessions_id_seq'::regclass);


--
-- Name: lead_notes id; Type: DEFAULT; Schema: analytics; Owner: -
--

ALTER TABLE ONLY analytics.lead_notes ALTER COLUMN id SET DEFAULT nextval('analytics.lead_notes_id_seq'::regclass);


--
-- Name: leads id; Type: DEFAULT; Schema: analytics; Owner: -
--

ALTER TABLE ONLY analytics.leads ALTER COLUMN id SET DEFAULT nextval('analytics.leads_id_seq'::regclass);


--
-- Name: payments id; Type: DEFAULT; Schema: analytics; Owner: -
--

ALTER TABLE ONLY analytics.payments ALTER COLUMN id SET DEFAULT nextval('analytics.payments_id_seq'::regclass);


--
-- Name: user_activity id; Type: DEFAULT; Schema: analytics; Owner: -
--

ALTER TABLE ONLY analytics.user_activity ALTER COLUMN id SET DEFAULT nextval('analytics.user_activity_id_seq'::regclass);


--
-- Name: application_documents id; Type: DEFAULT; Schema: discovery; Owner: -
--

ALTER TABLE ONLY discovery.application_documents ALTER COLUMN id SET DEFAULT nextval('discovery.application_documents_id_seq'::regclass);


--
-- Name: applications id; Type: DEFAULT; Schema: discovery; Owner: -
--

ALTER TABLE ONLY discovery.applications ALTER COLUMN id SET DEFAULT nextval('discovery.applications_id_seq'::regclass);


--
-- Name: course_admissions id; Type: DEFAULT; Schema: discovery; Owner: -
--

ALTER TABLE ONLY discovery.course_admissions ALTER COLUMN id SET DEFAULT nextval('discovery.course_admissions_id_seq'::regclass);


--
-- Name: course_fees id; Type: DEFAULT; Schema: discovery; Owner: -
--

ALTER TABLE ONLY discovery.course_fees ALTER COLUMN id SET DEFAULT nextval('discovery.course_fees_id_seq'::regclass);


--
-- Name: course_specializations id; Type: DEFAULT; Schema: discovery; Owner: -
--

ALTER TABLE ONLY discovery.course_specializations ALTER COLUMN id SET DEFAULT nextval('discovery.course_specializations_id_seq'::regclass);


--
-- Name: facilities id; Type: DEFAULT; Schema: discovery; Owner: -
--

ALTER TABLE ONLY discovery.facilities ALTER COLUMN id SET DEFAULT nextval('discovery.facilities_id_seq'::regclass);


--
-- Name: institution_affiliations id; Type: DEFAULT; Schema: discovery; Owner: -
--

ALTER TABLE ONLY discovery.institution_affiliations ALTER COLUMN id SET DEFAULT nextval('discovery.institution_affiliations_id_seq'::regclass);


--
-- Name: institution_approvals id; Type: DEFAULT; Schema: discovery; Owner: -
--

ALTER TABLE ONLY discovery.institution_approvals ALTER COLUMN id SET DEFAULT nextval('discovery.institution_approvals_id_seq'::regclass);


--
-- Name: institution_brochures id; Type: DEFAULT; Schema: discovery; Owner: -
--

ALTER TABLE ONLY discovery.institution_brochures ALTER COLUMN id SET DEFAULT nextval('discovery.institution_brochures_id_seq'::regclass);


--
-- Name: institution_courses id; Type: DEFAULT; Schema: discovery; Owner: -
--

ALTER TABLE ONLY discovery.institution_courses ALTER COLUMN id SET DEFAULT nextval('discovery.institution_courses_id_seq'::regclass);


--
-- Name: institution_highlights id; Type: DEFAULT; Schema: discovery; Owner: -
--

ALTER TABLE ONLY discovery.institution_highlights ALTER COLUMN id SET DEFAULT nextval('discovery.institution_highlights_id_seq'::regclass);


--
-- Name: institution_videos id; Type: DEFAULT; Schema: discovery; Owner: -
--

ALTER TABLE ONLY discovery.institution_videos ALTER COLUMN id SET DEFAULT nextval('discovery.institution_videos_id_seq'::regclass);


--
-- Name: qna id; Type: DEFAULT; Schema: discovery; Owner: -
--

ALTER TABLE ONLY discovery.qna ALTER COLUMN id SET DEFAULT nextval('discovery.qna_id_seq'::regclass);


--
-- Name: qna_votes id; Type: DEFAULT; Schema: discovery; Owner: -
--

ALTER TABLE ONLY discovery.qna_votes ALTER COLUMN id SET DEFAULT nextval('discovery.qna_votes_id_seq'::regclass);


--
-- Name: recruiter_companies id; Type: DEFAULT; Schema: discovery; Owner: -
--

ALTER TABLE ONLY discovery.recruiter_companies ALTER COLUMN id SET DEFAULT nextval('discovery.recruiter_companies_id_seq'::regclass);


--
-- Name: review_moderation id; Type: DEFAULT; Schema: discovery; Owner: -
--

ALTER TABLE ONLY discovery.review_moderation ALTER COLUMN id SET DEFAULT nextval('discovery.review_moderation_id_seq'::regclass);


--
-- Name: seo_metadata id; Type: DEFAULT; Schema: discovery; Owner: -
--

ALTER TABLE ONLY discovery.seo_metadata ALTER COLUMN id SET DEFAULT nextval('discovery.seo_metadata_id_seq'::regclass);


--
-- Name: streams id; Type: DEFAULT; Schema: discovery; Owner: -
--

ALTER TABLE ONLY discovery.streams ALTER COLUMN id SET DEFAULT nextval('discovery.streams_id_seq'::regclass);


--
-- Name: cities city_id; Type: DEFAULT; Schema: geo_master; Owner: -
--

ALTER TABLE ONLY geo_master.cities ALTER COLUMN city_id SET DEFAULT nextval('geo_master.cities_city_id_seq'::regclass);


--
-- Name: countries country_id; Type: DEFAULT; Schema: geo_master; Owner: -
--

ALTER TABLE ONLY geo_master.countries ALTER COLUMN country_id SET DEFAULT nextval('geo_master.countries_country_id_seq'::regclass);


--
-- Name: states state_id; Type: DEFAULT; Schema: geo_master; Owner: -
--

ALTER TABLE ONLY geo_master.states ALTER COLUMN state_id SET DEFAULT nextval('geo_master.states_state_id_seq'::regclass);


--
-- Name: admin_audit_logs log_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_audit_logs ALTER COLUMN log_id SET DEFAULT nextval('public.admin_audit_logs_log_id_seq'::regclass);


--
-- Name: admin_sessions session_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_sessions ALTER COLUMN session_id SET DEFAULT nextval('public.admin_sessions_session_id_seq'::regclass);


--
-- Name: admin_users admin_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_users ALTER COLUMN admin_id SET DEFAULT nextval('public.admin_users_admin_id_seq'::regclass);


--
-- Name: audit_log id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.audit_log ALTER COLUMN id SET DEFAULT nextval('public.audit_log_id_seq'::regclass);


--
-- Name: banner_analytics id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.banner_analytics ALTER COLUMN id SET DEFAULT nextval('public.banner_analytics_id_seq'::regclass);


--
-- Name: banners id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.banners ALTER COLUMN id SET DEFAULT nextval('public.banners_id_seq'::regclass);


--
-- Name: college_content id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.college_content ALTER COLUMN id SET DEFAULT nextval('public.college_content_id_seq'::regclass);


--
-- Name: college_facilities facility_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.college_facilities ALTER COLUMN facility_id SET DEFAULT nextval('public.college_facilities_facility_id_seq'::regclass);


--
-- Name: college_gallery id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.college_gallery ALTER COLUMN id SET DEFAULT nextval('public.college_gallery_id_seq'::regclass);


--
-- Name: college_media media_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.college_media ALTER COLUMN media_id SET DEFAULT nextval('public.college_media_media_id_seq'::regclass);


--
-- Name: college_rankings ranking_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.college_rankings ALTER COLUMN ranking_id SET DEFAULT nextval('public.college_rankings_ranking_id_seq'::regclass);


--
-- Name: college_updates id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.college_updates ALTER COLUMN id SET DEFAULT nextval('public.college_updates_id_seq'::regclass);


--
-- Name: colleges college_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.colleges ALTER COLUMN college_id SET DEFAULT nextval('public.colleges_college_id_seq'::regclass);


--
-- Name: community_answers answer_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.community_answers ALTER COLUMN answer_id SET DEFAULT nextval('public.community_answers_answer_id_seq'::regclass);


--
-- Name: community_questions question_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.community_questions ALTER COLUMN question_id SET DEFAULT nextval('public.community_questions_question_id_seq'::regclass);


--
-- Name: contact_queries id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contact_queries ALTER COLUMN id SET DEFAULT nextval('public.contact_queries_id_seq'::regclass);


--
-- Name: course_location_content content_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.course_location_content ALTER COLUMN content_id SET DEFAULT nextval('public.course_location_content_content_id_seq'::regclass);


--
-- Name: course_page_content content_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.course_page_content ALTER COLUMN content_id SET DEFAULT nextval('public.course_page_content_content_id_seq'::regclass);


--
-- Name: course_types_master course_type_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.course_types_master ALTER COLUMN course_type_id SET DEFAULT nextval('public.course_types_master_course_type_id_seq'::regclass);


--
-- Name: courses course_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.courses ALTER COLUMN course_id SET DEFAULT nextval('public.courses_course_id_seq'::regclass);


--
-- Name: degree_categories category_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.degree_categories ALTER COLUMN category_id SET DEFAULT nextval('public.degree_categories_category_id_seq'::regclass);


--
-- Name: education_loans loan_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.education_loans ALTER COLUMN loan_id SET DEFAULT nextval('public.education_loans_loan_id_seq'::regclass);


--
-- Name: exam_cutoffs cutoff_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.exam_cutoffs ALTER COLUMN cutoff_id SET DEFAULT nextval('public.exam_cutoffs_cutoff_id_seq'::regclass);


--
-- Name: exam_schedules schedule_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.exam_schedules ALTER COLUMN schedule_id SET DEFAULT nextval('public.exam_schedules_schedule_id_seq'::regclass);


--
-- Name: exams exam_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.exams ALTER COLUMN exam_id SET DEFAULT nextval('public.exams_exam_id_seq'::regclass);


--
-- Name: faculty_members id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.faculty_members ALTER COLUMN id SET DEFAULT nextval('public.faculty_members_id_seq'::regclass);


--
-- Name: faqs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.faqs ALTER COLUMN id SET DEFAULT nextval('public.faqs_id_seq'::regclass);


--
-- Name: hostels id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hostels ALTER COLUMN id SET DEFAULT nextval('public.hostels_id_seq'::regclass);


--
-- Name: institute_accounts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.institute_accounts ALTER COLUMN id SET DEFAULT nextval('public.institute_accounts_id_seq'::regclass);


--
-- Name: institute_users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.institute_users ALTER COLUMN id SET DEFAULT nextval('public.institute_users_id_seq'::regclass);


--
-- Name: job_postings id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.job_postings ALTER COLUMN id SET DEFAULT nextval('public.job_postings_id_seq'::regclass);


--
-- Name: news_articles article_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.news_articles ALTER COLUMN article_id SET DEFAULT nextval('public.news_articles_article_id_seq'::regclass);


--
-- Name: newsletter_subscribers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.newsletter_subscribers ALTER COLUMN id SET DEFAULT nextval('public.newsletter_subscribers_id_seq'::regclass);


--
-- Name: notification_preferences id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notification_preferences ALTER COLUMN id SET DEFAULT nextval('public.notification_preferences_id_seq'::regclass);


--
-- Name: notifications notification_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications ALTER COLUMN notification_id SET DEFAULT nextval('public.notifications_notification_id_seq'::regclass);


--
-- Name: password_resets id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.password_resets ALTER COLUMN id SET DEFAULT nextval('public.password_resets_id_seq'::regclass);


--
-- Name: payments payment_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payments ALTER COLUMN payment_id SET DEFAULT nextval('public.payments_payment_id_seq'::regclass);


--
-- Name: placement_recruiters id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.placement_recruiters ALTER COLUMN id SET DEFAULT nextval('public.placement_recruiters_id_seq'::regclass);


--
-- Name: placements placement_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.placements ALTER COLUMN placement_id SET DEFAULT nextval('public.placements_placement_id_seq'::regclass);


--
-- Name: questions question_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.questions ALTER COLUMN question_id SET DEFAULT nextval('public.questions_question_id_seq'::regclass);


--
-- Name: quick_tabs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quick_tabs ALTER COLUMN id SET DEFAULT nextval('public.quick_tabs_id_seq'::regclass);


--
-- Name: ranking_agencies agency_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ranking_agencies ALTER COLUMN agency_id SET DEFAULT nextval('public.ranking_agencies_agency_id_seq'::regclass);


--
-- Name: reviews review_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reviews ALTER COLUMN review_id SET DEFAULT nextval('public.reviews_review_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- Name: saved_items saved_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.saved_items ALTER COLUMN saved_id SET DEFAULT nextval('public.saved_items_saved_id_seq'::regclass);


--
-- Name: scholarships scholarship_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scholarships ALTER COLUMN scholarship_id SET DEFAULT nextval('public.scholarships_scholarship_id_seq'::regclass);


--
-- Name: search_logs search_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.search_logs ALTER COLUMN search_id SET DEFAULT nextval('public.search_logs_search_id_seq'::regclass);


--
-- Name: site_notifications id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.site_notifications ALTER COLUMN id SET DEFAULT nextval('public.site_notifications_id_seq'::regclass);


--
-- Name: system_settings id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.system_settings ALTER COLUMN id SET DEFAULT nextval('public.system_settings_id_seq'::regclass);


--
-- Name: team_members id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.team_members ALTER COLUMN id SET DEFAULT nextval('public.team_members_id_seq'::regclass);


--
-- Name: test_attempts attempt_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.test_attempts ALTER COLUMN attempt_id SET DEFAULT nextval('public.test_attempts_attempt_id_seq'::regclass);


--
-- Name: test_series series_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.test_series ALTER COLUMN series_id SET DEFAULT nextval('public.test_series_series_id_seq'::regclass);


--
-- Name: testimonials id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.testimonials ALTER COLUMN id SET DEFAULT nextval('public.testimonials_id_seq'::regclass);


--
-- Name: tests test_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tests ALTER COLUMN test_id SET DEFAULT nextval('public.tests_test_id_seq'::regclass);


--
-- Name: user_consents id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_consents ALTER COLUMN id SET DEFAULT nextval('public.user_consents_id_seq'::regclass);


--
-- Name: user_profiles profile_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_profiles ALTER COLUMN profile_id SET DEFAULT nextval('public.user_profiles_profile_id_seq'::regclass);


--
-- Name: user_verifications id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_verifications ALTER COLUMN id SET DEFAULT nextval('public.user_verifications_id_seq'::regclass);


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Data for Name: counselling_sessions; Type: TABLE DATA; Schema: analytics; Owner: -
--

COPY analytics.counselling_sessions (id, lead_id, counsellor_id, session_type, duration_minutes, notes, outcome, next_follow_up, created_at) FROM stdin;
\.


--
-- Data for Name: lead_notes; Type: TABLE DATA; Schema: analytics; Owner: -
--

COPY analytics.lead_notes (id, lead_id, user_id, note, created_at) FROM stdin;
\.


--
-- Data for Name: leads; Type: TABLE DATA; Schema: analytics; Owner: -
--

COPY analytics.leads (id, user_id, institution_id, institution_course_id, student_name, student_email, student_phone, message, source, website_origin, utm_source, utm_medium, utm_campaign, assigned_to, status, priority, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: payments; Type: TABLE DATA; Schema: analytics; Owner: -
--

COPY analytics.payments (id, user_id, institution_id, amount, currency, purpose, payment_gateway, transaction_id, gateway_response, status, refund_id, refunded_at, meta, created_at) FROM stdin;
\.


--
-- Data for Name: user_activity; Type: TABLE DATA; Schema: analytics; Owner: -
--

COPY analytics.user_activity (id, user_id, session_id, activity_type, entity_type, entity_id, search_query, filters_applied, meta, created_at) FROM stdin;
\.


--
-- Data for Name: application_documents; Type: TABLE DATA; Schema: discovery; Owner: -
--

COPY discovery.application_documents (id, application_id, document_type, file_url, is_verified, verified_by, verified_at, created_at) FROM stdin;
\.


--
-- Data for Name: applications; Type: TABLE DATA; Schema: discovery; Owner: -
--

COPY discovery.applications (id, user_id, institution_course_id, academic_year, status, submitted_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: course_admissions; Type: TABLE DATA; Schema: discovery; Owner: -
--

COPY discovery.course_admissions (id, institution_course_id, academic_year, application_start, application_end, admission_mode, process, counseling, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: course_fees; Type: TABLE DATA; Schema: discovery; Owner: -
--

COPY discovery.course_fees (id, institution_course_id, year, tuition_fee, hostel_fee, exam_fee, other_fee, total_fee, currency, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: course_specializations; Type: TABLE DATA; Schema: discovery; Owner: -
--

COPY discovery.course_specializations (id, institution_course_id, name, seats) FROM stdin;
\.


--
-- Data for Name: facilities; Type: TABLE DATA; Schema: discovery; Owner: -
--

COPY discovery.facilities (id, name) FROM stdin;
1	Hostel
2	Library
3	WiFi
4	Sports Complex
5	Cafeteria
6	Laboratory
7	Auditorium
8	Gym
\.


--
-- Data for Name: institution_affiliations; Type: TABLE DATA; Schema: discovery; Owner: -
--

COPY discovery.institution_affiliations (id, institution_id, affiliated_to, notes) FROM stdin;
\.


--
-- Data for Name: institution_approvals; Type: TABLE DATA; Schema: discovery; Owner: -
--

COPY discovery.institution_approvals (id, institution_id, approval_type, approval_number, grade, valid_from, valid_to, notes, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: institution_brochures; Type: TABLE DATA; Schema: discovery; Owner: -
--

COPY discovery.institution_brochures (id, institution_id, file_url, title, language, academic_year, created_at) FROM stdin;
\.


--
-- Data for Name: institution_courses; Type: TABLE DATA; Schema: discovery; Owner: -
--

COPY discovery.institution_courses (id, institution_id, course_id, seats, mode, affiliated_to, approved_by, view_count, is_trending, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: institution_facilities; Type: TABLE DATA; Schema: discovery; Owner: -
--

COPY discovery.institution_facilities (institution_id, facility_id, details) FROM stdin;
\.


--
-- Data for Name: institution_highlights; Type: TABLE DATA; Schema: discovery; Owner: -
--

COPY discovery.institution_highlights (id, institution_id, title, value) FROM stdin;
\.


--
-- Data for Name: institution_videos; Type: TABLE DATA; Schema: discovery; Owner: -
--

COPY discovery.institution_videos (id, institution_id, video_url, title, description, thumbnail_url, duration_seconds, category, created_at) FROM stdin;
\.


--
-- Data for Name: qna; Type: TABLE DATA; Schema: discovery; Owner: -
--

COPY discovery.qna (id, institution_id, course_id, user_id, question, answer, answered_by, is_featured, helpful_count, created_at, answered_at) FROM stdin;
\.


--
-- Data for Name: qna_votes; Type: TABLE DATA; Schema: discovery; Owner: -
--

COPY discovery.qna_votes (id, qna_id, user_id, is_helpful, created_at) FROM stdin;
\.


--
-- Data for Name: recruiter_companies; Type: TABLE DATA; Schema: discovery; Owner: -
--

COPY discovery.recruiter_companies (id, name, logo_url, website, industry, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: review_moderation; Type: TABLE DATA; Schema: discovery; Owner: -
--

COPY discovery.review_moderation (id, review_id, status, moderated_by, comments, moderated_at) FROM stdin;
\.


--
-- Data for Name: seo_metadata; Type: TABLE DATA; Schema: discovery; Owner: -
--

COPY discovery.seo_metadata (id, entity_type, entity_id, meta_title, meta_description, meta_keywords, canonical_url, og_title, og_description, og_image, schema_json, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: streams; Type: TABLE DATA; Schema: discovery; Owner: -
--

COPY discovery.streams (id, name, description) FROM stdin;
1	Engineering	Engineering and Technology programs
2	Medical	Medical and Healthcare programs
3	Management	Management and Business programs
4	Arts	Arts and Humanities programs
5	Science	Science programs
6	Commerce	Commerce and Finance programs
7	Law	Legal Studies programs
8	Architecture	Architecture and Design programs
\.


--
-- Data for Name: user_favorites; Type: TABLE DATA; Schema: discovery; Owner: -
--

COPY discovery.user_favorites (user_id, entity_type, entity_id, created_at) FROM stdin;
\.


--
-- Data for Name: cities; Type: TABLE DATA; Schema: geo_master; Owner: -
--

COPY geo_master.cities (city_id, state_id, city_name, population, is_metro) FROM stdin;
\.


--
-- Data for Name: countries; Type: TABLE DATA; Schema: geo_master; Owner: -
--

COPY geo_master.countries (country_id, country_name, country_code, currency, is_study_destination) FROM stdin;
1	India	IN	INR	t
2	United States	US	USD	t
3	United Kingdom	UK	GBP	t
4	Canada	CA	CAD	t
5	Australia	AU	AUD	t
\.


--
-- Data for Name: states; Type: TABLE DATA; Schema: geo_master; Owner: -
--

COPY geo_master.states (state_id, country_id, state_name, state_code) FROM stdin;
\.


--
-- Data for Name: admin_audit_logs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.admin_audit_logs (log_id, admin_id, action, resource_type, resource_id, details, ip_address, created_at) FROM stdin;
1	1	login	admin	\N	\N	::1	2025-12-15 20:05:00.385017
2	1	login	admin	\N	\N	::1	2025-12-17 17:01:59.296421
3	1	login	admin	\N	\N	::1	2025-12-17 17:10:14.146167
4	1	login	admin	\N	\N	::1	2025-12-18 13:26:44.170334
5	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-18 13:28:43.48352
6	1	CREATE	college	1	{"city": "Bangalore", "state": "Karnataka", "college_name": "Test University of Technology"}	\N	2025-12-18 13:30:45.992065
7	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-18 13:30:50.777966
8	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-18 13:30:50.866074
9	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-18 13:31:08.361159
10	1	VIEW	college	1	\N	\N	2025-12-18 13:31:24.640556
11	1	VIEW	college	1	\N	\N	2025-12-18 13:31:24.691204
12	1	VIEW	college	1	\N	\N	2025-12-18 13:31:37.825687
13	1	UPDATE	college	1	{"updated_fields": ["college_name", "short_name", "established_year", "college_type", "ownership", "country", "state", "city", "pincode", "address", "website_url", "phone", "email", "description", "is_featured", "is_verified", "status"]}	\N	2025-12-18 13:33:12.792807
14	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-18 13:33:18.179873
15	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-18 13:33:18.232215
16	1	DELETE	college	1	{"college_name": "Test University of Technology"}	\N	2025-12-18 13:33:35.937221
17	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-18 13:33:41.136779
18	1	login	admin	\N	\N	::1	2025-12-18 14:23:31.386918
19	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2025-12-18 14:23:49.253956
20	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2025-12-18 14:25:57.807005
21	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2025-12-18 14:26:08.414354
22	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2025-12-18 14:26:19.208972
23	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2025-12-18 14:26:19.255798
24	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2025-12-18 14:26:46.6493
25	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2025-12-18 14:26:58.362295
26	1	login	admin	\N	\N	::1	2025-12-18 15:05:46.707514
27	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2025-12-18 15:05:57.583234
28	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2025-12-18 15:05:57.678998
29	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2025-12-18 15:08:01.569045
30	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2025-12-18 15:10:22.47251
31	1	login	admin	\N	\N	::1	2025-12-18 15:26:19.703282
32	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-18 15:26:37.104269
33	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-18 15:26:37.155753
34	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2025-12-18 15:26:45.170882
35	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2025-12-18 15:26:45.186571
36	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-18 15:26:49.665401
37	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-18 15:26:49.699312
38	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-18 15:26:53.70681
39	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-18 15:45:26.411593
40	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-18 15:45:26.42498
41	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2025-12-18 15:56:21.150308
42	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2025-12-18 15:56:21.166149
43	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-18 15:56:23.260928
44	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-18 15:56:23.344033
45	1	VIEW	college	2	\N	\N	2025-12-18 15:56:32.376349
46	1	VIEW	college	2	\N	\N	2025-12-18 15:56:32.41821
47	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-18 15:56:36.466922
48	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-18 15:56:36.514825
49	1	login	admin	\N	\N	::1	2025-12-18 16:06:42.554175
50	1	login	admin	\N	\N	::1	2025-12-18 16:22:10.585299
51	1	login	admin	\N	\N	::1	2025-12-18 17:54:13.143824
52	1	login	admin	\N	\N	::1	2025-12-18 17:59:58.987384
53	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-18 18:01:21.366378
54	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-18 18:01:21.415543
55	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2025-12-18 18:01:46.665329
56	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2025-12-18 18:01:46.716058
57	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2025-12-18 18:02:07.812285
58	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2025-12-18 18:02:07.862317
59	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-18 18:25:00.434008
60	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-18 18:25:00.48171
61	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2025-12-18 18:25:02.081749
62	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2025-12-18 18:25:02.135313
63	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2025-12-18 18:25:03.925823
64	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2025-12-18 18:25:03.972469
65	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-18 18:54:49.548926
66	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-18 18:54:49.56529
67	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-18 18:55:03.971873
68	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-18 18:55:04.017096
69	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2025-12-18 18:55:05.167352
70	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2025-12-18 18:55:05.173864
71	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2025-12-18 18:55:06.908327
72	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2025-12-18 18:55:06.955012
73	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2025-12-18 18:55:09.170705
74	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2025-12-18 18:55:09.182896
75	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2025-12-18 18:55:10.242307
76	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2025-12-18 18:55:10.288861
77	1	login	admin	\N	\N	::1	2025-12-18 19:02:17.368548
78	1	login	admin	\N	\N	::1	2025-12-18 19:20:27.485159
79	1	login	admin	\N	\N	::1	2025-12-19 15:54:55.622699
80	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-19 15:55:05.440329
81	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-19 15:55:05.503477
82	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2025-12-19 15:55:08.995816
83	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2025-12-19 15:55:09.077157
84	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2025-12-19 15:55:13.157252
85	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2025-12-19 15:55:13.180136
86	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2025-12-19 15:55:15.547793
87	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2025-12-19 15:55:15.598641
88	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2025-12-19 15:55:16.522046
89	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2025-12-19 15:55:16.567456
90	1	login	admin	\N	\N	::1	2025-12-19 15:58:40.876416
91	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-19 16:03:37.024406
92	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-19 16:03:37.078583
93	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-19 16:10:38.24784
199	1	VIEW	college	2	\N	\N	2025-12-30 18:06:12.410451
94	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-19 16:15:01.833862
95	1	login	admin	\N	\N	::1	2025-12-23 13:28:15.321033
96	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-23 13:28:27.84517
97	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-23 13:28:27.933255
98	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2025-12-23 13:28:49.186322
99	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2025-12-23 13:28:49.340033
100	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2025-12-23 13:28:50.979128
101	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2025-12-23 13:28:51.010203
102	1	login	admin	\N	\N	::1	2025-12-23 18:07:18.880796
103	1	login	admin	\N	\N	::1	2025-12-23 18:15:38.856206
104	1	login	admin	\N	\N	::1	2025-12-23 19:04:35.879202
105	1	VIEW	colleges	\N	{"page": "1", "limit": "1000", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-23 19:43:10.619465
106	1	VIEW	colleges	\N	{"page": "1", "limit": "1000", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-23 19:44:16.05852
107	1	VIEW	colleges	\N	{"page": "1", "limit": "1000", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-23 19:44:30.416238
108	1	VIEW	colleges	\N	{"page": "1", "limit": "1000", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-23 19:44:41.320034
109	1	VIEW	colleges	\N	{"page": "1", "limit": "1000", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-23 19:45:23.315492
110	1	VIEW	colleges	\N	{"page": "1", "limit": "1000", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-23 19:45:35.798525
111	1	VIEW	colleges	\N	{"page": "1", "limit": "1000", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-23 19:49:41.09646
112	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-24 12:25:09.190186
113	1	CREATE	college	4	{"city": "Surathkal", "state": "Karnataka", "college_name": "National Institute of Technology Karnataka"}	\N	2025-12-24 12:27:30.724258
114	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-24 12:27:30.938808
115	1	UPDATE	college	4	{"updated_fields": ["college_name", "short_name", "established_year", "college_type", "ownership", "country", "state", "city", "pincode", "website_url", "phone", "email", "is_featured", "is_verified", "status"]}	\N	2025-12-24 12:28:31.25776
116	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-24 12:28:31.317049
117	1	DELETE	college	4	{"college_name": "National Institute of Technology Karnataka"}	\N	2025-12-24 12:29:21.174298
118	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-24 12:29:21.23256
119	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "IIT", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-24 12:30:05.204685
120	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-24 12:31:04.826225
121	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": "Institute"}}	\N	2025-12-24 12:31:26.894232
122	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2025-12-24 12:45:43.330425
123	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2025-12-24 12:55:27.129088
124	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2025-12-24 12:55:27.256667
125	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2025-12-24 13:13:38.329483
126	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2025-12-24 13:15:48.599146
127	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2025-12-24 13:18:31.714504
128	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2025-12-24 13:32:51.433701
129	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2025-12-24 13:55:29.921281
130	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2025-12-24 14:03:39.107992
131	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2025-12-24 14:10:24.288563
132	1	UPDATE_STATUS	user	9	{"status": "suspended"}	\N	2025-12-24 14:58:08.735032
133	1	UPDATE_STATUS	user	8	{"status": "inactive"}	\N	2025-12-24 15:30:23.596091
134	1	VIEW	colleges	\N	{"page": "1", "limit": "1000", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-24 16:40:51.964261
135	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-24 17:08:08.998166
136	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-24 17:08:09.049419
137	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2025-12-24 17:08:53.890131
138	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2025-12-24 17:09:16.855183
139	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-24 17:09:18.692775
140	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-24 17:09:18.753445
141	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2025-12-24 17:09:19.664455
142	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2025-12-24 17:09:19.683301
143	1	VIEW	colleges	\N	{"page": "1", "limit": "1000", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-24 17:09:23.098818
144	1	VIEW	colleges	\N	{"page": "1", "limit": "1000", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-24 17:09:23.149422
145	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2025-12-24 17:09:30.955179
146	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2025-12-24 17:09:31.014023
147	1	VIEW	colleges	\N	{"page": "1", "limit": "1000", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-24 17:09:47.344165
148	1	VIEW	colleges	\N	{"page": "1", "limit": "1000", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-24 17:09:47.397959
149	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2025-12-24 17:10:10.150087
150	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2025-12-24 17:10:10.197917
151	1	VIEW	colleges	\N	{"page": "1", "limit": "1000", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-24 17:11:40.519285
152	1	VIEW	colleges	\N	{"page": "1", "limit": "1000", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-24 17:11:40.54239
153	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2025-12-24 17:12:19.491789
154	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2025-12-24 17:12:19.52463
155	1	VIEW	colleges	\N	{"page": "1", "limit": "1000", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-24 17:18:39.099967
156	1	login	admin	\N	\N	::1	2025-12-24 17:19:40.343085
157	1	VIEW	colleges	\N	{"page": "1", "limit": "1000", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-24 17:19:52.626959
158	1	VIEW	colleges	\N	{"page": "1", "limit": "1000", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-24 17:19:52.677008
159	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-24 18:59:48.197432
160	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-24 18:59:48.32319
161	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2025-12-24 19:00:25.473789
162	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2025-12-24 19:00:25.572241
163	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-24 19:11:34.860707
164	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-24 19:11:34.958687
165	1	login	admin	\N	\N	::1	2025-12-30 17:02:15.825142
166	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-30 17:03:05.268439
167	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-30 17:03:05.273875
168	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-30 17:03:31.888974
169	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-30 17:03:31.891567
170	1	VIEW	college	2	\N	\N	2025-12-30 17:03:49.802981
171	1	VIEW	college	2	\N	\N	2025-12-30 17:03:59.783631
172	1	VIEW	college	2	\N	\N	2025-12-30 17:03:59.786379
173	1	VIEW	college	2	\N	\N	2025-12-30 17:04:33.781118
174	1	VIEW	college	2	\N	\N	2025-12-30 17:08:23.206094
175	1	VIEW	college	2	\N	\N	2025-12-30 17:08:23.208576
176	1	VIEW	college	2	\N	\N	2025-12-30 17:08:40.356826
177	1	VIEW	college	2	\N	\N	2025-12-30 17:08:46.654943
178	1	VIEW	college	2	\N	\N	2025-12-30 17:09:44.021561
179	1	VIEW	college	2	\N	\N	2025-12-30 17:16:47.85504
180	1	VIEW	college	2	\N	\N	2025-12-30 17:16:59.945393
181	1	VIEW	college	2	\N	\N	2025-12-30 17:27:13.264775
182	1	VIEW	college	2	\N	\N	2025-12-30 17:40:46.837013
183	1	VIEW	college	2	\N	\N	2025-12-30 17:40:59.370145
184	1	VIEW	college	2	\N	\N	2025-12-30 17:40:59.372698
185	1	VIEW	college	2	\N	\N	2025-12-30 17:41:09.352597
186	1	VIEW	college	2	\N	\N	2025-12-30 17:41:09.355392
187	1	VIEW	college	2	\N	\N	2025-12-30 17:42:31.776887
188	1	VIEW	college	2	\N	\N	2025-12-30 17:43:33.483268
189	1	VIEW	college	2	\N	\N	2025-12-30 17:44:09.452194
190	1	VIEW	college	2	\N	\N	2025-12-30 17:50:56.715499
191	1	VIEW	college	2	\N	\N	2025-12-30 17:53:43.493514
192	1	VIEW	college	2	\N	\N	2025-12-30 17:55:09.417912
193	1	VIEW	college	2	\N	\N	2025-12-30 17:55:32.851637
194	1	VIEW	college	2	\N	\N	2025-12-30 17:58:59.537727
195	1	VIEW	college	2	\N	\N	2025-12-30 17:59:42.971833
196	1	VIEW	college	2	\N	\N	2025-12-30 18:03:07.821733
197	1	VIEW	college	2	\N	\N	2025-12-30 18:04:51.725953
198	1	VIEW	college	2	\N	\N	2025-12-30 18:06:05.086439
200	1	VIEW	college	2	\N	\N	2025-12-30 18:07:31.208482
201	1	VIEW	college	2	\N	\N	2025-12-30 18:07:31.213677
202	1	VIEW	college	2	\N	\N	2025-12-30 18:07:45.326248
203	1	VIEW	college	2	\N	\N	2025-12-30 18:07:45.329868
204	1	VIEW	college	2	\N	\N	2025-12-30 18:08:04.5607
205	1	VIEW	college	2	\N	\N	2025-12-30 18:08:04.563645
206	1	VIEW	college	2	\N	\N	2025-12-30 18:08:22.529271
207	1	VIEW	college	2	\N	\N	2025-12-30 18:08:22.530836
208	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-30 18:38:04.606793
209	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-30 18:40:15.350854
210	1	VIEW	colleges	\N	{"page": 1, "limit": 10, "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-30 18:40:51.781338
211	1	VIEW	colleges	\N	{"page": 1, "limit": 10, "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-30 18:41:00.150076
212	1	VIEW	college	2	\N	\N	2025-12-30 18:41:10.115774
213	1	VIEW	college	2	\N	\N	2025-12-30 18:41:48.974747
214	1	VIEW	college	2	\N	\N	2025-12-30 18:41:48.977952
215	1	VIEW	college	2	\N	\N	2025-12-30 18:43:44.358165
216	1	VIEW	college	2	\N	\N	2025-12-30 18:44:00.369845
217	1	VIEW	college	2	\N	\N	2025-12-30 18:44:00.372277
218	1	VIEW	college	2	\N	\N	2025-12-30 18:45:28.39026
219	1	VIEW	college	2	\N	\N	2025-12-30 18:45:28.393533
220	1	VIEW	college	2	\N	\N	2025-12-30 18:48:53.098908
221	1	VIEW	college	2	\N	\N	2025-12-30 18:48:53.104314
222	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-30 18:48:54.696695
223	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-30 18:48:54.700484
224	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-30 18:50:00.455252
225	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-30 18:50:54.368557
226	1	VIEW	college	2	\N	\N	2025-12-30 18:51:00.587162
227	1	VIEW	college	2	\N	\N	2025-12-30 18:51:00.588758
228	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-30 18:52:00.147196
229	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-30 18:52:00.149434
230	1	VIEW	college	2	\N	\N	2025-12-30 18:52:01.508984
231	1	VIEW	college	2	\N	\N	2025-12-30 18:52:01.510418
232	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-30 18:52:07.127168
233	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-30 18:52:07.130803
234	1	VIEW	college	2	\N	\N	2025-12-30 18:52:40.390092
235	1	VIEW	college	2	\N	\N	2025-12-30 18:52:40.392355
236	1	VIEW	college	2	\N	\N	2025-12-30 18:52:46.848553
237	1	VIEW	college	2	\N	\N	2025-12-30 18:52:46.853324
238	1	VIEW	college	2	\N	\N	2025-12-30 18:52:54.995168
239	1	VIEW	college	2	\N	\N	2025-12-30 18:52:54.99929
240	1	VIEW	college	2	\N	\N	2025-12-30 18:53:03.805954
241	1	VIEW	college	2	\N	\N	2025-12-30 18:53:03.808534
242	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-30 18:53:20.108229
243	1	VIEW	college	2	\N	\N	2025-12-30 18:53:27.502946
244	1	VIEW	college	2	\N	\N	2025-12-30 18:53:27.504842
245	1	VIEW	college	2	\N	\N	2025-12-30 18:56:09.79649
246	1	VIEW	college	2	\N	\N	2025-12-30 18:57:38.056332
247	1	VIEW	college	2	\N	\N	2025-12-30 18:58:15.044904
248	1	VIEW	college	2	\N	\N	2025-12-30 18:59:15.804262
249	1	VIEW	college	2	\N	\N	2025-12-30 19:00:54.314528
250	1	VIEW	college	2	\N	\N	2025-12-30 19:00:54.317902
251	1	VIEW	college	2	\N	\N	2025-12-30 19:00:55.921847
252	1	VIEW	college	2	\N	\N	2025-12-30 19:00:55.923358
253	1	VIEW	college	2	\N	\N	2025-12-30 19:01:20.402696
254	1	VIEW	college	2	\N	\N	2025-12-30 19:08:28.947699
255	1	VIEW	college	2	\N	\N	2025-12-30 19:12:17.970321
256	1	VIEW	college	2	\N	\N	2025-12-30 19:12:17.975184
257	1	VIEW	college	2	\N	\N	2025-12-30 19:12:19.982073
258	1	VIEW	college	2	\N	\N	2025-12-30 19:13:40.071178
259	1	VIEW	college	2	\N	\N	2025-12-30 19:14:11.269318
260	1	VIEW	college	2	\N	\N	2025-12-30 19:14:44.327982
261	1	VIEW	college	2	\N	\N	2025-12-30 19:15:25.26932
262	1	VIEW	college	2	\N	\N	2025-12-30 19:15:45.656486
263	1	VIEW	college	2	\N	\N	2025-12-30 19:16:11.047781
264	1	VIEW	college	2	\N	\N	2025-12-30 19:16:49.034101
265	1	VIEW	college	2	\N	\N	2025-12-30 19:19:46.678337
266	1	VIEW	college	2	\N	\N	2025-12-30 19:24:09.308167
267	1	VIEW	college	2	\N	\N	2025-12-30 19:25:44.337157
268	1	VIEW	college	2	\N	\N	2025-12-30 19:25:44.520368
269	1	VIEW	college	2	\N	\N	2025-12-30 19:26:20.419156
270	1	VIEW	college	2	\N	\N	2025-12-30 19:28:15.446632
271	1	VIEW	college	2	\N	\N	2025-12-30 19:43:19.43139
272	1	VIEW	college	2	\N	\N	2025-12-30 19:44:00.984744
273	1	VIEW	college	2	\N	\N	2025-12-30 19:44:40.812875
274	1	VIEW	college	2	\N	\N	2025-12-30 19:46:19.323753
275	1	login	admin	\N	\N	::1	2025-12-30 19:49:29.872971
276	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-30 19:50:01.734249
277	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-30 19:50:01.73817
278	1	VIEW	college	2	\N	\N	2025-12-30 19:50:03.36145
279	1	VIEW	college	2	\N	\N	2025-12-30 19:50:03.364146
280	1	VIEW	college	2	\N	\N	2025-12-30 19:50:06.23929
281	1	VIEW	college	2	\N	\N	2025-12-30 19:50:06.243654
282	1	VIEW	college	2	\N	\N	2025-12-30 19:50:07.622503
283	1	VIEW	college	2	\N	\N	2025-12-30 19:50:07.631569
284	1	VIEW	college	2	\N	\N	2025-12-30 19:50:26.659118
285	1	VIEW	college	2	\N	\N	2025-12-30 19:50:26.665116
286	1	VIEW	college	2	\N	\N	2025-12-30 19:50:28.931654
287	1	VIEW	college	2	\N	\N	2025-12-30 19:50:28.935484
288	1	login	admin	\N	\N	::1	2025-12-31 13:49:16.611418
380	1	CREATE	college	14	{"city": "Bangalore", "state": "Karnataka", "college_name": "Indian Institute of Science"}	\N	2026-01-01 18:08:18.781154
289	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-31 13:49:20.114699
290	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-31 13:49:20.123944
291	1	VIEW	college	2	\N	\N	2025-12-31 13:57:29.703924
292	1	VIEW	college	2	\N	\N	2025-12-31 13:57:29.70775
293	1	VIEW	college	2	\N	\N	2025-12-31 13:57:47.255914
294	1	VIEW	college	2	\N	\N	2025-12-31 13:57:54.673664
295	1	VIEW	college	2	\N	\N	2025-12-31 13:57:54.68723
296	1	VIEW	college	2	\N	\N	2025-12-31 16:53:10.84021
297	1	VIEW	college	2	\N	\N	2025-12-31 16:53:10.845234
298	1	login	admin	\N	\N	::1	2025-12-31 17:08:49.679049
299	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-31 17:09:05.777904
300	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-31 17:09:05.780603
301	1	VIEW	college	2	\N	\N	2025-12-31 17:09:17.860706
302	1	VIEW	college	2	\N	\N	2025-12-31 17:09:17.862722
303	1	VIEW	college	2	\N	\N	2025-12-31 17:09:36.789322
304	1	VIEW	college	2	\N	\N	2025-12-31 17:09:36.794096
305	1	VIEW	college	2	\N	\N	2025-12-31 17:15:00.709881
306	1	VIEW	college	2	\N	\N	2025-12-31 17:16:07.402352
307	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-31 17:20:49.040243
308	1	VIEW	college	2	\N	\N	2025-12-31 17:20:55.427439
309	1	VIEW	college	2	\N	\N	2025-12-31 17:20:55.429439
310	1	VIEW	college	2	\N	\N	2025-12-31 17:31:41.704412
311	1	VIEW	college	2	\N	\N	2025-12-31 17:31:57.350073
312	1	VIEW	college	2	\N	\N	2025-12-31 17:31:57.355834
313	1	VIEW	college	2	\N	\N	2025-12-31 17:32:58.889382
314	1	VIEW	college	2	\N	\N	2025-12-31 17:33:36.943505
315	1	VIEW	college	2	\N	\N	2025-12-31 17:33:36.948167
316	1	VIEW	college	2	\N	\N	2025-12-31 17:34:56.497331
317	1	VIEW	college	2	\N	\N	2025-12-31 17:39:37.442769
318	1	VIEW	college	2	\N	\N	2025-12-31 17:44:40.973822
319	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-31 17:54:46.230186
320	1	VIEW	college	2	\N	\N	2025-12-31 17:54:52.899111
321	1	VIEW	college	2	\N	\N	2025-12-31 17:57:22.608096
322	1	VIEW	college	2	\N	\N	2025-12-31 17:59:57.42101
323	1	VIEW	college	2	\N	\N	2025-12-31 18:05:56.345872
324	1	VIEW	college	2	\N	\N	2025-12-31 18:21:27.252697
325	1	VIEW	college	2	\N	\N	2025-12-31 18:44:57.757783
326	1	VIEW	college	2	\N	\N	2025-12-31 18:45:04.0425
327	1	VIEW	college	2	\N	\N	2025-12-31 18:45:09.378191
328	1	VIEW	college	2	\N	\N	2025-12-31 18:45:17.573602
329	1	VIEW	college	2	\N	\N	2025-12-31 18:46:08.791543
330	1	VIEW	college	2	\N	\N	2025-12-31 18:49:47.224493
331	1	VIEW	college	2	\N	\N	2025-12-31 18:50:56.771359
332	1	VIEW	college	2	\N	\N	2025-12-31 18:51:36.00669
333	1	VIEW	college	2	\N	\N	2025-12-31 18:54:33.047603
334	1	VIEW	college	2	\N	\N	2025-12-31 18:54:53.731245
335	1	VIEW	college	2	\N	\N	2025-12-31 18:55:35.273022
336	1	VIEW	college	2	\N	\N	2025-12-31 18:58:34.417244
337	1	VIEW	college	2	\N	\N	2025-12-31 19:01:05.517008
338	1	VIEW	college	2	\N	\N	2025-12-31 19:01:14.377826
339	1	VIEW	college	2	\N	\N	2025-12-31 19:01:35.649588
340	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2025-12-31 19:02:24.421849
341	1	VIEW	college	2	\N	\N	2025-12-31 19:02:31.462917
342	1	VIEW	college	2	\N	\N	2025-12-31 19:03:36.66794
343	1	VIEW	college	2	\N	\N	2025-12-31 19:03:58.841714
344	1	VIEW	college	2	\N	\N	2025-12-31 19:03:58.853448
345	1	VIEW	college	2	\N	\N	2025-12-31 19:04:13.774103
346	1	VIEW	college	2	\N	\N	2025-12-31 19:04:57.195016
347	1	VIEW	college	2	\N	\N	2025-12-31 19:05:46.534117
348	1	VIEW	college	2	\N	\N	2025-12-31 19:23:34.576512
349	1	VIEW	college	2	\N	\N	2025-12-31 19:23:34.581876
350	1	VIEW	college	2	\N	\N	2025-12-31 19:24:44.252954
351	1	VIEW	college	2	\N	\N	2025-12-31 19:25:12.028729
352	1	VIEW	college	2	\N	\N	2025-12-31 19:44:23.57182
353	1	VIEW	college	2	\N	\N	2026-01-01 12:16:35.69471
354	1	VIEW	college	2	\N	\N	2026-01-01 12:17:20.893903
355	1	VIEW	college	2	\N	\N	2026-01-01 12:17:52.562778
356	1	VIEW	college	2	\N	\N	2026-01-01 12:18:20.03659
357	1	VIEW	college	2	\N	\N	2026-01-01 12:19:38.14613
358	1	VIEW	college	2	\N	\N	2026-01-01 12:21:33.498263
359	1	VIEW	college	2	\N	\N	2026-01-01 12:22:53.854277
360	1	VIEW	college	2	\N	\N	2026-01-01 12:25:10.409711
361	1	VIEW	college	2	\N	\N	2026-01-01 12:41:13.583571
362	1	VIEW	colleges	\N	{"page": 1, "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": "Institute"}}	\N	2026-01-01 12:41:13.598168
363	1	VIEW	college	2	\N	\N	2026-01-01 12:42:24.075151
364	1	VIEW	colleges	\N	{"page": 1, "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": "Institute"}}	\N	2026-01-01 12:42:24.09456
365	1	login	admin	\N	\N	::1	2026-01-01 12:47:44.380555
366	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2026-01-01 12:47:49.903651
367	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2026-01-01 12:47:49.907547
368	1	VIEW	college	2	\N	\N	2026-01-01 12:47:52.61796
369	1	VIEW	college	2	\N	\N	2026-01-01 12:47:52.620076
370	1	VIEW	college	2	\N	\N	2026-01-01 12:47:54.182585
371	1	VIEW	college	2	\N	\N	2026-01-01 12:47:54.189699
372	1	VIEW	college	2	\N	\N	2026-01-01 12:48:01.728173
373	1	VIEW	colleges	\N	{"page": 1, "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": "Institute"}}	\N	2026-01-01 12:48:01.745949
374	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2026-01-01 12:50:17.700096
375	1	VIEW	college	2	\N	\N	2026-01-01 12:50:23.411102
376	1	VIEW	colleges	\N	{"page": 1, "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": "Institute"}}	\N	2026-01-01 12:50:23.426986
377	1	login	admin	\N	\N	::1	2026-01-01 18:07:17.775494
378	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2026-01-01 18:07:36.000057
379	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2026-01-01 18:07:36.002921
381	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2026-01-01 18:08:18.795975
382	1	login	admin	\N	\N	::1	2026-01-01 19:19:34.552003
383	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2026-01-01 19:19:42.88024
384	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2026-01-01 19:19:42.888289
385	1	CREATE	college	15	{"city": "Pune", "state": "Maharashtra", "college_name": "Pune Institute of Technology"}	\N	2026-01-01 19:20:16.736495
386	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2026-01-01 19:20:16.755728
387	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2026-01-01 19:20:25.840259
388	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2026-01-01 19:20:25.842115
389	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2026-01-01 19:21:08.192265
390	1	login	admin	\N	\N	::1	2026-01-01 19:28:57.077918
391	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2026-01-01 19:29:09.602011
392	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2026-01-01 19:29:09.606571
393	1	CREATE	college	16	{"city": "Chennai", "state": "Tamil Nadu", "college_name": "Chennai Business School"}	\N	2026-01-01 19:29:40.701869
394	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2026-01-01 19:29:40.716286
395	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2026-01-01 19:29:57.069102
396	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2026-01-01 19:29:57.071691
397	1	VIEW	colleges	\N	{"page": 1, "limit": "5", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2026-01-01 19:32:45.727536
398	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2026-01-01 19:33:03.187252
399	1	login	admin	\N	\N	::1	2026-01-01 19:53:05.564924
400	1	login	admin	\N	\N	::1	2026-01-01 22:41:02.219592
401	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2026-01-01 22:41:12.436601
402	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2026-01-01 22:41:12.445614
403	1	login	admin	\N	\N	::1	2026-01-01 22:52:00.964623
404	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2026-01-01 22:52:07.400754
405	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2026-01-01 22:52:07.405555
406	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2026-01-01 22:53:09.152592
407	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2026-01-01 22:53:09.157353
408	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2026-01-01 23:04:02.198069
409	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2026-01-01 23:13:48.899357
410	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2026-01-01 23:13:48.904083
411	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2026-01-01 23:17:41.430065
412	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2026-01-01 23:17:41.433901
413	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2026-01-02 13:58:00.272747
414	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2026-01-02 13:58:00.279219
415	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2026-01-02 13:58:01.044817
416	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2026-01-02 13:58:01.048067
417	1	VIEW	college	16	\N	\N	2026-01-02 13:58:03.162508
418	1	VIEW	college	16	\N	\N	2026-01-02 13:58:03.164667
419	1	VIEW	college	16	\N	\N	2026-01-02 13:58:05.349665
420	1	VIEW	college	16	\N	\N	2026-01-02 13:58:05.353163
421	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2026-01-02 16:24:41.897171
422	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2026-01-02 16:24:41.902704
423	1	login	admin	\N	\N	::1	2026-01-05 12:08:37.116299
424	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2026-01-05 12:08:53.479084
425	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2026-01-05 12:08:53.486852
426	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2026-01-05 12:10:02.077801
431	1	VIEW	college	16	\N	\N	2026-01-05 12:10:29.233477
427	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2026-01-05 12:10:02.081678
428	1	VIEW	college	16	\N	\N	2026-01-05 12:10:19.062613
429	1	VIEW	college	16	\N	\N	2026-01-05 12:10:19.065211
430	1	VIEW	college	16	\N	\N	2026-01-05 12:10:29.226967
432	1	VIEW	college	16	\N	\N	2026-01-05 12:11:28.674817
433	1	VIEW	college	16	\N	\N	2026-01-05 12:14:10.076556
434	1	VIEW	college	16	\N	\N	2026-01-05 12:15:11.574671
435	1	VIEW	college	16	\N	\N	2026-01-05 12:18:47.942805
436	1	login	admin	\N	\N	::1	2026-01-05 12:20:20.904687
437	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2026-01-05 12:20:25.529088
438	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2026-01-05 12:20:25.533978
439	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2026-01-05 12:20:27.408119
440	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2026-01-05 12:20:27.411576
441	1	VIEW	college	16	\N	\N	2026-01-05 12:20:29.273831
442	1	VIEW	college	16	\N	\N	2026-01-05 12:20:29.276257
443	1	VIEW	college	16	\N	\N	2026-01-05 12:20:31.606113
444	1	VIEW	college	16	\N	\N	2026-01-05 12:20:31.615349
445	1	VIEW	college	16	\N	\N	2026-01-05 12:41:33.667786
446	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2026-01-05 12:41:57.70692
447	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2026-01-05 12:41:57.71253
448	1	VIEW	college	16	\N	\N	2026-01-05 12:48:04.393396
449	1	VIEW	college	16	\N	\N	2026-01-05 12:51:11.834621
450	1	VIEW	college	16	\N	\N	2026-01-05 12:51:44.82669
451	1	VIEW	college	16	\N	\N	2026-01-05 12:52:49.861453
452	1	VIEW	college	16	\N	\N	2026-01-05 12:54:28.314927
453	1	VIEW	college	16	\N	\N	2026-01-05 12:55:16.144379
454	1	VIEW	college	16	\N	\N	2026-01-05 12:56:42.896101
455	1	VIEW	college	16	\N	\N	2026-01-05 12:57:32.328033
456	1	VIEW	college	16	\N	\N	2026-01-05 12:59:28.541518
457	1	VIEW	college	16	\N	\N	2026-01-05 13:00:16.280755
458	1	VIEW	college	16	\N	\N	2026-01-05 13:01:09.341267
459	1	VIEW	college	16	\N	\N	2026-01-05 13:01:46.606715
460	1	VIEW	college	16	\N	\N	2026-01-05 13:01:52.959622
461	1	VIEW	college	16	\N	\N	2026-01-05 13:03:14.114505
462	1	VIEW	college	16	\N	\N	2026-01-05 13:03:21.43149
463	1	VIEW	college	16	\N	\N	2026-01-05 13:04:01.950201
464	1	VIEW	college	16	\N	\N	2026-01-05 13:04:14.864603
465	1	VIEW	college	16	\N	\N	2026-01-05 13:04:35.375528
466	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2026-01-05 13:11:22.681954
467	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2026-01-05 13:11:22.685829
468	1	VIEW	college	16	\N	\N	2026-01-05 13:11:28.214028
469	1	VIEW	college	16	\N	\N	2026-01-05 13:11:28.216856
470	1	VIEW	college	16	\N	\N	2026-01-05 13:11:30.6085
471	1	VIEW	college	16	\N	\N	2026-01-05 13:11:30.612327
472	1	VIEW	college	16	\N	\N	2026-01-05 13:14:24.081193
473	1	VIEW	colleges	\N	{"page": 1, "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": "Institute"}}	\N	2026-01-05 13:14:24.099798
474	1	VIEW	college	16	\N	\N	2026-01-05 13:14:40.389514
475	1	VIEW	college	16	\N	\N	2026-01-05 13:14:40.395685
476	1	VIEW	college	16	\N	\N	2026-01-05 13:18:45.005428
477	1	VIEW	college	16	\N	\N	2026-01-05 13:19:49.358514
478	1	VIEW	college	16	\N	\N	2026-01-05 13:28:43.435243
479	1	VIEW	college	16	\N	\N	2026-01-05 13:30:03.861706
480	1	VIEW	colleges	\N	{"page": 1, "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": "Institute"}}	\N	2026-01-05 13:30:03.882486
481	1	VIEW	college	16	\N	\N	2026-01-05 13:30:17.989674
482	1	VIEW	college	16	\N	\N	2026-01-05 13:30:18.0002
483	1	VIEW	college	16	\N	\N	2026-01-05 13:30:20.104279
484	1	VIEW	college	16	\N	\N	2026-01-05 13:30:20.109812
485	1	VIEW	college	16	\N	\N	2026-01-05 13:32:29.797217
486	1	VIEW	college	16	\N	\N	2026-01-05 13:36:01.04083
487	1	VIEW	colleges	\N	{"page": 1, "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": "Institute"}}	\N	2026-01-05 13:36:01.053884
488	1	VIEW	college	16	\N	\N	2026-01-05 13:36:18.366249
489	1	VIEW	college	16	\N	\N	2026-01-05 13:36:18.368375
490	1	VIEW	college	16	\N	\N	2026-01-05 13:36:20.638836
491	1	VIEW	college	16	\N	\N	2026-01-05 13:36:20.641587
492	1	VIEW	college	16	\N	\N	2026-01-05 13:36:22.472854
493	1	VIEW	college	16	\N	\N	2026-01-05 13:36:22.475987
494	1	VIEW	college	16	\N	\N	2026-01-05 13:36:23.890135
495	1	VIEW	college	16	\N	\N	2026-01-05 13:36:23.895967
496	1	VIEW	college	16	\N	\N	2026-01-05 13:36:25.251641
497	1	VIEW	college	16	\N	\N	2026-01-05 13:36:25.254523
498	1	VIEW	college	16	\N	\N	2026-01-05 13:38:25.60013
499	1	VIEW	colleges	\N	{"page": 1, "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": "Institute"}}	\N	2026-01-05 13:38:25.613968
500	1	VIEW	college	16	\N	\N	2026-01-05 13:44:29.302389
501	1	VIEW	colleges	\N	{"page": 1, "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": "Institute"}}	\N	2026-01-05 13:44:29.319632
502	1	VIEW	college	16	\N	\N	2026-01-05 13:45:13.157285
503	1	VIEW	college	16	\N	\N	2026-01-05 13:45:13.161041
504	1	VIEW	college	16	\N	\N	2026-01-05 13:45:48.78082
505	1	VIEW	colleges	\N	{"page": 1, "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": "Institute"}}	\N	2026-01-05 13:45:48.827861
506	1	VIEW	college	16	\N	\N	2026-01-05 13:57:41.740928
507	1	VIEW	colleges	\N	{"page": 1, "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": "Institute"}}	\N	2026-01-05 13:57:41.757612
508	1	VIEW	college	16	\N	\N	2026-01-05 13:58:55.020997
509	1	VIEW	colleges	\N	{"page": 1, "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": "Institute"}}	\N	2026-01-05 13:58:55.039526
510	1	VIEW	college	16	\N	\N	2026-01-05 14:00:34.673359
511	1	VIEW	colleges	\N	{"page": 1, "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": "Institute"}}	\N	2026-01-05 14:00:34.689943
512	1	VIEW	college	16	\N	\N	2026-01-05 14:00:53.133009
513	1	VIEW	college	16	\N	\N	2026-01-05 14:01:28.464413
514	1	VIEW	colleges	\N	{"page": 1, "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": "Institute"}}	\N	2026-01-05 14:01:28.569838
515	1	VIEW	college	16	\N	\N	2026-01-05 14:08:40.413048
516	1	VIEW	college	16	\N	\N	2026-01-05 14:08:40.456735
517	1	VIEW	college	16	\N	\N	2026-01-05 14:10:47.903481
518	1	VIEW	college	16	\N	\N	2026-01-05 14:13:33.431019
519	1	VIEW	colleges	\N	{"page": 1, "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": "Institute"}}	\N	2026-01-05 14:13:33.452226
520	1	VIEW	college	16	\N	\N	2026-01-05 14:28:46.321344
521	1	VIEW	college	16	\N	\N	2026-01-05 14:32:21.324466
522	1	VIEW	college	16	\N	\N	2026-01-05 15:16:03.983672
523	1	login	admin	\N	\N	::1	2026-01-05 15:16:25.871334
524	1	VIEW	college	16	\N	\N	2026-01-05 15:22:46.311741
525	1	login	admin	\N	\N	::1	2026-01-05 15:23:03.689477
526	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2026-01-05 15:23:15.948546
527	1	VIEW	colleges	\N	{"page": "1", "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": ""}}	\N	2026-01-05 15:23:15.951456
528	1	VIEW	college	16	\N	\N	2026-01-05 15:23:23.241872
529	1	VIEW	college	16	\N	\N	2026-01-05 15:23:23.244799
530	1	VIEW	college	16	\N	\N	2026-01-05 15:23:40.998439
531	1	VIEW	college	16	\N	\N	2026-01-05 15:23:41.050647
532	1	VIEW	college	16	\N	\N	2026-01-05 15:29:45.88559
533	1	login	admin	\N	\N	::1	2026-01-05 15:30:07.642298
534	1	VIEW	college	16	\N	\N	2026-01-05 15:30:15.122369
535	1	login	admin	\N	\N	::1	2026-01-05 15:31:21.675919
536	1	VIEW	college	16	\N	\N	2026-01-05 15:31:30.549144
537	1	VIEW	college	16	\N	\N	2026-01-05 15:31:46.447764
538	1	VIEW	colleges	\N	{"page": 1, "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": "Institute"}}	\N	2026-01-05 15:31:46.472303
539	1	VIEW	college	16	\N	\N	2026-01-05 15:32:10.860627
540	1	VIEW	college	16	\N	\N	2026-01-05 15:32:17.922336
541	1	VIEW	colleges	\N	{"page": 1, "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": "Institute"}}	\N	2026-01-05 15:32:17.940696
542	1	VIEW	college	16	\N	\N	2026-01-05 15:35:21.442968
543	1	VIEW	colleges	\N	{"page": 1, "limit": "10", "search": "", "filters": {"state": "", "status": "", "ownership": "", "college_type": "Institute"}}	\N	2026-01-05 15:35:21.468481
544	1	login	admin	\N	\N	::1	2026-01-05 15:37:50.290211
545	1	VIEW	college	16	\N	\N	2026-01-05 15:38:02.088021
546	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2026-01-05 16:51:49.980248
547	1	VIEW	colleges	\N	{"page": 1, "limit": "1000", "search": "", "filters": {"state": "", "status": "active", "ownership": "", "college_type": ""}}	\N	2026-01-05 16:51:49.984531
\.


--
-- Data for Name: admin_sessions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.admin_sessions (session_id, admin_id, session_token, ip_address, expires_at, is_active, created_at) FROM stdin;
1	1	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbl9pZCI6MSwiZW1haWwiOiJhZG1pbkBwbGFuZWR1LmNvbSIsInJvbGUiOiJzdXBlcl9hZG1pbiIsInR5cGUiOiJhZG1pbiIsImlhdCI6MTc2NTgwOTMwMCwiZXhwIjoxNzY4NDAxMzAwfQ.-OrTHz3uo5iKxPg7Otjjyl_mrRzqad0R2JimHd9wWrM	::1	2025-12-22 20:05:00.380742	t	2025-12-15 20:05:00.380742
2	1	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbl9pZCI6MSwiZW1haWwiOiJhZG1pbkBwbGFuZWR1LmNvbSIsInJvbGUiOiJzdXBlcl9hZG1pbiIsInR5cGUiOiJhZG1pbiIsImlhdCI6MTc2NTk3MTExOSwiZXhwIjoxNzY4NTYzMTE5fQ.d0faho9aSkVBKMOBAv9rQfsC-JcRQ47TxROmkgtgaqs	::1	2025-12-24 17:01:59.233457	t	2025-12-17 17:01:59.233457
3	1	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbl9pZCI6MSwiZW1haWwiOiJhZG1pbkBwbGFuZWR1LmNvbSIsInJvbGUiOiJzdXBlcl9hZG1pbiIsInR5cGUiOiJhZG1pbiIsImlhdCI6MTc2NTk3MTYxNCwiZXhwIjoxNzY4NTYzNjE0fQ.VBGQIwbvbqdzjHEOgGBBH-948SSILE56H0hqhtmw3EE	::1	2025-12-24 17:10:14.143265	t	2025-12-17 17:10:14.143265
4	1	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbl9pZCI6MSwiZW1haWwiOiJhZG1pbkBwbGFuZWR1LmNvbSIsInJvbGUiOiJzdXBlcl9hZG1pbiIsInR5cGUiOiJhZG1pbiIsImlhdCI6MTc2NjA0NDYwNCwiZXhwIjoxNzY4NjM2NjA0fQ.wxYVVnDxHyQLHEU2hO42mgdl5EPqB3fNk8ka26XADPk	::1	2025-12-25 13:26:44.164712	t	2025-12-18 13:26:44.164712
5	1	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbl9pZCI6MSwiZW1haWwiOiJhZG1pbkBwbGFuZWR1LmNvbSIsInJvbGUiOiJzdXBlcl9hZG1pbiIsInR5cGUiOiJhZG1pbiIsImlhdCI6MTc2NjA0ODAxMSwiZXhwIjoxNzY4NjQwMDExfQ.LHJgng0NZcFMTenf-HxzDpTvDoiAN6-4ayZXUo1NHfE	::1	2025-12-25 14:23:31.38236	t	2025-12-18 14:23:31.38236
6	1	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbl9pZCI6MSwiZW1haWwiOiJhZG1pbkBwbGFuZWR1LmNvbSIsInJvbGUiOiJzdXBlcl9hZG1pbiIsInR5cGUiOiJhZG1pbiIsImlhdCI6MTc2NjA1MDU0NiwiZXhwIjoxNzY4NjQyNTQ2fQ.b0-j0jCNYhO2QOzovGdVe6o6myycDDijluwW8bJNmzw	::1	2025-12-25 15:05:46.703972	t	2025-12-18 15:05:46.703972
7	1	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbl9pZCI6MSwiZW1haWwiOiJhZG1pbkBwbGFuZWR1LmNvbSIsInJvbGUiOiJzdXBlcl9hZG1pbiIsInR5cGUiOiJhZG1pbiIsImlhdCI6MTc2NjA1MTc3OSwiZXhwIjoxNzY4NjQzNzc5fQ.2lviuH5cG-ZbwzR24A4WNVzZBn3guh3JbPa0ii5p_fs	::1	2025-12-25 15:26:19.696347	t	2025-12-18 15:26:19.696347
8	1	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbl9pZCI6MSwiZW1haWwiOiJhZG1pbkBwbGFuZWR1LmNvbSIsInJvbGUiOiJzdXBlcl9hZG1pbiIsInR5cGUiOiJhZG1pbiIsImlhdCI6MTc2NjA1NDIwMiwiZXhwIjoxNzY4NjQ2MjAyfQ.VrChpsnDrfWhKO-rHfLuGpngxrEcSx9Yp7uFMPvHRjk	::1	2025-12-25 16:06:42.551118	t	2025-12-18 16:06:42.551118
9	1	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbl9pZCI6MSwiZW1haWwiOiJhZG1pbkBwbGFuZWR1LmNvbSIsInJvbGUiOiJzdXBlcl9hZG1pbiIsInR5cGUiOiJhZG1pbiIsImlhdCI6MTc2NjA1NTEzMCwiZXhwIjoxNzY4NjQ3MTMwfQ.yy0ehYcB8q1bxrdHRkpeNowgKE4THxz0sbn-zMGXgu4	::1	2025-12-25 16:22:10.581842	t	2025-12-18 16:22:10.581842
10	1	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbl9pZCI6MSwiZW1haWwiOiJhZG1pbkBwbGFuZWR1LmNvbSIsInJvbGUiOiJzdXBlcl9hZG1pbiIsInR5cGUiOiJhZG1pbiIsImlhdCI6MTc2NjA2MDY1MywiZXhwIjoxNzY4NjUyNjUzfQ.7kiTvHEfe56PKA14Ssyi4KZONXWKGD74Ryw6K6GepmU	::1	2025-12-25 17:54:13.095245	t	2025-12-18 17:54:13.095245
11	1	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbl9pZCI6MSwiZW1haWwiOiJhZG1pbkBwbGFuZWR1LmNvbSIsInJvbGUiOiJzdXBlcl9hZG1pbiIsInR5cGUiOiJhZG1pbiIsImlhdCI6MTc2NjA2MDk5OCwiZXhwIjoxNzY4NjUyOTk4fQ.mCOYnom4wqfzzLSVrpTgEoj7aop8R2VQSBmJ0h1TIfw	::1	2025-12-25 17:59:58.984093	t	2025-12-18 17:59:58.984093
12	1	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbl9pZCI6MSwiZW1haWwiOiJhZG1pbkBwbGFuZWR1LmNvbSIsInJvbGUiOiJzdXBlcl9hZG1pbiIsInR5cGUiOiJhZG1pbiIsImlhdCI6MTc2NjA2NDczNywiZXhwIjoxNzY4NjU2NzM3fQ.RsIpveWSaEC5AQlpwQUtI0cMtzZrx24wDWk1Rj-gmUE	::1	2025-12-25 19:02:17.365216	t	2025-12-18 19:02:17.365216
13	1	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbl9pZCI6MSwiZW1haWwiOiJhZG1pbkBwbGFuZWR1LmNvbSIsInJvbGUiOiJzdXBlcl9hZG1pbiIsInR5cGUiOiJhZG1pbiIsImlhdCI6MTc2NjA2NTgyNywiZXhwIjoxNzY4NjU3ODI3fQ.sD6CfgdjVzLgvmz5VzgTjmofi3Grpe1SdyhrgXc9xb4	::1	2025-12-25 19:20:27.481899	t	2025-12-18 19:20:27.481899
14	1	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbl9pZCI6MSwiZW1haWwiOiJhZG1pbkBwbGFuZWR1LmNvbSIsInJvbGUiOiJzdXBlcl9hZG1pbiIsInR5cGUiOiJhZG1pbiIsImlhdCI6MTc2NjEzOTg5NSwiZXhwIjoxNzY4NzMxODk1fQ.fF3wc8FSLcAG8T7xTq-iOXrr9clv82wPDh1nr5aYB2c	::1	2025-12-26 15:54:55.576072	t	2025-12-19 15:54:55.576072
15	1	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbl9pZCI6MSwiZW1haWwiOiJhZG1pbkBwbGFuZWR1LmNvbSIsInJvbGUiOiJzdXBlcl9hZG1pbiIsInR5cGUiOiJhZG1pbiIsImlhdCI6MTc2NjE0MDEyMCwiZXhwIjoxNzY4NzMyMTIwfQ.2CbttOtfINE7XUhkhKLWEZ0jtxHz0ClEFAWzd3rb9IE	::1	2025-12-26 15:58:40.871818	t	2025-12-19 15:58:40.871818
16	1	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbl9pZCI6MSwiZW1haWwiOiJhZG1pbkBwbGFuZWR1LmNvbSIsInJvbGUiOiJzdXBlcl9hZG1pbiIsInR5cGUiOiJhZG1pbiIsImlhdCI6MTc2NjQ3NjY5NSwiZXhwIjoxNzY5MDY4Njk1fQ.ReoUDaoZHs6RCOm7_3QwiTtE18e2LfsCInMGwHYg0Cw	::1	2025-12-30 13:28:15.265555	t	2025-12-23 13:28:15.265555
17	1	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbl9pZCI6MSwiZW1haWwiOiJhZG1pbkBwbGFuZWR1LmNvbSIsInJvbGUiOiJzdXBlcl9hZG1pbiIsInR5cGUiOiJhZG1pbiIsImlhdCI6MTc2NjQ5MzQzOCwiZXhwIjoxNzY5MDg1NDM4fQ.ia8jYEORkG0ZMTq4V49BTeTCWVUhsGi4mPuc0KTHwqA	::1	2025-12-30 18:07:18.876532	t	2025-12-23 18:07:18.876532
18	1	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbl9pZCI6MSwiZW1haWwiOiJhZG1pbkBwbGFuZWR1LmNvbSIsInJvbGUiOiJzdXBlcl9hZG1pbiIsInR5cGUiOiJhZG1pbiIsImlhdCI6MTc2NjQ5MzkzOCwiZXhwIjoxNzY5MDg1OTM4fQ.QdR72ULqyMAPNR6HAYEmlLE6rn1YCBmzZhkyWf-36iY	::1	2025-12-30 18:15:38.852839	t	2025-12-23 18:15:38.852839
19	1	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbl9pZCI6MSwiZW1haWwiOiJhZG1pbkBwbGFuZWR1LmNvbSIsInJvbGUiOiJzdXBlcl9hZG1pbiIsInR5cGUiOiJhZG1pbiIsImlhdCI6MTc2NjQ5Njg3NSwiZXhwIjoxNzY5MDg4ODc1fQ.IpZT3w5xnbYrnwYZu9UNehbt9E4DXCB2lUeSoMH6Bro	::1	2025-12-30 19:04:35.754647	t	2025-12-23 19:04:35.754647
20	1	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbl9pZCI6MSwiZW1haWwiOiJhZG1pbkBwbGFuZWR1LmNvbSIsInJvbGUiOiJzdXBlcl9hZG1pbiIsInR5cGUiOiJhZG1pbiIsImlhdCI6MTc2NjU3Njk4MCwiZXhwIjoxNzY5MTY4OTgwfQ.zt2x6r2ZWXO4cE0pEZzwS-xYXqwmhpjQFbL5dUgMWgU	::1	2025-12-31 17:19:40.340552	t	2025-12-24 17:19:40.340552
21	1	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbl9pZCI6MSwiZW1haWwiOiJhZG1pbkBwbGFuZWR1LmNvbSIsInJvbGUiOiJzdXBlcl9hZG1pbiIsInR5cGUiOiJhZG1pbiIsImlhdCI6MTc2NzA5NDMzNSwiZXhwIjoxNzY5Njg2MzM1fQ.4CLzxjA4zsGHclejrgFYUEF-ZSLkz-pbE3UFn95PEOA	::1	2026-01-06 17:02:15.822079	t	2025-12-30 17:02:15.822079
22	1	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbl9pZCI6MSwiZW1haWwiOiJhZG1pbkBwbGFuZWR1LmNvbSIsInJvbGUiOiJzdXBlcl9hZG1pbiIsInR5cGUiOiJhZG1pbiIsImlhdCI6MTc2NzEwNDM2OSwiZXhwIjoxNzY5Njk2MzY5fQ.nMJTUfU01hZUhsjP-QfHAxRvsy1TcrSu_ez3OclGsBg	::1	2026-01-06 19:49:29.870058	t	2025-12-30 19:49:29.870058
23	1	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbl9pZCI6MSwiZW1haWwiOiJhZG1pbkBwbGFuZWR1LmNvbSIsInJvbGUiOiJzdXBlcl9hZG1pbiIsInR5cGUiOiJhZG1pbiIsImlhdCI6MTc2NzE2OTE1NiwiZXhwIjoxNzY5NzYxMTU2fQ.UJycRXaVlyzBzYSrZd7P47x6KNjf6_oRVVYIgyY0LZc	::1	2026-01-07 13:49:16.601232	t	2025-12-31 13:49:16.601232
24	1	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbl9pZCI6MSwiZW1haWwiOiJhZG1pbkBwbGFuZWR1LmNvbSIsInJvbGUiOiJzdXBlcl9hZG1pbiIsInR5cGUiOiJhZG1pbiIsImlhdCI6MTc2NzE4MTEyOSwiZXhwIjoxNzY5NzczMTI5fQ.EMxpiZmsaFBFIpI640NcXWfRzLPB5qwP64mF75fnU1Y	::1	2026-01-07 17:08:49.676074	t	2025-12-31 17:08:49.676074
25	1	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbl9pZCI6MSwiZW1haWwiOiJhZG1pbkBwbGFuZWR1LmNvbSIsInJvbGUiOiJzdXBlcl9hZG1pbiIsInR5cGUiOiJhZG1pbiIsImlhdCI6MTc2NzI1MTg2NCwiZXhwIjoxNzY5ODQzODY0fQ.Ed334Tp3SbtTC58ZQGhOF5wmscd1T9f8VFHHNLbvAhc	::1	2026-01-08 12:47:44.377139	t	2026-01-01 12:47:44.377139
26	1	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbl9pZCI6MSwiZW1haWwiOiJhZG1pbkBwbGFuZWR1LmNvbSIsInJvbGUiOiJzdXBlcl9hZG1pbiIsInR5cGUiOiJhZG1pbiIsImlhdCI6MTc2NzI3MTAzNywiZXhwIjoxNzY5ODYzMDM3fQ.uLdpXZgCZHxxgeLD9GhGlkmdGwXT0vBvlnMiGJgvxAY	::1	2026-01-08 18:07:17.772403	t	2026-01-01 18:07:17.772403
27	1	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbl9pZCI6MSwiZW1haWwiOiJhZG1pbkBwbGFuZWR1LmNvbSIsInJvbGUiOiJzdXBlcl9hZG1pbiIsInR5cGUiOiJhZG1pbiIsImlhdCI6MTc2NzI3NTM3NCwiZXhwIjoxNzY5ODY3Mzc0fQ.gdp18D-5Py_4kfCc4c2rW2rGMKsJIKu80MfDp4dHbWo	::1	2026-01-08 19:19:34.549222	t	2026-01-01 19:19:34.549222
28	1	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbl9pZCI6MSwiZW1haWwiOiJhZG1pbkBwbGFuZWR1LmNvbSIsInJvbGUiOiJzdXBlcl9hZG1pbiIsInR5cGUiOiJhZG1pbiIsImlhdCI6MTc2NzI3NTkzNywiZXhwIjoxNzY5ODY3OTM3fQ.XDOA7Y9OP_ohCXnTkmjCzcIYmKxlCOdfXJyWQkzI4dw	::1	2026-01-08 19:28:57.073632	t	2026-01-01 19:28:57.073632
29	1	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbl9pZCI6MSwiZW1haWwiOiJhZG1pbkBwbGFuZWR1LmNvbSIsInJvbGUiOiJzdXBlcl9hZG1pbiIsInR5cGUiOiJhZG1pbiIsImlhdCI6MTc2NzI3NzM4NSwiZXhwIjoxNzY5ODY5Mzg1fQ.vUOp-c8CdqutV1yRb26WaDBs0yHhFBzVZ1b2chVJGVw	::1	2026-01-08 19:53:05.562873	t	2026-01-01 19:53:05.562873
30	1	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbl9pZCI6MSwiZW1haWwiOiJhZG1pbkBwbGFuZWR1LmNvbSIsInJvbGUiOiJzdXBlcl9hZG1pbiIsInR5cGUiOiJhZG1pbiIsImlhdCI6MTc2NzI4NzQ2MiwiZXhwIjoxNzY5ODc5NDYyfQ.c9TibvT8Uy_Z4qxmTSg06rPMo2ZO_AmHsghnyeoXll8	::1	2026-01-08 22:41:02.217447	t	2026-01-01 22:41:02.217447
31	1	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbl9pZCI6MSwiZW1haWwiOiJhZG1pbkBwbGFuZWR1LmNvbSIsInJvbGUiOiJzdXBlcl9hZG1pbiIsInR5cGUiOiJhZG1pbiIsImlhdCI6MTc2NzI4ODEyMCwiZXhwIjoxNzY5ODgwMTIwfQ.iVue4eZeUkz8aH4h6QneagseNd1Ha1IzuXnh8dTYPYM	::1	2026-01-08 22:52:00.961913	t	2026-01-01 22:52:00.961913
32	1	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbl9pZCI6MSwiZW1haWwiOiJhZG1pbkBwbGFuZWR1LmNvbSIsInJvbGUiOiJzdXBlcl9hZG1pbiIsInR5cGUiOiJhZG1pbiIsImlhdCI6MTc2NzU5NTExNywiZXhwIjoxNzcwMTg3MTE3fQ.ysuTL_u6IlWjcIGAKzs_RtMebYwBMHZ9k59KI3-gvxU	::1	2026-01-12 12:08:37.110643	t	2026-01-05 12:08:37.110643
33	1	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbl9pZCI6MSwiZW1haWwiOiJhZG1pbkBwbGFuZWR1LmNvbSIsInJvbGUiOiJzdXBlcl9hZG1pbiIsInR5cGUiOiJhZG1pbiIsImlhdCI6MTc2NzU5NTgyMCwiZXhwIjoxNzcwMTg3ODIwfQ.PJUmPwsSVnxbOtLyJadVW6IMNy2E3cNlxnE30OKbDhk	::1	2026-01-12 12:20:20.901531	t	2026-01-05 12:20:20.901531
34	1	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbl9pZCI6MSwiZW1haWwiOiJhZG1pbkBwbGFuZWR1LmNvbSIsInJvbGUiOiJzdXBlcl9hZG1pbiIsInR5cGUiOiJhZG1pbiIsImlhdCI6MTc2NzYwNjM4NSwiZXhwIjoxNzcwMTk4Mzg1fQ.x8wA9OmOD8bZfKORjTGiVzvMaHTcMauDOUt5c22Od54	::1	2026-01-12 15:16:25.866886	t	2026-01-05 15:16:25.866886
35	1	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbl9pZCI6MSwiZW1haWwiOiJhZG1pbkBwbGFuZWR1LmNvbSIsInJvbGUiOiJzdXBlcl9hZG1pbiIsInR5cGUiOiJhZG1pbiIsImlhdCI6MTc2NzYwNjc4MywiZXhwIjoxNzcwMTk4NzgzfQ.SSrqB6ntJfgVkO_tbXPETATu00Bcb__GwCzu3q3x-sg	::1	2026-01-12 15:23:03.68748	t	2026-01-05 15:23:03.68748
36	1	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbl9pZCI6MSwiZW1haWwiOiJhZG1pbkBwbGFuZWR1LmNvbSIsInJvbGUiOiJzdXBlcl9hZG1pbiIsInR5cGUiOiJhZG1pbiIsImlhdCI6MTc2NzYwNzIwNywiZXhwIjoxNzcwMTk5MjA3fQ.FblDVk3rywHbAd3bMXCZlUI0F5E91-aq-1iKqGJ_I0A	::1	2026-01-12 15:30:07.638489	t	2026-01-05 15:30:07.638489
37	1	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbl9pZCI6MSwiZW1haWwiOiJhZG1pbkBwbGFuZWR1LmNvbSIsInJvbGUiOiJzdXBlcl9hZG1pbiIsInR5cGUiOiJhZG1pbiIsImlhdCI6MTc2NzYwNzI4MSwiZXhwIjoxNzcwMTk5MjgxfQ.5qBcSiXzLRKxxkid564wt13A4ilN3fp81jW-b14t5m4	::1	2026-01-12 15:31:21.671537	t	2026-01-05 15:31:21.671537
38	1	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhZG1pbl9pZCI6MSwiZW1haWwiOiJhZG1pbkBwbGFuZWR1LmNvbSIsInJvbGUiOiJzdXBlcl9hZG1pbiIsInR5cGUiOiJhZG1pbiIsImlhdCI6MTc2NzYwNzY3MCwiZXhwIjoxNzcwMTk5NjcwfQ.RT7kmHDT81KaRX3IE3NmypTTokgeAmqBMmDn-8awtVU	::1	2026-01-12 15:37:50.288475	t	2026-01-05 15:37:50.288475
\.


--
-- Data for Name: admin_users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.admin_users (admin_id, email, password_hash, name, role, status, created_at, updated_at) FROM stdin;
1	admin@planedu.com	$2b$10$H/qIVGgwnmzkXmuKBnFb0eA9SSF.JbxSOTPiH2ksMmO8T8pjn7Ox.	Super Admin	super_admin	active	2025-12-15 20:03:47.002636	2025-12-15 20:03:47.002636
\.


--
-- Data for Name: audit_log; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.audit_log (id, user_id, action, entity, entity_id, old_values, new_values, meta, created_at) FROM stdin;
\.


--
-- Data for Name: banner_analytics; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.banner_analytics (id, banner_id, event_type, user_id, session_id, ip_address, created_at) FROM stdin;
\.


--
-- Data for Name: banners; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.banners (id, title, image_url, link_url, placement, page_type, target_audience, priority, valid_from, valid_to, is_active, click_count, view_count, created_by, created_at) FROM stdin;
1	JEE Advanced 2024 Counselling	https://images.unsplash.com/photo-1523050854058-8df90110c9f1	/news/jee-advanced-2024-counselling	top	home	\N	1	2025-12-23 13:38:56.095543	2026-01-22 13:38:56.095543	t	0	0	\N	2025-12-23 13:38:56.095543
2	NEET UG 2024 Results	https://images.unsplash.com/photo-1434030216411-0b793f4b4173	/news/neet-ug-2024-results	middle	home	\N	2	2025-12-23 13:38:56.095543	2026-01-07 13:38:56.095543	t	0	0	\N	2025-12-23 13:38:56.095543
3	Top Engineering Colleges	https://images.unsplash.com/photo-1562774053-701939374585	/colleges?type=Engineering	bottom	home	\N	3	2025-12-23 13:38:56.095543	2026-03-23 13:38:56.095543	t	0	0	\N	2025-12-23 13:38:56.095543
4	MBA Admissions Open	https://images.unsplash.com/photo-1454165804606-c3d57bc86b40	/news/mba-admissions-2024	sidebar	colleges	\N	4	2025-12-23 13:38:56.095543	2026-02-21 13:38:56.095543	t	0	0	\N	2025-12-23 13:38:56.095543
\.


--
-- Data for Name: college_content; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.college_content (id, college_id, section_type, title, content, table_of_contents, author_id, meta_title, meta_description, status, published_at, created_at, updated_at) FROM stdin;
1	2	overview	IIT Delhi Overview - About the Institute	<p style="text-align: left;">Indian Institute of Technology Bombay, popularly known as IIT Bombay or IIT Mumbai, is an autonomous institute established in <strong>1958</strong>. As per the data, the maximum number of top JEE (Advanced) rankers chose IIT Bombay because of its career opportunities and its location in the financial hub of India. <a target="_blank" rel="noopener noreferrer nofollow" class="text-primary-600 underline hover:text-primary-800" href="https://collegedunia.com/university/25703-iit-bombay-indian-institute-of-technology-iitb-mumbai/ranking" style="color: rgb(37, 99, 235); text-decoration: underline;"><strong><u>IITB Ranking</u></strong></a> is <strong>3rd </strong>in the <a target="_blank" rel="noopener noreferrer nofollow" class="text-primary-600 underline hover:text-primary-800" href="http://B.Tech" style="color: rgb(37, 99, 235); text-decoration: underline;"><u>B.Tech</u></a>. category by NIRF 2025. According to Collegedunia Rankings, the institute has been ranked <strong>1st</strong> for <a target="_blank" rel="noopener noreferrer nofollow" class="text-primary-600 underline hover:text-primary-800" href="http://B.Tech" style="color: rgb(37, 99, 235); text-decoration: underline;"><u>B.Tech</u></a>.</p><p style="text-align: left;">IITB offers <a target="_blank" rel="noopener noreferrer nofollow" class="text-primary-600 underline hover:text-primary-800" href="http://B.Tech" style="color: rgb(37, 99, 235); text-decoration: underline;"><u>B.Tech</u></a> as one of the most popular programs. Admission to <a target="_blank" rel="noopener noreferrer nofollow" class="text-primary-600 underline hover:text-primary-800" href="http://B.Tech" style="color: rgb(37, 99, 235); text-decoration: underline;"><u>B.Tech</u></a> is based on JEE Advanced scores, followed by JoSAA Counselling. <a target="_blank" rel="noopener noreferrer nofollow" class="text-primary-600 underline hover:text-primary-800" href="https://collegedunia.com/university/25703-iit-bombay-indian-institute-of-technology-iitb-mumbai/jee-advanced-2025-cutoff" style="color: rgb(37, 99, 235); text-decoration: underline;"><strong><u>IIT Bombay JEE Advanced Cutoff Rank</u></strong></a> 2025 Round 1 for the General Category is <strong>66 - 4696</strong>.</p><p style="text-align: left;">As per IIT Bombay Placements, the average package was INR 23.5 LPA. 22 students accepted offers above INR 1 Cr PA. 388 companies participated, including Fortune 500 companies. The top recruiters at <a target="_blank" rel="noopener noreferrer nofollow" class="text-primary-600 underline hover:text-primary-800" href="https://collegedunia.com/university/25703-iit-bombay-indian-institute-of-technology-iitb-mumbai/placement" style="color: rgb(37, 99, 235); text-decoration: underline;"><strong><u>IIT Bombay Placement</u></strong></a> included Airbus, Apple, Google, Intel, Godrej, Shell, Halliburton, Accenture, Barclays, Michelin, Cipla, Abbott, Pfizer, Amazon, Honeywell, Hitachi, Boeing, and Reliance.</p><p style="text-align: left;"></p><p style="text-align: left;"></p><div data-youtube-video=""><iframe width="640" height="360" allowfullscreen="true" autoplay="false" disablekbcontrols="false" enableiframeapi="false" endtime="0" ivloadpolicy="0" loop="false" modestbranding="false" origin="" playlist="" rel="1" src="https://www.youtube-nocookie.com/embed/Mzw2ttJD2qQ?si=14QHai3UoukUif_Q" start="0" style="width: 100%; aspect-ratio: 16 / 9; margin: 1rem 0px;"></iframe></div><div data-background-color="#f3f4f6" data-border-color="#e5e7eb" data-type="callout" class="callout-box" style="background-color: rgb(243, 244, 246); border: 1px solid rgb(229, 231, 235); border-radius: 8px; padding: 16px; margin: 12px 0px;"><p><strong>Table of Contents</strong></p><ul style="list-style-type: disc; padding-left: 1.5em; margin: 0.5em 0px;"><li style="margin: 0.25em 0px;"><p><a target="_blank" rel="noopener noreferrer nofollow" class="text-primary-600 underline hover:text-primary-800" href="https://collegedunia.com/university/25703-iit-bombay-indian-institute-of-technology-iitb-mumbai#1" style="color: rgb(37, 99, 235); text-decoration: underline;"><strong><u>IIT Bombay Admission 2026 Dates</u></strong></a></p></li><li style="margin: 0.25em 0px;"><p><a target="_blank" rel="noopener noreferrer nofollow" class="text-primary-600 underline hover:text-primary-800" href="https://collegedunia.com/university/25703-iit-bombay-indian-institute-of-technology-iitb-mumbai#7" style="color: rgb(37, 99, 235); text-decoration: underline;"><strong><u>IIT Bombay Fees 2026</u></strong></a></p></li><li style="margin: 0.25em 0px;"><p><a target="_blank" rel="noopener noreferrer nofollow" class="text-primary-600 underline hover:text-primary-800" href="https://collegedunia.com/university/25703-iit-bombay-indian-institute-of-technology-iitb-mumbai#10" style="color: rgb(37, 99, 235); text-decoration: underline;"><strong><u>IIT Bombay Ranking</u></strong></a></p></li><li style="margin: 0.25em 0px;"><p><a target="_blank" rel="noopener noreferrer nofollow" class="text-primary-600 underline hover:text-primary-800" href="https://collegedunia.com/university/25703-iit-bombay-indian-institute-of-technology-iitb-mumbai#12" style="color: rgb(37, 99, 235); text-decoration: underline;"><strong><u>IIT Bombay Admission 2026</u></strong></a></p></li><li style="margin: 0.25em 0px;"><p><a target="_blank" rel="noopener noreferrer nofollow" class="text-primary-600 underline hover:text-primary-800" href="https://collegedunia.com/university/25703-iit-bombay-indian-institute-of-technology-iitb-mumbai#16" style="color: rgb(37, 99, 235); text-decoration: underline;"><strong><u>IIT Bombay Cutoff</u></strong></a></p></li><li style="margin: 0.25em 0px;"><p><a target="_blank" rel="noopener noreferrer nofollow" class="text-primary-600 underline hover:text-primary-800" href="https://collegedunia.com/university/25703-iit-bombay-indian-institute-of-technology-iitb-mumbai#20" style="color: rgb(37, 99, 235); text-decoration: underline;"><strong><u>IIT Bombay Placement</u></strong></a></p></li><li style="margin: 0.25em 0px;"><p><a target="_blank" rel="noopener noreferrer nofollow" class="text-primary-600 underline hover:text-primary-800" href="https://collegedunia.com/university/25703-iit-bombay-indian-institute-of-technology-iitb-mumbai#21" style="color: rgb(37, 99, 235); text-decoration: underline;"><strong><u>IIT Bombay vs IIT Delhi vs IIT Kharagpur</u></strong></a></p></li><li style="margin: 0.25em 0px;"><p><a target="_blank" rel="noopener noreferrer nofollow" class="text-primary-600 underline hover:text-primary-800" href="https://collegedunia.com/university/25703-iit-bombay-indian-institute-of-technology-iitb-mumbai#26" style="color: rgb(37, 99, 235); text-decoration: underline;"><strong><u>IIT Bombay Campus &amp; Facilities</u></strong></a></p></li><li style="margin: 0.25em 0px;"><p><a target="_blank" rel="noopener noreferrer nofollow" class="text-primary-600 underline hover:text-primary-800" href="https://collegedunia.com/university/25703-iit-bombay-indian-institute-of-technology-iitb-mumbai#30" style="color: rgb(37, 99, 235); text-decoration: underline;"><strong><u>IIT Bombay FAQs</u></strong></a></p></li></ul></div><p></p><p></p><h2><strong>IIT Bombay Admission 2026 Dates</strong></h2><p>IIT Bombay also offers <a target="_blank" rel="noopener noreferrer nofollow" class="text-primary-600 underline hover:text-primary-800" href="http://M.Tech" style="color: rgb(37, 99, 235); text-decoration: underline;"><u>M.Tech</u></a> and MSc as other popular programs. Admission to these programs is based on national-level entrance exams, including IIT JAM and GATE. Here are the important dates of the admission process conducted by IIT Bombay:</p><h3><strong>IIT Bombay </strong><a target="_blank" rel="noopener noreferrer nofollow" class="text-primary-600 underline hover:text-primary-800" href="http://B.Tech" style="color: rgb(37, 99, 235); text-decoration: underline;"><strong><u>B.Tech</u></strong></a><strong> Admission Dates 2026</strong></h3><p>Candidates applying for admission to the <a target="_blank" rel="noopener noreferrer nofollow" class="text-primary-600 underline hover:text-primary-800" href="http://B.Tech" style="color: rgb(37, 99, 235); text-decoration: underline;"><u>B.Tech</u></a> have to appear for JEE Main and JEE Advanced, followed by JoSAA Counselling. The candidates can check the schedule from the table below:</p><h4><strong>JEE Main Dates 2026</strong></h4><table style="border-collapse: collapse; width: 100%; margin: 1rem 0px;"><tbody><tr><th colspan="1" rowspan="1" style="border: 1px solid rgb(209, 213, 219); padding: 12px 16px; text-align: left; background-color: rgb(243, 244, 246); font-weight: 600;"><p><strong>Event</strong></p></th><th colspan="1" rowspan="1" style="border: 1px solid rgb(209, 213, 219); padding: 12px 16px; text-align: left; background-color: rgb(243, 244, 246); font-weight: 600;"><p><strong>Date</strong></p></th></tr><tr><td colspan="1" rowspan="1" style="border: 1px solid rgb(209, 213, 219); padding: 12px 16px; text-align: left;"><p><strong>JEE Main 2026 Session 1 Exam&nbsp;Date</strong></p></td><td colspan="1" rowspan="1" style="border: 1px solid rgb(209, 213, 219); padding: 12px 16px; text-align: left;"><p><strong>Jan 22 - 30, 2026</strong></p></td></tr><tr><td colspan="1" rowspan="1" style="border: 1px solid rgb(209, 213, 219); padding: 12px 16px; text-align: left;"><p><strong>JEE Main 2026 Session 1 Result</strong></p></td><td colspan="1" rowspan="1" style="border: 1px solid rgb(209, 213, 219); padding: 12px 16px; text-align: left;"><p><strong>Feb 19, 2026</strong></p></td></tr><tr><td colspan="1" rowspan="1" style="border: 1px solid rgb(209, 213, 219); padding: 12px 16px; text-align: left;"><p><strong>JEE Main 2026 Session 2 Exam Date</strong></p></td><td colspan="1" rowspan="1" style="border: 1px solid rgb(209, 213, 219); padding: 12px 16px; text-align: left;"><p><strong>Apr 1-10, 2026</strong></p></td></tr><tr><td colspan="1" rowspan="1" style="border: 1px solid rgb(209, 213, 219); padding: 12px 16px; text-align: left;"><p><strong>JEE Main 2026 Session 2 Result</strong></p></td><td colspan="1" rowspan="1" style="border: 1px solid rgb(209, 213, 219); padding: 12px 16px; text-align: left;"><p><strong>Apr 20, 2026</strong></p></td></tr></tbody></table><div data-background-color="#f3f4f6" data-border-color="#e5e7eb" data-type="callout" class="callout-box" style="background-color: rgb(243, 244, 246); border: 1px solid rgb(229, 231, 235); border-radius: 8px; padding: 16px; margin: 12px 0px;"><p>This is a test callout box with a gray background!</p></div><ul data-type="taskList" style="list-style: none; padding-left: 0px; margin: 0.5em 0px;"><li data-checked="true" data-type="taskItem" style="display: flex; align-items: flex-start; gap: 0.5rem; margin: 0.5rem 0px;"><label style="flex-shrink: 0; margin-top: 0.25rem;"><input type="checkbox" checked="checked" style="width: 1rem; height: 1rem; cursor: pointer; accent-color: rgb(59, 130, 246);"></label><div style="flex: 1 1 0%; text-decoration: line-through; color: rgb(156, 163, 175);"><p><s>Complete the application form</s></p></div></li><li data-checked="false" data-type="taskItem" style="display: flex; align-items: flex-start; gap: 0.5rem; margin: 0.5rem 0px;"><label style="flex-shrink: 0; margin-top: 0.25rem;"><input type="checkbox" style="width: 1rem; height: 1rem; cursor: pointer; accent-color: rgb(59, 130, 246);"></label><div style="flex: 1 1 0%;"><p>Submit documents by deadline🎓</p></div></li></ul><p></p>	\N	2	\N	\N	draft	2025-12-31 18:44:54.072124	2025-12-30 17:08:05.871878	2025-12-31 19:05:38.859124
2	2	courses	IIT Delhi Courses & Fees 2025 - Programs, Eligibility & Fee Structure	<h2>About IIT Delhi Courses</h2><p>Indian Institute of Technology Delhi offers a wide range of undergraduate, postgraduate, and doctoral programs across various disciplines. The institute is renowned for its rigorous academic curriculum and world-class faculty.</p><h3>Key Highlights</h3><ul style="list-style-type: disc; padding-left: 1.5em; margin: 0.5em 0px;"><li style="margin: 0.25em 0px;"><p>NIRF Ranking: #2 among Engineering Colleges</p></li><li style="margin: 0.25em 0px;"><p>Total Programs: 50+ courses</p></li><li style="margin: 0.25em 0px;"><p>Average Package: ₹20+ LPA</p></li></ul><p>IIT Delhi admission is highly competitive and primarily based on JEE Advanced scores for B.Tech programs.</p>	\N	1	\N	\N	published	2026-01-01 12:21:25.424	2026-01-01 12:21:25.420977	2026-01-01 12:21:25.420977
4	16	admission	\N	<p>Chennai Business School admission process includes entrance exams and personal interviews. Candidates must meet the eligibility criteria for their chosen program.</p>	\N	2	\N	\N	published	2026-01-05 14:01:21.204	2026-01-05 14:01:21.20374	2026-01-05 14:01:21.20374
6	16	cutoff	\N	<p>Chennai Business School cutoff marks are determined based on entrance exam scores. Check the latest cutoff trends for different programs.</p>	\N	2	\N	\N	published	2026-01-05 14:11:58.573	2026-01-05 14:11:58.571488	2026-01-05 14:11:58.571488
7	16	placement	\N	<p>Chennai Business School has excellent placement records with top recruiters visiting campus. Average package and top companies are highlighted below.</p>	\N	1	\N	\N	published	2026-01-05 14:12:35.52	2026-01-05 14:12:35.518578	2026-01-05 14:12:35.518578
8	16	scholarship	\N	<p>Chennai Business School offers various scholarships for meritorious students. Financial aid programs are available for deserving candidates.</p>	\N	2	\N	\N	published	2026-01-05 14:13:25.768	2026-01-05 14:13:25.765912	2026-01-05 14:13:25.765912
3	16	overview	\N	<p>Chennai Business School is a premier institution for management education. It offers various courses in business administration and management.</p>	\N	1	\N	\N	published	2026-01-05 13:45:41.441	2026-01-05 13:45:41.440331	2026-01-05 15:35:07.182879
5	16	courses	\N	<p>Chennai Business School offers diverse courses in management and business. The fee structure varies based on the program and duration.</p>	\N	1	\N	\N	published	2026-01-05 14:11:22.737	2026-01-05 14:11:22.735898	2026-01-05 15:38:14.719722
\.


--
-- Data for Name: college_facilities; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.college_facilities (facility_id, college_id, facility_type, facility_name, description, created_at) FROM stdin;
\.


--
-- Data for Name: college_gallery; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.college_gallery (id, college_id, category, image_url, caption, display_order, created_at) FROM stdin;
1	2	campus	https://picsum.photos/seed/campus/800/600	IIT Delhi Main Building	0	2025-12-30 18:45:56.971251
2	2	library	https://picsum.photos/seed/library/800/600	Central Library - IIT Delhi	0	2025-12-30 18:59:39.574786
4	16	campus	http://localhost:3000/uploads/gallery/gallery-1767599684351-820860241.jpg	wertyuio	0	2026-01-05 13:24:47.243582
5	16	library	http://localhost:3000/uploads/gallery/gallery-1767599801039-612909660.jpg	Test Library Photo - Uploaded via Playwright	0	2026-01-05 13:26:59.083286
6	16	sports	http://localhost:3000/uploads/gallery/gallery-1767600228471-8160243.jpg	Sports Facility - One Click Upload Test	0	2026-01-05 13:33:48.490499
\.


--
-- Data for Name: college_media; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.college_media (media_id, college_id, media_type, media_url, title, uploaded_at) FROM stdin;
\.


--
-- Data for Name: college_rankings; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.college_rankings (ranking_id, college_id, agency_id, ranking_year, category, rank_position, score, created_at) FROM stdin;
2	5	1	2025	Management	2	\N	2026-01-01 17:51:17.203287
3	6	1	2025	Engineering	2	\N	2026-01-01 17:51:17.203287
4	7	1	2025	Medical	8	\N	2026-01-01 17:51:17.203287
5	8	1	2025	Law	1	\N	2026-01-01 17:51:17.203287
6	2	1	2025	Engineering	3	\N	2026-01-01 17:51:17.203287
7	10	1	2025	Management	3	\N	2026-01-01 17:51:17.203287
8	11	1	2025	College	1	\N	2026-01-01 17:51:17.203287
9	12	1	2025	College	18	\N	2026-01-01 17:51:17.203287
10	16	1	2026	\N	25	85.50	2026-01-05 13:01:09.329678
\.


--
-- Data for Name: college_updates; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.college_updates (id, college_id, update_type, title, content, source_url, event_date, is_pinned, published_at, expires_at, created_at) FROM stdin;
1	2	key_update	JEE Advanced 2026 Registration Opens April 15	IIT Delhi announces that JEE Advanced 2026 registration will begin from April 15, 2026. Eligible candidates can apply through the official website.	\N	\N	t	2025-12-30 17:09:44.009912	\N	2025-12-30 17:09:44.009912
2	16	key_update	Test Update - Admissions 2026	This is a test update for the 2026 admissions cycle. Applications are now open.	\N	\N	f	2026-01-05 13:04:35.367859	\N	2026-01-05 13:04:35.367859
\.


--
-- Data for Name: colleges; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.colleges (college_id, college_name, slug, short_name, established_year, college_type, ownership, country, state, city, pincode, address, latitude, longitude, website_url, phone, email, description, logo_url, is_featured, is_verified, status, avg_rating, total_reviews, view_count, created_at, updated_at, deleted_at, is_popular, cover_image_url, accreditation, affiliation, campus_size) FROM stdin;
1	Test University of Technology	test-university-of-technology	TUT	2000	University	Private	India	Karnataka	Bangalore	560001	123 Tech Road, Bangalore	\N	\N	https://www.testuniversity.edu	+91 9876543210	info@testuniversity.edu	A premier institution focused on technology and innovation. Offering undergraduate and graduate programs.	\N	t	t	inactive	0.00	0	0	2025-12-18 13:30:45.992065	2025-12-18 13:33:12.792807	2025-12-18 13:33:35.937221	f	\N	\N	\N	\N
2	Indian Institute of Technology Delhi	iit-delhi	IIT Delhi	1961	Institute	Government	India	Delhi	New Delhi	110016	Hauz Khas, New Delhi, Delhi 110016	\N	\N	https://home.iitd.ac.in	+91-11-26591999	info@admin.iitd.ac.in	IIT Delhi is one of the twenty three IITs created to be Centres of Excellence for training, research and development in science, engineering and technology in India.	https://upload.wikimedia.org/wikipedia/en/f/fd/Indian_Institute_of_Technology_Delhi_Logo.svg	t	t	active	4.50	250	4	2025-12-18 13:35:38.587865	2025-12-18 13:35:38.587865	\N	f	\N	\N	\N	\N
4	National Institute of Technology Karnataka	national-institute-of-technology-karnataka	NIT Surathkal	1961	Institute	Government	India	Karnataka	Surathkal	575025	\N	\N	\N	https://www.nitk.ac.in	+91 824 247 3000	info@nitk.ac.in	National Institute of Technology Karnataka is one of the premier engineering institutions in India, offering undergraduate and postgraduate programs in engineering, science, and management.	\N	f	f	inactive	0.00	0	0	2025-12-24 12:27:30.724258	2025-12-24 12:28:31.25776	2025-12-24 12:29:21.174298	f	\N	\N	\N	\N
5	Indian Institute of Management Ahmedabad	iim-ahmedabad	IIMA	\N	Institute	Autonomous	India	Gujarat	Ahmedabad	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	f	active	5.00	245	0	2026-01-01 17:49:37.363869	2026-01-01 17:49:37.363869	\N	f	\N	\N	\N	\N
6	Indian Institute of Technology Bombay	iit-bombay	IIT Bombay	\N	Institute	Autonomous	India	Maharashtra	Mumbai	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	f	active	5.00	312	0	2026-01-01 17:49:37.363869	2026-01-01 17:49:37.363869	\N	f	\N	\N	\N	\N
7	All India Institute of Medical Sciences Delhi	aiims-delhi	AIIMS Delhi	\N	Institute	Autonomous	India	Delhi	New Delhi	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	f	active	4.90	189	0	2026-01-01 17:49:37.363869	2026-01-01 17:49:37.363869	\N	f	\N	\N	\N	\N
8	National Law School of India University	nlsiu-bangalore	NLSIU	\N	University	Autonomous	India	Karnataka	Bangalore	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	f	active	4.90	156	0	2026-01-01 17:49:37.363869	2026-01-01 17:49:37.363869	\N	f	\N	\N	\N	\N
9	Vardhman Mahavir Medical College	vmmc-delhi	VMMC	\N	College	Government	India	Delhi	New Delhi	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	f	active	4.90	98	0	2026-01-01 17:49:37.363869	2026-01-01 17:49:37.363869	\N	f	\N	\N	\N	\N
10	Indian Institute of Management Calcutta	iim-calcutta	IIM Calcutta	\N	Institute	Autonomous	India	West Bengal	Kolkata	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	f	active	4.90	234	0	2026-01-01 17:49:37.363869	2026-01-01 17:49:37.363869	\N	f	\N	\N	\N	\N
11	Hindu College	hindu-college-delhi	Hindu College	\N	College	Government	India	Delhi	New Delhi	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	f	active	4.90	287	0	2026-01-01 17:49:37.363869	2026-01-01 17:49:37.363869	\N	f	\N	\N	\N	\N
12	Shri Ram College of Commerce	srcc-delhi	SRCC	\N	College	Government	India	Delhi	New Delhi	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	f	active	4.90	312	0	2026-01-01 17:49:37.363869	2026-01-01 17:49:37.363869	\N	f	\N	\N	\N	\N
13	Institute of Hotel Management Pusa	ihm-pusa-delhi	IHM Pusa	\N	Institute	Government	India	Delhi	New Delhi	\N	\N	\N	\N	\N	\N	\N	\N	\N	t	f	active	4.90	145	0	2026-01-01 17:49:37.363869	2026-01-01 17:49:37.363869	\N	f	\N	\N	\N	\N
14	Indian Institute of Science	indian-institute-of-science	IISc Bangalore	1909	Institute	Government	India	Karnataka	Bangalore	560012	\N	\N	\N	https://www.iisc.ac.in	\N	info@iisc.ac.in	The Indian Institute of Science (IISc) is a premier public research university for scientific and technological research and higher education. It is India's top-ranked university for research.	\N	t	f	active	0.00	0	0	2026-01-01 18:08:18.781154	2026-01-01 18:08:18.781154	\N	f	\N	\N	\N	\N
15	Pune Institute of Technology	pune-institute-of-technology	PIT Pune	\N	Institute	Private	India	Maharashtra	Pune	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	active	0.00	0	0	2026-01-01 19:20:16.736495	2026-01-01 19:20:16.736495	\N	f	\N	\N	\N	\N
16	Chennai Business School	chennai-business-school	CBS Chennai	\N	Institute	Private	India	Tamil Nadu	Chennai	\N	\N	\N	\N	\N	\N	\N	\N	\N	f	f	active	0.00	0	0	2026-01-01 19:29:40.701869	2026-01-01 19:29:40.701869	\N	f	\N	\N	\N	\N
\.


--
-- Data for Name: community_answers; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.community_answers (answer_id, question_id, user_id, answer_text, is_accepted, upvote_count, created_at) FROM stdin;
\.


--
-- Data for Name: community_questions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.community_questions (question_id, user_id, title, question_text, category, college_id, view_count, upvote_count, answer_count, status, created_at) FROM stdin;
\.


--
-- Data for Name: contact_queries; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.contact_queries (id, name, email, phone, subject, message, status, assigned_to, response, created_at, responded_at) FROM stdin;
\.


--
-- Data for Name: course_location_content; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.course_location_content (content_id, course_type, location_type, location_name, location_slug, page_title, full_content, author_id, meta_title, meta_description, banners, status, created_at, updated_at) FROM stdin;
1	btech	city	Mumbai	mumbai-colleges	B.Tech Colleges in Mumbai 2027		1			[]	draft	2026-01-05 15:41:27.523118	2026-01-05 15:41:27.523118
\.


--
-- Data for Name: course_page_content; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.course_page_content (content_id, course_type, page_title, full_content, author_id, meta_title, meta_description, status, created_at, updated_at, banners) FROM stdin;
4	b.tech	BTech Colleges in India 2026: Fees, Admissions, Placements	\N	1	\N	\N	draft	2026-01-05 15:40:23.336763	2026-01-05 15:40:23.336763	[]
1	btech	B.Tech Colleges in India 2028	<h1>Test Content</h1><p>This is a test paragraph. 😄</p>	1			published	2026-01-01 22:32:02.440137	2026-01-05 15:40:54.96319	[]
\.


--
-- Data for Name: course_types_master; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.course_types_master (course_type_id, name, slug, full_name, category, level, duration_years, display_order, status, created_at, updated_at) FROM stdin;
1	B.Tech	btech	Bachelor of Technology	Engineering	Undergraduate	4.0	1	active	2026-01-01 22:57:41.36265	2026-01-01 22:57:41.36265
2	M.Tech	mtech	Master of Technology	Engineering	Postgraduate	2.0	2	active	2026-01-01 22:57:41.36265	2026-01-01 22:57:41.36265
3	MBA	mba	Master of Business Administration	Management	Postgraduate	2.0	3	active	2026-01-01 22:57:41.36265	2026-01-01 22:57:41.36265
4	BBA	bba	Bachelor of Business Administration	Management	Undergraduate	3.0	4	active	2026-01-01 22:57:41.36265	2026-01-01 22:57:41.36265
5	MBBS	mbbs	Bachelor of Medicine, Bachelor of Surgery	Medical	Undergraduate	5.5	5	active	2026-01-01 22:57:41.36265	2026-01-01 22:57:41.36265
6	B.Com	bcom	Bachelor of Commerce	Commerce	Undergraduate	3.0	6	active	2026-01-01 22:57:41.36265	2026-01-01 22:57:41.36265
7	M.Com	mcom	Master of Commerce	Commerce	Postgraduate	2.0	7	active	2026-01-01 22:57:41.36265	2026-01-01 22:57:41.36265
8	BA	ba	Bachelor of Arts	Arts	Undergraduate	3.0	8	active	2026-01-01 22:57:41.36265	2026-01-01 22:57:41.36265
9	MA	ma	Master of Arts	Arts	Postgraduate	2.0	9	active	2026-01-01 22:57:41.36265	2026-01-01 22:57:41.36265
10	BSc	bsc	Bachelor of Science	Science	Undergraduate	3.0	10	active	2026-01-01 22:57:41.36265	2026-01-01 22:57:41.36265
11	MSc	msc	Master of Science	Science	Postgraduate	2.0	11	active	2026-01-01 22:57:41.36265	2026-01-01 22:57:41.36265
12	BCA	bca	Bachelor of Computer Applications	Computer Applications	Undergraduate	3.0	12	active	2026-01-01 22:57:41.36265	2026-01-01 22:57:41.36265
13	MCA	mca	Master of Computer Applications	Computer Applications	Postgraduate	2.0	13	active	2026-01-01 22:57:41.36265	2026-01-01 22:57:41.36265
14	LLB	llb	Bachelor of Laws	Law	Undergraduate	3.0	14	active	2026-01-01 22:57:41.36265	2026-01-01 22:57:41.36265
15	LLM	llm	Master of Laws	Law	Postgraduate	2.0	15	active	2026-01-01 22:57:41.36265	2026-01-01 22:57:41.36265
16	BA LLB	ballb	Bachelor of Arts, Bachelor of Laws	Law	Undergraduate	5.0	16	active	2026-01-01 22:57:41.36265	2026-01-01 22:57:41.36265
17	B.Pharm	bpharm	Bachelor of Pharmacy	Pharmacy	Undergraduate	4.0	17	active	2026-01-01 22:57:41.36265	2026-01-01 22:57:41.36265
18	M.Pharm	mpharm	Master of Pharmacy	Pharmacy	Postgraduate	2.0	18	active	2026-01-01 22:57:41.36265	2026-01-01 22:57:41.36265
19	B.Arch	barch	Bachelor of Architecture	Architecture	Undergraduate	5.0	19	active	2026-01-01 22:57:41.36265	2026-01-01 22:57:41.36265
20	B.Ed	bed	Bachelor of Education	Education	Undergraduate	2.0	20	active	2026-01-01 22:57:41.36265	2026-01-01 22:57:41.36265
21	PhD	phd	Doctor of Philosophy	Research	Doctoral	3.0	21	active	2026-01-01 22:57:41.36265	2026-01-01 22:57:41.36265
22	PGDM	pgdm	Post Graduate Diploma in Management	Management	Postgraduate	2.0	22	active	2026-01-01 22:57:41.36265	2026-01-01 22:57:41.36265
\.


--
-- Data for Name: courses; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.courses (course_id, college_id, course_name, short_name, degree_type, duration, stream, specialization, total_fees, fees_type, eligibility, seats_available, course_mode, description, status, is_featured, created_at, updated_at, deleted_at, application_start_date, application_end_date, brochure_url) FROM stdin;
1	2	Bachelor of Technology in Computer Science	B.Tech CSE	Bachelor	4 Years (8 Semesters)	Engineering	Computer Science	800000.00	Total	10+2 with 60% marks in Physics, Chemistry and Mathematics	100	Full-time	B.Tech in Computer Science is a 4-year undergraduate program focusing on computer science fundamentals, programming, algorithms, and software development.	active	f	2025-12-24 13:13:17.652434	2025-12-24 13:16:42.181458	2025-12-24 13:19:04.47761	\N	\N	\N
2	2	Bachelor of Technology in Computer Science and Engineering	B.Tech CSE	B.Tech	4 Years	Engineering	Computer Science	800000.00	Per Year	10+2 with 75% in PCM, JEE Advanced qualification required	\N	Full-time		active	f	2025-12-30 17:40:46.827947	2025-12-30 18:43:44.353949	\N	2025-06-01	2026-06-30	https://iitd.ac.in/brochures/btech-cse-2025.pdf
3	5	Master of Business Administration	MBA	MBA	2 Years	Management	\N	3535000.00	Total	\N	\N	Full-time	\N	active	f	2026-01-01 17:52:00.099086	2026-01-01 17:52:00.099086	\N	2025-07-07	2025-09-08	\N
4	6	Bachelor of Technology	B.Tech	B.Tech	4 Years	Engineering	\N	84500.00	Per Year	\N	\N	Full-time	\N	active	f	2026-01-01 17:52:00.099086	2026-01-01 17:52:00.099086	\N	2025-10-01	2025-11-05	\N
5	7	Bachelor of Medicine and Bachelor of Surgery	MBBS	MBBS	5.5 Years	Medical	\N	5111.00	Per Year	\N	\N	Full-time	\N	active	f	2026-01-01 17:52:00.099086	2026-01-01 17:52:00.099086	\N	2025-04-08	2025-05-07	\N
6	8	Bachelor of Arts and Bachelor of Laws	BA LLB	BA LLB	5 Years	Law	\N	2292600.00	Total	\N	\N	Full-time	\N	active	f	2026-01-01 17:52:00.099086	2026-01-01 17:52:00.099086	\N	2025-11-15	2026-03-23	\N
7	9	Bachelor of Medicine and Bachelor of Surgery	MBBS	MBBS	5.5 Years	Medical	\N	265000.00	Total	\N	\N	Full-time	\N	active	f	2026-01-01 17:52:00.099086	2026-01-01 17:52:00.099086	\N	2025-02-01	2025-05-15	\N
8	2	Bachelor of Technology	B.Tech	B.Tech	4 Years	Engineering	\N	862550.00	Total	\N	\N	Full-time	\N	active	f	2026-01-01 17:52:00.099086	2026-01-01 17:52:00.099086	\N	2025-10-01	2025-11-05	\N
9	10	Master of Business Administration	MBA	MBA	2 Years	Management	\N	1350000.00	Per Year	\N	\N	Full-time	\N	active	f	2026-01-01 17:52:00.099086	2026-01-01 17:52:00.099086	\N	2025-10-16	2025-11-26	\N
10	11	Bachelor of Arts	BA	BA	3 Years	Arts	\N	86010.00	Per Year	\N	\N	Full-time	\N	active	f	2026-01-01 17:52:00.099086	2026-01-01 17:52:00.099086	\N	2025-06-17	2025-08-10	\N
11	12	Bachelor of Commerce	B.Com	B.Com	3 Years	Commerce	\N	97260.00	Per Year	\N	\N	Full-time	\N	active	f	2026-01-01 17:52:00.099086	2026-01-01 17:52:00.099086	\N	2025-06-17	2025-08-10	\N
12	13	Bachelor of Science in Hospitality and Hotel Administration	BSc HHA	BSc	3 Years	Hospitality	\N	492515.00	Total	\N	\N	Full-time	\N	active	f	2026-01-01 17:52:00.099086	2026-01-01 17:52:00.099086	\N	2025-12-16	2026-03-15	\N
13	15	B.Tech Computer Science and Engineering	B.Tech CSE	B.Tech	4 Years	Engineering	Computer Science	600000.00	Per Year	\N	\N	Full-time	\N	active	f	2026-01-01 19:24:35.947316	2026-01-01 19:24:35.947316	\N	\N	\N	\N
14	16	Master of Business Administration	MBA	Master	2 Years	Management	\N	1500000.00	Per Year	\N	\N	Full-time	\N	active	f	2026-01-01 19:33:39.67554	2026-01-01 19:33:39.67554	\N	\N	\N	\N
15	2	Master of Technology in Artificial Intelligence	\N	M.Tech	2.0 Years	\N	\N	\N	Per Year	\N	\N	Full-time	\N	active	f	2026-01-05 12:09:34.897429	2026-01-05 12:09:34.897429	\N	\N	\N	\N
16	16	Bachelor of Business Administration	\N	BBA	\N	\N	\N	\N	Per Year	\N	\N	Full-time	\N	active	f	2026-01-05 12:11:28.669539	2026-01-05 12:11:28.669539	\N	\N	\N	\N
17	16	Bachelor of Computer Applications	BCA	BCA	3 Years	Computer Applications	\N	250000.00	Per Year	\N	60	Full-time	\N	active	f	2026-01-05 12:51:44.821022	2026-01-05 12:51:44.821022	2026-01-05 12:52:49.84929	\N	\N	\N
\.


--
-- Data for Name: degree_categories; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.degree_categories (category_id, name, display_order, status, created_at, slug, icon, description) FROM stdin;
1	Engineering	1	active	2026-01-01 23:18:42.011465	engineering	settings	\N
2	Management	2	active	2026-01-01 23:18:42.011465	management	chart	\N
3	Medical	3	active	2026-01-01 23:18:42.011465	medical	heart	\N
4	Commerce	4	active	2026-01-01 23:18:42.011465	commerce	briefcase	\N
5	Arts	5	active	2026-01-01 23:18:42.011465	arts	book	\N
6	Science	6	active	2026-01-01 23:18:42.011465	science	flask	\N
7	Computer Applications	7	active	2026-01-01 23:18:42.011465	computer-applications	code	\N
8	Law	8	active	2026-01-01 23:18:42.011465	law	shield	\N
9	Pharmacy	9	active	2026-01-01 23:18:42.011465	pharmacy	pill	\N
10	Architecture	10	active	2026-01-01 23:18:42.011465	architecture	building	\N
11	Education	11	active	2026-01-01 23:18:42.011465	education	graduation	\N
12	Research	12	active	2026-01-01 23:18:42.011465	research	folder	\N
\.


--
-- Data for Name: education_loans; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.education_loans (loan_id, loan_provider, provider_type, country, max_loan_amount, currency, interest_rate_min, interest_rate_max, is_active, created_at) FROM stdin;
\.


--
-- Data for Name: exam_cutoffs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.exam_cutoffs (cutoff_id, exam_id, college_id, course_id, academic_year, category, cutoff_type, cutoff_value, closing_rank, created_at, round, opening_rank, specialization) FROM stdin;
1	2	2	\N	2024	General	Rank	\N	350	2025-12-30 17:44:34.699055	1	1	\N
2	4	5	3	2025-26	General	Percentile	99.00	\N	2026-01-01 17:56:50.390028	1	\N	\N
3	2	6	4	2025-26	General	Rank	\N	66	2026-01-01 17:56:50.390028	1	\N	\N
4	15	7	5	2025-26	General	Rank	\N	1729	2026-01-01 17:56:50.390028	1	\N	\N
5	6	8	6	2025-26	General	Rank	\N	112	2026-01-01 17:56:50.390028	1	\N	\N
6	3	9	7	2025-26	General	Rank	\N	132	2026-01-01 17:56:50.390028	1	\N	\N
7	2	2	8	2025-26	General	Rank	\N	355	2026-01-01 17:56:50.390028	1	\N	\N
8	4	10	9	2025-26	General	Percentile	99.00	\N	2026-01-01 17:56:50.390028	1	\N	\N
9	13	11	10	2025-26	General	Score	448.00	\N	2026-01-01 17:56:50.390028	1	\N	\N
10	13	12	11	2025-26	General	Score	910.00	\N	2026-01-01 17:56:50.390028	1	\N	\N
11	14	13	12	2025-26	General	Rank	\N	180	2026-01-01 17:56:50.390028	1	\N	\N
12	4	16	\N	2025	General	Rank	\N	5000	2026-01-05 12:58:02.010247	1	1000	\N
\.


--
-- Data for Name: exam_schedules; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.exam_schedules (schedule_id, exam_id, academic_year, application_start, application_end, exam_start_date, exam_end_date, result_date, created_at) FROM stdin;
\.


--
-- Data for Name: exams; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.exams (exam_id, exam_name, slug, short_name, exam_category, exam_level, exam_mode, conducting_body, official_website, description, is_active, created_at, updated_at, deleted_at) FROM stdin;
1	Joint Entrance Examination Main	jee-main	JEE Main	Engineering	National	Online	National Testing Agency (NTA)	https://jeemain.nta.nic.in/	JEE Main is a national level entrance exam for admission to undergraduate engineering programs at NITs, IIITs, and other Centrally Funded Technical Institutions (CFTIs). It is also the qualifying exam for JEE Advanced.	t	2025-12-23 14:43:17.531812	2025-12-23 18:36:13.913963	\N
2	Joint Entrance Examination Advanced	jee-advanced	JEE Advanced	Engineering	National	Online	IIT (Rotating)	https://jeeadv.ac.in/	JEE Advanced is the entrance examination for admission to the prestigious Indian Institutes of Technology (IITs). Only top JEE Main qualifiers are eligible to appear for this exam.	t	2025-12-23 14:43:17.531812	2025-12-23 18:36:13.913963	\N
3	National Eligibility cum Entrance Test (UG)	neet-ug	NEET UG	Medical	National	Offline	National Testing Agency (NTA)	https://neet.nta.nic.in/	NEET UG is the single entrance examination for admission to MBBS, BDS, AYUSH and other medical courses in India. It is mandatory for all medical aspirants to qualify NEET to pursue undergraduate medical education.	t	2025-12-23 14:43:17.531812	2025-12-23 18:36:13.913963	\N
4	Common Admission Test	cat	CAT	MBA	National	Online	Indian Institutes of Management (IIMs)	https://iimcat.ac.in/	CAT is a computer-based test for admission into top MBA and PGDM programs offered by the IIMs and other prestigious business schools across India. The exam tests candidates on quantitative ability, verbal ability, data interpretation, and logical reasoning.	t	2025-12-23 14:43:17.531812	2025-12-23 18:36:13.913963	\N
5	Graduate Aptitude Test in Engineering	gate	GATE	Engineering	National	Online	IIT (Rotating) and IISc	https://gate.iitm.ac.in/	GATE is an examination that primarily tests comprehensive understanding of various undergraduate subjects in engineering and science. GATE scores are used for admissions to ME/MTech/PhD programs and for PSU recruitments.	t	2025-12-23 14:43:17.531812	2025-12-23 18:36:13.913963	\N
6	Common Law Admission Test	clat	CLAT	Law	National	Offline	Consortium of National Law Universities	https://consortiumofnlus.ac.in/	CLAT is a centralized national level entrance exam for admissions to undergraduate and postgraduate law programs offered by 22 National Law Universities in India.	t	2025-12-23 14:43:17.531812	2025-12-23 18:36:13.913963	\N
7	National Eligibility Test	ugc-net	UGC NET	Research/Teaching	National	Online	National Testing Agency (NTA)	https://ugcnet.nta.nic.in/	UGC NET is conducted to determine the eligibility for the award of Junior Research Fellowship (JRF) and for appointment as Assistant Professor in Indian universities and colleges.	t	2025-12-23 14:43:17.531812	2025-12-23 18:36:13.913963	\N
8	Birla Institute of Technology and Science Admission Test	bitsat	BITSAT	Engineering	University	Online	BITS Pilani	https://www.bitsadmission.com/	BITSAT is an online test conducted by BITS Pilani for admissions to its integrated first-degree programs at Pilani, Goa, and Hyderabad campuses.	t	2025-12-23 14:43:17.531812	2025-12-23 18:36:13.913963	\N
9	Symbiosis National Aptitude Test	snap	SNAP	MBA	University	Online	Symbiosis International University	https://snap.org.in/	SNAP is a national level management aptitude test conducted by Symbiosis International University for admission to MBA and other management programs across its constituent institutes.	t	2025-12-23 14:43:17.531812	2025-12-23 18:36:13.913963	\N
10	Maharashtra Common Entrance Test	mht-cet	MHT CET	Engineering/Pharmacy	State	Online	State Common Entrance Test Cell, Maharashtra	https://cetcell.mahacet.org/	MHT CET is a state-level entrance exam for admission to engineering, pharmacy, and other technical courses in colleges across Maharashtra.	t	2025-12-23 14:43:17.531812	2025-12-23 18:36:13.913963	\N
11	All India Institute of Medical Sciences	aiims	AIIMS	Medical	National	Offline	All India Institute of Medical Sciences	https://www.aiimsexams.ac.in/	AIIMS examination is conducted for admission to MBBS courses at AIIMS institutions across India. It is one of the most competitive medical entrance exams in the country.	t	2025-12-23 14:43:17.531812	2025-12-23 18:36:13.913963	\N
12	Xavier Aptitude Test	xat	XAT	MBA	National	Online	XLRI Jamshedpur	https://xatonline.in/	XAT is a national level MBA entrance exam conducted by XLRI Jamshedpur. The scores are accepted by over 160 top B-schools in India for admission to their MBA/PGDM programs.	t	2025-12-23 14:43:17.531812	2025-12-23 18:36:13.913963	\N
13	Common University Entrance Test	cuet	CUET	Undergraduate	National	\N	National Testing Agency	\N	Central university admissions test for UG programs	t	2026-01-01 17:48:59.418975	2026-01-01 17:48:59.418975	\N
14	National Council for Hotel Management and Catering Technology Joint Entrance Exam	nchmct-jee	NCHMCT-JEE	Hotel Management	National	\N	NCHMCT	\N	Entrance exam for hotel management courses	t	2026-01-01 17:48:59.418975	2026-01-01 17:48:59.418975	\N
15	Institute of National Importance Combined Entrance Test	ini-cet	INI-CET	Medical PG	National	\N	AIIMS	\N	PG medical entrance for INI institutions	t	2026-01-01 17:48:59.418975	2026-01-01 17:48:59.418975	\N
16	National Aptitude Test in Architecture	nata	NATA	Architecture	National	Both	Council of Architecture	https://www.nata.in	NATA is the national-level entrance exam for admission to 5-year B.Arch programs in India.	t	2026-01-01 18:09:59.701611	2026-01-01 18:09:59.701611	\N
17	Graduate Management Admission Test	graduate-management-admission-test	GMAT	MBA	International	Online	GMAC	https://www.mba.com/exams/gmat	GMAT is a computer-adaptive test for MBA admissions.	t	2026-01-01 18:38:41.027225	2026-01-01 18:38:41.027225	\N
\.


--
-- Data for Name: faculty_members; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.faculty_members (id, college_id, name, designation, department, qualification, specialization, experience_years, profile_image_url, email, profile_url, status, display_order, created_at, updated_at, phone) FROM stdin;
1	2	Dr. Rajesh Kumar	Professor	Computer Science & Engineering	Ph.D. (IIT Bombay), M.Tech, B.Tech	Machine Learning, Artificial Intelligence	20	\N	rajesh@iitd.ac.in	\N	active	0	2025-12-30 18:03:29.158528	2025-12-30 18:41:36.513058	+91 11 2659 1999
2	2	Dr. K. Rajaraman	Head of Department	Humanities & Social Sciences	\N	\N	\N	\N	drkrajaraman99@gmail.com	\N	active	0	2025-12-30 18:56:44.11435	2025-12-30 18:56:44.11435	0414-4243777
3	16	Dr. Test Professor	Professor	Computer Science & Engineering	Ph.D. Computer Science	Artificial Intelligence	15	\N	\N	\N	active	0	2026-01-05 13:02:43.723383	2026-01-05 13:02:43.723383	\N
\.


--
-- Data for Name: faqs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.faqs (id, category, question, answer, display_order, is_active, created_at) FROM stdin;
1	Admissions	What are the eligibility criteria for admission?	Students must have completed 12th grade with a minimum of 60% marks in relevant subjects. Entrance exam scores may also be required depending on the program.	0	t	2025-12-18 16:07:25.548346
3	Admissions	How do I apply for undergraduate programs?	<p>To apply for undergraduate programs, you need to:</p><ul><li>Visit the official admission portal</li><li>Register with your email and phone number</li><li>Fill out the application form with all required details</li><li>Upload necessary documents (10th, 12th mark sheets, ID proof)</li><li>Pay the application fee</li><li>Submit the form and take a printout for your records</li></ul>	1	t	2025-12-23 13:38:56.092549
4	Admissions	What are the eligibility criteria for engineering courses?	<p>The general eligibility criteria for engineering courses are:</p><ul><li>Must have passed 12th standard with Physics, Chemistry, and Mathematics</li><li>Minimum 60% aggregate marks (50% for reserved categories)</li><li>Valid entrance exam score (JEE Main/Advanced, state-level exams)</li><li>Age limit: Maximum 25 years as on December 31st of admission year</li></ul>	2	t	2025-12-23 13:38:56.092549
5	Fees	What is the fee structure for MBA programs?	<p>The fee structure for MBA programs varies by institution:</p><p><strong>Government Colleges:</strong> ₹50,000 - ₹3,00,000 per year</p><p><strong>Private Colleges:</strong> ₹2,00,000 - ₹20,00,000 per year</p><p>Top IIMs can charge between ₹20-25 lakhs for the entire program. Additional costs include hostel fees, examination fees, and other miscellaneous charges.</p>	3	t	2025-12-23 13:38:56.092549
6	Placements	What is the average placement package?	<p>Average placement packages vary significantly based on the institution and course:</p><ul><li><strong>IITs:</strong> ₹15-20 LPA average, highest up to ₹1 crore+</li><li><strong>NITs:</strong> ₹8-12 LPA average</li><li><strong>IIMs:</strong> ₹20-28 LPA average for MBA</li><li><strong>Other Engineering Colleges:</strong> ₹3-6 LPA average</li></ul><p>Top companies visiting include Microsoft, Google, Amazon, Deloitte, and many more.</p>	4	t	2025-12-23 13:38:56.092549
7	Scholarships	Are scholarships available for students?	<p>Yes, various scholarships are available:</p><p><strong>Merit-based Scholarships:</strong></p><ul><li>National Scholarship Portal</li><li>Institute-specific merit scholarships</li><li>Private organization scholarships</li></ul><p><strong>Need-based Scholarships:</strong></p><ul><li>Financial aid based on family income</li><li>SC/ST/OBC scholarships</li><li>Minority scholarships</li></ul><p>Students can apply through the National Scholarship Portal or directly through their institutions.</p>	5	t	2025-12-23 13:38:56.092549
8	Exams	What are the important entrance exams for engineering?	<p>Important entrance exams for engineering include:</p><ul><li><strong>JEE Main:</strong> For admission to NITs, IIITs, and other engineering colleges</li><li><strong>JEE Advanced:</strong> For admission to IITs</li><li><strong>State-level exams:</strong> For state government colleges</li><li><strong>BITSAT:</strong> For BITS Pilani</li><li><strong>VITEEE:</strong> For VIT</li></ul>	6	t	2025-12-23 13:38:56.092549
9	Hostel	Do colleges provide hostel facilities?	<p>Most colleges provide hostel facilities for students. Hostel amenities typically include:</p><ul><li>Furnished rooms (single/double/triple occupancy)</li><li>Mess facilities with nutritious food</li><li>24x7 security</li><li>Wi-Fi connectivity</li><li>Common room and recreational facilities</li><li>Laundry services</li></ul><p>Hostel fees vary from ₹20,000 to ₹1,50,000 per year depending on the institution.</p>	7	t	2025-12-23 13:38:56.092549
\.


--
-- Data for Name: hostels; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.hostels (id, college_id, hostel_type, name, total_capacity, room_types, fee_per_semester, mess_fee_per_semester, amenities, description, status, created_at, updated_at, photos) FROM stdin;
1	2	boys	Kumaon House	500	\N	25000.00	18000.00	["WiFi", "Mess", "24/7 Security"]	\N	active	2025-12-30 17:59:42.962078	2025-12-30 17:59:42.962078	[]
2	16	boys	Test Boys Hostel	200	\N	50000.00	\N	["WiFi", "AC"]	\N	active	2026-01-05 13:04:01.939788	2026-01-05 13:04:01.939788	[]
\.


--
-- Data for Name: institute_accounts; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.institute_accounts (id, institution_id, subscription_plan, contract_start, contract_end, status, account_manager_id, features, max_users, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: institute_users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.institute_users (id, institution_id, user_id, role, permissions, is_active, created_at) FROM stdin;
\.


--
-- Data for Name: job_postings; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.job_postings (id, title, department, location, job_type, experience_required, description, requirements, responsibilities, salary_range, is_active, posted_date, application_deadline, apply_url, created_at) FROM stdin;
\.


--
-- Data for Name: news_articles; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.news_articles (article_id, title, slug, content, category, author_id, is_featured, status, view_count, published_at, created_at) FROM stdin;
2	New Campus Facilities Opening Next Month	new-campus-facilities-opening-next-month	We are excited to announce the opening of our state-of-the-art campus facilities next month. The new building includes modern laboratories, collaborative study spaces, and a cutting-edge library with digital resources.	Campus News	\N	f	draft	0	\N	2025-12-18 16:18:24.619565
3	JEE Advanced 2024 Results Announced	jee-advanced-2024-results-announced	<h2>JEE Advanced 2024 Results Declared</h2><p>The Indian Institute of Technology (IIT) Madras has announced the results of JEE Advanced 2024. The examination was conducted on May 26, 2024, across various centers in India.</p><h3>Key Highlights</h3><ul><li>Total candidates appeared: 1,80,000+</li><li>Qualified candidates: 48,000+</li><li>Top score: 355/360</li><li>Results available on official website: jeeadv.ac.in</li></ul><p>Candidates can check their results using their registration number and date of birth. The counselling process for seat allocation will begin from June 10, 2024.</p>	Entrance Exams	\N	t	published	0	2025-12-23 13:38:56.093711	2025-12-23 13:38:56.093711
4	NEET UG 2024: Important Dates and Updates	neet-ug-2024-important-dates-updates	<h2>NEET UG 2024 Schedule Released</h2><p>The National Testing Agency (NTA) has released the revised schedule for NEET UG 2024 examination.</p><h3>Important Dates</h3><ul><li>Application Start Date: March 15, 2024</li><li>Last Date to Apply: April 15, 2024</li><li>Exam Date: May 5, 2024</li><li>Result Declaration: June 20, 2024</li></ul><h3>Exam Pattern</h3><p>The exam will consist of 200 questions covering Physics, Chemistry, and Biology. Duration: 3 hours 20 minutes.</p>	Entrance Exams	\N	t	published	0	2025-12-22 13:38:56.093711	2025-12-23 13:38:56.093711
5	Top 10 Engineering Colleges in India 2024	top-10-engineering-colleges-india-2024	<h2>Best Engineering Colleges in India 2024</h2><p>Here is the list of top 10 engineering colleges based on various parameters including placements, faculty, infrastructure, and research output.</p><h3>Top 10 Colleges</h3><ol><li>IIT Bombay</li><li>IIT Delhi</li><li>IIT Madras</li><li>IIT Kanpur</li><li>IIT Kharagpur</li><li>IIT Roorkee</li><li>NIT Trichy</li><li>BITS Pilani</li><li>Delhi Technological University</li><li>VIT Vellore</li></ol><p>These institutions are known for their excellent placement records with average packages ranging from 10-20 LPA.</p>	Rankings	\N	f	published	0	2025-12-21 13:38:56.093711	2025-12-23 13:38:56.093711
6	MBA Entrance Exams 2024: Complete Guide	mba-entrance-exams-2024-complete-guide	<h2>MBA Entrance Exams 2024</h2><p>Aspiring MBA students need to appear for various entrance exams to get admission to top B-schools.</p><h3>Major MBA Exams</h3><ul><li><strong>CAT (Common Admission Test):</strong> Conducted by IIMs</li><li><strong>XAT (Xavier Aptitude Test):</strong> For XLRI and associate institutions</li><li><strong>SNAP:</strong> For Symbiosis Institute of Business Management</li><li><strong>GMAT:</strong> For international MBA programs</li></ul><h3>Preparation Tips</h3><p>Start preparation at least 6 months before the exam. Focus on quantitative ability, verbal ability, logical reasoning, and data interpretation.</p>	MBA	\N	f	published	0	2025-12-20 13:38:56.093711	2025-12-23 13:38:56.093711
\.


--
-- Data for Name: newsletter_subscribers; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.newsletter_subscribers (id, email, phone, name, subscribed_at, is_active, unsubscribed_at, source) FROM stdin;
\.


--
-- Data for Name: notification_preferences; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.notification_preferences (id, user_id, email_notifications, exam_alerts, admission_alerts, newsletter, sms_notifications, updated_at) FROM stdin;
\.


--
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.notifications (notification_id, user_id, notification_type, title, message, link_url, status, sent_at, read_at, created_at) FROM stdin;
\.


--
-- Data for Name: password_resets; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.password_resets (id, user_id, otp_code, expires_at, used, created_at) FROM stdin;
\.


--
-- Data for Name: payments; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.payments (payment_id, user_id, order_id, payment_gateway, amount, currency, payment_status, transaction_date, created_at) FROM stdin;
\.


--
-- Data for Name: placement_recruiters; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.placement_recruiters (id, placement_id, company_name, company_logo_url, sector, offers_count, package_offered, is_top_recruiter, created_at) FROM stdin;
1	1	Google	https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png	IT/Software	25	4500000.00	f	2025-12-30 18:45:09.006201
2	1	TCS	https://upload.wikimedia.org/wikipedia/commons/b/b1/Tata_Consultancy_Services_Logo.svg	IT/Software	35	1200000.00	f	2025-12-30 18:58:49.83833
3	8	TCS	\N	IT/Software	15	700000.00	f	2026-01-05 12:56:14.93759
\.


--
-- Data for Name: placements; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.placements (placement_id, college_id, course_id, academic_year, total_students, students_placed, placement_percentage, highest_package, average_package, median_package, currency, created_at, updated_at, deleted_at, companies_participated, ppos_offered, ppos_accepted, international_offers, highest_international_package, top_sectors) FROM stdin;
1	2	\N	2024-25	1200	1140	95.00	4500000.00	1800000.00	1500000.00	INR	2025-12-23 17:01:46.722994	2025-12-23 18:37:18.345897	\N	\N	\N	\N	\N	\N	\N
2	2	\N	2023-24	1180	1121	95.00	4200000.00	1750000.00	1450000.00	INR	2025-12-23 17:01:46.722994	2025-12-23 18:37:18.345897	\N	\N	\N	\N	\N	\N	\N
3	2	\N	2022-23	1150	1081	94.00	3800000.00	1650000.00	1400000.00	INR	2025-12-23 17:01:46.722994	2025-12-23 18:37:18.345897	\N	\N	\N	\N	\N	\N	\N
4	1	\N	2024-25	800	680	85.00	1800000.00	650000.00	550000.00	INR	2025-12-23 17:01:46.722994	2025-12-23 18:37:18.345897	\N	\N	\N	\N	\N	\N	\N
5	1	\N	2023-24	750	623	83.00	1600000.00	600000.00	500000.00	INR	2025-12-23 17:01:46.722994	2025-12-23 18:37:18.345897	\N	\N	\N	\N	\N	\N	\N
7	1	\N	2025-26	500	425	85.00	2500000.00	800000.00	750000.00	INR	2025-12-23 19:49:05.140191	2025-12-23 19:49:05.140191	2025-12-23 19:50:22.907362	\N	\N	\N	\N	\N	\N
6	1	\N	2022-23	720	576	80.00	1400000.00	550000.00	480000.00	INR	2025-12-23 17:01:46.722994	2025-12-23 18:37:18.345897	2025-12-24 16:41:41.287695	\N	\N	\N	\N	\N	\N
8	16	\N	2026-27	100	85	85.00	2500000.00	800000.00	\N	INR	2026-01-05 12:55:16.138018	2026-01-05 12:55:16.138018	\N	\N	\N	\N	\N	\N	\N
\.


--
-- Data for Name: questions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.questions (question_id, test_id, question_text, question_type, marks, option_a, option_b, option_c, option_d, correct_answer, explanation, created_at) FROM stdin;
\.


--
-- Data for Name: quick_tabs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.quick_tabs (id, degree_type, display_name, slug, display_order, is_active, created_at, updated_at) FROM stdin;
1	B.Tech	B.Tech	/btech-colleges	1	t	2026-01-01 19:48:19.497472	2026-01-01 19:48:19.497472
2	MBA	MBA	/mba-colleges	2	t	2026-01-01 19:48:19.497472	2026-01-01 19:48:19.497472
3	MBBS	MBBS	/mbbs-colleges	3	t	2026-01-01 19:48:19.497472	2026-01-01 19:48:19.497472
4	B.Com	B.Com	/bcom-colleges	4	t	2026-01-01 19:48:19.497472	2026-01-01 19:48:19.497472
7	BA	BA	/ba-colleges	7	t	2026-01-01 19:48:19.497472	2026-01-01 19:48:19.497472
8	BA LLB	BA LLB	/ba-llb-colleges	8	f	2026-01-01 19:48:19.497472	2026-01-01 19:53:35.954532
9	M.Tech	M.Tech	/mtech-colleges	5	t	2026-01-02 16:22:52.628353	2026-01-02 16:22:52.628353
10	BBA	BBA	/bba-colleges	9	t	2026-01-02 16:22:52.628353	2026-01-02 16:22:52.628353
11	BCA	BCA	/bca-colleges	10	t	2026-01-02 16:22:52.628353	2026-01-02 16:22:52.628353
12	B.Sc Nursing	B.Sc Nursing	/bsc-nursing-colleges	11	t	2026-01-02 16:22:52.628353	2026-01-02 16:22:52.628353
13	LLB	LLB	/llb-colleges	12	t	2026-01-02 16:22:52.628353	2026-01-02 16:22:52.628353
6	B.Sc	B.Sc	/bsc-colleges	6	t	2026-01-01 19:48:19.497472	2026-01-01 19:48:19.497472
5	Master	Master	/master-colleges	5	f	2026-01-01 19:48:19.497472	2026-01-01 19:48:19.497472
\.


--
-- Data for Name: ranking_agencies; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.ranking_agencies (agency_id, agency_name, agency_code, country, website_url, is_active, created_at) FROM stdin;
1	National Institutional Ranking Framework	NIRF	India	\N	t	2025-12-12 13:12:46.552074
2	QS World University Rankings	QS	United Kingdom	\N	t	2025-12-12 13:12:46.552074
3	Times Higher Education	THE	United Kingdom	\N	t	2025-12-12 13:12:46.552074
4	India Today	INDIATODAY	India	\N	t	2025-12-12 13:12:46.552074
5	Outlook	OUTLOOK	India	\N	t	2025-12-12 13:12:46.552074
\.


--
-- Data for Name: reviews; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.reviews (review_id, college_id, user_id, overall_rating, academic_rating, infrastructure_rating, faculty_rating, placement_rating, review_title, review_text, pros, cons, is_verified, status, helpful_count, created_at, updated_at, title, admin_reply, replied_at, replied_by, deleted_at) FROM stdin;
1	2	2	4.5	4.0	4.5	4.5	5.0	Excellent Institute for Engineering	IIT Delhi is one of the premier engineering institutes in India. The academic environment is excellent with highly qualified faculty and great placement opportunities.	World-class faculty, Great placements, Excellent research facilities, Strong alumni network	High competition, Stressful environment at times	f	approved	0	2025-12-24 13:54:05.944072	2025-12-24 13:57:21.54769	\N	\N	\N	\N	\N
2	2	2	3.0	3.5	2.5	3.0	3.5	Average Experience	The college has good faculty but infrastructure needs improvement. Placements are decent but not exceptional.	Good faculty, Decent placements	Poor infrastructure, Limited facilities	f	rejected	0	2025-12-24 14:03:31.372793	2025-12-24 14:03:50.470849	\N	Thank you for your honest feedback. We acknowledge your concerns about infrastructure and are working on improvements.	2025-12-24 14:09:50.462204	2	2025-12-24 14:12:19.19358
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.roles (id, name, description) FROM stdin;
1	super_admin	Full system access
2	admin	Administrative access
3	content_editor	Content management access
4	counsellor	Lead and counselling access
5	institute_admin	Institution management access
6	student	Student user
7	parent	Parent user
\.


--
-- Data for Name: saved_items; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.saved_items (saved_id, user_id, item_type, item_id, notes, created_at) FROM stdin;
\.


--
-- Data for Name: scholarships; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.scholarships (scholarship_id, scholarship_name, slug, provider_name, scholarship_type, country, scholarship_amount, currency, eligibility_criteria, application_deadline, is_active, created_at, updated_at, deleted_at) FROM stdin;
1	Prime Minister's Scholarship Scheme for Central Armed Police Forces	pm-scholarship-capf	Ministry of Home Affairs	Government	India	36000.00	INR	For wards/widows of personnel of Central Armed Police Forces (CAPFs) and Assam Rifles. Students must have secured at least 60% marks in 12th board examination. Family income should not exceed Rs. 6 lakh per annum.	2025-10-31	t	2025-12-23 16:27:10.2802	2025-12-23 18:37:18.345897	\N
2	National Scholarship Portal - Post Matric Scholarship for SC Students	nsp-post-matric-sc	Ministry of Social Justice and Empowerment	Government	India	10000.00	INR	For SC students pursuing post-matriculation studies. Parental income should not exceed Rs. 2.5 lakh per annum. Available for various courses including professional, technical, and degree courses.	2025-11-15	t	2025-12-23 16:27:10.2802	2025-12-23 18:37:18.345897	\N
3	AICTE Pragati Scholarship for Girls	aicte-pragati-scholarship	All India Council for Technical Education	Women	India	50000.00	INR	For girl students pursuing technical degree/diploma courses. Family income should be less than Rs. 8 lakh per annum. Scholarship is available for first year students only. Merit-cum-means based.	2025-09-30	t	2025-12-23 16:27:10.2802	2025-12-23 18:37:18.345897	\N
4	Tata Scholarship for Undergraduate Students	tata-undergraduate-scholarship	Tata Education and Development Trust	Private	India	200000.00	INR	For academically bright students from economically weaker sections. Students must have admission in premier institutions. Family income should not exceed Rs. 4 lakh per annum. Based on merit and financial need.	2025-08-31	t	2025-12-23 16:27:10.2802	2025-12-23 18:37:18.345897	\N
5	Reliance Foundation Undergraduate Scholarship	reliance-foundation-ug-scholarship	Reliance Foundation	Private	India	200000.00	INR	For undergraduate students from economically disadvantaged backgrounds. Must have scored above 60% in class 12. Family income less than Rs. 6 lakh per annum. Available for all streams including engineering, medical, and arts.	2025-07-31	t	2025-12-23 16:27:10.2802	2025-12-23 18:37:18.345897	\N
6	British Chevening Scholarships	chevening-scholarship-uk	UK Foreign, Commonwealth & Development Office	Government	UK	25000.00	GBP	For outstanding emerging leaders worldwide to pursue one-year master's degree in the UK. Must have undergraduate degree, minimum 2 years work experience, and meet English language requirement. Fully funded including tuition, stipend, and airfare.	2025-11-01	t	2025-12-23 16:27:10.2802	2025-12-23 18:37:18.345897	\N
7	Fulbright-Nehru Master's Fellowships	fulbright-nehru-masters	United States-India Educational Foundation	Government	USA	45000.00	USD	For outstanding Indian students to pursue master's degree in the USA. Must have completed bachelor's degree with excellent academic record. Covers tuition, living expenses, health insurance, and airfare. Age limit: 30 years.	2025-05-15	t	2025-12-23 16:27:10.2802	2025-12-23 18:37:18.345897	\N
8	Australia Awards Scholarship	australia-awards-scholarship	Australian Department of Foreign Affairs and Trade	Government	Australia	50000.00	AUD	For students from developing countries including India. For master's and PhD programs at Australian universities. Covers full tuition, return air travel, establishment allowance, and contribution to living expenses. Must demonstrate leadership qualities.	2025-04-30	t	2025-12-23 16:27:10.2802	2025-12-23 18:37:18.345897	\N
9	INSPIRE Scholarship for Higher Education	inspire-scholarship	Department of Science and Technology	Government	India	80000.00	INR	For students pursuing B.Sc./B.Sc.(Hons.)/M.Sc. in Natural and Basic Sciences. Must have secured at least 60% marks in class 12. Age should be 17-22 years. Merit-based scholarship to encourage science education.	2025-07-31	t	2025-12-23 16:27:10.2802	2025-12-23 18:37:18.345897	\N
10	Central Sector Scheme of National Merit Scholarship	central-sector-merit-scholarship	Department of Higher Education	Merit-Based	India	12000.00	INR	For meritorious students of economically weaker sections. Must be within top 20% of successful candidates of class 12 board. Family income should not exceed Rs. 6 lakh per annum. Available for undergraduate and postgraduate studies.	2025-10-30	t	2025-12-23 16:27:10.2802	2025-12-23 18:37:18.345897	\N
11	Sitaram Jindal Foundation Scholarship	sitaram-jindal-scholarship	Sitaram Jindal Foundation	Private	India	50000.00	INR	For meritorious students pursuing professional courses like Engineering, Medicine, MBA, etc. Must have admission in recognized institution. Selection based on academic merit and financial need. Renewable annually based on performance.	2025-06-30	t	2025-12-23 16:27:10.2802	2025-12-23 18:37:18.345897	\N
12	Sports Scholarship Scheme by Ministry of Youth Affairs	sports-scholarship-scheme	Ministry of Youth Affairs and Sports	Sports	India	75000.00	INR	For talented sportspersons pursuing higher education. Must have represented state/nation in recognized sports events. Covers tuition fees and maintenance allowance. Aimed at promoting sports while continuing education.	2025-08-15	t	2025-12-23 16:27:10.2802	2025-12-23 18:37:18.345897	\N
13	National Merit Scholarship	national-merit-scholarship	Ministry of Education	Merit-Based	India	75000.00	INR	Students with 85% or above in their previous examination. Annual family income should be below 8 lakhs. Must be pursuing undergraduate or postgraduate studies.	\N	t	2025-12-23 19:23:27.893487	2025-12-23 19:28:49.552648	2025-12-23 19:29:56.471369
\.


--
-- Data for Name: search_logs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.search_logs (search_id, user_id, search_query, search_type, results_count, created_at) FROM stdin;
\.


--
-- Data for Name: site_notifications; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.site_notifications (id, title, message, type, priority, link_url, is_active, valid_from, valid_to, created_at) FROM stdin;
\.


--
-- Data for Name: system_settings; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.system_settings (id, setting_key, setting_value, setting_type, category, description, is_public, created_at, updated_at) FROM stdin;
1	site_name	CollegeDunia	text	general	Website name	t	2025-12-18 16:40:12.962434	2025-12-18 16:40:12.962434
2	site_tagline	Find Your Perfect College	text	general	Website tagline	t	2025-12-18 16:40:12.962434	2025-12-18 16:40:12.962434
3	site_description	Your trusted guide to finding the best colleges and courses	textarea	general	Site description for SEO	t	2025-12-18 16:40:12.962434	2025-12-18 16:40:12.962434
4	contact_email	contact@collegedunia.com	email	contact	Primary contact email	t	2025-12-18 16:40:12.962434	2025-12-18 16:40:12.962434
6	contact_address	123 Education Street, New Delhi, India	textarea	contact	Physical address	t	2025-12-18 16:40:12.962434	2025-12-18 16:40:12.962434
7	social_facebook		url	social	Facebook page URL	t	2025-12-18 16:40:12.962434	2025-12-18 16:40:12.962434
8	social_twitter		url	social	Twitter profile URL	t	2025-12-18 16:40:12.962434	2025-12-18 16:40:12.962434
9	social_instagram		url	social	Instagram profile URL	t	2025-12-18 16:40:12.962434	2025-12-18 16:40:12.962434
10	social_linkedin		url	social	LinkedIn page URL	t	2025-12-18 16:40:12.962434	2025-12-18 16:40:12.962434
11	seo_meta_title	CollegeDunia - Find Your Perfect College	text	seo	Default meta title	t	2025-12-18 16:40:12.962434	2025-12-18 16:40:12.962434
12	seo_meta_description	Discover the best colleges and courses across India	textarea	seo	Default meta description	t	2025-12-18 16:40:12.962434	2025-12-18 16:40:12.962434
13	seo_meta_keywords	colleges, education, courses, admission	text	seo	Default meta keywords	t	2025-12-18 16:40:12.962434	2025-12-18 16:40:12.962434
14	email_notifications	true	boolean	notifications	Enable email notifications	f	2025-12-18 16:40:12.962434	2025-12-18 16:40:12.962434
15	maintenance_mode	false	boolean	system	Enable maintenance mode	f	2025-12-18 16:40:12.962434	2025-12-18 16:40:12.962434
16	items_per_page	25	number	system	Default items per page	f	2025-12-18 16:40:12.962434	2025-12-18 16:40:12.962434
5	contact_phone	+91-9876543210	text	contact	Contact phone number	t	2025-12-18 16:40:12.962434	2025-12-24 16:43:13.723046
\.


--
-- Data for Name: team_members; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.team_members (id, name, designation, photo_url, bio, linkedin_url, twitter_url, display_order, is_leadership, is_active, created_at) FROM stdin;
\.


--
-- Data for Name: test_attempts; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.test_attempts (attempt_id, test_id, user_id, start_time, end_time, score, percentage, created_at) FROM stdin;
\.


--
-- Data for Name: test_series; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.test_series (series_id, series_name, exam_id, price, total_tests, description, is_active, created_at) FROM stdin;
\.


--
-- Data for Name: testimonials; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.testimonials (id, student_name, student_image, institution_id, course_id, testimonial, rating, designation, is_featured, is_approved, display_order, created_at) FROM stdin;
\.


--
-- Data for Name: tests; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.tests (test_id, series_id, test_name, test_type, total_questions, total_marks, duration_minutes, is_active, created_at) FROM stdin;
\.


--
-- Data for Name: user_consents; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_consents (id, user_id, consent_type, consented, ip_address, created_at) FROM stdin;
\.


--
-- Data for Name: user_profiles; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_profiles (profile_id, user_id, first_name, last_name, date_of_birth, gender, profile_photo_url, country, state, city, pincode, address, academic_level, stream, target_course, created_at, updated_at) FROM stdin;
2	2	Test	User	\N	\N	\N	India	\N	\N	\N	\N	\N	\N	\N	2025-12-15 14:26:39.135063	2025-12-15 14:26:39.135063
3	3	Rahul	Kumar	\N	\N	\N	India	\N	\N	\N	\N	\N	\N	\N	2025-12-15 15:47:49.252382	2025-12-15 15:47:49.252382
4	5	Test	User	\N	\N	\N	India	\N	\N	\N	\N	\N	\N	\N	2025-12-15 16:30:54.819677	2025-12-15 16:30:54.819677
5	6	John	Doe	\N	\N	\N	India	\N	\N	\N	\N	\N	\N	\N	2025-12-15 16:31:56.740356	2025-12-15 16:31:56.740356
6	7	Jane	Smith	\N	\N	\N	India	\N	\N	\N	\N	\N	\N	\N	2025-12-15 18:56:11.290784	2025-12-15 18:56:11.290784
7	8	Amit	Sharma	\N	\N	\N	India	\N	Mumbai	\N	\N	\N	\N	B.Tech Computer Science	2025-12-15 19:36:11.325573	2025-12-15 19:36:11.325573
8	9	Test	User	\N	\N	\N	India	\N	Hyderabad	\N	\N	\N	\N	B.Tech AI & ML	2025-12-15 19:38:49.169212	2025-12-15 19:38:49.169212
\.


--
-- Data for Name: user_roles; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_roles (user_id, role_id) FROM stdin;
\.


--
-- Data for Name: user_sessions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_sessions (session_id, user_id, session_token, ip_address, is_active, created_at, expires_at) FROM stdin;
0fee8e93-d42a-4e76-b768-fb56266f3fc0	7	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiNyIsImVtYWlsIjoiamFuZUBwbGFuZWR1LmNvbSIsInBob25lIjpudWxsLCJ1c2VyX3R5cGUiOiJzdHVkZW50Iiwicm9sZXMiOltdLCJpYXQiOjE3NjU4MDUxODIsImV4cCI6MTc2ODM5NzE4Mn0.UgK2m4KM_fIFCd7RNJjJNSg-yab-DLFHFswtRnB4SMM	::1	t	2025-12-15 18:56:22.170972	2025-12-22 18:56:22.170972
c62d59ea-0f11-483a-b13f-c028dd129342	3	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiMyIsImVtYWlsIjoic3R1ZGVudEBleGFtcGxlLmNvbSIsInBob25lIjoiKzkxOTg3NjU0MzIxMCIsInVzZXJfdHlwZSI6InN0dWRlbnQiLCJyb2xlcyI6W10sImlhdCI6MTc2NTgwNTI1MiwiZXhwIjoxNzY4Mzk3MjUyfQ.ZO-M_ELBmIa8MG4TcGULX747NvX4vVtzqqnTcYyBl-o	::1	t	2025-12-15 18:57:32.11485	2025-12-22 18:57:32.11485
09168dcc-a0b8-4970-8959-a2fa2a973982	8	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiOCIsImVtYWlsIjoiYW1pdEBwbGFuZWR1LmNvbSIsInBob25lIjoiKzkxOTg3NjU0MzIxMSIsInVzZXJfdHlwZSI6InN0dWRlbnQiLCJyb2xlcyI6W10sImlhdCI6MTc2NTgwNzU4MiwiZXhwIjoxNzY4Mzk5NTgyfQ.S8PfXSICffdf13nzBVKNbmTn7ohRYWlndagdGUpnxkw	::1	t	2025-12-15 19:36:22.28537	2025-12-22 19:36:22.28537
\.


--
-- Data for Name: user_verifications; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.user_verifications (id, user_id, code, type, expires_at, consumed, created_at) FROM stdin;
1	2	889211	email	2025-12-15 14:41:39.135063	f	2025-12-15 14:26:39.135063
2	3	229353	email	2025-12-15 16:02:49.252382	f	2025-12-15 15:47:49.252382
3	5	373287	email	2025-12-15 16:40:54.819677	t	2025-12-15 16:30:54.819677
4	6	959608	email	2025-12-15 16:41:56.740356	t	2025-12-15 16:31:56.740356
5	7	109183	email	2025-12-15 19:06:11.290784	t	2025-12-15 18:56:11.290784
6	7	339091	email	2025-12-15 19:06:56.818544	f	2025-12-15 18:56:56.818544
7	3	513491	phone	2025-12-15 19:07:16.069422	t	2025-12-15 18:57:16.069422
8	8	951494	email	2025-12-15 19:46:11.325573	t	2025-12-15 19:36:11.325573
9	9	916848	email	2025-12-15 19:48:49.169212	f	2025-12-15 19:38:49.169212
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.users (user_id, username, email, phone, password_hash, user_type, email_verified, phone_verified, status, created_at, updated_at, last_login, login_count, deleted_at) FROM stdin;
2	\N	test2@example.com	\N	$2b$10$Cy7d29126WYU.qthWiE8ZO7UnP/7.SseJizCBGbhTJBQPR9vYL8wK	student	f	f	active	2025-12-15 14:26:39.135063	2025-12-15 14:26:39.135063	\N	0	\N
5	\N	testuser@planedu.com	\N	\N	student	t	f	active	2025-12-15 16:30:54.819677	2025-12-15 16:31:13.283047	\N	0	\N
6	\N	john@planedu.com	\N	\N	student	t	f	active	2025-12-15 16:31:56.740356	2025-12-15 16:32:08.008707	\N	0	\N
7	\N	jane@planedu.com	\N	\N	student	t	f	active	2025-12-15 18:56:11.290784	2025-12-15 18:56:22.177274	2025-12-15 18:56:22.177274	1	\N
3	\N	student@example.com	+919876543210	$2b$10$FZ.flqyDvyTDRTPIFA/afOw7pv64cBCXEdbeVBm8JddJ70S0KdaKe	student	f	t	active	2025-12-15 15:47:49.252382	2025-12-15 18:57:32.115882	2025-12-15 18:57:32.115882	1	\N
9	\N	testform@planedu.com	\N	\N	student	f	f	suspended	2025-12-15 19:38:49.169212	2025-12-24 14:58:08.688554	\N	0	\N
8	\N	amit@planedu.com	+919876543211	\N	student	t	f	inactive	2025-12-15 19:36:11.325573	2025-12-24 15:30:23.592382	2025-12-15 19:36:22.287009	1	\N
\.


--
-- Name: counselling_sessions_id_seq; Type: SEQUENCE SET; Schema: analytics; Owner: -
--

SELECT pg_catalog.setval('analytics.counselling_sessions_id_seq', 1, false);


--
-- Name: lead_notes_id_seq; Type: SEQUENCE SET; Schema: analytics; Owner: -
--

SELECT pg_catalog.setval('analytics.lead_notes_id_seq', 1, false);


--
-- Name: leads_id_seq; Type: SEQUENCE SET; Schema: analytics; Owner: -
--

SELECT pg_catalog.setval('analytics.leads_id_seq', 1, false);


--
-- Name: payments_id_seq; Type: SEQUENCE SET; Schema: analytics; Owner: -
--

SELECT pg_catalog.setval('analytics.payments_id_seq', 1, false);


--
-- Name: user_activity_id_seq; Type: SEQUENCE SET; Schema: analytics; Owner: -
--

SELECT pg_catalog.setval('analytics.user_activity_id_seq', 1, false);


--
-- Name: application_documents_id_seq; Type: SEQUENCE SET; Schema: discovery; Owner: -
--

SELECT pg_catalog.setval('discovery.application_documents_id_seq', 1, false);


--
-- Name: applications_id_seq; Type: SEQUENCE SET; Schema: discovery; Owner: -
--

SELECT pg_catalog.setval('discovery.applications_id_seq', 1, false);


--
-- Name: course_admissions_id_seq; Type: SEQUENCE SET; Schema: discovery; Owner: -
--

SELECT pg_catalog.setval('discovery.course_admissions_id_seq', 1, false);


--
-- Name: course_fees_id_seq; Type: SEQUENCE SET; Schema: discovery; Owner: -
--

SELECT pg_catalog.setval('discovery.course_fees_id_seq', 1, false);


--
-- Name: course_specializations_id_seq; Type: SEQUENCE SET; Schema: discovery; Owner: -
--

SELECT pg_catalog.setval('discovery.course_specializations_id_seq', 1, false);


--
-- Name: facilities_id_seq; Type: SEQUENCE SET; Schema: discovery; Owner: -
--

SELECT pg_catalog.setval('discovery.facilities_id_seq', 16, true);


--
-- Name: institution_affiliations_id_seq; Type: SEQUENCE SET; Schema: discovery; Owner: -
--

SELECT pg_catalog.setval('discovery.institution_affiliations_id_seq', 1, false);


--
-- Name: institution_approvals_id_seq; Type: SEQUENCE SET; Schema: discovery; Owner: -
--

SELECT pg_catalog.setval('discovery.institution_approvals_id_seq', 1, false);


--
-- Name: institution_brochures_id_seq; Type: SEQUENCE SET; Schema: discovery; Owner: -
--

SELECT pg_catalog.setval('discovery.institution_brochures_id_seq', 1, false);


--
-- Name: institution_courses_id_seq; Type: SEQUENCE SET; Schema: discovery; Owner: -
--

SELECT pg_catalog.setval('discovery.institution_courses_id_seq', 1, false);


--
-- Name: institution_highlights_id_seq; Type: SEQUENCE SET; Schema: discovery; Owner: -
--

SELECT pg_catalog.setval('discovery.institution_highlights_id_seq', 1, false);


--
-- Name: institution_videos_id_seq; Type: SEQUENCE SET; Schema: discovery; Owner: -
--

SELECT pg_catalog.setval('discovery.institution_videos_id_seq', 1, false);


--
-- Name: qna_id_seq; Type: SEQUENCE SET; Schema: discovery; Owner: -
--

SELECT pg_catalog.setval('discovery.qna_id_seq', 1, false);


--
-- Name: qna_votes_id_seq; Type: SEQUENCE SET; Schema: discovery; Owner: -
--

SELECT pg_catalog.setval('discovery.qna_votes_id_seq', 1, false);


--
-- Name: recruiter_companies_id_seq; Type: SEQUENCE SET; Schema: discovery; Owner: -
--

SELECT pg_catalog.setval('discovery.recruiter_companies_id_seq', 1, false);


--
-- Name: review_moderation_id_seq; Type: SEQUENCE SET; Schema: discovery; Owner: -
--

SELECT pg_catalog.setval('discovery.review_moderation_id_seq', 1, false);


--
-- Name: seo_metadata_id_seq; Type: SEQUENCE SET; Schema: discovery; Owner: -
--

SELECT pg_catalog.setval('discovery.seo_metadata_id_seq', 1, false);


--
-- Name: streams_id_seq; Type: SEQUENCE SET; Schema: discovery; Owner: -
--

SELECT pg_catalog.setval('discovery.streams_id_seq', 16, true);


--
-- Name: cities_city_id_seq; Type: SEQUENCE SET; Schema: geo_master; Owner: -
--

SELECT pg_catalog.setval('geo_master.cities_city_id_seq', 1, false);


--
-- Name: countries_country_id_seq; Type: SEQUENCE SET; Schema: geo_master; Owner: -
--

SELECT pg_catalog.setval('geo_master.countries_country_id_seq', 5, true);


--
-- Name: states_state_id_seq; Type: SEQUENCE SET; Schema: geo_master; Owner: -
--

SELECT pg_catalog.setval('geo_master.states_state_id_seq', 1, false);


--
-- Name: admin_audit_logs_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.admin_audit_logs_log_id_seq', 547, true);


--
-- Name: admin_sessions_session_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.admin_sessions_session_id_seq', 38, true);


--
-- Name: admin_users_admin_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.admin_users_admin_id_seq', 1, true);


--
-- Name: audit_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.audit_log_id_seq', 1, false);


--
-- Name: banner_analytics_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.banner_analytics_id_seq', 1, false);


--
-- Name: banners_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.banners_id_seq', 4, true);


--
-- Name: college_content_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.college_content_id_seq', 8, true);


--
-- Name: college_facilities_facility_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.college_facilities_facility_id_seq', 1, false);


--
-- Name: college_gallery_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.college_gallery_id_seq', 6, true);


--
-- Name: college_media_media_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.college_media_media_id_seq', 1, false);


--
-- Name: college_rankings_ranking_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.college_rankings_ranking_id_seq', 10, true);


--
-- Name: college_updates_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.college_updates_id_seq', 2, true);


--
-- Name: colleges_college_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.colleges_college_id_seq', 16, true);


--
-- Name: community_answers_answer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.community_answers_answer_id_seq', 1, false);


--
-- Name: community_questions_question_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.community_questions_question_id_seq', 1, false);


--
-- Name: contact_queries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.contact_queries_id_seq', 1, false);


--
-- Name: course_location_content_content_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.course_location_content_content_id_seq', 1, true);


--
-- Name: course_page_content_content_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.course_page_content_content_id_seq', 4, true);


--
-- Name: course_types_master_course_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.course_types_master_course_type_id_seq', 22, true);


--
-- Name: courses_course_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.courses_course_id_seq', 17, true);


--
-- Name: degree_categories_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.degree_categories_category_id_seq', 12, true);


--
-- Name: education_loans_loan_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.education_loans_loan_id_seq', 1, false);


--
-- Name: exam_cutoffs_cutoff_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.exam_cutoffs_cutoff_id_seq', 12, true);


--
-- Name: exam_schedules_schedule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.exam_schedules_schedule_id_seq', 1, false);


--
-- Name: exams_exam_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.exams_exam_id_seq', 17, true);


--
-- Name: faculty_members_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.faculty_members_id_seq', 3, true);


--
-- Name: faqs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.faqs_id_seq', 9, true);


--
-- Name: hostels_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.hostels_id_seq', 2, true);


--
-- Name: institute_accounts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.institute_accounts_id_seq', 1, false);


--
-- Name: institute_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.institute_users_id_seq', 1, false);


--
-- Name: job_postings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.job_postings_id_seq', 1, false);


--
-- Name: news_articles_article_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.news_articles_article_id_seq', 7, true);


--
-- Name: newsletter_subscribers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.newsletter_subscribers_id_seq', 1, false);


--
-- Name: notification_preferences_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.notification_preferences_id_seq', 1, false);


--
-- Name: notifications_notification_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.notifications_notification_id_seq', 1, false);


--
-- Name: password_resets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.password_resets_id_seq', 1, false);


--
-- Name: payments_payment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.payments_payment_id_seq', 1, false);


--
-- Name: placement_recruiters_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.placement_recruiters_id_seq', 3, true);


--
-- Name: placements_placement_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.placements_placement_id_seq', 8, true);


--
-- Name: questions_question_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.questions_question_id_seq', 1, false);


--
-- Name: quick_tabs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.quick_tabs_id_seq', 13, true);


--
-- Name: ranking_agencies_agency_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.ranking_agencies_agency_id_seq', 5, true);


--
-- Name: reviews_review_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.reviews_review_id_seq', 2, true);


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.roles_id_seq', 14, true);


--
-- Name: saved_items_saved_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.saved_items_saved_id_seq', 1, false);


--
-- Name: scholarships_scholarship_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.scholarships_scholarship_id_seq', 13, true);


--
-- Name: search_logs_search_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.search_logs_search_id_seq', 1, false);


--
-- Name: site_notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.site_notifications_id_seq', 1, false);


--
-- Name: system_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.system_settings_id_seq', 16, true);


--
-- Name: team_members_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.team_members_id_seq', 1, false);


--
-- Name: test_attempts_attempt_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.test_attempts_attempt_id_seq', 1, false);


--
-- Name: test_series_series_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.test_series_series_id_seq', 1, false);


--
-- Name: testimonials_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.testimonials_id_seq', 1, false);


--
-- Name: tests_test_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.tests_test_id_seq', 1, false);


--
-- Name: user_consents_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.user_consents_id_seq', 1, false);


--
-- Name: user_profiles_profile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.user_profiles_profile_id_seq', 8, true);


--
-- Name: user_verifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.user_verifications_id_seq', 9, true);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.users_user_id_seq', 9, true);


--
-- Name: counselling_sessions counselling_sessions_pkey; Type: CONSTRAINT; Schema: analytics; Owner: -
--

ALTER TABLE ONLY analytics.counselling_sessions
    ADD CONSTRAINT counselling_sessions_pkey PRIMARY KEY (id);


--
-- Name: lead_notes lead_notes_pkey; Type: CONSTRAINT; Schema: analytics; Owner: -
--

ALTER TABLE ONLY analytics.lead_notes
    ADD CONSTRAINT lead_notes_pkey PRIMARY KEY (id);


--
-- Name: leads leads_pkey; Type: CONSTRAINT; Schema: analytics; Owner: -
--

ALTER TABLE ONLY analytics.leads
    ADD CONSTRAINT leads_pkey PRIMARY KEY (id);


--
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: analytics; Owner: -
--

ALTER TABLE ONLY analytics.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (id);


--
-- Name: user_activity user_activity_pkey; Type: CONSTRAINT; Schema: analytics; Owner: -
--

ALTER TABLE ONLY analytics.user_activity
    ADD CONSTRAINT user_activity_pkey PRIMARY KEY (id);


--
-- Name: application_documents application_documents_pkey; Type: CONSTRAINT; Schema: discovery; Owner: -
--

ALTER TABLE ONLY discovery.application_documents
    ADD CONSTRAINT application_documents_pkey PRIMARY KEY (id);


--
-- Name: applications applications_pkey; Type: CONSTRAINT; Schema: discovery; Owner: -
--

ALTER TABLE ONLY discovery.applications
    ADD CONSTRAINT applications_pkey PRIMARY KEY (id);


--
-- Name: course_admissions course_admissions_pkey; Type: CONSTRAINT; Schema: discovery; Owner: -
--

ALTER TABLE ONLY discovery.course_admissions
    ADD CONSTRAINT course_admissions_pkey PRIMARY KEY (id);


--
-- Name: course_fees course_fees_institution_course_id_year_key; Type: CONSTRAINT; Schema: discovery; Owner: -
--

ALTER TABLE ONLY discovery.course_fees
    ADD CONSTRAINT course_fees_institution_course_id_year_key UNIQUE (institution_course_id, year);


--
-- Name: course_fees course_fees_pkey; Type: CONSTRAINT; Schema: discovery; Owner: -
--

ALTER TABLE ONLY discovery.course_fees
    ADD CONSTRAINT course_fees_pkey PRIMARY KEY (id);


--
-- Name: course_specializations course_specializations_institution_course_id_name_key; Type: CONSTRAINT; Schema: discovery; Owner: -
--

ALTER TABLE ONLY discovery.course_specializations
    ADD CONSTRAINT course_specializations_institution_course_id_name_key UNIQUE (institution_course_id, name);


--
-- Name: course_specializations course_specializations_pkey; Type: CONSTRAINT; Schema: discovery; Owner: -
--

ALTER TABLE ONLY discovery.course_specializations
    ADD CONSTRAINT course_specializations_pkey PRIMARY KEY (id);


--
-- Name: facilities facilities_name_key; Type: CONSTRAINT; Schema: discovery; Owner: -
--

ALTER TABLE ONLY discovery.facilities
    ADD CONSTRAINT facilities_name_key UNIQUE (name);


--
-- Name: facilities facilities_pkey; Type: CONSTRAINT; Schema: discovery; Owner: -
--

ALTER TABLE ONLY discovery.facilities
    ADD CONSTRAINT facilities_pkey PRIMARY KEY (id);


--
-- Name: institution_affiliations institution_affiliations_pkey; Type: CONSTRAINT; Schema: discovery; Owner: -
--

ALTER TABLE ONLY discovery.institution_affiliations
    ADD CONSTRAINT institution_affiliations_pkey PRIMARY KEY (id);


--
-- Name: institution_approvals institution_approvals_pkey; Type: CONSTRAINT; Schema: discovery; Owner: -
--

ALTER TABLE ONLY discovery.institution_approvals
    ADD CONSTRAINT institution_approvals_pkey PRIMARY KEY (id);


--
-- Name: institution_brochures institution_brochures_pkey; Type: CONSTRAINT; Schema: discovery; Owner: -
--

ALTER TABLE ONLY discovery.institution_brochures
    ADD CONSTRAINT institution_brochures_pkey PRIMARY KEY (id);


--
-- Name: institution_courses institution_courses_pkey; Type: CONSTRAINT; Schema: discovery; Owner: -
--

ALTER TABLE ONLY discovery.institution_courses
    ADD CONSTRAINT institution_courses_pkey PRIMARY KEY (id);


--
-- Name: institution_facilities institution_facilities_pkey; Type: CONSTRAINT; Schema: discovery; Owner: -
--

ALTER TABLE ONLY discovery.institution_facilities
    ADD CONSTRAINT institution_facilities_pkey PRIMARY KEY (institution_id, facility_id);


--
-- Name: institution_highlights institution_highlights_pkey; Type: CONSTRAINT; Schema: discovery; Owner: -
--

ALTER TABLE ONLY discovery.institution_highlights
    ADD CONSTRAINT institution_highlights_pkey PRIMARY KEY (id);


--
-- Name: institution_videos institution_videos_pkey; Type: CONSTRAINT; Schema: discovery; Owner: -
--

ALTER TABLE ONLY discovery.institution_videos
    ADD CONSTRAINT institution_videos_pkey PRIMARY KEY (id);


--
-- Name: qna qna_pkey; Type: CONSTRAINT; Schema: discovery; Owner: -
--

ALTER TABLE ONLY discovery.qna
    ADD CONSTRAINT qna_pkey PRIMARY KEY (id);


--
-- Name: qna_votes qna_votes_pkey; Type: CONSTRAINT; Schema: discovery; Owner: -
--

ALTER TABLE ONLY discovery.qna_votes
    ADD CONSTRAINT qna_votes_pkey PRIMARY KEY (id);


--
-- Name: qna_votes qna_votes_qna_id_user_id_key; Type: CONSTRAINT; Schema: discovery; Owner: -
--

ALTER TABLE ONLY discovery.qna_votes
    ADD CONSTRAINT qna_votes_qna_id_user_id_key UNIQUE (qna_id, user_id);


--
-- Name: recruiter_companies recruiter_companies_name_key; Type: CONSTRAINT; Schema: discovery; Owner: -
--

ALTER TABLE ONLY discovery.recruiter_companies
    ADD CONSTRAINT recruiter_companies_name_key UNIQUE (name);


--
-- Name: recruiter_companies recruiter_companies_pkey; Type: CONSTRAINT; Schema: discovery; Owner: -
--

ALTER TABLE ONLY discovery.recruiter_companies
    ADD CONSTRAINT recruiter_companies_pkey PRIMARY KEY (id);


--
-- Name: review_moderation review_moderation_pkey; Type: CONSTRAINT; Schema: discovery; Owner: -
--

ALTER TABLE ONLY discovery.review_moderation
    ADD CONSTRAINT review_moderation_pkey PRIMARY KEY (id);


--
-- Name: seo_metadata seo_metadata_entity_type_entity_id_key; Type: CONSTRAINT; Schema: discovery; Owner: -
--

ALTER TABLE ONLY discovery.seo_metadata
    ADD CONSTRAINT seo_metadata_entity_type_entity_id_key UNIQUE (entity_type, entity_id);


--
-- Name: seo_metadata seo_metadata_pkey; Type: CONSTRAINT; Schema: discovery; Owner: -
--

ALTER TABLE ONLY discovery.seo_metadata
    ADD CONSTRAINT seo_metadata_pkey PRIMARY KEY (id);


--
-- Name: streams streams_name_key; Type: CONSTRAINT; Schema: discovery; Owner: -
--

ALTER TABLE ONLY discovery.streams
    ADD CONSTRAINT streams_name_key UNIQUE (name);


--
-- Name: streams streams_pkey; Type: CONSTRAINT; Schema: discovery; Owner: -
--

ALTER TABLE ONLY discovery.streams
    ADD CONSTRAINT streams_pkey PRIMARY KEY (id);


--
-- Name: user_favorites user_favorites_pkey; Type: CONSTRAINT; Schema: discovery; Owner: -
--

ALTER TABLE ONLY discovery.user_favorites
    ADD CONSTRAINT user_favorites_pkey PRIMARY KEY (user_id, entity_type, entity_id);


--
-- Name: cities cities_pkey; Type: CONSTRAINT; Schema: geo_master; Owner: -
--

ALTER TABLE ONLY geo_master.cities
    ADD CONSTRAINT cities_pkey PRIMARY KEY (city_id);


--
-- Name: countries countries_country_code_key; Type: CONSTRAINT; Schema: geo_master; Owner: -
--

ALTER TABLE ONLY geo_master.countries
    ADD CONSTRAINT countries_country_code_key UNIQUE (country_code);


--
-- Name: countries countries_country_name_key; Type: CONSTRAINT; Schema: geo_master; Owner: -
--

ALTER TABLE ONLY geo_master.countries
    ADD CONSTRAINT countries_country_name_key UNIQUE (country_name);


--
-- Name: countries countries_pkey; Type: CONSTRAINT; Schema: geo_master; Owner: -
--

ALTER TABLE ONLY geo_master.countries
    ADD CONSTRAINT countries_pkey PRIMARY KEY (country_id);


--
-- Name: states states_pkey; Type: CONSTRAINT; Schema: geo_master; Owner: -
--

ALTER TABLE ONLY geo_master.states
    ADD CONSTRAINT states_pkey PRIMARY KEY (state_id);


--
-- Name: admin_audit_logs admin_audit_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_audit_logs
    ADD CONSTRAINT admin_audit_logs_pkey PRIMARY KEY (log_id);


--
-- Name: admin_sessions admin_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_sessions
    ADD CONSTRAINT admin_sessions_pkey PRIMARY KEY (session_id);


--
-- Name: admin_users admin_users_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_users
    ADD CONSTRAINT admin_users_email_key UNIQUE (email);


--
-- Name: admin_users admin_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_users
    ADD CONSTRAINT admin_users_pkey PRIMARY KEY (admin_id);


--
-- Name: audit_log audit_log_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.audit_log
    ADD CONSTRAINT audit_log_pkey PRIMARY KEY (id);


--
-- Name: banner_analytics banner_analytics_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.banner_analytics
    ADD CONSTRAINT banner_analytics_pkey PRIMARY KEY (id);


--
-- Name: banners banners_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.banners
    ADD CONSTRAINT banners_pkey PRIMARY KEY (id);


--
-- Name: college_content college_content_college_id_section_type_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.college_content
    ADD CONSTRAINT college_content_college_id_section_type_key UNIQUE (college_id, section_type);


--
-- Name: college_content college_content_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.college_content
    ADD CONSTRAINT college_content_pkey PRIMARY KEY (id);


--
-- Name: college_facilities college_facilities_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.college_facilities
    ADD CONSTRAINT college_facilities_pkey PRIMARY KEY (facility_id);


--
-- Name: college_gallery college_gallery_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.college_gallery
    ADD CONSTRAINT college_gallery_pkey PRIMARY KEY (id);


--
-- Name: college_media college_media_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.college_media
    ADD CONSTRAINT college_media_pkey PRIMARY KEY (media_id);


--
-- Name: college_rankings college_rankings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.college_rankings
    ADD CONSTRAINT college_rankings_pkey PRIMARY KEY (ranking_id);


--
-- Name: college_updates college_updates_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.college_updates
    ADD CONSTRAINT college_updates_pkey PRIMARY KEY (id);


--
-- Name: colleges colleges_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.colleges
    ADD CONSTRAINT colleges_pkey PRIMARY KEY (college_id);


--
-- Name: colleges colleges_slug_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.colleges
    ADD CONSTRAINT colleges_slug_key UNIQUE (slug);


--
-- Name: community_answers community_answers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.community_answers
    ADD CONSTRAINT community_answers_pkey PRIMARY KEY (answer_id);


--
-- Name: community_questions community_questions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.community_questions
    ADD CONSTRAINT community_questions_pkey PRIMARY KEY (question_id);


--
-- Name: contact_queries contact_queries_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contact_queries
    ADD CONSTRAINT contact_queries_pkey PRIMARY KEY (id);


--
-- Name: course_location_content course_location_content_course_type_location_slug_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.course_location_content
    ADD CONSTRAINT course_location_content_course_type_location_slug_key UNIQUE (course_type, location_slug);


--
-- Name: course_location_content course_location_content_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.course_location_content
    ADD CONSTRAINT course_location_content_pkey PRIMARY KEY (content_id);


--
-- Name: course_page_content course_page_content_course_type_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.course_page_content
    ADD CONSTRAINT course_page_content_course_type_key UNIQUE (course_type);


--
-- Name: course_page_content course_page_content_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.course_page_content
    ADD CONSTRAINT course_page_content_pkey PRIMARY KEY (content_id);


--
-- Name: course_types_master course_types_master_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.course_types_master
    ADD CONSTRAINT course_types_master_name_key UNIQUE (name);


--
-- Name: course_types_master course_types_master_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.course_types_master
    ADD CONSTRAINT course_types_master_pkey PRIMARY KEY (course_type_id);


--
-- Name: course_types_master course_types_master_slug_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.course_types_master
    ADD CONSTRAINT course_types_master_slug_key UNIQUE (slug);


--
-- Name: courses courses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.courses
    ADD CONSTRAINT courses_pkey PRIMARY KEY (course_id);


--
-- Name: degree_categories degree_categories_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.degree_categories
    ADD CONSTRAINT degree_categories_name_key UNIQUE (name);


--
-- Name: degree_categories degree_categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.degree_categories
    ADD CONSTRAINT degree_categories_pkey PRIMARY KEY (category_id);


--
-- Name: education_loans education_loans_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.education_loans
    ADD CONSTRAINT education_loans_pkey PRIMARY KEY (loan_id);


--
-- Name: exam_cutoffs exam_cutoffs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.exam_cutoffs
    ADD CONSTRAINT exam_cutoffs_pkey PRIMARY KEY (cutoff_id);


--
-- Name: exam_schedules exam_schedules_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.exam_schedules
    ADD CONSTRAINT exam_schedules_pkey PRIMARY KEY (schedule_id);


--
-- Name: exams exams_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.exams
    ADD CONSTRAINT exams_pkey PRIMARY KEY (exam_id);


--
-- Name: exams exams_slug_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.exams
    ADD CONSTRAINT exams_slug_key UNIQUE (slug);


--
-- Name: faculty_members faculty_members_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.faculty_members
    ADD CONSTRAINT faculty_members_pkey PRIMARY KEY (id);


--
-- Name: faqs faqs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.faqs
    ADD CONSTRAINT faqs_pkey PRIMARY KEY (id);


--
-- Name: hostels hostels_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hostels
    ADD CONSTRAINT hostels_pkey PRIMARY KEY (id);


--
-- Name: institute_accounts institute_accounts_institution_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.institute_accounts
    ADD CONSTRAINT institute_accounts_institution_id_key UNIQUE (institution_id);


--
-- Name: institute_accounts institute_accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.institute_accounts
    ADD CONSTRAINT institute_accounts_pkey PRIMARY KEY (id);


--
-- Name: institute_users institute_users_institution_id_user_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.institute_users
    ADD CONSTRAINT institute_users_institution_id_user_id_key UNIQUE (institution_id, user_id);


--
-- Name: institute_users institute_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.institute_users
    ADD CONSTRAINT institute_users_pkey PRIMARY KEY (id);


--
-- Name: job_postings job_postings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.job_postings
    ADD CONSTRAINT job_postings_pkey PRIMARY KEY (id);


--
-- Name: news_articles news_articles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.news_articles
    ADD CONSTRAINT news_articles_pkey PRIMARY KEY (article_id);


--
-- Name: news_articles news_articles_slug_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.news_articles
    ADD CONSTRAINT news_articles_slug_key UNIQUE (slug);


--
-- Name: newsletter_subscribers newsletter_subscribers_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.newsletter_subscribers
    ADD CONSTRAINT newsletter_subscribers_email_key UNIQUE (email);


--
-- Name: newsletter_subscribers newsletter_subscribers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.newsletter_subscribers
    ADD CONSTRAINT newsletter_subscribers_pkey PRIMARY KEY (id);


--
-- Name: notification_preferences notification_preferences_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notification_preferences
    ADD CONSTRAINT notification_preferences_pkey PRIMARY KEY (id);


--
-- Name: notification_preferences notification_preferences_user_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notification_preferences
    ADD CONSTRAINT notification_preferences_user_id_key UNIQUE (user_id);


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (notification_id);


--
-- Name: password_resets password_resets_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.password_resets
    ADD CONSTRAINT password_resets_pkey PRIMARY KEY (id);


--
-- Name: payments payments_order_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_order_id_key UNIQUE (order_id);


--
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (payment_id);


--
-- Name: placement_recruiters placement_recruiters_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.placement_recruiters
    ADD CONSTRAINT placement_recruiters_pkey PRIMARY KEY (id);


--
-- Name: placements placements_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.placements
    ADD CONSTRAINT placements_pkey PRIMARY KEY (placement_id);


--
-- Name: questions questions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT questions_pkey PRIMARY KEY (question_id);


--
-- Name: quick_tabs quick_tabs_degree_type_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quick_tabs
    ADD CONSTRAINT quick_tabs_degree_type_key UNIQUE (degree_type);


--
-- Name: quick_tabs quick_tabs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.quick_tabs
    ADD CONSTRAINT quick_tabs_pkey PRIMARY KEY (id);


--
-- Name: ranking_agencies ranking_agencies_agency_code_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ranking_agencies
    ADD CONSTRAINT ranking_agencies_agency_code_key UNIQUE (agency_code);


--
-- Name: ranking_agencies ranking_agencies_agency_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ranking_agencies
    ADD CONSTRAINT ranking_agencies_agency_name_key UNIQUE (agency_name);


--
-- Name: ranking_agencies ranking_agencies_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ranking_agencies
    ADD CONSTRAINT ranking_agencies_pkey PRIMARY KEY (agency_id);


--
-- Name: reviews reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (review_id);


--
-- Name: roles roles_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_name_key UNIQUE (name);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: saved_items saved_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.saved_items
    ADD CONSTRAINT saved_items_pkey PRIMARY KEY (saved_id);


--
-- Name: saved_items saved_items_user_id_item_type_item_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.saved_items
    ADD CONSTRAINT saved_items_user_id_item_type_item_id_key UNIQUE (user_id, item_type, item_id);


--
-- Name: scholarships scholarships_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scholarships
    ADD CONSTRAINT scholarships_pkey PRIMARY KEY (scholarship_id);


--
-- Name: scholarships scholarships_slug_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.scholarships
    ADD CONSTRAINT scholarships_slug_key UNIQUE (slug);


--
-- Name: search_logs search_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.search_logs
    ADD CONSTRAINT search_logs_pkey PRIMARY KEY (search_id);


--
-- Name: site_notifications site_notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.site_notifications
    ADD CONSTRAINT site_notifications_pkey PRIMARY KEY (id);


--
-- Name: system_settings system_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.system_settings
    ADD CONSTRAINT system_settings_pkey PRIMARY KEY (id);


--
-- Name: system_settings system_settings_setting_key_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.system_settings
    ADD CONSTRAINT system_settings_setting_key_key UNIQUE (setting_key);


--
-- Name: team_members team_members_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.team_members
    ADD CONSTRAINT team_members_pkey PRIMARY KEY (id);


--
-- Name: test_attempts test_attempts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.test_attempts
    ADD CONSTRAINT test_attempts_pkey PRIMARY KEY (attempt_id);


--
-- Name: test_series test_series_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.test_series
    ADD CONSTRAINT test_series_pkey PRIMARY KEY (series_id);


--
-- Name: testimonials testimonials_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.testimonials
    ADD CONSTRAINT testimonials_pkey PRIMARY KEY (id);


--
-- Name: tests tests_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tests
    ADD CONSTRAINT tests_pkey PRIMARY KEY (test_id);


--
-- Name: user_consents user_consents_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_consents
    ADD CONSTRAINT user_consents_pkey PRIMARY KEY (id);


--
-- Name: user_profiles user_profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_profiles
    ADD CONSTRAINT user_profiles_pkey PRIMARY KEY (profile_id);


--
-- Name: user_roles user_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_pkey PRIMARY KEY (user_id, role_id);


--
-- Name: user_sessions user_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_sessions
    ADD CONSTRAINT user_sessions_pkey PRIMARY KEY (session_id);


--
-- Name: user_sessions user_sessions_session_token_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_sessions
    ADD CONSTRAINT user_sessions_session_token_key UNIQUE (session_token);


--
-- Name: user_verifications user_verifications_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_verifications
    ADD CONSTRAINT user_verifications_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: idx_activity_user_time; Type: INDEX; Schema: analytics; Owner: -
--

CREATE INDEX idx_activity_user_time ON analytics.user_activity USING btree (user_id, created_at);


--
-- Name: idx_counselling_sessions_lead; Type: INDEX; Schema: analytics; Owner: -
--

CREATE INDEX idx_counselling_sessions_lead ON analytics.counselling_sessions USING btree (lead_id);


--
-- Name: idx_leads_assigned_status; Type: INDEX; Schema: analytics; Owner: -
--

CREATE INDEX idx_leads_assigned_status ON analytics.leads USING btree (assigned_to, status);


--
-- Name: idx_leads_institution; Type: INDEX; Schema: analytics; Owner: -
--

CREATE INDEX idx_leads_institution ON analytics.leads USING btree (institution_id);


--
-- Name: idx_payments_user; Type: INDEX; Schema: analytics; Owner: -
--

CREATE INDEX idx_payments_user ON analytics.payments USING btree (user_id);


--
-- Name: idx_applications_user; Type: INDEX; Schema: discovery; Owner: -
--

CREATE INDEX idx_applications_user ON discovery.applications USING btree (user_id);


--
-- Name: idx_brochures_inst; Type: INDEX; Schema: discovery; Owner: -
--

CREATE INDEX idx_brochures_inst ON discovery.institution_brochures USING btree (institution_id);


--
-- Name: idx_inst_affiliation_inst; Type: INDEX; Schema: discovery; Owner: -
--

CREATE INDEX idx_inst_affiliation_inst ON discovery.institution_affiliations USING btree (institution_id);


--
-- Name: idx_inst_approvals_inst; Type: INDEX; Schema: discovery; Owner: -
--

CREATE INDEX idx_inst_approvals_inst ON discovery.institution_approvals USING btree (institution_id);


--
-- Name: idx_inst_facility_inst; Type: INDEX; Schema: discovery; Owner: -
--

CREATE INDEX idx_inst_facility_inst ON discovery.institution_facilities USING btree (institution_id);


--
-- Name: idx_inst_highlights_inst; Type: INDEX; Schema: discovery; Owner: -
--

CREATE INDEX idx_inst_highlights_inst ON discovery.institution_highlights USING btree (institution_id);


--
-- Name: idx_institution_courses_inst_course; Type: INDEX; Schema: discovery; Owner: -
--

CREATE INDEX idx_institution_courses_inst_course ON discovery.institution_courses USING btree (institution_id, course_id);


--
-- Name: idx_qna_inst; Type: INDEX; Schema: discovery; Owner: -
--

CREATE INDEX idx_qna_inst ON discovery.qna USING btree (institution_id);


--
-- Name: idx_videos_inst; Type: INDEX; Schema: discovery; Owner: -
--

CREATE INDEX idx_videos_inst ON discovery.institution_videos USING btree (institution_id);


--
-- Name: idx_answer_question; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_answer_question ON public.community_answers USING btree (question_id);


--
-- Name: idx_article_category; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_article_category ON public.news_articles USING btree (category);


--
-- Name: idx_article_slug; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_article_slug ON public.news_articles USING btree (slug);


--
-- Name: idx_attempt_test; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_attempt_test ON public.test_attempts USING btree (test_id);


--
-- Name: idx_attempt_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_attempt_user ON public.test_attempts USING btree (user_id);


--
-- Name: idx_audit_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_audit_user ON public.audit_log USING btree (user_id);


--
-- Name: idx_banners_placement; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_banners_placement ON public.banners USING btree (placement);


--
-- Name: idx_college_content_author; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_college_content_author ON public.college_content USING btree (author_id);


--
-- Name: idx_college_content_college; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_college_content_college ON public.college_content USING btree (college_id);


--
-- Name: idx_college_content_section; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_college_content_section ON public.college_content USING btree (section_type);


--
-- Name: idx_college_content_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_college_content_status ON public.college_content USING btree (status);


--
-- Name: idx_college_gallery_category; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_college_gallery_category ON public.college_gallery USING btree (college_id, category);


--
-- Name: idx_college_gallery_college; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_college_gallery_college ON public.college_gallery USING btree (college_id);


--
-- Name: idx_college_location; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_college_location ON public.colleges USING btree (state, city);


--
-- Name: idx_college_name_search; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_college_name_search ON public.colleges USING gin (to_tsvector('english'::regconfig, (college_name)::text));


--
-- Name: idx_college_slug; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_college_slug ON public.colleges USING btree (slug);


--
-- Name: idx_college_updates_college; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_college_updates_college ON public.college_updates USING btree (college_id);


--
-- Name: idx_college_updates_expires; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_college_updates_expires ON public.college_updates USING btree (expires_at);


--
-- Name: idx_college_updates_pinned; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_college_updates_pinned ON public.college_updates USING btree (is_pinned);


--
-- Name: idx_college_updates_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_college_updates_type ON public.college_updates USING btree (update_type);


--
-- Name: idx_course_location_content_lookup; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_course_location_content_lookup ON public.course_location_content USING btree (course_type, location_slug);


--
-- Name: idx_course_location_content_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_course_location_content_status ON public.course_location_content USING btree (status);


--
-- Name: idx_course_page_content_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_course_page_content_status ON public.course_page_content USING btree (status);


--
-- Name: idx_course_page_content_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_course_page_content_type ON public.course_page_content USING btree (course_type);


--
-- Name: idx_course_types_master_category; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_course_types_master_category ON public.course_types_master USING btree (category);


--
-- Name: idx_course_types_master_level; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_course_types_master_level ON public.course_types_master USING btree (level);


--
-- Name: idx_course_types_master_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_course_types_master_status ON public.course_types_master USING btree (status);


--
-- Name: idx_courses_college_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_courses_college_id ON public.courses USING btree (college_id);


--
-- Name: idx_courses_degree_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_courses_degree_type ON public.courses USING btree (degree_type);


--
-- Name: idx_courses_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_courses_status ON public.courses USING btree (status);


--
-- Name: idx_courses_stream; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_courses_stream ON public.courses USING btree (stream);


--
-- Name: idx_cutoff_college; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_cutoff_college ON public.exam_cutoffs USING btree (college_id);


--
-- Name: idx_cutoff_exam; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_cutoff_exam ON public.exam_cutoffs USING btree (exam_id);


--
-- Name: idx_exam_category; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_exam_category ON public.exams USING btree (exam_category);


--
-- Name: idx_exam_slug; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_exam_slug ON public.exams USING btree (slug);


--
-- Name: idx_facility_college; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_facility_college ON public.college_facilities USING btree (college_id);


--
-- Name: idx_faculty_college; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_faculty_college ON public.faculty_members USING btree (college_id);


--
-- Name: idx_faculty_department; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_faculty_department ON public.faculty_members USING btree (department);


--
-- Name: idx_faculty_designation; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_faculty_designation ON public.faculty_members USING btree (designation);


--
-- Name: idx_faqs_category; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_faqs_category ON public.faqs USING btree (category);


--
-- Name: idx_hostels_college; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_hostels_college ON public.hostels USING btree (college_id);


--
-- Name: idx_hostels_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_hostels_type ON public.hostels USING btree (hostel_type);


--
-- Name: idx_loan_provider; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_loan_provider ON public.education_loans USING btree (loan_provider);


--
-- Name: idx_media_college; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_media_college ON public.college_media USING btree (college_id);


--
-- Name: idx_newsletter_email; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_newsletter_email ON public.newsletter_subscribers USING btree (email);


--
-- Name: idx_notification_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_notification_status ON public.notifications USING btree (status);


--
-- Name: idx_notification_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_notification_user ON public.notifications USING btree (user_id);


--
-- Name: idx_password_resets_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_password_resets_user ON public.password_resets USING btree (user_id);


--
-- Name: idx_payment_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_payment_status ON public.payments USING btree (payment_status);


--
-- Name: idx_payment_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_payment_user ON public.payments USING btree (user_id);


--
-- Name: idx_placement_college; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_placement_college ON public.placements USING btree (college_id);


--
-- Name: idx_placement_recruiters_placement; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_placement_recruiters_placement ON public.placement_recruiters USING btree (placement_id);


--
-- Name: idx_placement_recruiters_sector; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_placement_recruiters_sector ON public.placement_recruiters USING btree (sector);


--
-- Name: idx_profile_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_profile_user ON public.user_profiles USING btree (user_id);


--
-- Name: idx_question_college; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_question_college ON public.community_questions USING btree (college_id);


--
-- Name: idx_question_test; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_question_test ON public.questions USING btree (test_id);


--
-- Name: idx_question_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_question_user ON public.community_questions USING btree (user_id);


--
-- Name: idx_quick_tabs_order; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_quick_tabs_order ON public.quick_tabs USING btree (display_order, is_active);


--
-- Name: idx_ranking_college; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_ranking_college ON public.college_rankings USING btree (college_id);


--
-- Name: idx_ranking_year; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_ranking_year ON public.college_rankings USING btree (ranking_year);


--
-- Name: idx_review_college; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_review_college ON public.reviews USING btree (college_id);


--
-- Name: idx_review_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_review_status ON public.reviews USING btree (status);


--
-- Name: idx_review_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_review_user ON public.reviews USING btree (user_id);


--
-- Name: idx_reviews_college_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_reviews_college_id ON public.reviews USING btree (college_id);


--
-- Name: idx_reviews_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_reviews_created_at ON public.reviews USING btree (created_at);


--
-- Name: idx_reviews_deleted_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_reviews_deleted_at ON public.reviews USING btree (deleted_at);


--
-- Name: idx_reviews_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_reviews_status ON public.reviews USING btree (status);


--
-- Name: idx_reviews_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_reviews_user_id ON public.reviews USING btree (user_id);


--
-- Name: idx_saved_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_saved_user ON public.saved_items USING btree (user_id);


--
-- Name: idx_schedule_exam; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_schedule_exam ON public.exam_schedules USING btree (exam_id);


--
-- Name: idx_scholarship_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_scholarship_type ON public.scholarships USING btree (scholarship_type);


--
-- Name: idx_search_created; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_search_created ON public.search_logs USING btree (created_at);


--
-- Name: idx_search_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_search_user ON public.search_logs USING btree (user_id);


--
-- Name: idx_series_exam; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_series_exam ON public.test_series USING btree (exam_id);


--
-- Name: idx_session_token; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_session_token ON public.user_sessions USING btree (session_token);


--
-- Name: idx_session_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_session_user ON public.user_sessions USING btree (user_id);


--
-- Name: idx_site_notifications_active; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_site_notifications_active ON public.site_notifications USING btree (is_active, valid_from, valid_to);


--
-- Name: idx_test_series; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_test_series ON public.tests USING btree (series_id);


--
-- Name: idx_user_consents_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_consents_user ON public.user_consents USING btree (user_id);


--
-- Name: idx_user_verifications_user; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_user_verifications_user ON public.user_verifications USING btree (user_id);


--
-- Name: idx_users_email; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_users_email ON public.users USING btree (email);


--
-- Name: idx_users_phone; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_users_phone ON public.users USING btree (phone);


--
-- Name: idx_users_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX idx_users_type ON public.users USING btree (user_type);


--
-- Name: college_content update_college_content_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_college_content_updated_at BEFORE UPDATE ON public.college_content FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: faculty_members update_faculty_members_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_faculty_members_updated_at BEFORE UPDATE ON public.faculty_members FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: hostels update_hostels_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER update_hostels_updated_at BEFORE UPDATE ON public.hostels FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- Name: counselling_sessions counselling_sessions_counsellor_id_fkey; Type: FK CONSTRAINT; Schema: analytics; Owner: -
--

ALTER TABLE ONLY analytics.counselling_sessions
    ADD CONSTRAINT counselling_sessions_counsellor_id_fkey FOREIGN KEY (counsellor_id) REFERENCES public.users(user_id) ON DELETE SET NULL;


--
-- Name: counselling_sessions counselling_sessions_lead_id_fkey; Type: FK CONSTRAINT; Schema: analytics; Owner: -
--

ALTER TABLE ONLY analytics.counselling_sessions
    ADD CONSTRAINT counselling_sessions_lead_id_fkey FOREIGN KEY (lead_id) REFERENCES analytics.leads(id) ON DELETE CASCADE;


--
-- Name: lead_notes lead_notes_lead_id_fkey; Type: FK CONSTRAINT; Schema: analytics; Owner: -
--

ALTER TABLE ONLY analytics.lead_notes
    ADD CONSTRAINT lead_notes_lead_id_fkey FOREIGN KEY (lead_id) REFERENCES analytics.leads(id) ON DELETE CASCADE;


--
-- Name: lead_notes lead_notes_user_id_fkey; Type: FK CONSTRAINT; Schema: analytics; Owner: -
--

ALTER TABLE ONLY analytics.lead_notes
    ADD CONSTRAINT lead_notes_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE SET NULL;


--
-- Name: leads leads_assigned_to_fkey; Type: FK CONSTRAINT; Schema: analytics; Owner: -
--

ALTER TABLE ONLY analytics.leads
    ADD CONSTRAINT leads_assigned_to_fkey FOREIGN KEY (assigned_to) REFERENCES public.users(user_id) ON DELETE SET NULL;


--
-- Name: leads leads_institution_id_fkey; Type: FK CONSTRAINT; Schema: analytics; Owner: -
--

ALTER TABLE ONLY analytics.leads
    ADD CONSTRAINT leads_institution_id_fkey FOREIGN KEY (institution_id) REFERENCES public.colleges(college_id) ON DELETE SET NULL;


--
-- Name: leads leads_user_id_fkey; Type: FK CONSTRAINT; Schema: analytics; Owner: -
--

ALTER TABLE ONLY analytics.leads
    ADD CONSTRAINT leads_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE SET NULL;


--
-- Name: payments payments_institution_id_fkey; Type: FK CONSTRAINT; Schema: analytics; Owner: -
--

ALTER TABLE ONLY analytics.payments
    ADD CONSTRAINT payments_institution_id_fkey FOREIGN KEY (institution_id) REFERENCES public.colleges(college_id);


--
-- Name: payments payments_user_id_fkey; Type: FK CONSTRAINT; Schema: analytics; Owner: -
--

ALTER TABLE ONLY analytics.payments
    ADD CONSTRAINT payments_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: user_activity user_activity_user_id_fkey; Type: FK CONSTRAINT; Schema: analytics; Owner: -
--

ALTER TABLE ONLY analytics.user_activity
    ADD CONSTRAINT user_activity_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- Name: application_documents application_documents_application_id_fkey; Type: FK CONSTRAINT; Schema: discovery; Owner: -
--

ALTER TABLE ONLY discovery.application_documents
    ADD CONSTRAINT application_documents_application_id_fkey FOREIGN KEY (application_id) REFERENCES discovery.applications(id) ON DELETE CASCADE;


--
-- Name: application_documents application_documents_verified_by_fkey; Type: FK CONSTRAINT; Schema: discovery; Owner: -
--

ALTER TABLE ONLY discovery.application_documents
    ADD CONSTRAINT application_documents_verified_by_fkey FOREIGN KEY (verified_by) REFERENCES public.users(user_id);


--
-- Name: applications applications_institution_course_id_fkey; Type: FK CONSTRAINT; Schema: discovery; Owner: -
--

ALTER TABLE ONLY discovery.applications
    ADD CONSTRAINT applications_institution_course_id_fkey FOREIGN KEY (institution_course_id) REFERENCES discovery.institution_courses(id) ON DELETE CASCADE;


--
-- Name: applications applications_user_id_fkey; Type: FK CONSTRAINT; Schema: discovery; Owner: -
--

ALTER TABLE ONLY discovery.applications
    ADD CONSTRAINT applications_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- Name: course_admissions course_admissions_institution_course_id_fkey; Type: FK CONSTRAINT; Schema: discovery; Owner: -
--

ALTER TABLE ONLY discovery.course_admissions
    ADD CONSTRAINT course_admissions_institution_course_id_fkey FOREIGN KEY (institution_course_id) REFERENCES discovery.institution_courses(id) ON DELETE CASCADE;


--
-- Name: course_fees course_fees_institution_course_id_fkey; Type: FK CONSTRAINT; Schema: discovery; Owner: -
--

ALTER TABLE ONLY discovery.course_fees
    ADD CONSTRAINT course_fees_institution_course_id_fkey FOREIGN KEY (institution_course_id) REFERENCES discovery.institution_courses(id) ON DELETE CASCADE;


--
-- Name: course_specializations course_specializations_institution_course_id_fkey; Type: FK CONSTRAINT; Schema: discovery; Owner: -
--

ALTER TABLE ONLY discovery.course_specializations
    ADD CONSTRAINT course_specializations_institution_course_id_fkey FOREIGN KEY (institution_course_id) REFERENCES discovery.institution_courses(id) ON DELETE CASCADE;


--
-- Name: institution_affiliations institution_affiliations_institution_id_fkey; Type: FK CONSTRAINT; Schema: discovery; Owner: -
--

ALTER TABLE ONLY discovery.institution_affiliations
    ADD CONSTRAINT institution_affiliations_institution_id_fkey FOREIGN KEY (institution_id) REFERENCES public.colleges(college_id) ON DELETE CASCADE;


--
-- Name: institution_approvals institution_approvals_institution_id_fkey; Type: FK CONSTRAINT; Schema: discovery; Owner: -
--

ALTER TABLE ONLY discovery.institution_approvals
    ADD CONSTRAINT institution_approvals_institution_id_fkey FOREIGN KEY (institution_id) REFERENCES public.colleges(college_id) ON DELETE CASCADE;


--
-- Name: institution_brochures institution_brochures_institution_id_fkey; Type: FK CONSTRAINT; Schema: discovery; Owner: -
--

ALTER TABLE ONLY discovery.institution_brochures
    ADD CONSTRAINT institution_brochures_institution_id_fkey FOREIGN KEY (institution_id) REFERENCES public.colleges(college_id) ON DELETE CASCADE;


--
-- Name: institution_courses institution_courses_institution_id_fkey; Type: FK CONSTRAINT; Schema: discovery; Owner: -
--

ALTER TABLE ONLY discovery.institution_courses
    ADD CONSTRAINT institution_courses_institution_id_fkey FOREIGN KEY (institution_id) REFERENCES public.colleges(college_id) ON DELETE CASCADE;


--
-- Name: institution_facilities institution_facilities_facility_id_fkey; Type: FK CONSTRAINT; Schema: discovery; Owner: -
--

ALTER TABLE ONLY discovery.institution_facilities
    ADD CONSTRAINT institution_facilities_facility_id_fkey FOREIGN KEY (facility_id) REFERENCES discovery.facilities(id) ON DELETE CASCADE;


--
-- Name: institution_facilities institution_facilities_institution_id_fkey; Type: FK CONSTRAINT; Schema: discovery; Owner: -
--

ALTER TABLE ONLY discovery.institution_facilities
    ADD CONSTRAINT institution_facilities_institution_id_fkey FOREIGN KEY (institution_id) REFERENCES public.colleges(college_id) ON DELETE CASCADE;


--
-- Name: institution_highlights institution_highlights_institution_id_fkey; Type: FK CONSTRAINT; Schema: discovery; Owner: -
--

ALTER TABLE ONLY discovery.institution_highlights
    ADD CONSTRAINT institution_highlights_institution_id_fkey FOREIGN KEY (institution_id) REFERENCES public.colleges(college_id) ON DELETE CASCADE;


--
-- Name: institution_videos institution_videos_institution_id_fkey; Type: FK CONSTRAINT; Schema: discovery; Owner: -
--

ALTER TABLE ONLY discovery.institution_videos
    ADD CONSTRAINT institution_videos_institution_id_fkey FOREIGN KEY (institution_id) REFERENCES public.colleges(college_id) ON DELETE CASCADE;


--
-- Name: qna qna_answered_by_fkey; Type: FK CONSTRAINT; Schema: discovery; Owner: -
--

ALTER TABLE ONLY discovery.qna
    ADD CONSTRAINT qna_answered_by_fkey FOREIGN KEY (answered_by) REFERENCES public.users(user_id) ON DELETE SET NULL;


--
-- Name: qna qna_institution_id_fkey; Type: FK CONSTRAINT; Schema: discovery; Owner: -
--

ALTER TABLE ONLY discovery.qna
    ADD CONSTRAINT qna_institution_id_fkey FOREIGN KEY (institution_id) REFERENCES public.colleges(college_id) ON DELETE CASCADE;


--
-- Name: qna qna_user_id_fkey; Type: FK CONSTRAINT; Schema: discovery; Owner: -
--

ALTER TABLE ONLY discovery.qna
    ADD CONSTRAINT qna_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE SET NULL;


--
-- Name: qna_votes qna_votes_qna_id_fkey; Type: FK CONSTRAINT; Schema: discovery; Owner: -
--

ALTER TABLE ONLY discovery.qna_votes
    ADD CONSTRAINT qna_votes_qna_id_fkey FOREIGN KEY (qna_id) REFERENCES discovery.qna(id) ON DELETE CASCADE;


--
-- Name: qna_votes qna_votes_user_id_fkey; Type: FK CONSTRAINT; Schema: discovery; Owner: -
--

ALTER TABLE ONLY discovery.qna_votes
    ADD CONSTRAINT qna_votes_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- Name: review_moderation review_moderation_moderated_by_fkey; Type: FK CONSTRAINT; Schema: discovery; Owner: -
--

ALTER TABLE ONLY discovery.review_moderation
    ADD CONSTRAINT review_moderation_moderated_by_fkey FOREIGN KEY (moderated_by) REFERENCES public.users(user_id);


--
-- Name: review_moderation review_moderation_review_id_fkey; Type: FK CONSTRAINT; Schema: discovery; Owner: -
--

ALTER TABLE ONLY discovery.review_moderation
    ADD CONSTRAINT review_moderation_review_id_fkey FOREIGN KEY (review_id) REFERENCES public.reviews(review_id) ON DELETE CASCADE;


--
-- Name: user_favorites user_favorites_user_id_fkey; Type: FK CONSTRAINT; Schema: discovery; Owner: -
--

ALTER TABLE ONLY discovery.user_favorites
    ADD CONSTRAINT user_favorites_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: cities cities_state_id_fkey; Type: FK CONSTRAINT; Schema: geo_master; Owner: -
--

ALTER TABLE ONLY geo_master.cities
    ADD CONSTRAINT cities_state_id_fkey FOREIGN KEY (state_id) REFERENCES geo_master.states(state_id);


--
-- Name: states states_country_id_fkey; Type: FK CONSTRAINT; Schema: geo_master; Owner: -
--

ALTER TABLE ONLY geo_master.states
    ADD CONSTRAINT states_country_id_fkey FOREIGN KEY (country_id) REFERENCES geo_master.countries(country_id);


--
-- Name: admin_audit_logs admin_audit_logs_admin_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_audit_logs
    ADD CONSTRAINT admin_audit_logs_admin_id_fkey FOREIGN KEY (admin_id) REFERENCES public.admin_users(admin_id);


--
-- Name: admin_sessions admin_sessions_admin_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.admin_sessions
    ADD CONSTRAINT admin_sessions_admin_id_fkey FOREIGN KEY (admin_id) REFERENCES public.admin_users(admin_id);


--
-- Name: audit_log audit_log_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.audit_log
    ADD CONSTRAINT audit_log_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE SET NULL;


--
-- Name: banner_analytics banner_analytics_banner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.banner_analytics
    ADD CONSTRAINT banner_analytics_banner_id_fkey FOREIGN KEY (banner_id) REFERENCES public.banners(id) ON DELETE CASCADE;


--
-- Name: banner_analytics banner_analytics_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.banner_analytics
    ADD CONSTRAINT banner_analytics_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: banners banners_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.banners
    ADD CONSTRAINT banners_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(user_id);


--
-- Name: college_content college_content_college_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.college_content
    ADD CONSTRAINT college_content_college_id_fkey FOREIGN KEY (college_id) REFERENCES public.colleges(college_id) ON DELETE CASCADE;


--
-- Name: college_facilities college_facilities_college_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.college_facilities
    ADD CONSTRAINT college_facilities_college_id_fkey FOREIGN KEY (college_id) REFERENCES public.colleges(college_id) ON DELETE CASCADE;


--
-- Name: college_gallery college_gallery_college_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.college_gallery
    ADD CONSTRAINT college_gallery_college_id_fkey FOREIGN KEY (college_id) REFERENCES public.colleges(college_id) ON DELETE CASCADE;


--
-- Name: college_media college_media_college_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.college_media
    ADD CONSTRAINT college_media_college_id_fkey FOREIGN KEY (college_id) REFERENCES public.colleges(college_id) ON DELETE CASCADE;


--
-- Name: college_rankings college_rankings_agency_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.college_rankings
    ADD CONSTRAINT college_rankings_agency_id_fkey FOREIGN KEY (agency_id) REFERENCES public.ranking_agencies(agency_id);


--
-- Name: college_rankings college_rankings_college_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.college_rankings
    ADD CONSTRAINT college_rankings_college_id_fkey FOREIGN KEY (college_id) REFERENCES public.colleges(college_id) ON DELETE CASCADE;


--
-- Name: college_updates college_updates_college_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.college_updates
    ADD CONSTRAINT college_updates_college_id_fkey FOREIGN KEY (college_id) REFERENCES public.colleges(college_id) ON DELETE CASCADE;


--
-- Name: community_answers community_answers_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.community_answers
    ADD CONSTRAINT community_answers_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.community_questions(question_id) ON DELETE CASCADE;


--
-- Name: community_answers community_answers_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.community_answers
    ADD CONSTRAINT community_answers_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE SET NULL;


--
-- Name: community_questions community_questions_college_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.community_questions
    ADD CONSTRAINT community_questions_college_id_fkey FOREIGN KEY (college_id) REFERENCES public.colleges(college_id);


--
-- Name: community_questions community_questions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.community_questions
    ADD CONSTRAINT community_questions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE SET NULL;


--
-- Name: contact_queries contact_queries_assigned_to_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.contact_queries
    ADD CONSTRAINT contact_queries_assigned_to_fkey FOREIGN KEY (assigned_to) REFERENCES public.users(user_id) ON DELETE SET NULL;


--
-- Name: courses courses_college_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.courses
    ADD CONSTRAINT courses_college_id_fkey FOREIGN KEY (college_id) REFERENCES public.colleges(college_id) ON DELETE CASCADE;


--
-- Name: exam_cutoffs exam_cutoffs_college_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.exam_cutoffs
    ADD CONSTRAINT exam_cutoffs_college_id_fkey FOREIGN KEY (college_id) REFERENCES public.colleges(college_id) ON DELETE CASCADE;


--
-- Name: exam_cutoffs exam_cutoffs_exam_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.exam_cutoffs
    ADD CONSTRAINT exam_cutoffs_exam_id_fkey FOREIGN KEY (exam_id) REFERENCES public.exams(exam_id) ON DELETE CASCADE;


--
-- Name: exam_schedules exam_schedules_exam_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.exam_schedules
    ADD CONSTRAINT exam_schedules_exam_id_fkey FOREIGN KEY (exam_id) REFERENCES public.exams(exam_id) ON DELETE CASCADE;


--
-- Name: faculty_members faculty_members_college_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.faculty_members
    ADD CONSTRAINT faculty_members_college_id_fkey FOREIGN KEY (college_id) REFERENCES public.colleges(college_id) ON DELETE CASCADE;


--
-- Name: hostels hostels_college_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.hostels
    ADD CONSTRAINT hostels_college_id_fkey FOREIGN KEY (college_id) REFERENCES public.colleges(college_id) ON DELETE CASCADE;


--
-- Name: institute_accounts institute_accounts_account_manager_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.institute_accounts
    ADD CONSTRAINT institute_accounts_account_manager_id_fkey FOREIGN KEY (account_manager_id) REFERENCES public.users(user_id);


--
-- Name: institute_accounts institute_accounts_institution_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.institute_accounts
    ADD CONSTRAINT institute_accounts_institution_id_fkey FOREIGN KEY (institution_id) REFERENCES public.colleges(college_id);


--
-- Name: institute_users institute_users_institution_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.institute_users
    ADD CONSTRAINT institute_users_institution_id_fkey FOREIGN KEY (institution_id) REFERENCES public.colleges(college_id);


--
-- Name: institute_users institute_users_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.institute_users
    ADD CONSTRAINT institute_users_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: news_articles news_articles_author_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.news_articles
    ADD CONSTRAINT news_articles_author_id_fkey FOREIGN KEY (author_id) REFERENCES public.users(user_id);


--
-- Name: notification_preferences notification_preferences_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notification_preferences
    ADD CONSTRAINT notification_preferences_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- Name: notifications notifications_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- Name: password_resets password_resets_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.password_resets
    ADD CONSTRAINT password_resets_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- Name: payments payments_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: placement_recruiters placement_recruiters_placement_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.placement_recruiters
    ADD CONSTRAINT placement_recruiters_placement_id_fkey FOREIGN KEY (placement_id) REFERENCES public.placements(placement_id) ON DELETE CASCADE;


--
-- Name: placements placements_college_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.placements
    ADD CONSTRAINT placements_college_id_fkey FOREIGN KEY (college_id) REFERENCES public.colleges(college_id) ON DELETE CASCADE;


--
-- Name: questions questions_test_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT questions_test_id_fkey FOREIGN KEY (test_id) REFERENCES public.tests(test_id) ON DELETE CASCADE;


--
-- Name: reviews reviews_college_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_college_id_fkey FOREIGN KEY (college_id) REFERENCES public.colleges(college_id) ON DELETE CASCADE;


--
-- Name: reviews reviews_replied_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_replied_by_fkey FOREIGN KEY (replied_by) REFERENCES public.users(user_id);


--
-- Name: reviews reviews_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE SET NULL;


--
-- Name: saved_items saved_items_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.saved_items
    ADD CONSTRAINT saved_items_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- Name: search_logs search_logs_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.search_logs
    ADD CONSTRAINT search_logs_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: test_attempts test_attempts_test_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.test_attempts
    ADD CONSTRAINT test_attempts_test_id_fkey FOREIGN KEY (test_id) REFERENCES public.tests(test_id) ON DELETE CASCADE;


--
-- Name: test_attempts test_attempts_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.test_attempts
    ADD CONSTRAINT test_attempts_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- Name: test_series test_series_exam_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.test_series
    ADD CONSTRAINT test_series_exam_id_fkey FOREIGN KEY (exam_id) REFERENCES public.exams(exam_id);


--
-- Name: testimonials testimonials_institution_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.testimonials
    ADD CONSTRAINT testimonials_institution_id_fkey FOREIGN KEY (institution_id) REFERENCES public.colleges(college_id);


--
-- Name: tests tests_series_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tests
    ADD CONSTRAINT tests_series_id_fkey FOREIGN KEY (series_id) REFERENCES public.test_series(series_id) ON DELETE CASCADE;


--
-- Name: user_consents user_consents_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_consents
    ADD CONSTRAINT user_consents_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: user_profiles user_profiles_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_profiles
    ADD CONSTRAINT user_profiles_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- Name: user_roles user_roles_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(id) ON DELETE CASCADE;


--
-- Name: user_roles user_roles_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- Name: user_sessions user_sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_sessions
    ADD CONSTRAINT user_sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- Name: user_verifications user_verifications_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_verifications
    ADD CONSTRAINT user_verifications_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict EakBiW8oR0OtUhMjMF9SbU6fpc4gcRE0ChpGxXas0RjeVhKTDSirfUyl3XlHD0L

