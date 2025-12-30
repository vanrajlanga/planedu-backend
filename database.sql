--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5
-- Dumped by pg_dump version 17.5

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
ALTER TABLE IF EXISTS ONLY public.payments DROP CONSTRAINT IF EXISTS payments_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.password_resets DROP CONSTRAINT IF EXISTS password_resets_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.notifications DROP CONSTRAINT IF EXISTS notifications_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.notification_preferences DROP CONSTRAINT IF EXISTS notification_preferences_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.news_articles DROP CONSTRAINT IF EXISTS news_articles_author_id_fkey;
ALTER TABLE IF EXISTS ONLY public.institute_users DROP CONSTRAINT IF EXISTS institute_users_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.institute_users DROP CONSTRAINT IF EXISTS institute_users_institution_id_fkey;
ALTER TABLE IF EXISTS ONLY public.institute_accounts DROP CONSTRAINT IF EXISTS institute_accounts_institution_id_fkey;
ALTER TABLE IF EXISTS ONLY public.institute_accounts DROP CONSTRAINT IF EXISTS institute_accounts_account_manager_id_fkey;
ALTER TABLE IF EXISTS ONLY public.exam_schedules DROP CONSTRAINT IF EXISTS exam_schedules_exam_id_fkey;
ALTER TABLE IF EXISTS ONLY public.exam_cutoffs DROP CONSTRAINT IF EXISTS exam_cutoffs_exam_id_fkey;
ALTER TABLE IF EXISTS ONLY public.exam_cutoffs DROP CONSTRAINT IF EXISTS exam_cutoffs_college_id_fkey;
ALTER TABLE IF EXISTS ONLY public.courses DROP CONSTRAINT IF EXISTS courses_college_id_fkey;
ALTER TABLE IF EXISTS ONLY public.contact_queries DROP CONSTRAINT IF EXISTS contact_queries_assigned_to_fkey;
ALTER TABLE IF EXISTS ONLY public.community_questions DROP CONSTRAINT IF EXISTS community_questions_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.community_questions DROP CONSTRAINT IF EXISTS community_questions_college_id_fkey;
ALTER TABLE IF EXISTS ONLY public.community_answers DROP CONSTRAINT IF EXISTS community_answers_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.community_answers DROP CONSTRAINT IF EXISTS community_answers_question_id_fkey;
ALTER TABLE IF EXISTS ONLY public.college_rankings DROP CONSTRAINT IF EXISTS college_rankings_college_id_fkey;
ALTER TABLE IF EXISTS ONLY public.college_rankings DROP CONSTRAINT IF EXISTS college_rankings_agency_id_fkey;
ALTER TABLE IF EXISTS ONLY public.college_media DROP CONSTRAINT IF EXISTS college_media_college_id_fkey;
ALTER TABLE IF EXISTS ONLY public.college_facilities DROP CONSTRAINT IF EXISTS college_facilities_college_id_fkey;
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
DROP INDEX IF EXISTS public.idx_question_user;
DROP INDEX IF EXISTS public.idx_question_test;
DROP INDEX IF EXISTS public.idx_question_college;
DROP INDEX IF EXISTS public.idx_profile_user;
DROP INDEX IF EXISTS public.idx_placement_college;
DROP INDEX IF EXISTS public.idx_payment_user;
DROP INDEX IF EXISTS public.idx_payment_status;
DROP INDEX IF EXISTS public.idx_password_resets_user;
DROP INDEX IF EXISTS public.idx_notification_user;
DROP INDEX IF EXISTS public.idx_notification_status;
DROP INDEX IF EXISTS public.idx_newsletter_email;
DROP INDEX IF EXISTS public.idx_media_college;
DROP INDEX IF EXISTS public.idx_loan_provider;
DROP INDEX IF EXISTS public.idx_faqs_category;
DROP INDEX IF EXISTS public.idx_facility_college;
DROP INDEX IF EXISTS public.idx_exam_slug;
DROP INDEX IF EXISTS public.idx_exam_category;
DROP INDEX IF EXISTS public.idx_cutoff_exam;
DROP INDEX IF EXISTS public.idx_cutoff_college;
DROP INDEX IF EXISTS public.idx_courses_stream;
DROP INDEX IF EXISTS public.idx_courses_status;
DROP INDEX IF EXISTS public.idx_courses_degree_type;
DROP INDEX IF EXISTS public.idx_courses_college_id;
DROP INDEX IF EXISTS public.idx_college_slug;
DROP INDEX IF EXISTS public.idx_college_name_search;
DROP INDEX IF EXISTS public.idx_college_location;
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
ALTER TABLE IF EXISTS ONLY public.questions DROP CONSTRAINT IF EXISTS questions_pkey;
ALTER TABLE IF EXISTS ONLY public.placements DROP CONSTRAINT IF EXISTS placements_pkey;
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
ALTER TABLE IF EXISTS ONLY public.faqs DROP CONSTRAINT IF EXISTS faqs_pkey;
ALTER TABLE IF EXISTS ONLY public.exams DROP CONSTRAINT IF EXISTS exams_slug_key;
ALTER TABLE IF EXISTS ONLY public.exams DROP CONSTRAINT IF EXISTS exams_pkey;
ALTER TABLE IF EXISTS ONLY public.exam_schedules DROP CONSTRAINT IF EXISTS exam_schedules_pkey;
ALTER TABLE IF EXISTS ONLY public.exam_cutoffs DROP CONSTRAINT IF EXISTS exam_cutoffs_pkey;
ALTER TABLE IF EXISTS ONLY public.education_loans DROP CONSTRAINT IF EXISTS education_loans_pkey;
ALTER TABLE IF EXISTS ONLY public.courses DROP CONSTRAINT IF EXISTS courses_pkey;
ALTER TABLE IF EXISTS ONLY public.contact_queries DROP CONSTRAINT IF EXISTS contact_queries_pkey;
ALTER TABLE IF EXISTS ONLY public.community_questions DROP CONSTRAINT IF EXISTS community_questions_pkey;
ALTER TABLE IF EXISTS ONLY public.community_answers DROP CONSTRAINT IF EXISTS community_answers_pkey;
ALTER TABLE IF EXISTS ONLY public.colleges DROP CONSTRAINT IF EXISTS colleges_slug_key;
ALTER TABLE IF EXISTS ONLY public.colleges DROP CONSTRAINT IF EXISTS colleges_pkey;
ALTER TABLE IF EXISTS ONLY public.college_rankings DROP CONSTRAINT IF EXISTS college_rankings_pkey;
ALTER TABLE IF EXISTS ONLY public.college_media DROP CONSTRAINT IF EXISTS college_media_pkey;
ALTER TABLE IF EXISTS ONLY public.college_facilities DROP CONSTRAINT IF EXISTS college_facilities_pkey;
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
ALTER TABLE IF EXISTS public.questions ALTER COLUMN question_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.placements ALTER COLUMN placement_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.payments ALTER COLUMN payment_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.password_resets ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.notifications ALTER COLUMN notification_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.notification_preferences ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.newsletter_subscribers ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.news_articles ALTER COLUMN article_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.job_postings ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.institute_users ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.institute_accounts ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.faqs ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.exams ALTER COLUMN exam_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.exam_schedules ALTER COLUMN schedule_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.exam_cutoffs ALTER COLUMN cutoff_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.education_loans ALTER COLUMN loan_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.courses ALTER COLUMN course_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.contact_queries ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.community_questions ALTER COLUMN question_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.community_answers ALTER COLUMN answer_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.colleges ALTER COLUMN college_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.college_rankings ALTER COLUMN ranking_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.college_media ALTER COLUMN media_id DROP DEFAULT;
ALTER TABLE IF EXISTS public.college_facilities ALTER COLUMN facility_id DROP DEFAULT;
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
DROP SEQUENCE IF EXISTS public.questions_question_id_seq;
DROP TABLE IF EXISTS public.questions;
DROP SEQUENCE IF EXISTS public.placements_placement_id_seq;
DROP TABLE IF EXISTS public.placements;
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
DROP SEQUENCE IF EXISTS public.faqs_id_seq;
DROP TABLE IF EXISTS public.faqs;
DROP SEQUENCE IF EXISTS public.exams_exam_id_seq;
DROP TABLE IF EXISTS public.exams;
DROP SEQUENCE IF EXISTS public.exam_schedules_schedule_id_seq;
DROP TABLE IF EXISTS public.exam_schedules;
DROP SEQUENCE IF EXISTS public.exam_cutoffs_cutoff_id_seq;
DROP TABLE IF EXISTS public.exam_cutoffs;
DROP SEQUENCE IF EXISTS public.education_loans_loan_id_seq;
DROP TABLE IF EXISTS public.education_loans;
DROP SEQUENCE IF EXISTS public.courses_course_id_seq;
DROP TABLE IF EXISTS public.courses;
DROP SEQUENCE IF EXISTS public.contact_queries_id_seq;
DROP TABLE IF EXISTS public.contact_queries;
DROP SEQUENCE IF EXISTS public.community_questions_question_id_seq;
DROP TABLE IF EXISTS public.community_questions;
DROP SEQUENCE IF EXISTS public.community_answers_answer_id_seq;
DROP TABLE IF EXISTS public.community_answers;
DROP SEQUENCE IF EXISTS public.colleges_college_id_seq;
DROP TABLE IF EXISTS public.colleges;
DROP SEQUENCE IF EXISTS public.college_rankings_ranking_id_seq;
DROP TABLE IF EXISTS public.college_rankings;
DROP SEQUENCE IF EXISTS public.college_media_media_id_seq;
DROP TABLE IF EXISTS public.college_media;
DROP SEQUENCE IF EXISTS public.college_facilities_facility_id_seq;
DROP TABLE IF EXISTS public.college_facilities;
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
-- Name: analytics; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA analytics;


ALTER SCHEMA analytics OWNER TO postgres;

--
-- Name: SCHEMA analytics; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA analytics IS 'Analytics, leads, tracking, payments';


--
-- Name: discovery; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA discovery;


ALTER SCHEMA discovery OWNER TO postgres;

--
-- Name: SCHEMA discovery; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA discovery IS 'Core discovery content (institutions, courses, exams, content)';


--
-- Name: geo_master; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA geo_master;


ALTER SCHEMA geo_master OWNER TO postgres;

--
-- Name: SCHEMA geo_master; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA geo_master IS 'Geographic master data (countries, states, cities)';


--
-- Name: cube; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS cube WITH SCHEMA public;


--
-- Name: EXTENSION cube; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION cube IS 'data type for multidimensional cubes';


--
-- Name: earthdistance; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS earthdistance WITH SCHEMA public;


--
-- Name: EXTENSION earthdistance; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION earthdistance IS 'calculate great-circle distances on the surface of the Earth';


--
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;


--
-- Name: EXTENSION pg_trgm; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: college_type_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.college_type_enum AS ENUM (
    'University',
    'College',
    'Institute',
    'Deemed University'
);


ALTER TYPE public.college_type_enum OWNER TO postgres;

--
-- Name: course_mode_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.course_mode_enum AS ENUM (
    'Full-time',
    'Part-time',
    'Distance',
    'Online',
    'Blended'
);


ALTER TYPE public.course_mode_enum OWNER TO postgres;

--
-- Name: cutoff_type_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.cutoff_type_enum AS ENUM (
    'Rank',
    'Score',
    'Percentile'
);


ALTER TYPE public.cutoff_type_enum OWNER TO postgres;

--
-- Name: degree_level_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.degree_level_enum AS ENUM (
    'Undergraduate',
    'Postgraduate',
    'Doctoral',
    'Diploma',
    'Certificate'
);


ALTER TYPE public.degree_level_enum OWNER TO postgres;

--
-- Name: exam_level_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.exam_level_enum AS ENUM (
    'National',
    'State',
    'University',
    'International'
);


ALTER TYPE public.exam_level_enum OWNER TO postgres;

--
-- Name: exam_mode_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.exam_mode_enum AS ENUM (
    'Online',
    'Offline',
    'Both'
);


ALTER TYPE public.exam_mode_enum OWNER TO postgres;

--
-- Name: ownership_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.ownership_enum AS ENUM (
    'Government',
    'Private',
    'Autonomous',
    'Public-Private'
);


ALTER TYPE public.ownership_enum OWNER TO postgres;

--
-- Name: payment_status_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.payment_status_enum AS ENUM (
    'initiated',
    'pending',
    'success',
    'failed',
    'refunded'
);


ALTER TYPE public.payment_status_enum OWNER TO postgres;

--
-- Name: review_status_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.review_status_enum AS ENUM (
    'pending',
    'approved',
    'rejected',
    'flagged'
);


ALTER TYPE public.review_status_enum OWNER TO postgres;

--
-- Name: user_status_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.user_status_enum AS ENUM (
    'active',
    'suspended',
    'banned',
    'deleted',
    'inactive'
);


ALTER TYPE public.user_status_enum OWNER TO postgres;

--
-- Name: user_type_enum; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.user_type_enum AS ENUM (
    'student',
    'parent',
    'counsellor',
    'admin',
    'institution'
);


ALTER TYPE public.user_type_enum OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: counselling_sessions; Type: TABLE; Schema: analytics; Owner: postgres
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


ALTER TABLE analytics.counselling_sessions OWNER TO postgres;

--
-- Name: counselling_sessions_id_seq; Type: SEQUENCE; Schema: analytics; Owner: postgres
--

CREATE SEQUENCE analytics.counselling_sessions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE analytics.counselling_sessions_id_seq OWNER TO postgres;

--
-- Name: counselling_sessions_id_seq; Type: SEQUENCE OWNED BY; Schema: analytics; Owner: postgres
--

ALTER SEQUENCE analytics.counselling_sessions_id_seq OWNED BY analytics.counselling_sessions.id;


--
-- Name: lead_notes; Type: TABLE; Schema: analytics; Owner: postgres
--

CREATE TABLE analytics.lead_notes (
    id bigint NOT NULL,
    lead_id bigint,
    user_id bigint,
    note text,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE analytics.lead_notes OWNER TO postgres;

--
-- Name: lead_notes_id_seq; Type: SEQUENCE; Schema: analytics; Owner: postgres
--

CREATE SEQUENCE analytics.lead_notes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE analytics.lead_notes_id_seq OWNER TO postgres;

--
-- Name: lead_notes_id_seq; Type: SEQUENCE OWNED BY; Schema: analytics; Owner: postgres
--

ALTER SEQUENCE analytics.lead_notes_id_seq OWNED BY analytics.lead_notes.id;


--
-- Name: leads; Type: TABLE; Schema: analytics; Owner: postgres
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


ALTER TABLE analytics.leads OWNER TO postgres;

--
-- Name: leads_id_seq; Type: SEQUENCE; Schema: analytics; Owner: postgres
--

CREATE SEQUENCE analytics.leads_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE analytics.leads_id_seq OWNER TO postgres;

--
-- Name: leads_id_seq; Type: SEQUENCE OWNED BY; Schema: analytics; Owner: postgres
--

ALTER SEQUENCE analytics.leads_id_seq OWNED BY analytics.leads.id;


--
-- Name: payments; Type: TABLE; Schema: analytics; Owner: postgres
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


ALTER TABLE analytics.payments OWNER TO postgres;

--
-- Name: payments_id_seq; Type: SEQUENCE; Schema: analytics; Owner: postgres
--

CREATE SEQUENCE analytics.payments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE analytics.payments_id_seq OWNER TO postgres;

--
-- Name: payments_id_seq; Type: SEQUENCE OWNED BY; Schema: analytics; Owner: postgres
--

ALTER SEQUENCE analytics.payments_id_seq OWNED BY analytics.payments.id;


--
-- Name: user_activity; Type: TABLE; Schema: analytics; Owner: postgres
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


ALTER TABLE analytics.user_activity OWNER TO postgres;

--
-- Name: user_activity_id_seq; Type: SEQUENCE; Schema: analytics; Owner: postgres
--

CREATE SEQUENCE analytics.user_activity_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE analytics.user_activity_id_seq OWNER TO postgres;

--
-- Name: user_activity_id_seq; Type: SEQUENCE OWNED BY; Schema: analytics; Owner: postgres
--

ALTER SEQUENCE analytics.user_activity_id_seq OWNED BY analytics.user_activity.id;


--
-- Name: application_documents; Type: TABLE; Schema: discovery; Owner: postgres
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


ALTER TABLE discovery.application_documents OWNER TO postgres;

--
-- Name: application_documents_id_seq; Type: SEQUENCE; Schema: discovery; Owner: postgres
--

CREATE SEQUENCE discovery.application_documents_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE discovery.application_documents_id_seq OWNER TO postgres;

--
-- Name: application_documents_id_seq; Type: SEQUENCE OWNED BY; Schema: discovery; Owner: postgres
--

ALTER SEQUENCE discovery.application_documents_id_seq OWNED BY discovery.application_documents.id;


--
-- Name: applications; Type: TABLE; Schema: discovery; Owner: postgres
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


ALTER TABLE discovery.applications OWNER TO postgres;

--
-- Name: applications_id_seq; Type: SEQUENCE; Schema: discovery; Owner: postgres
--

CREATE SEQUENCE discovery.applications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE discovery.applications_id_seq OWNER TO postgres;

--
-- Name: applications_id_seq; Type: SEQUENCE OWNED BY; Schema: discovery; Owner: postgres
--

ALTER SEQUENCE discovery.applications_id_seq OWNED BY discovery.applications.id;


--
-- Name: course_admissions; Type: TABLE; Schema: discovery; Owner: postgres
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


ALTER TABLE discovery.course_admissions OWNER TO postgres;

--
-- Name: course_admissions_id_seq; Type: SEQUENCE; Schema: discovery; Owner: postgres
--

CREATE SEQUENCE discovery.course_admissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE discovery.course_admissions_id_seq OWNER TO postgres;

--
-- Name: course_admissions_id_seq; Type: SEQUENCE OWNED BY; Schema: discovery; Owner: postgres
--

ALTER SEQUENCE discovery.course_admissions_id_seq OWNED BY discovery.course_admissions.id;


--
-- Name: course_fees; Type: TABLE; Schema: discovery; Owner: postgres
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


ALTER TABLE discovery.course_fees OWNER TO postgres;

--
-- Name: course_fees_id_seq; Type: SEQUENCE; Schema: discovery; Owner: postgres
--

CREATE SEQUENCE discovery.course_fees_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE discovery.course_fees_id_seq OWNER TO postgres;

--
-- Name: course_fees_id_seq; Type: SEQUENCE OWNED BY; Schema: discovery; Owner: postgres
--

ALTER SEQUENCE discovery.course_fees_id_seq OWNED BY discovery.course_fees.id;


--
-- Name: course_specializations; Type: TABLE; Schema: discovery; Owner: postgres
--

CREATE TABLE discovery.course_specializations (
    id integer NOT NULL,
    institution_course_id integer,
    name character varying(255) NOT NULL,
    seats integer
);


ALTER TABLE discovery.course_specializations OWNER TO postgres;

--
-- Name: course_specializations_id_seq; Type: SEQUENCE; Schema: discovery; Owner: postgres
--

CREATE SEQUENCE discovery.course_specializations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE discovery.course_specializations_id_seq OWNER TO postgres;

--
-- Name: course_specializations_id_seq; Type: SEQUENCE OWNED BY; Schema: discovery; Owner: postgres
--

ALTER SEQUENCE discovery.course_specializations_id_seq OWNED BY discovery.course_specializations.id;


--
-- Name: facilities; Type: TABLE; Schema: discovery; Owner: postgres
--

CREATE TABLE discovery.facilities (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE discovery.facilities OWNER TO postgres;

--
-- Name: facilities_id_seq; Type: SEQUENCE; Schema: discovery; Owner: postgres
--

CREATE SEQUENCE discovery.facilities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE discovery.facilities_id_seq OWNER TO postgres;

--
-- Name: facilities_id_seq; Type: SEQUENCE OWNED BY; Schema: discovery; Owner: postgres
--

ALTER SEQUENCE discovery.facilities_id_seq OWNED BY discovery.facilities.id;


--
-- Name: institution_affiliations; Type: TABLE; Schema: discovery; Owner: postgres
--

CREATE TABLE discovery.institution_affiliations (
    id integer NOT NULL,
    institution_id integer,
    affiliated_to character varying(255),
    notes text
);


ALTER TABLE discovery.institution_affiliations OWNER TO postgres;

--
-- Name: institution_affiliations_id_seq; Type: SEQUENCE; Schema: discovery; Owner: postgres
--

CREATE SEQUENCE discovery.institution_affiliations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE discovery.institution_affiliations_id_seq OWNER TO postgres;

--
-- Name: institution_affiliations_id_seq; Type: SEQUENCE OWNED BY; Schema: discovery; Owner: postgres
--

ALTER SEQUENCE discovery.institution_affiliations_id_seq OWNED BY discovery.institution_affiliations.id;


--
-- Name: institution_approvals; Type: TABLE; Schema: discovery; Owner: postgres
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


ALTER TABLE discovery.institution_approvals OWNER TO postgres;

--
-- Name: institution_approvals_id_seq; Type: SEQUENCE; Schema: discovery; Owner: postgres
--

CREATE SEQUENCE discovery.institution_approvals_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE discovery.institution_approvals_id_seq OWNER TO postgres;

--
-- Name: institution_approvals_id_seq; Type: SEQUENCE OWNED BY; Schema: discovery; Owner: postgres
--

ALTER SEQUENCE discovery.institution_approvals_id_seq OWNED BY discovery.institution_approvals.id;


--
-- Name: institution_brochures; Type: TABLE; Schema: discovery; Owner: postgres
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


ALTER TABLE discovery.institution_brochures OWNER TO postgres;

--
-- Name: institution_brochures_id_seq; Type: SEQUENCE; Schema: discovery; Owner: postgres
--

CREATE SEQUENCE discovery.institution_brochures_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE discovery.institution_brochures_id_seq OWNER TO postgres;

--
-- Name: institution_brochures_id_seq; Type: SEQUENCE OWNED BY; Schema: discovery; Owner: postgres
--

ALTER SEQUENCE discovery.institution_brochures_id_seq OWNED BY discovery.institution_brochures.id;


--
-- Name: institution_courses; Type: TABLE; Schema: discovery; Owner: postgres
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


ALTER TABLE discovery.institution_courses OWNER TO postgres;

--
-- Name: institution_courses_id_seq; Type: SEQUENCE; Schema: discovery; Owner: postgres
--

CREATE SEQUENCE discovery.institution_courses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE discovery.institution_courses_id_seq OWNER TO postgres;

--
-- Name: institution_courses_id_seq; Type: SEQUENCE OWNED BY; Schema: discovery; Owner: postgres
--

ALTER SEQUENCE discovery.institution_courses_id_seq OWNED BY discovery.institution_courses.id;


--
-- Name: institution_facilities; Type: TABLE; Schema: discovery; Owner: postgres
--

CREATE TABLE discovery.institution_facilities (
    institution_id integer NOT NULL,
    facility_id integer NOT NULL,
    details text
);


ALTER TABLE discovery.institution_facilities OWNER TO postgres;

--
-- Name: institution_highlights; Type: TABLE; Schema: discovery; Owner: postgres
--

CREATE TABLE discovery.institution_highlights (
    id integer NOT NULL,
    institution_id integer,
    title character varying(255),
    value text
);


ALTER TABLE discovery.institution_highlights OWNER TO postgres;

--
-- Name: institution_highlights_id_seq; Type: SEQUENCE; Schema: discovery; Owner: postgres
--

CREATE SEQUENCE discovery.institution_highlights_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE discovery.institution_highlights_id_seq OWNER TO postgres;

--
-- Name: institution_highlights_id_seq; Type: SEQUENCE OWNED BY; Schema: discovery; Owner: postgres
--

ALTER SEQUENCE discovery.institution_highlights_id_seq OWNED BY discovery.institution_highlights.id;


--
-- Name: institution_videos; Type: TABLE; Schema: discovery; Owner: postgres
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


ALTER TABLE discovery.institution_videos OWNER TO postgres;

--
-- Name: institution_videos_id_seq; Type: SEQUENCE; Schema: discovery; Owner: postgres
--

CREATE SEQUENCE discovery.institution_videos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE discovery.institution_videos_id_seq OWNER TO postgres;

--
-- Name: institution_videos_id_seq; Type: SEQUENCE OWNED BY; Schema: discovery; Owner: postgres
--

ALTER SEQUENCE discovery.institution_videos_id_seq OWNED BY discovery.institution_videos.id;


--
-- Name: qna; Type: TABLE; Schema: discovery; Owner: postgres
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


ALTER TABLE discovery.qna OWNER TO postgres;

--
-- Name: qna_id_seq; Type: SEQUENCE; Schema: discovery; Owner: postgres
--

CREATE SEQUENCE discovery.qna_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE discovery.qna_id_seq OWNER TO postgres;

--
-- Name: qna_id_seq; Type: SEQUENCE OWNED BY; Schema: discovery; Owner: postgres
--

ALTER SEQUENCE discovery.qna_id_seq OWNED BY discovery.qna.id;


--
-- Name: qna_votes; Type: TABLE; Schema: discovery; Owner: postgres
--

CREATE TABLE discovery.qna_votes (
    id integer NOT NULL,
    qna_id integer,
    user_id bigint,
    is_helpful boolean,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE discovery.qna_votes OWNER TO postgres;

--
-- Name: qna_votes_id_seq; Type: SEQUENCE; Schema: discovery; Owner: postgres
--

CREATE SEQUENCE discovery.qna_votes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE discovery.qna_votes_id_seq OWNER TO postgres;

--
-- Name: qna_votes_id_seq; Type: SEQUENCE OWNED BY; Schema: discovery; Owner: postgres
--

ALTER SEQUENCE discovery.qna_votes_id_seq OWNED BY discovery.qna_votes.id;


--
-- Name: recruiter_companies; Type: TABLE; Schema: discovery; Owner: postgres
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


ALTER TABLE discovery.recruiter_companies OWNER TO postgres;

--
-- Name: recruiter_companies_id_seq; Type: SEQUENCE; Schema: discovery; Owner: postgres
--

CREATE SEQUENCE discovery.recruiter_companies_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE discovery.recruiter_companies_id_seq OWNER TO postgres;

--
-- Name: recruiter_companies_id_seq; Type: SEQUENCE OWNED BY; Schema: discovery; Owner: postgres
--

ALTER SEQUENCE discovery.recruiter_companies_id_seq OWNED BY discovery.recruiter_companies.id;


--
-- Name: review_moderation; Type: TABLE; Schema: discovery; Owner: postgres
--

CREATE TABLE discovery.review_moderation (
    id integer NOT NULL,
    review_id integer,
    status character varying(50) DEFAULT 'pending'::character varying,
    moderated_by bigint,
    comments text,
    moderated_at timestamp without time zone
);


ALTER TABLE discovery.review_moderation OWNER TO postgres;

--
-- Name: review_moderation_id_seq; Type: SEQUENCE; Schema: discovery; Owner: postgres
--

CREATE SEQUENCE discovery.review_moderation_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE discovery.review_moderation_id_seq OWNER TO postgres;

--
-- Name: review_moderation_id_seq; Type: SEQUENCE OWNED BY; Schema: discovery; Owner: postgres
--

ALTER SEQUENCE discovery.review_moderation_id_seq OWNED BY discovery.review_moderation.id;


--
-- Name: seo_metadata; Type: TABLE; Schema: discovery; Owner: postgres
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


ALTER TABLE discovery.seo_metadata OWNER TO postgres;

--
-- Name: seo_metadata_id_seq; Type: SEQUENCE; Schema: discovery; Owner: postgres
--

CREATE SEQUENCE discovery.seo_metadata_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE discovery.seo_metadata_id_seq OWNER TO postgres;

--
-- Name: seo_metadata_id_seq; Type: SEQUENCE OWNED BY; Schema: discovery; Owner: postgres
--

ALTER SEQUENCE discovery.seo_metadata_id_seq OWNED BY discovery.seo_metadata.id;


--
-- Name: streams; Type: TABLE; Schema: discovery; Owner: postgres
--

CREATE TABLE discovery.streams (
    id integer NOT NULL,
    name character varying(150) NOT NULL,
    description text
);


ALTER TABLE discovery.streams OWNER TO postgres;

--
-- Name: streams_id_seq; Type: SEQUENCE; Schema: discovery; Owner: postgres
--

CREATE SEQUENCE discovery.streams_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE discovery.streams_id_seq OWNER TO postgres;

--
-- Name: streams_id_seq; Type: SEQUENCE OWNED BY; Schema: discovery; Owner: postgres
--

ALTER SEQUENCE discovery.streams_id_seq OWNED BY discovery.streams.id;


--
-- Name: user_favorites; Type: TABLE; Schema: discovery; Owner: postgres
--

CREATE TABLE discovery.user_favorites (
    user_id bigint NOT NULL,
    entity_type character varying(50) NOT NULL,
    entity_id integer NOT NULL,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE discovery.user_favorites OWNER TO postgres;

--
-- Name: cities; Type: TABLE; Schema: geo_master; Owner: postgres
--

CREATE TABLE geo_master.cities (
    city_id integer NOT NULL,
    state_id integer,
    city_name character varying(100) NOT NULL,
    population integer,
    is_metro boolean DEFAULT false
);


ALTER TABLE geo_master.cities OWNER TO postgres;

--
-- Name: cities_city_id_seq; Type: SEQUENCE; Schema: geo_master; Owner: postgres
--

CREATE SEQUENCE geo_master.cities_city_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE geo_master.cities_city_id_seq OWNER TO postgres;

--
-- Name: cities_city_id_seq; Type: SEQUENCE OWNED BY; Schema: geo_master; Owner: postgres
--

ALTER SEQUENCE geo_master.cities_city_id_seq OWNED BY geo_master.cities.city_id;


--
-- Name: countries; Type: TABLE; Schema: geo_master; Owner: postgres
--

CREATE TABLE geo_master.countries (
    country_id integer NOT NULL,
    country_name character varying(100) NOT NULL,
    country_code character varying(5) NOT NULL,
    currency character varying(10),
    is_study_destination boolean DEFAULT false
);


ALTER TABLE geo_master.countries OWNER TO postgres;

--
-- Name: countries_country_id_seq; Type: SEQUENCE; Schema: geo_master; Owner: postgres
--

CREATE SEQUENCE geo_master.countries_country_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE geo_master.countries_country_id_seq OWNER TO postgres;

--
-- Name: countries_country_id_seq; Type: SEQUENCE OWNED BY; Schema: geo_master; Owner: postgres
--

ALTER SEQUENCE geo_master.countries_country_id_seq OWNED BY geo_master.countries.country_id;


--
-- Name: states; Type: TABLE; Schema: geo_master; Owner: postgres
--

CREATE TABLE geo_master.states (
    state_id integer NOT NULL,
    country_id integer,
    state_name character varying(100) NOT NULL,
    state_code character varying(10)
);


ALTER TABLE geo_master.states OWNER TO postgres;

--
-- Name: states_state_id_seq; Type: SEQUENCE; Schema: geo_master; Owner: postgres
--

CREATE SEQUENCE geo_master.states_state_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE geo_master.states_state_id_seq OWNER TO postgres;

--
-- Name: states_state_id_seq; Type: SEQUENCE OWNED BY; Schema: geo_master; Owner: postgres
--

ALTER SEQUENCE geo_master.states_state_id_seq OWNED BY geo_master.states.state_id;


--
-- Name: admin_audit_logs; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.admin_audit_logs OWNER TO postgres;

--
-- Name: admin_audit_logs_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.admin_audit_logs_log_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.admin_audit_logs_log_id_seq OWNER TO postgres;

--
-- Name: admin_audit_logs_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.admin_audit_logs_log_id_seq OWNED BY public.admin_audit_logs.log_id;


--
-- Name: admin_sessions; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.admin_sessions OWNER TO postgres;

--
-- Name: admin_sessions_session_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.admin_sessions_session_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.admin_sessions_session_id_seq OWNER TO postgres;

--
-- Name: admin_sessions_session_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.admin_sessions_session_id_seq OWNED BY public.admin_sessions.session_id;


--
-- Name: admin_users; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.admin_users OWNER TO postgres;

--
-- Name: admin_users_admin_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.admin_users_admin_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.admin_users_admin_id_seq OWNER TO postgres;

--
-- Name: admin_users_admin_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.admin_users_admin_id_seq OWNED BY public.admin_users.admin_id;


--
-- Name: audit_log; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.audit_log OWNER TO postgres;

--
-- Name: audit_log_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.audit_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.audit_log_id_seq OWNER TO postgres;

--
-- Name: audit_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.audit_log_id_seq OWNED BY public.audit_log.id;


--
-- Name: banner_analytics; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.banner_analytics OWNER TO postgres;

--
-- Name: banner_analytics_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.banner_analytics_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.banner_analytics_id_seq OWNER TO postgres;

--
-- Name: banner_analytics_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.banner_analytics_id_seq OWNED BY public.banner_analytics.id;


--
-- Name: banners; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.banners OWNER TO postgres;

--
-- Name: banners_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.banners_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.banners_id_seq OWNER TO postgres;

--
-- Name: banners_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.banners_id_seq OWNED BY public.banners.id;


--
-- Name: college_facilities; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.college_facilities (
    facility_id bigint NOT NULL,
    college_id bigint NOT NULL,
    facility_type character varying(100) NOT NULL,
    facility_name character varying(200),
    description text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.college_facilities OWNER TO postgres;

--
-- Name: college_facilities_facility_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.college_facilities_facility_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.college_facilities_facility_id_seq OWNER TO postgres;

--
-- Name: college_facilities_facility_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.college_facilities_facility_id_seq OWNED BY public.college_facilities.facility_id;


--
-- Name: college_media; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.college_media (
    media_id bigint NOT NULL,
    college_id bigint NOT NULL,
    media_type character varying(50),
    media_url text NOT NULL,
    title character varying(300),
    uploaded_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.college_media OWNER TO postgres;

--
-- Name: college_media_media_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.college_media_media_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.college_media_media_id_seq OWNER TO postgres;

--
-- Name: college_media_media_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.college_media_media_id_seq OWNED BY public.college_media.media_id;


--
-- Name: college_rankings; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.college_rankings OWNER TO postgres;

--
-- Name: college_rankings_ranking_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.college_rankings_ranking_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.college_rankings_ranking_id_seq OWNER TO postgres;

--
-- Name: college_rankings_ranking_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.college_rankings_ranking_id_seq OWNED BY public.college_rankings.ranking_id;


--
-- Name: colleges; Type: TABLE; Schema: public; Owner: postgres
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
    is_popular boolean DEFAULT false
);


ALTER TABLE public.colleges OWNER TO postgres;

--
-- Name: colleges_college_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.colleges_college_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.colleges_college_id_seq OWNER TO postgres;

--
-- Name: colleges_college_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.colleges_college_id_seq OWNED BY public.colleges.college_id;


--
-- Name: community_answers; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.community_answers OWNER TO postgres;

--
-- Name: community_answers_answer_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.community_answers_answer_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.community_answers_answer_id_seq OWNER TO postgres;

--
-- Name: community_answers_answer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.community_answers_answer_id_seq OWNED BY public.community_answers.answer_id;


--
-- Name: community_questions; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.community_questions OWNER TO postgres;

--
-- Name: community_questions_question_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.community_questions_question_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.community_questions_question_id_seq OWNER TO postgres;

--
-- Name: community_questions_question_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.community_questions_question_id_seq OWNED BY public.community_questions.question_id;


--
-- Name: contact_queries; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.contact_queries OWNER TO postgres;

--
-- Name: contact_queries_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.contact_queries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.contact_queries_id_seq OWNER TO postgres;

--
-- Name: contact_queries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.contact_queries_id_seq OWNED BY public.contact_queries.id;


--
-- Name: courses; Type: TABLE; Schema: public; Owner: postgres
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
    deleted_at timestamp without time zone
);


ALTER TABLE public.courses OWNER TO postgres;

--
-- Name: courses_course_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.courses_course_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.courses_course_id_seq OWNER TO postgres;

--
-- Name: courses_course_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.courses_course_id_seq OWNED BY public.courses.course_id;


--
-- Name: education_loans; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.education_loans OWNER TO postgres;

--
-- Name: education_loans_loan_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.education_loans_loan_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.education_loans_loan_id_seq OWNER TO postgres;

--
-- Name: education_loans_loan_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.education_loans_loan_id_seq OWNED BY public.education_loans.loan_id;


--
-- Name: exam_cutoffs; Type: TABLE; Schema: public; Owner: postgres
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
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.exam_cutoffs OWNER TO postgres;

--
-- Name: exam_cutoffs_cutoff_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.exam_cutoffs_cutoff_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.exam_cutoffs_cutoff_id_seq OWNER TO postgres;

--
-- Name: exam_cutoffs_cutoff_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.exam_cutoffs_cutoff_id_seq OWNED BY public.exam_cutoffs.cutoff_id;


--
-- Name: exam_schedules; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.exam_schedules OWNER TO postgres;

--
-- Name: exam_schedules_schedule_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.exam_schedules_schedule_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.exam_schedules_schedule_id_seq OWNER TO postgres;

--
-- Name: exam_schedules_schedule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.exam_schedules_schedule_id_seq OWNED BY public.exam_schedules.schedule_id;


--
-- Name: exams; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.exams OWNER TO postgres;

--
-- Name: exams_exam_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.exams_exam_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.exams_exam_id_seq OWNER TO postgres;

--
-- Name: exams_exam_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.exams_exam_id_seq OWNED BY public.exams.exam_id;


--
-- Name: faqs; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.faqs OWNER TO postgres;

--
-- Name: faqs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.faqs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.faqs_id_seq OWNER TO postgres;

--
-- Name: faqs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.faqs_id_seq OWNED BY public.faqs.id;


--
-- Name: institute_accounts; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.institute_accounts OWNER TO postgres;

--
-- Name: institute_accounts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.institute_accounts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.institute_accounts_id_seq OWNER TO postgres;

--
-- Name: institute_accounts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.institute_accounts_id_seq OWNED BY public.institute_accounts.id;


--
-- Name: institute_users; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.institute_users OWNER TO postgres;

--
-- Name: institute_users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.institute_users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.institute_users_id_seq OWNER TO postgres;

--
-- Name: institute_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.institute_users_id_seq OWNED BY public.institute_users.id;


--
-- Name: job_postings; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.job_postings OWNER TO postgres;

--
-- Name: job_postings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.job_postings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.job_postings_id_seq OWNER TO postgres;

--
-- Name: job_postings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.job_postings_id_seq OWNED BY public.job_postings.id;


--
-- Name: news_articles; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.news_articles OWNER TO postgres;

--
-- Name: news_articles_article_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.news_articles_article_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.news_articles_article_id_seq OWNER TO postgres;

--
-- Name: news_articles_article_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.news_articles_article_id_seq OWNED BY public.news_articles.article_id;


--
-- Name: newsletter_subscribers; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.newsletter_subscribers OWNER TO postgres;

--
-- Name: newsletter_subscribers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.newsletter_subscribers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.newsletter_subscribers_id_seq OWNER TO postgres;

--
-- Name: newsletter_subscribers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.newsletter_subscribers_id_seq OWNED BY public.newsletter_subscribers.id;


--
-- Name: notification_preferences; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.notification_preferences OWNER TO postgres;

--
-- Name: notification_preferences_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.notification_preferences_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.notification_preferences_id_seq OWNER TO postgres;

--
-- Name: notification_preferences_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.notification_preferences_id_seq OWNED BY public.notification_preferences.id;


--
-- Name: notifications; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.notifications OWNER TO postgres;

--
-- Name: notifications_notification_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.notifications_notification_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.notifications_notification_id_seq OWNER TO postgres;

--
-- Name: notifications_notification_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.notifications_notification_id_seq OWNED BY public.notifications.notification_id;


--
-- Name: password_resets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.password_resets (
    id bigint NOT NULL,
    user_id bigint,
    otp_code character varying(20),
    expires_at timestamp without time zone,
    used boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.password_resets OWNER TO postgres;

--
-- Name: password_resets_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.password_resets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.password_resets_id_seq OWNER TO postgres;

--
-- Name: password_resets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.password_resets_id_seq OWNED BY public.password_resets.id;


--
-- Name: payments; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.payments OWNER TO postgres;

--
-- Name: payments_payment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.payments_payment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payments_payment_id_seq OWNER TO postgres;

--
-- Name: payments_payment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.payments_payment_id_seq OWNED BY public.payments.payment_id;


--
-- Name: placements; Type: TABLE; Schema: public; Owner: postgres
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
    deleted_at timestamp without time zone
);


ALTER TABLE public.placements OWNER TO postgres;

--
-- Name: placements_placement_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.placements_placement_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.placements_placement_id_seq OWNER TO postgres;

--
-- Name: placements_placement_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.placements_placement_id_seq OWNED BY public.placements.placement_id;


--
-- Name: questions; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.questions OWNER TO postgres;

--
-- Name: questions_question_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.questions_question_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.questions_question_id_seq OWNER TO postgres;

--
-- Name: questions_question_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.questions_question_id_seq OWNED BY public.questions.question_id;


--
-- Name: ranking_agencies; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.ranking_agencies OWNER TO postgres;

--
-- Name: ranking_agencies_agency_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ranking_agencies_agency_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ranking_agencies_agency_id_seq OWNER TO postgres;

--
-- Name: ranking_agencies_agency_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ranking_agencies_agency_id_seq OWNED BY public.ranking_agencies.agency_id;


--
-- Name: reviews; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.reviews OWNER TO postgres;

--
-- Name: reviews_review_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reviews_review_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reviews_review_id_seq OWNER TO postgres;

--
-- Name: reviews_review_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reviews_review_id_seq OWNED BY public.reviews.review_id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    id bigint NOT NULL,
    name character varying(100) NOT NULL,
    description text
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.roles_id_seq OWNER TO postgres;

--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- Name: saved_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.saved_items (
    saved_id bigint NOT NULL,
    user_id bigint NOT NULL,
    item_type character varying(50) NOT NULL,
    item_id bigint NOT NULL,
    notes text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.saved_items OWNER TO postgres;

--
-- Name: saved_items_saved_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.saved_items_saved_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.saved_items_saved_id_seq OWNER TO postgres;

--
-- Name: saved_items_saved_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.saved_items_saved_id_seq OWNED BY public.saved_items.saved_id;


--
-- Name: scholarships; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.scholarships OWNER TO postgres;

--
-- Name: scholarships_scholarship_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.scholarships_scholarship_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.scholarships_scholarship_id_seq OWNER TO postgres;

--
-- Name: scholarships_scholarship_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.scholarships_scholarship_id_seq OWNED BY public.scholarships.scholarship_id;


--
-- Name: search_logs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.search_logs (
    search_id bigint NOT NULL,
    user_id bigint,
    search_query text NOT NULL,
    search_type character varying(50),
    results_count integer,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.search_logs OWNER TO postgres;

--
-- Name: search_logs_search_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.search_logs_search_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.search_logs_search_id_seq OWNER TO postgres;

--
-- Name: search_logs_search_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.search_logs_search_id_seq OWNED BY public.search_logs.search_id;


--
-- Name: site_notifications; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.site_notifications OWNER TO postgres;

--
-- Name: site_notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.site_notifications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.site_notifications_id_seq OWNER TO postgres;

--
-- Name: site_notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.site_notifications_id_seq OWNED BY public.site_notifications.id;


--
-- Name: system_settings; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.system_settings OWNER TO postgres;

--
-- Name: system_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.system_settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.system_settings_id_seq OWNER TO postgres;

--
-- Name: system_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.system_settings_id_seq OWNED BY public.system_settings.id;


--
-- Name: team_members; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.team_members OWNER TO postgres;

--
-- Name: team_members_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.team_members_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.team_members_id_seq OWNER TO postgres;

--
-- Name: team_members_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.team_members_id_seq OWNED BY public.team_members.id;


--
-- Name: test_attempts; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.test_attempts OWNER TO postgres;

--
-- Name: test_attempts_attempt_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.test_attempts_attempt_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.test_attempts_attempt_id_seq OWNER TO postgres;

--
-- Name: test_attempts_attempt_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.test_attempts_attempt_id_seq OWNED BY public.test_attempts.attempt_id;


--
-- Name: test_series; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.test_series OWNER TO postgres;

--
-- Name: test_series_series_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.test_series_series_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.test_series_series_id_seq OWNER TO postgres;

--
-- Name: test_series_series_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.test_series_series_id_seq OWNED BY public.test_series.series_id;


--
-- Name: testimonials; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.testimonials OWNER TO postgres;

--
-- Name: testimonials_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.testimonials_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.testimonials_id_seq OWNER TO postgres;

--
-- Name: testimonials_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.testimonials_id_seq OWNED BY public.testimonials.id;


--
-- Name: tests; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.tests OWNER TO postgres;

--
-- Name: tests_test_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tests_test_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tests_test_id_seq OWNER TO postgres;

--
-- Name: tests_test_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tests_test_id_seq OWNED BY public.tests.test_id;


--
-- Name: user_consents; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_consents (
    id integer NOT NULL,
    user_id bigint,
    consent_type character varying(100),
    consented boolean,
    ip_address character varying(50),
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.user_consents OWNER TO postgres;

--
-- Name: user_consents_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_consents_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_consents_id_seq OWNER TO postgres;

--
-- Name: user_consents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_consents_id_seq OWNED BY public.user_consents.id;


--
-- Name: user_profiles; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.user_profiles OWNER TO postgres;

--
-- Name: user_profiles_profile_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_profiles_profile_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_profiles_profile_id_seq OWNER TO postgres;

--
-- Name: user_profiles_profile_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_profiles_profile_id_seq OWNED BY public.user_profiles.profile_id;


--
-- Name: user_roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_roles (
    user_id bigint NOT NULL,
    role_id bigint NOT NULL
);


ALTER TABLE public.user_roles OWNER TO postgres;

--
-- Name: user_sessions; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.user_sessions OWNER TO postgres;

--
-- Name: user_verifications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_verifications (
    id bigint NOT NULL,
    user_id bigint,
    code character varying(20) NOT NULL,
    type character varying(20) NOT NULL,
    expires_at timestamp without time zone NOT NULL,
    consumed boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT user_verifications_type_check CHECK (((type)::text = ANY ((ARRAY['email'::character varying, 'phone'::character varying])::text[])))
);


ALTER TABLE public.user_verifications OWNER TO postgres;

--
-- Name: user_verifications_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_verifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_verifications_id_seq OWNER TO postgres;

--
-- Name: user_verifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_verifications_id_seq OWNED BY public.user_verifications.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
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


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_user_id_seq OWNER TO postgres;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: counselling_sessions id; Type: DEFAULT; Schema: analytics; Owner: postgres
--

ALTER TABLE ONLY analytics.counselling_sessions ALTER COLUMN id SET DEFAULT nextval('analytics.counselling_sessions_id_seq'::regclass);


--
-- Name: lead_notes id; Type: DEFAULT; Schema: analytics; Owner: postgres
--

ALTER TABLE ONLY analytics.lead_notes ALTER COLUMN id SET DEFAULT nextval('analytics.lead_notes_id_seq'::regclass);


--
-- Name: leads id; Type: DEFAULT; Schema: analytics; Owner: postgres
--

ALTER TABLE ONLY analytics.leads ALTER COLUMN id SET DEFAULT nextval('analytics.leads_id_seq'::regclass);


--
-- Name: payments id; Type: DEFAULT; Schema: analytics; Owner: postgres
--

ALTER TABLE ONLY analytics.payments ALTER COLUMN id SET DEFAULT nextval('analytics.payments_id_seq'::regclass);


--
-- Name: user_activity id; Type: DEFAULT; Schema: analytics; Owner: postgres
--

ALTER TABLE ONLY analytics.user_activity ALTER COLUMN id SET DEFAULT nextval('analytics.user_activity_id_seq'::regclass);


--
-- Name: application_documents id; Type: DEFAULT; Schema: discovery; Owner: postgres
--

ALTER TABLE ONLY discovery.application_documents ALTER COLUMN id SET DEFAULT nextval('discovery.application_documents_id_seq'::regclass);


--
-- Name: applications id; Type: DEFAULT; Schema: discovery; Owner: postgres
--

ALTER TABLE ONLY discovery.applications ALTER COLUMN id SET DEFAULT nextval('discovery.applications_id_seq'::regclass);


--
-- Name: course_admissions id; Type: DEFAULT; Schema: discovery; Owner: postgres
--

ALTER TABLE ONLY discovery.course_admissions ALTER COLUMN id SET DEFAULT nextval('discovery.course_admissions_id_seq'::regclass);


--
-- Name: course_fees id; Type: DEFAULT; Schema: discovery; Owner: postgres
--

ALTER TABLE ONLY discovery.course_fees ALTER COLUMN id SET DEFAULT nextval('discovery.course_fees_id_seq'::regclass);


--
-- Name: course_specializations id; Type: DEFAULT; Schema: discovery; Owner: postgres
--

ALTER TABLE ONLY discovery.course_specializations ALTER COLUMN id SET DEFAULT nextval('discovery.course_specializations_id_seq'::regclass);


--
-- Name: facilities id; Type: DEFAULT; Schema: discovery; Owner: postgres
--

ALTER TABLE ONLY discovery.facilities ALTER COLUMN id SET DEFAULT nextval('discovery.facilities_id_seq'::regclass);


--
-- Name: institution_affiliations id; Type: DEFAULT; Schema: discovery; Owner: postgres
--

ALTER TABLE ONLY discovery.institution_affiliations ALTER COLUMN id SET DEFAULT nextval('discovery.institution_affiliations_id_seq'::regclass);


--
-- Name: institution_approvals id; Type: DEFAULT; Schema: discovery; Owner: postgres
--

ALTER TABLE ONLY discovery.institution_approvals ALTER COLUMN id SET DEFAULT nextval('discovery.institution_approvals_id_seq'::regclass);


--
-- Name: institution_brochures id; Type: DEFAULT; Schema: discovery; Owner: postgres
--

ALTER TABLE ONLY discovery.institution_brochures ALTER COLUMN id SET DEFAULT nextval('discovery.institution_brochures_id_seq'::regclass);


--
-- Name: institution_courses id; Type: DEFAULT; Schema: discovery; Owner: postgres
--

ALTER TABLE ONLY discovery.institution_courses ALTER COLUMN id SET DEFAULT nextval('discovery.institution_courses_id_seq'::regclass);


--
-- Name: institution_highlights id; Type: DEFAULT; Schema: discovery; Owner: postgres
--

ALTER TABLE ONLY discovery.institution_highlights ALTER COLUMN id SET DEFAULT nextval('discovery.institution_highlights_id_seq'::regclass);


--
-- Name: institution_videos id; Type: DEFAULT; Schema: discovery; Owner: postgres
--

ALTER TABLE ONLY discovery.institution_videos ALTER COLUMN id SET DEFAULT nextval('discovery.institution_videos_id_seq'::regclass);


--
-- Name: qna id; Type: DEFAULT; Schema: discovery; Owner: postgres
--

ALTER TABLE ONLY discovery.qna ALTER COLUMN id SET DEFAULT nextval('discovery.qna_id_seq'::regclass);


--
-- Name: qna_votes id; Type: DEFAULT; Schema: discovery; Owner: postgres
--

ALTER TABLE ONLY discovery.qna_votes ALTER COLUMN id SET DEFAULT nextval('discovery.qna_votes_id_seq'::regclass);


--
-- Name: recruiter_companies id; Type: DEFAULT; Schema: discovery; Owner: postgres
--

ALTER TABLE ONLY discovery.recruiter_companies ALTER COLUMN id SET DEFAULT nextval('discovery.recruiter_companies_id_seq'::regclass);


--
-- Name: review_moderation id; Type: DEFAULT; Schema: discovery; Owner: postgres
--

ALTER TABLE ONLY discovery.review_moderation ALTER COLUMN id SET DEFAULT nextval('discovery.review_moderation_id_seq'::regclass);


--
-- Name: seo_metadata id; Type: DEFAULT; Schema: discovery; Owner: postgres
--

ALTER TABLE ONLY discovery.seo_metadata ALTER COLUMN id SET DEFAULT nextval('discovery.seo_metadata_id_seq'::regclass);


--
-- Name: streams id; Type: DEFAULT; Schema: discovery; Owner: postgres
--

ALTER TABLE ONLY discovery.streams ALTER COLUMN id SET DEFAULT nextval('discovery.streams_id_seq'::regclass);


--
-- Name: cities city_id; Type: DEFAULT; Schema: geo_master; Owner: postgres
--

ALTER TABLE ONLY geo_master.cities ALTER COLUMN city_id SET DEFAULT nextval('geo_master.cities_city_id_seq'::regclass);


--
-- Name: countries country_id; Type: DEFAULT; Schema: geo_master; Owner: postgres
--

ALTER TABLE ONLY geo_master.countries ALTER COLUMN country_id SET DEFAULT nextval('geo_master.countries_country_id_seq'::regclass);


--
-- Name: states state_id; Type: DEFAULT; Schema: geo_master; Owner: postgres
--

ALTER TABLE ONLY geo_master.states ALTER COLUMN state_id SET DEFAULT nextval('geo_master.states_state_id_seq'::regclass);


--
-- Name: admin_audit_logs log_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_audit_logs ALTER COLUMN log_id SET DEFAULT nextval('public.admin_audit_logs_log_id_seq'::regclass);


--
-- Name: admin_sessions session_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_sessions ALTER COLUMN session_id SET DEFAULT nextval('public.admin_sessions_session_id_seq'::regclass);


--
-- Name: admin_users admin_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_users ALTER COLUMN admin_id SET DEFAULT nextval('public.admin_users_admin_id_seq'::regclass);


--
-- Name: audit_log id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.audit_log ALTER COLUMN id SET DEFAULT nextval('public.audit_log_id_seq'::regclass);


--
-- Name: banner_analytics id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.banner_analytics ALTER COLUMN id SET DEFAULT nextval('public.banner_analytics_id_seq'::regclass);


--
-- Name: banners id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.banners ALTER COLUMN id SET DEFAULT nextval('public.banners_id_seq'::regclass);


--
-- Name: college_facilities facility_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.college_facilities ALTER COLUMN facility_id SET DEFAULT nextval('public.college_facilities_facility_id_seq'::regclass);


--
-- Name: college_media media_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.college_media ALTER COLUMN media_id SET DEFAULT nextval('public.college_media_media_id_seq'::regclass);


--
-- Name: college_rankings ranking_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.college_rankings ALTER COLUMN ranking_id SET DEFAULT nextval('public.college_rankings_ranking_id_seq'::regclass);


--
-- Name: colleges college_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.colleges ALTER COLUMN college_id SET DEFAULT nextval('public.colleges_college_id_seq'::regclass);


--
-- Name: community_answers answer_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.community_answers ALTER COLUMN answer_id SET DEFAULT nextval('public.community_answers_answer_id_seq'::regclass);


--
-- Name: community_questions question_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.community_questions ALTER COLUMN question_id SET DEFAULT nextval('public.community_questions_question_id_seq'::regclass);


--
-- Name: contact_queries id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contact_queries ALTER COLUMN id SET DEFAULT nextval('public.contact_queries_id_seq'::regclass);


--
-- Name: courses course_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.courses ALTER COLUMN course_id SET DEFAULT nextval('public.courses_course_id_seq'::regclass);


--
-- Name: education_loans loan_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.education_loans ALTER COLUMN loan_id SET DEFAULT nextval('public.education_loans_loan_id_seq'::regclass);


--
-- Name: exam_cutoffs cutoff_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exam_cutoffs ALTER COLUMN cutoff_id SET DEFAULT nextval('public.exam_cutoffs_cutoff_id_seq'::regclass);


--
-- Name: exam_schedules schedule_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exam_schedules ALTER COLUMN schedule_id SET DEFAULT nextval('public.exam_schedules_schedule_id_seq'::regclass);


--
-- Name: exams exam_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exams ALTER COLUMN exam_id SET DEFAULT nextval('public.exams_exam_id_seq'::regclass);


--
-- Name: faqs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faqs ALTER COLUMN id SET DEFAULT nextval('public.faqs_id_seq'::regclass);


--
-- Name: institute_accounts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.institute_accounts ALTER COLUMN id SET DEFAULT nextval('public.institute_accounts_id_seq'::regclass);


--
-- Name: institute_users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.institute_users ALTER COLUMN id SET DEFAULT nextval('public.institute_users_id_seq'::regclass);


--
-- Name: job_postings id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_postings ALTER COLUMN id SET DEFAULT nextval('public.job_postings_id_seq'::regclass);


--
-- Name: news_articles article_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.news_articles ALTER COLUMN article_id SET DEFAULT nextval('public.news_articles_article_id_seq'::regclass);


--
-- Name: newsletter_subscribers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.newsletter_subscribers ALTER COLUMN id SET DEFAULT nextval('public.newsletter_subscribers_id_seq'::regclass);


--
-- Name: notification_preferences id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification_preferences ALTER COLUMN id SET DEFAULT nextval('public.notification_preferences_id_seq'::regclass);


--
-- Name: notifications notification_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications ALTER COLUMN notification_id SET DEFAULT nextval('public.notifications_notification_id_seq'::regclass);


--
-- Name: password_resets id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.password_resets ALTER COLUMN id SET DEFAULT nextval('public.password_resets_id_seq'::regclass);


--
-- Name: payments payment_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments ALTER COLUMN payment_id SET DEFAULT nextval('public.payments_payment_id_seq'::regclass);


--
-- Name: placements placement_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.placements ALTER COLUMN placement_id SET DEFAULT nextval('public.placements_placement_id_seq'::regclass);


--
-- Name: questions question_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questions ALTER COLUMN question_id SET DEFAULT nextval('public.questions_question_id_seq'::regclass);


--
-- Name: ranking_agencies agency_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ranking_agencies ALTER COLUMN agency_id SET DEFAULT nextval('public.ranking_agencies_agency_id_seq'::regclass);


--
-- Name: reviews review_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews ALTER COLUMN review_id SET DEFAULT nextval('public.reviews_review_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- Name: saved_items saved_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.saved_items ALTER COLUMN saved_id SET DEFAULT nextval('public.saved_items_saved_id_seq'::regclass);


--
-- Name: scholarships scholarship_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scholarships ALTER COLUMN scholarship_id SET DEFAULT nextval('public.scholarships_scholarship_id_seq'::regclass);


--
-- Name: search_logs search_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.search_logs ALTER COLUMN search_id SET DEFAULT nextval('public.search_logs_search_id_seq'::regclass);


--
-- Name: site_notifications id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.site_notifications ALTER COLUMN id SET DEFAULT nextval('public.site_notifications_id_seq'::regclass);


--
-- Name: system_settings id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.system_settings ALTER COLUMN id SET DEFAULT nextval('public.system_settings_id_seq'::regclass);


--
-- Name: team_members id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.team_members ALTER COLUMN id SET DEFAULT nextval('public.team_members_id_seq'::regclass);


--
-- Name: test_attempts attempt_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test_attempts ALTER COLUMN attempt_id SET DEFAULT nextval('public.test_attempts_attempt_id_seq'::regclass);


--
-- Name: test_series series_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test_series ALTER COLUMN series_id SET DEFAULT nextval('public.test_series_series_id_seq'::regclass);


--
-- Name: testimonials id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.testimonials ALTER COLUMN id SET DEFAULT nextval('public.testimonials_id_seq'::regclass);


--
-- Name: tests test_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tests ALTER COLUMN test_id SET DEFAULT nextval('public.tests_test_id_seq'::regclass);


--
-- Name: user_consents id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consents ALTER COLUMN id SET DEFAULT nextval('public.user_consents_id_seq'::regclass);


--
-- Name: user_profiles profile_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_profiles ALTER COLUMN profile_id SET DEFAULT nextval('public.user_profiles_profile_id_seq'::regclass);


--
-- Name: user_verifications id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_verifications ALTER COLUMN id SET DEFAULT nextval('public.user_verifications_id_seq'::regclass);


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Data for Name: counselling_sessions; Type: TABLE DATA; Schema: analytics; Owner: postgres
--

COPY analytics.counselling_sessions (id, lead_id, counsellor_id, session_type, duration_minutes, notes, outcome, next_follow_up, created_at) FROM stdin;
\.


--
-- Data for Name: lead_notes; Type: TABLE DATA; Schema: analytics; Owner: postgres
--

COPY analytics.lead_notes (id, lead_id, user_id, note, created_at) FROM stdin;
\.


--
-- Data for Name: leads; Type: TABLE DATA; Schema: analytics; Owner: postgres
--

COPY analytics.leads (id, user_id, institution_id, institution_course_id, student_name, student_email, student_phone, message, source, website_origin, utm_source, utm_medium, utm_campaign, assigned_to, status, priority, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: payments; Type: TABLE DATA; Schema: analytics; Owner: postgres
--

COPY analytics.payments (id, user_id, institution_id, amount, currency, purpose, payment_gateway, transaction_id, gateway_response, status, refund_id, refunded_at, meta, created_at) FROM stdin;
\.


--
-- Data for Name: user_activity; Type: TABLE DATA; Schema: analytics; Owner: postgres
--

COPY analytics.user_activity (id, user_id, session_id, activity_type, entity_type, entity_id, search_query, filters_applied, meta, created_at) FROM stdin;
\.


--
-- Data for Name: application_documents; Type: TABLE DATA; Schema: discovery; Owner: postgres
--

COPY discovery.application_documents (id, application_id, document_type, file_url, is_verified, verified_by, verified_at, created_at) FROM stdin;
\.


--
-- Data for Name: applications; Type: TABLE DATA; Schema: discovery; Owner: postgres
--

COPY discovery.applications (id, user_id, institution_course_id, academic_year, status, submitted_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: course_admissions; Type: TABLE DATA; Schema: discovery; Owner: postgres
--

COPY discovery.course_admissions (id, institution_course_id, academic_year, application_start, application_end, admission_mode, process, counseling, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: course_fees; Type: TABLE DATA; Schema: discovery; Owner: postgres
--

COPY discovery.course_fees (id, institution_course_id, year, tuition_fee, hostel_fee, exam_fee, other_fee, total_fee, currency, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: course_specializations; Type: TABLE DATA; Schema: discovery; Owner: postgres
--

COPY discovery.course_specializations (id, institution_course_id, name, seats) FROM stdin;
\.


--
-- Data for Name: facilities; Type: TABLE DATA; Schema: discovery; Owner: postgres
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
-- Data for Name: institution_affiliations; Type: TABLE DATA; Schema: discovery; Owner: postgres
--

COPY discovery.institution_affiliations (id, institution_id, affiliated_to, notes) FROM stdin;
\.


--
-- Data for Name: institution_approvals; Type: TABLE DATA; Schema: discovery; Owner: postgres
--

COPY discovery.institution_approvals (id, institution_id, approval_type, approval_number, grade, valid_from, valid_to, notes, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: institution_brochures; Type: TABLE DATA; Schema: discovery; Owner: postgres
--

COPY discovery.institution_brochures (id, institution_id, file_url, title, language, academic_year, created_at) FROM stdin;
\.


--
-- Data for Name: institution_courses; Type: TABLE DATA; Schema: discovery; Owner: postgres
--

COPY discovery.institution_courses (id, institution_id, course_id, seats, mode, affiliated_to, approved_by, view_count, is_trending, created_at, updated_at, deleted_at) FROM stdin;
\.


--
-- Data for Name: institution_facilities; Type: TABLE DATA; Schema: discovery; Owner: postgres
--

COPY discovery.institution_facilities (institution_id, facility_id, details) FROM stdin;
\.


--
-- Data for Name: institution_highlights; Type: TABLE DATA; Schema: discovery; Owner: postgres
--

COPY discovery.institution_highlights (id, institution_id, title, value) FROM stdin;
\.


--
-- Data for Name: institution_videos; Type: TABLE DATA; Schema: discovery; Owner: postgres
--

COPY discovery.institution_videos (id, institution_id, video_url, title, description, thumbnail_url, duration_seconds, category, created_at) FROM stdin;
\.


--
-- Data for Name: qna; Type: TABLE DATA; Schema: discovery; Owner: postgres
--

COPY discovery.qna (id, institution_id, course_id, user_id, question, answer, answered_by, is_featured, helpful_count, created_at, answered_at) FROM stdin;
\.


--
-- Data for Name: qna_votes; Type: TABLE DATA; Schema: discovery; Owner: postgres
--

COPY discovery.qna_votes (id, qna_id, user_id, is_helpful, created_at) FROM stdin;
\.


--
-- Data for Name: recruiter_companies; Type: TABLE DATA; Schema: discovery; Owner: postgres
--

COPY discovery.recruiter_companies (id, name, logo_url, website, industry, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: review_moderation; Type: TABLE DATA; Schema: discovery; Owner: postgres
--

COPY discovery.review_moderation (id, review_id, status, moderated_by, comments, moderated_at) FROM stdin;
\.


--
-- Data for Name: seo_metadata; Type: TABLE DATA; Schema: discovery; Owner: postgres
--

COPY discovery.seo_metadata (id, entity_type, entity_id, meta_title, meta_description, meta_keywords, canonical_url, og_title, og_description, og_image, schema_json, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: streams; Type: TABLE DATA; Schema: discovery; Owner: postgres
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
-- Data for Name: user_favorites; Type: TABLE DATA; Schema: discovery; Owner: postgres
--

COPY discovery.user_favorites (user_id, entity_type, entity_id, created_at) FROM stdin;
\.


--
-- Data for Name: cities; Type: TABLE DATA; Schema: geo_master; Owner: postgres
--

COPY geo_master.cities (city_id, state_id, city_name, population, is_metro) FROM stdin;
\.


--
-- Data for Name: countries; Type: TABLE DATA; Schema: geo_master; Owner: postgres
--

COPY geo_master.countries (country_id, country_name, country_code, currency, is_study_destination) FROM stdin;
1	India	IN	INR	t
2	United States	US	USD	t
3	United Kingdom	UK	GBP	t
4	Canada	CA	CAD	t
5	Australia	AU	AUD	t
\.


--
-- Data for Name: states; Type: TABLE DATA; Schema: geo_master; Owner: postgres
--

COPY geo_master.states (state_id, country_id, state_name, state_code) FROM stdin;
\.


--
-- Data for Name: admin_audit_logs; Type: TABLE DATA; Schema: public; Owner: postgres
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
\.


--
-- Data for Name: admin_sessions; Type: TABLE DATA; Schema: public; Owner: postgres
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
\.


--
-- Data for Name: admin_users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.admin_users (admin_id, email, password_hash, name, role, status, created_at, updated_at) FROM stdin;
1	admin@planedu.com	$2b$10$H/qIVGgwnmzkXmuKBnFb0eA9SSF.JbxSOTPiH2ksMmO8T8pjn7Ox.	Super Admin	super_admin	active	2025-12-15 20:03:47.002636	2025-12-15 20:03:47.002636
\.


--
-- Data for Name: audit_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.audit_log (id, user_id, action, entity, entity_id, old_values, new_values, meta, created_at) FROM stdin;
\.


--
-- Data for Name: banner_analytics; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.banner_analytics (id, banner_id, event_type, user_id, session_id, ip_address, created_at) FROM stdin;
\.


--
-- Data for Name: banners; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.banners (id, title, image_url, link_url, placement, page_type, target_audience, priority, valid_from, valid_to, is_active, click_count, view_count, created_by, created_at) FROM stdin;
1	JEE Advanced 2024 Counselling	https://images.unsplash.com/photo-1523050854058-8df90110c9f1	/news/jee-advanced-2024-counselling	top	home	\N	1	2025-12-23 13:38:56.095543	2026-01-22 13:38:56.095543	t	0	0	\N	2025-12-23 13:38:56.095543
2	NEET UG 2024 Results	https://images.unsplash.com/photo-1434030216411-0b793f4b4173	/news/neet-ug-2024-results	middle	home	\N	2	2025-12-23 13:38:56.095543	2026-01-07 13:38:56.095543	t	0	0	\N	2025-12-23 13:38:56.095543
3	Top Engineering Colleges	https://images.unsplash.com/photo-1562774053-701939374585	/colleges?type=Engineering	bottom	home	\N	3	2025-12-23 13:38:56.095543	2026-03-23 13:38:56.095543	t	0	0	\N	2025-12-23 13:38:56.095543
4	MBA Admissions Open	https://images.unsplash.com/photo-1454165804606-c3d57bc86b40	/news/mba-admissions-2024	sidebar	colleges	\N	4	2025-12-23 13:38:56.095543	2026-02-21 13:38:56.095543	t	0	0	\N	2025-12-23 13:38:56.095543
\.


--
-- Data for Name: college_facilities; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.college_facilities (facility_id, college_id, facility_type, facility_name, description, created_at) FROM stdin;
\.


--
-- Data for Name: college_media; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.college_media (media_id, college_id, media_type, media_url, title, uploaded_at) FROM stdin;
\.


--
-- Data for Name: college_rankings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.college_rankings (ranking_id, college_id, agency_id, ranking_year, category, rank_position, score, created_at) FROM stdin;
\.


--
-- Data for Name: colleges; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.colleges (college_id, college_name, slug, short_name, established_year, college_type, ownership, country, state, city, pincode, address, latitude, longitude, website_url, phone, email, description, logo_url, is_featured, is_verified, status, avg_rating, total_reviews, view_count, created_at, updated_at, deleted_at, is_popular) FROM stdin;
1	Test University of Technology	test-university-of-technology	TUT	2000	University	Private	India	Karnataka	Bangalore	560001	123 Tech Road, Bangalore	\N	\N	https://www.testuniversity.edu	+91 9876543210	info@testuniversity.edu	A premier institution focused on technology and innovation. Offering undergraduate and graduate programs.	\N	t	t	inactive	0.00	0	0	2025-12-18 13:30:45.992065	2025-12-18 13:33:12.792807	2025-12-18 13:33:35.937221	f
2	Indian Institute of Technology Delhi	iit-delhi	IIT Delhi	1961	Institute	Government	India	Delhi	New Delhi	110016	Hauz Khas, New Delhi, Delhi 110016	\N	\N	https://home.iitd.ac.in	+91-11-26591999	info@admin.iitd.ac.in	IIT Delhi is one of the twenty three IITs created to be Centres of Excellence for training, research and development in science, engineering and technology in India.	https://upload.wikimedia.org/wikipedia/en/f/fd/Indian_Institute_of_Technology_Delhi_Logo.svg	t	t	active	4.50	250	4	2025-12-18 13:35:38.587865	2025-12-18 13:35:38.587865	\N	f
4	National Institute of Technology Karnataka	national-institute-of-technology-karnataka	NIT Surathkal	1961	Institute	Government	India	Karnataka	Surathkal	575025	\N	\N	\N	https://www.nitk.ac.in	+91 824 247 3000	info@nitk.ac.in	National Institute of Technology Karnataka is one of the premier engineering institutions in India, offering undergraduate and postgraduate programs in engineering, science, and management.	\N	f	f	inactive	0.00	0	0	2025-12-24 12:27:30.724258	2025-12-24 12:28:31.25776	2025-12-24 12:29:21.174298	f
\.


--
-- Data for Name: community_answers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.community_answers (answer_id, question_id, user_id, answer_text, is_accepted, upvote_count, created_at) FROM stdin;
\.


--
-- Data for Name: community_questions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.community_questions (question_id, user_id, title, question_text, category, college_id, view_count, upvote_count, answer_count, status, created_at) FROM stdin;
\.


--
-- Data for Name: contact_queries; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contact_queries (id, name, email, phone, subject, message, status, assigned_to, response, created_at, responded_at) FROM stdin;
\.


--
-- Data for Name: courses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.courses (course_id, college_id, course_name, short_name, degree_type, duration, stream, specialization, total_fees, fees_type, eligibility, seats_available, course_mode, description, status, is_featured, created_at, updated_at, deleted_at) FROM stdin;
1	2	Bachelor of Technology in Computer Science	B.Tech CSE	Bachelor	4 Years (8 Semesters)	Engineering	Computer Science	800000.00	Total	10+2 with 60% marks in Physics, Chemistry and Mathematics	100	Full-time	B.Tech in Computer Science is a 4-year undergraduate program focusing on computer science fundamentals, programming, algorithms, and software development.	active	f	2025-12-24 13:13:17.652434	2025-12-24 13:16:42.181458	2025-12-24 13:19:04.47761
\.


--
-- Data for Name: education_loans; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.education_loans (loan_id, loan_provider, provider_type, country, max_loan_amount, currency, interest_rate_min, interest_rate_max, is_active, created_at) FROM stdin;
\.


--
-- Data for Name: exam_cutoffs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.exam_cutoffs (cutoff_id, exam_id, college_id, course_id, academic_year, category, cutoff_type, cutoff_value, closing_rank, created_at) FROM stdin;
\.


--
-- Data for Name: exam_schedules; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.exam_schedules (schedule_id, exam_id, academic_year, application_start, application_end, exam_start_date, exam_end_date, result_date, created_at) FROM stdin;
\.


--
-- Data for Name: exams; Type: TABLE DATA; Schema: public; Owner: postgres
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
\.


--
-- Data for Name: faqs; Type: TABLE DATA; Schema: public; Owner: postgres
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
-- Data for Name: institute_accounts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.institute_accounts (id, institution_id, subscription_plan, contract_start, contract_end, status, account_manager_id, features, max_users, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: institute_users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.institute_users (id, institution_id, user_id, role, permissions, is_active, created_at) FROM stdin;
\.


--
-- Data for Name: job_postings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.job_postings (id, title, department, location, job_type, experience_required, description, requirements, responsibilities, salary_range, is_active, posted_date, application_deadline, apply_url, created_at) FROM stdin;
\.


--
-- Data for Name: news_articles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.news_articles (article_id, title, slug, content, category, author_id, is_featured, status, view_count, published_at, created_at) FROM stdin;
2	New Campus Facilities Opening Next Month	new-campus-facilities-opening-next-month	We are excited to announce the opening of our state-of-the-art campus facilities next month. The new building includes modern laboratories, collaborative study spaces, and a cutting-edge library with digital resources.	Campus News	\N	f	draft	0	\N	2025-12-18 16:18:24.619565
3	JEE Advanced 2024 Results Announced	jee-advanced-2024-results-announced	<h2>JEE Advanced 2024 Results Declared</h2><p>The Indian Institute of Technology (IIT) Madras has announced the results of JEE Advanced 2024. The examination was conducted on May 26, 2024, across various centers in India.</p><h3>Key Highlights</h3><ul><li>Total candidates appeared: 1,80,000+</li><li>Qualified candidates: 48,000+</li><li>Top score: 355/360</li><li>Results available on official website: jeeadv.ac.in</li></ul><p>Candidates can check their results using their registration number and date of birth. The counselling process for seat allocation will begin from June 10, 2024.</p>	Entrance Exams	\N	t	published	0	2025-12-23 13:38:56.093711	2025-12-23 13:38:56.093711
4	NEET UG 2024: Important Dates and Updates	neet-ug-2024-important-dates-updates	<h2>NEET UG 2024 Schedule Released</h2><p>The National Testing Agency (NTA) has released the revised schedule for NEET UG 2024 examination.</p><h3>Important Dates</h3><ul><li>Application Start Date: March 15, 2024</li><li>Last Date to Apply: April 15, 2024</li><li>Exam Date: May 5, 2024</li><li>Result Declaration: June 20, 2024</li></ul><h3>Exam Pattern</h3><p>The exam will consist of 200 questions covering Physics, Chemistry, and Biology. Duration: 3 hours 20 minutes.</p>	Entrance Exams	\N	t	published	0	2025-12-22 13:38:56.093711	2025-12-23 13:38:56.093711
5	Top 10 Engineering Colleges in India 2024	top-10-engineering-colleges-india-2024	<h2>Best Engineering Colleges in India 2024</h2><p>Here is the list of top 10 engineering colleges based on various parameters including placements, faculty, infrastructure, and research output.</p><h3>Top 10 Colleges</h3><ol><li>IIT Bombay</li><li>IIT Delhi</li><li>IIT Madras</li><li>IIT Kanpur</li><li>IIT Kharagpur</li><li>IIT Roorkee</li><li>NIT Trichy</li><li>BITS Pilani</li><li>Delhi Technological University</li><li>VIT Vellore</li></ol><p>These institutions are known for their excellent placement records with average packages ranging from 10-20 LPA.</p>	Rankings	\N	f	published	0	2025-12-21 13:38:56.093711	2025-12-23 13:38:56.093711
6	MBA Entrance Exams 2024: Complete Guide	mba-entrance-exams-2024-complete-guide	<h2>MBA Entrance Exams 2024</h2><p>Aspiring MBA students need to appear for various entrance exams to get admission to top B-schools.</p><h3>Major MBA Exams</h3><ul><li><strong>CAT (Common Admission Test):</strong> Conducted by IIMs</li><li><strong>XAT (Xavier Aptitude Test):</strong> For XLRI and associate institutions</li><li><strong>SNAP:</strong> For Symbiosis Institute of Business Management</li><li><strong>GMAT:</strong> For international MBA programs</li></ul><h3>Preparation Tips</h3><p>Start preparation at least 6 months before the exam. Focus on quantitative ability, verbal ability, logical reasoning, and data interpretation.</p>	MBA	\N	f	published	0	2025-12-20 13:38:56.093711	2025-12-23 13:38:56.093711
\.


--
-- Data for Name: newsletter_subscribers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.newsletter_subscribers (id, email, phone, name, subscribed_at, is_active, unsubscribed_at, source) FROM stdin;
\.


--
-- Data for Name: notification_preferences; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notification_preferences (id, user_id, email_notifications, exam_alerts, admission_alerts, newsletter, sms_notifications, updated_at) FROM stdin;
\.


--
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.notifications (notification_id, user_id, notification_type, title, message, link_url, status, sent_at, read_at, created_at) FROM stdin;
\.


--
-- Data for Name: password_resets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.password_resets (id, user_id, otp_code, expires_at, used, created_at) FROM stdin;
\.


--
-- Data for Name: payments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payments (payment_id, user_id, order_id, payment_gateway, amount, currency, payment_status, transaction_date, created_at) FROM stdin;
\.


--
-- Data for Name: placements; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.placements (placement_id, college_id, course_id, academic_year, total_students, students_placed, placement_percentage, highest_package, average_package, median_package, currency, created_at, updated_at, deleted_at) FROM stdin;
1	2	\N	2024-25	1200	1140	95.00	4500000.00	1800000.00	1500000.00	INR	2025-12-23 17:01:46.722994	2025-12-23 18:37:18.345897	\N
2	2	\N	2023-24	1180	1121	95.00	4200000.00	1750000.00	1450000.00	INR	2025-12-23 17:01:46.722994	2025-12-23 18:37:18.345897	\N
3	2	\N	2022-23	1150	1081	94.00	3800000.00	1650000.00	1400000.00	INR	2025-12-23 17:01:46.722994	2025-12-23 18:37:18.345897	\N
4	1	\N	2024-25	800	680	85.00	1800000.00	650000.00	550000.00	INR	2025-12-23 17:01:46.722994	2025-12-23 18:37:18.345897	\N
5	1	\N	2023-24	750	623	83.00	1600000.00	600000.00	500000.00	INR	2025-12-23 17:01:46.722994	2025-12-23 18:37:18.345897	\N
7	1	\N	2025-26	500	425	85.00	2500000.00	800000.00	750000.00	INR	2025-12-23 19:49:05.140191	2025-12-23 19:49:05.140191	2025-12-23 19:50:22.907362
6	1	\N	2022-23	720	576	80.00	1400000.00	550000.00	480000.00	INR	2025-12-23 17:01:46.722994	2025-12-23 18:37:18.345897	2025-12-24 16:41:41.287695
\.


--
-- Data for Name: questions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.questions (question_id, test_id, question_text, question_type, marks, option_a, option_b, option_c, option_d, correct_answer, explanation, created_at) FROM stdin;
\.


--
-- Data for Name: ranking_agencies; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ranking_agencies (agency_id, agency_name, agency_code, country, website_url, is_active, created_at) FROM stdin;
1	National Institutional Ranking Framework	NIRF	India	\N	t	2025-12-12 13:12:46.552074
2	QS World University Rankings	QS	United Kingdom	\N	t	2025-12-12 13:12:46.552074
3	Times Higher Education	THE	United Kingdom	\N	t	2025-12-12 13:12:46.552074
4	India Today	INDIATODAY	India	\N	t	2025-12-12 13:12:46.552074
5	Outlook	OUTLOOK	India	\N	t	2025-12-12 13:12:46.552074
\.


--
-- Data for Name: reviews; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reviews (review_id, college_id, user_id, overall_rating, academic_rating, infrastructure_rating, faculty_rating, placement_rating, review_title, review_text, pros, cons, is_verified, status, helpful_count, created_at, updated_at, title, admin_reply, replied_at, replied_by, deleted_at) FROM stdin;
1	2	2	4.5	4.0	4.5	4.5	5.0	Excellent Institute for Engineering	IIT Delhi is one of the premier engineering institutes in India. The academic environment is excellent with highly qualified faculty and great placement opportunities.	World-class faculty, Great placements, Excellent research facilities, Strong alumni network	High competition, Stressful environment at times	f	approved	0	2025-12-24 13:54:05.944072	2025-12-24 13:57:21.54769	\N	\N	\N	\N	\N
2	2	2	3.0	3.5	2.5	3.0	3.5	Average Experience	The college has good faculty but infrastructure needs improvement. Placements are decent but not exceptional.	Good faculty, Decent placements	Poor infrastructure, Limited facilities	f	rejected	0	2025-12-24 14:03:31.372793	2025-12-24 14:03:50.470849	\N	Thank you for your honest feedback. We acknowledge your concerns about infrastructure and are working on improvements.	2025-12-24 14:09:50.462204	2	2025-12-24 14:12:19.19358
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
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
-- Data for Name: saved_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.saved_items (saved_id, user_id, item_type, item_id, notes, created_at) FROM stdin;
\.


--
-- Data for Name: scholarships; Type: TABLE DATA; Schema: public; Owner: postgres
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
-- Data for Name: search_logs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.search_logs (search_id, user_id, search_query, search_type, results_count, created_at) FROM stdin;
\.


--
-- Data for Name: site_notifications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.site_notifications (id, title, message, type, priority, link_url, is_active, valid_from, valid_to, created_at) FROM stdin;
\.


--
-- Data for Name: system_settings; Type: TABLE DATA; Schema: public; Owner: postgres
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
-- Data for Name: team_members; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.team_members (id, name, designation, photo_url, bio, linkedin_url, twitter_url, display_order, is_leadership, is_active, created_at) FROM stdin;
\.


--
-- Data for Name: test_attempts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.test_attempts (attempt_id, test_id, user_id, start_time, end_time, score, percentage, created_at) FROM stdin;
\.


--
-- Data for Name: test_series; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.test_series (series_id, series_name, exam_id, price, total_tests, description, is_active, created_at) FROM stdin;
\.


--
-- Data for Name: testimonials; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.testimonials (id, student_name, student_image, institution_id, course_id, testimonial, rating, designation, is_featured, is_approved, display_order, created_at) FROM stdin;
\.


--
-- Data for Name: tests; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tests (test_id, series_id, test_name, test_type, total_questions, total_marks, duration_minutes, is_active, created_at) FROM stdin;
\.


--
-- Data for Name: user_consents; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_consents (id, user_id, consent_type, consented, ip_address, created_at) FROM stdin;
\.


--
-- Data for Name: user_profiles; Type: TABLE DATA; Schema: public; Owner: postgres
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
-- Data for Name: user_roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_roles (user_id, role_id) FROM stdin;
\.


--
-- Data for Name: user_sessions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_sessions (session_id, user_id, session_token, ip_address, is_active, created_at, expires_at) FROM stdin;
0fee8e93-d42a-4e76-b768-fb56266f3fc0	7	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiNyIsImVtYWlsIjoiamFuZUBwbGFuZWR1LmNvbSIsInBob25lIjpudWxsLCJ1c2VyX3R5cGUiOiJzdHVkZW50Iiwicm9sZXMiOltdLCJpYXQiOjE3NjU4MDUxODIsImV4cCI6MTc2ODM5NzE4Mn0.UgK2m4KM_fIFCd7RNJjJNSg-yab-DLFHFswtRnB4SMM	::1	t	2025-12-15 18:56:22.170972	2025-12-22 18:56:22.170972
c62d59ea-0f11-483a-b13f-c028dd129342	3	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiMyIsImVtYWlsIjoic3R1ZGVudEBleGFtcGxlLmNvbSIsInBob25lIjoiKzkxOTg3NjU0MzIxMCIsInVzZXJfdHlwZSI6InN0dWRlbnQiLCJyb2xlcyI6W10sImlhdCI6MTc2NTgwNTI1MiwiZXhwIjoxNzY4Mzk3MjUyfQ.ZO-M_ELBmIa8MG4TcGULX747NvX4vVtzqqnTcYyBl-o	::1	t	2025-12-15 18:57:32.11485	2025-12-22 18:57:32.11485
09168dcc-a0b8-4970-8959-a2fa2a973982	8	eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiOCIsImVtYWlsIjoiYW1pdEBwbGFuZWR1LmNvbSIsInBob25lIjoiKzkxOTg3NjU0MzIxMSIsInVzZXJfdHlwZSI6InN0dWRlbnQiLCJyb2xlcyI6W10sImlhdCI6MTc2NTgwNzU4MiwiZXhwIjoxNzY4Mzk5NTgyfQ.S8PfXSICffdf13nzBVKNbmTn7ohRYWlndagdGUpnxkw	::1	t	2025-12-15 19:36:22.28537	2025-12-22 19:36:22.28537
\.


--
-- Data for Name: user_verifications; Type: TABLE DATA; Schema: public; Owner: postgres
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
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
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
-- Name: counselling_sessions_id_seq; Type: SEQUENCE SET; Schema: analytics; Owner: postgres
--

SELECT pg_catalog.setval('analytics.counselling_sessions_id_seq', 1, false);


--
-- Name: lead_notes_id_seq; Type: SEQUENCE SET; Schema: analytics; Owner: postgres
--

SELECT pg_catalog.setval('analytics.lead_notes_id_seq', 1, false);


--
-- Name: leads_id_seq; Type: SEQUENCE SET; Schema: analytics; Owner: postgres
--

SELECT pg_catalog.setval('analytics.leads_id_seq', 1, false);


--
-- Name: payments_id_seq; Type: SEQUENCE SET; Schema: analytics; Owner: postgres
--

SELECT pg_catalog.setval('analytics.payments_id_seq', 1, false);


--
-- Name: user_activity_id_seq; Type: SEQUENCE SET; Schema: analytics; Owner: postgres
--

SELECT pg_catalog.setval('analytics.user_activity_id_seq', 1, false);


--
-- Name: application_documents_id_seq; Type: SEQUENCE SET; Schema: discovery; Owner: postgres
--

SELECT pg_catalog.setval('discovery.application_documents_id_seq', 1, false);


--
-- Name: applications_id_seq; Type: SEQUENCE SET; Schema: discovery; Owner: postgres
--

SELECT pg_catalog.setval('discovery.applications_id_seq', 1, false);


--
-- Name: course_admissions_id_seq; Type: SEQUENCE SET; Schema: discovery; Owner: postgres
--

SELECT pg_catalog.setval('discovery.course_admissions_id_seq', 1, false);


--
-- Name: course_fees_id_seq; Type: SEQUENCE SET; Schema: discovery; Owner: postgres
--

SELECT pg_catalog.setval('discovery.course_fees_id_seq', 1, false);


--
-- Name: course_specializations_id_seq; Type: SEQUENCE SET; Schema: discovery; Owner: postgres
--

SELECT pg_catalog.setval('discovery.course_specializations_id_seq', 1, false);


--
-- Name: facilities_id_seq; Type: SEQUENCE SET; Schema: discovery; Owner: postgres
--

SELECT pg_catalog.setval('discovery.facilities_id_seq', 16, true);


--
-- Name: institution_affiliations_id_seq; Type: SEQUENCE SET; Schema: discovery; Owner: postgres
--

SELECT pg_catalog.setval('discovery.institution_affiliations_id_seq', 1, false);


--
-- Name: institution_approvals_id_seq; Type: SEQUENCE SET; Schema: discovery; Owner: postgres
--

SELECT pg_catalog.setval('discovery.institution_approvals_id_seq', 1, false);


--
-- Name: institution_brochures_id_seq; Type: SEQUENCE SET; Schema: discovery; Owner: postgres
--

SELECT pg_catalog.setval('discovery.institution_brochures_id_seq', 1, false);


--
-- Name: institution_courses_id_seq; Type: SEQUENCE SET; Schema: discovery; Owner: postgres
--

SELECT pg_catalog.setval('discovery.institution_courses_id_seq', 1, false);


--
-- Name: institution_highlights_id_seq; Type: SEQUENCE SET; Schema: discovery; Owner: postgres
--

SELECT pg_catalog.setval('discovery.institution_highlights_id_seq', 1, false);


--
-- Name: institution_videos_id_seq; Type: SEQUENCE SET; Schema: discovery; Owner: postgres
--

SELECT pg_catalog.setval('discovery.institution_videos_id_seq', 1, false);


--
-- Name: qna_id_seq; Type: SEQUENCE SET; Schema: discovery; Owner: postgres
--

SELECT pg_catalog.setval('discovery.qna_id_seq', 1, false);


--
-- Name: qna_votes_id_seq; Type: SEQUENCE SET; Schema: discovery; Owner: postgres
--

SELECT pg_catalog.setval('discovery.qna_votes_id_seq', 1, false);


--
-- Name: recruiter_companies_id_seq; Type: SEQUENCE SET; Schema: discovery; Owner: postgres
--

SELECT pg_catalog.setval('discovery.recruiter_companies_id_seq', 1, false);


--
-- Name: review_moderation_id_seq; Type: SEQUENCE SET; Schema: discovery; Owner: postgres
--

SELECT pg_catalog.setval('discovery.review_moderation_id_seq', 1, false);


--
-- Name: seo_metadata_id_seq; Type: SEQUENCE SET; Schema: discovery; Owner: postgres
--

SELECT pg_catalog.setval('discovery.seo_metadata_id_seq', 1, false);


--
-- Name: streams_id_seq; Type: SEQUENCE SET; Schema: discovery; Owner: postgres
--

SELECT pg_catalog.setval('discovery.streams_id_seq', 16, true);


--
-- Name: cities_city_id_seq; Type: SEQUENCE SET; Schema: geo_master; Owner: postgres
--

SELECT pg_catalog.setval('geo_master.cities_city_id_seq', 1, false);


--
-- Name: countries_country_id_seq; Type: SEQUENCE SET; Schema: geo_master; Owner: postgres
--

SELECT pg_catalog.setval('geo_master.countries_country_id_seq', 5, true);


--
-- Name: states_state_id_seq; Type: SEQUENCE SET; Schema: geo_master; Owner: postgres
--

SELECT pg_catalog.setval('geo_master.states_state_id_seq', 1, false);


--
-- Name: admin_audit_logs_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.admin_audit_logs_log_id_seq', 164, true);


--
-- Name: admin_sessions_session_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.admin_sessions_session_id_seq', 20, true);


--
-- Name: admin_users_admin_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.admin_users_admin_id_seq', 1, true);


--
-- Name: audit_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.audit_log_id_seq', 1, false);


--
-- Name: banner_analytics_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.banner_analytics_id_seq', 1, false);


--
-- Name: banners_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.banners_id_seq', 4, true);


--
-- Name: college_facilities_facility_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.college_facilities_facility_id_seq', 1, false);


--
-- Name: college_media_media_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.college_media_media_id_seq', 1, false);


--
-- Name: college_rankings_ranking_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.college_rankings_ranking_id_seq', 1, false);


--
-- Name: colleges_college_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.colleges_college_id_seq', 4, true);


--
-- Name: community_answers_answer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.community_answers_answer_id_seq', 1, false);


--
-- Name: community_questions_question_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.community_questions_question_id_seq', 1, false);


--
-- Name: contact_queries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.contact_queries_id_seq', 1, false);


--
-- Name: courses_course_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.courses_course_id_seq', 1, true);


--
-- Name: education_loans_loan_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.education_loans_loan_id_seq', 1, false);


--
-- Name: exam_cutoffs_cutoff_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.exam_cutoffs_cutoff_id_seq', 1, false);


--
-- Name: exam_schedules_schedule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.exam_schedules_schedule_id_seq', 1, false);


--
-- Name: exams_exam_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.exams_exam_id_seq', 12, true);


--
-- Name: faqs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.faqs_id_seq', 9, true);


--
-- Name: institute_accounts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.institute_accounts_id_seq', 1, false);


--
-- Name: institute_users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.institute_users_id_seq', 1, false);


--
-- Name: job_postings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.job_postings_id_seq', 1, false);


--
-- Name: news_articles_article_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.news_articles_article_id_seq', 7, true);


--
-- Name: newsletter_subscribers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.newsletter_subscribers_id_seq', 1, false);


--
-- Name: notification_preferences_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notification_preferences_id_seq', 1, false);


--
-- Name: notifications_notification_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.notifications_notification_id_seq', 1, false);


--
-- Name: password_resets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.password_resets_id_seq', 1, false);


--
-- Name: payments_payment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.payments_payment_id_seq', 1, false);


--
-- Name: placements_placement_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.placements_placement_id_seq', 7, true);


--
-- Name: questions_question_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.questions_question_id_seq', 1, false);


--
-- Name: ranking_agencies_agency_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ranking_agencies_agency_id_seq', 5, true);


--
-- Name: reviews_review_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reviews_review_id_seq', 2, true);


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_id_seq', 14, true);


--
-- Name: saved_items_saved_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.saved_items_saved_id_seq', 1, false);


--
-- Name: scholarships_scholarship_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.scholarships_scholarship_id_seq', 13, true);


--
-- Name: search_logs_search_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.search_logs_search_id_seq', 1, false);


--
-- Name: site_notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.site_notifications_id_seq', 1, false);


--
-- Name: system_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.system_settings_id_seq', 16, true);


--
-- Name: team_members_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.team_members_id_seq', 1, false);


--
-- Name: test_attempts_attempt_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.test_attempts_attempt_id_seq', 1, false);


--
-- Name: test_series_series_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.test_series_series_id_seq', 1, false);


--
-- Name: testimonials_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.testimonials_id_seq', 1, false);


--
-- Name: tests_test_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tests_test_id_seq', 1, false);


--
-- Name: user_consents_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_consents_id_seq', 1, false);


--
-- Name: user_profiles_profile_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_profiles_profile_id_seq', 8, true);


--
-- Name: user_verifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_verifications_id_seq', 9, true);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_user_id_seq', 9, true);


--
-- Name: counselling_sessions counselling_sessions_pkey; Type: CONSTRAINT; Schema: analytics; Owner: postgres
--

ALTER TABLE ONLY analytics.counselling_sessions
    ADD CONSTRAINT counselling_sessions_pkey PRIMARY KEY (id);


--
-- Name: lead_notes lead_notes_pkey; Type: CONSTRAINT; Schema: analytics; Owner: postgres
--

ALTER TABLE ONLY analytics.lead_notes
    ADD CONSTRAINT lead_notes_pkey PRIMARY KEY (id);


--
-- Name: leads leads_pkey; Type: CONSTRAINT; Schema: analytics; Owner: postgres
--

ALTER TABLE ONLY analytics.leads
    ADD CONSTRAINT leads_pkey PRIMARY KEY (id);


--
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: analytics; Owner: postgres
--

ALTER TABLE ONLY analytics.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (id);


--
-- Name: user_activity user_activity_pkey; Type: CONSTRAINT; Schema: analytics; Owner: postgres
--

ALTER TABLE ONLY analytics.user_activity
    ADD CONSTRAINT user_activity_pkey PRIMARY KEY (id);


--
-- Name: application_documents application_documents_pkey; Type: CONSTRAINT; Schema: discovery; Owner: postgres
--

ALTER TABLE ONLY discovery.application_documents
    ADD CONSTRAINT application_documents_pkey PRIMARY KEY (id);


--
-- Name: applications applications_pkey; Type: CONSTRAINT; Schema: discovery; Owner: postgres
--

ALTER TABLE ONLY discovery.applications
    ADD CONSTRAINT applications_pkey PRIMARY KEY (id);


--
-- Name: course_admissions course_admissions_pkey; Type: CONSTRAINT; Schema: discovery; Owner: postgres
--

ALTER TABLE ONLY discovery.course_admissions
    ADD CONSTRAINT course_admissions_pkey PRIMARY KEY (id);


--
-- Name: course_fees course_fees_institution_course_id_year_key; Type: CONSTRAINT; Schema: discovery; Owner: postgres
--

ALTER TABLE ONLY discovery.course_fees
    ADD CONSTRAINT course_fees_institution_course_id_year_key UNIQUE (institution_course_id, year);


--
-- Name: course_fees course_fees_pkey; Type: CONSTRAINT; Schema: discovery; Owner: postgres
--

ALTER TABLE ONLY discovery.course_fees
    ADD CONSTRAINT course_fees_pkey PRIMARY KEY (id);


--
-- Name: course_specializations course_specializations_institution_course_id_name_key; Type: CONSTRAINT; Schema: discovery; Owner: postgres
--

ALTER TABLE ONLY discovery.course_specializations
    ADD CONSTRAINT course_specializations_institution_course_id_name_key UNIQUE (institution_course_id, name);


--
-- Name: course_specializations course_specializations_pkey; Type: CONSTRAINT; Schema: discovery; Owner: postgres
--

ALTER TABLE ONLY discovery.course_specializations
    ADD CONSTRAINT course_specializations_pkey PRIMARY KEY (id);


--
-- Name: facilities facilities_name_key; Type: CONSTRAINT; Schema: discovery; Owner: postgres
--

ALTER TABLE ONLY discovery.facilities
    ADD CONSTRAINT facilities_name_key UNIQUE (name);


--
-- Name: facilities facilities_pkey; Type: CONSTRAINT; Schema: discovery; Owner: postgres
--

ALTER TABLE ONLY discovery.facilities
    ADD CONSTRAINT facilities_pkey PRIMARY KEY (id);


--
-- Name: institution_affiliations institution_affiliations_pkey; Type: CONSTRAINT; Schema: discovery; Owner: postgres
--

ALTER TABLE ONLY discovery.institution_affiliations
    ADD CONSTRAINT institution_affiliations_pkey PRIMARY KEY (id);


--
-- Name: institution_approvals institution_approvals_pkey; Type: CONSTRAINT; Schema: discovery; Owner: postgres
--

ALTER TABLE ONLY discovery.institution_approvals
    ADD CONSTRAINT institution_approvals_pkey PRIMARY KEY (id);


--
-- Name: institution_brochures institution_brochures_pkey; Type: CONSTRAINT; Schema: discovery; Owner: postgres
--

ALTER TABLE ONLY discovery.institution_brochures
    ADD CONSTRAINT institution_brochures_pkey PRIMARY KEY (id);


--
-- Name: institution_courses institution_courses_pkey; Type: CONSTRAINT; Schema: discovery; Owner: postgres
--

ALTER TABLE ONLY discovery.institution_courses
    ADD CONSTRAINT institution_courses_pkey PRIMARY KEY (id);


--
-- Name: institution_facilities institution_facilities_pkey; Type: CONSTRAINT; Schema: discovery; Owner: postgres
--

ALTER TABLE ONLY discovery.institution_facilities
    ADD CONSTRAINT institution_facilities_pkey PRIMARY KEY (institution_id, facility_id);


--
-- Name: institution_highlights institution_highlights_pkey; Type: CONSTRAINT; Schema: discovery; Owner: postgres
--

ALTER TABLE ONLY discovery.institution_highlights
    ADD CONSTRAINT institution_highlights_pkey PRIMARY KEY (id);


--
-- Name: institution_videos institution_videos_pkey; Type: CONSTRAINT; Schema: discovery; Owner: postgres
--

ALTER TABLE ONLY discovery.institution_videos
    ADD CONSTRAINT institution_videos_pkey PRIMARY KEY (id);


--
-- Name: qna qna_pkey; Type: CONSTRAINT; Schema: discovery; Owner: postgres
--

ALTER TABLE ONLY discovery.qna
    ADD CONSTRAINT qna_pkey PRIMARY KEY (id);


--
-- Name: qna_votes qna_votes_pkey; Type: CONSTRAINT; Schema: discovery; Owner: postgres
--

ALTER TABLE ONLY discovery.qna_votes
    ADD CONSTRAINT qna_votes_pkey PRIMARY KEY (id);


--
-- Name: qna_votes qna_votes_qna_id_user_id_key; Type: CONSTRAINT; Schema: discovery; Owner: postgres
--

ALTER TABLE ONLY discovery.qna_votes
    ADD CONSTRAINT qna_votes_qna_id_user_id_key UNIQUE (qna_id, user_id);


--
-- Name: recruiter_companies recruiter_companies_name_key; Type: CONSTRAINT; Schema: discovery; Owner: postgres
--

ALTER TABLE ONLY discovery.recruiter_companies
    ADD CONSTRAINT recruiter_companies_name_key UNIQUE (name);


--
-- Name: recruiter_companies recruiter_companies_pkey; Type: CONSTRAINT; Schema: discovery; Owner: postgres
--

ALTER TABLE ONLY discovery.recruiter_companies
    ADD CONSTRAINT recruiter_companies_pkey PRIMARY KEY (id);


--
-- Name: review_moderation review_moderation_pkey; Type: CONSTRAINT; Schema: discovery; Owner: postgres
--

ALTER TABLE ONLY discovery.review_moderation
    ADD CONSTRAINT review_moderation_pkey PRIMARY KEY (id);


--
-- Name: seo_metadata seo_metadata_entity_type_entity_id_key; Type: CONSTRAINT; Schema: discovery; Owner: postgres
--

ALTER TABLE ONLY discovery.seo_metadata
    ADD CONSTRAINT seo_metadata_entity_type_entity_id_key UNIQUE (entity_type, entity_id);


--
-- Name: seo_metadata seo_metadata_pkey; Type: CONSTRAINT; Schema: discovery; Owner: postgres
--

ALTER TABLE ONLY discovery.seo_metadata
    ADD CONSTRAINT seo_metadata_pkey PRIMARY KEY (id);


--
-- Name: streams streams_name_key; Type: CONSTRAINT; Schema: discovery; Owner: postgres
--

ALTER TABLE ONLY discovery.streams
    ADD CONSTRAINT streams_name_key UNIQUE (name);


--
-- Name: streams streams_pkey; Type: CONSTRAINT; Schema: discovery; Owner: postgres
--

ALTER TABLE ONLY discovery.streams
    ADD CONSTRAINT streams_pkey PRIMARY KEY (id);


--
-- Name: user_favorites user_favorites_pkey; Type: CONSTRAINT; Schema: discovery; Owner: postgres
--

ALTER TABLE ONLY discovery.user_favorites
    ADD CONSTRAINT user_favorites_pkey PRIMARY KEY (user_id, entity_type, entity_id);


--
-- Name: cities cities_pkey; Type: CONSTRAINT; Schema: geo_master; Owner: postgres
--

ALTER TABLE ONLY geo_master.cities
    ADD CONSTRAINT cities_pkey PRIMARY KEY (city_id);


--
-- Name: countries countries_country_code_key; Type: CONSTRAINT; Schema: geo_master; Owner: postgres
--

ALTER TABLE ONLY geo_master.countries
    ADD CONSTRAINT countries_country_code_key UNIQUE (country_code);


--
-- Name: countries countries_country_name_key; Type: CONSTRAINT; Schema: geo_master; Owner: postgres
--

ALTER TABLE ONLY geo_master.countries
    ADD CONSTRAINT countries_country_name_key UNIQUE (country_name);


--
-- Name: countries countries_pkey; Type: CONSTRAINT; Schema: geo_master; Owner: postgres
--

ALTER TABLE ONLY geo_master.countries
    ADD CONSTRAINT countries_pkey PRIMARY KEY (country_id);


--
-- Name: states states_pkey; Type: CONSTRAINT; Schema: geo_master; Owner: postgres
--

ALTER TABLE ONLY geo_master.states
    ADD CONSTRAINT states_pkey PRIMARY KEY (state_id);


--
-- Name: admin_audit_logs admin_audit_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_audit_logs
    ADD CONSTRAINT admin_audit_logs_pkey PRIMARY KEY (log_id);


--
-- Name: admin_sessions admin_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_sessions
    ADD CONSTRAINT admin_sessions_pkey PRIMARY KEY (session_id);


--
-- Name: admin_users admin_users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_users
    ADD CONSTRAINT admin_users_email_key UNIQUE (email);


--
-- Name: admin_users admin_users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_users
    ADD CONSTRAINT admin_users_pkey PRIMARY KEY (admin_id);


--
-- Name: audit_log audit_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.audit_log
    ADD CONSTRAINT audit_log_pkey PRIMARY KEY (id);


--
-- Name: banner_analytics banner_analytics_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.banner_analytics
    ADD CONSTRAINT banner_analytics_pkey PRIMARY KEY (id);


--
-- Name: banners banners_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.banners
    ADD CONSTRAINT banners_pkey PRIMARY KEY (id);


--
-- Name: college_facilities college_facilities_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.college_facilities
    ADD CONSTRAINT college_facilities_pkey PRIMARY KEY (facility_id);


--
-- Name: college_media college_media_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.college_media
    ADD CONSTRAINT college_media_pkey PRIMARY KEY (media_id);


--
-- Name: college_rankings college_rankings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.college_rankings
    ADD CONSTRAINT college_rankings_pkey PRIMARY KEY (ranking_id);


--
-- Name: colleges colleges_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.colleges
    ADD CONSTRAINT colleges_pkey PRIMARY KEY (college_id);


--
-- Name: colleges colleges_slug_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.colleges
    ADD CONSTRAINT colleges_slug_key UNIQUE (slug);


--
-- Name: community_answers community_answers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.community_answers
    ADD CONSTRAINT community_answers_pkey PRIMARY KEY (answer_id);


--
-- Name: community_questions community_questions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.community_questions
    ADD CONSTRAINT community_questions_pkey PRIMARY KEY (question_id);


--
-- Name: contact_queries contact_queries_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contact_queries
    ADD CONSTRAINT contact_queries_pkey PRIMARY KEY (id);


--
-- Name: courses courses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.courses
    ADD CONSTRAINT courses_pkey PRIMARY KEY (course_id);


--
-- Name: education_loans education_loans_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.education_loans
    ADD CONSTRAINT education_loans_pkey PRIMARY KEY (loan_id);


--
-- Name: exam_cutoffs exam_cutoffs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exam_cutoffs
    ADD CONSTRAINT exam_cutoffs_pkey PRIMARY KEY (cutoff_id);


--
-- Name: exam_schedules exam_schedules_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exam_schedules
    ADD CONSTRAINT exam_schedules_pkey PRIMARY KEY (schedule_id);


--
-- Name: exams exams_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exams
    ADD CONSTRAINT exams_pkey PRIMARY KEY (exam_id);


--
-- Name: exams exams_slug_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exams
    ADD CONSTRAINT exams_slug_key UNIQUE (slug);


--
-- Name: faqs faqs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.faqs
    ADD CONSTRAINT faqs_pkey PRIMARY KEY (id);


--
-- Name: institute_accounts institute_accounts_institution_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.institute_accounts
    ADD CONSTRAINT institute_accounts_institution_id_key UNIQUE (institution_id);


--
-- Name: institute_accounts institute_accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.institute_accounts
    ADD CONSTRAINT institute_accounts_pkey PRIMARY KEY (id);


--
-- Name: institute_users institute_users_institution_id_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.institute_users
    ADD CONSTRAINT institute_users_institution_id_user_id_key UNIQUE (institution_id, user_id);


--
-- Name: institute_users institute_users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.institute_users
    ADD CONSTRAINT institute_users_pkey PRIMARY KEY (id);


--
-- Name: job_postings job_postings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.job_postings
    ADD CONSTRAINT job_postings_pkey PRIMARY KEY (id);


--
-- Name: news_articles news_articles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.news_articles
    ADD CONSTRAINT news_articles_pkey PRIMARY KEY (article_id);


--
-- Name: news_articles news_articles_slug_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.news_articles
    ADD CONSTRAINT news_articles_slug_key UNIQUE (slug);


--
-- Name: newsletter_subscribers newsletter_subscribers_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.newsletter_subscribers
    ADD CONSTRAINT newsletter_subscribers_email_key UNIQUE (email);


--
-- Name: newsletter_subscribers newsletter_subscribers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.newsletter_subscribers
    ADD CONSTRAINT newsletter_subscribers_pkey PRIMARY KEY (id);


--
-- Name: notification_preferences notification_preferences_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification_preferences
    ADD CONSTRAINT notification_preferences_pkey PRIMARY KEY (id);


--
-- Name: notification_preferences notification_preferences_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification_preferences
    ADD CONSTRAINT notification_preferences_user_id_key UNIQUE (user_id);


--
-- Name: notifications notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_pkey PRIMARY KEY (notification_id);


--
-- Name: password_resets password_resets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.password_resets
    ADD CONSTRAINT password_resets_pkey PRIMARY KEY (id);


--
-- Name: payments payments_order_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_order_id_key UNIQUE (order_id);


--
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (payment_id);


--
-- Name: placements placements_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.placements
    ADD CONSTRAINT placements_pkey PRIMARY KEY (placement_id);


--
-- Name: questions questions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT questions_pkey PRIMARY KEY (question_id);


--
-- Name: ranking_agencies ranking_agencies_agency_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ranking_agencies
    ADD CONSTRAINT ranking_agencies_agency_code_key UNIQUE (agency_code);


--
-- Name: ranking_agencies ranking_agencies_agency_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ranking_agencies
    ADD CONSTRAINT ranking_agencies_agency_name_key UNIQUE (agency_name);


--
-- Name: ranking_agencies ranking_agencies_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ranking_agencies
    ADD CONSTRAINT ranking_agencies_pkey PRIMARY KEY (agency_id);


--
-- Name: reviews reviews_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_pkey PRIMARY KEY (review_id);


--
-- Name: roles roles_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_name_key UNIQUE (name);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: saved_items saved_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.saved_items
    ADD CONSTRAINT saved_items_pkey PRIMARY KEY (saved_id);


--
-- Name: saved_items saved_items_user_id_item_type_item_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.saved_items
    ADD CONSTRAINT saved_items_user_id_item_type_item_id_key UNIQUE (user_id, item_type, item_id);


--
-- Name: scholarships scholarships_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scholarships
    ADD CONSTRAINT scholarships_pkey PRIMARY KEY (scholarship_id);


--
-- Name: scholarships scholarships_slug_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scholarships
    ADD CONSTRAINT scholarships_slug_key UNIQUE (slug);


--
-- Name: search_logs search_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.search_logs
    ADD CONSTRAINT search_logs_pkey PRIMARY KEY (search_id);


--
-- Name: site_notifications site_notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.site_notifications
    ADD CONSTRAINT site_notifications_pkey PRIMARY KEY (id);


--
-- Name: system_settings system_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.system_settings
    ADD CONSTRAINT system_settings_pkey PRIMARY KEY (id);


--
-- Name: system_settings system_settings_setting_key_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.system_settings
    ADD CONSTRAINT system_settings_setting_key_key UNIQUE (setting_key);


--
-- Name: team_members team_members_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.team_members
    ADD CONSTRAINT team_members_pkey PRIMARY KEY (id);


--
-- Name: test_attempts test_attempts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test_attempts
    ADD CONSTRAINT test_attempts_pkey PRIMARY KEY (attempt_id);


--
-- Name: test_series test_series_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test_series
    ADD CONSTRAINT test_series_pkey PRIMARY KEY (series_id);


--
-- Name: testimonials testimonials_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.testimonials
    ADD CONSTRAINT testimonials_pkey PRIMARY KEY (id);


--
-- Name: tests tests_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tests
    ADD CONSTRAINT tests_pkey PRIMARY KEY (test_id);


--
-- Name: user_consents user_consents_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consents
    ADD CONSTRAINT user_consents_pkey PRIMARY KEY (id);


--
-- Name: user_profiles user_profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_profiles
    ADD CONSTRAINT user_profiles_pkey PRIMARY KEY (profile_id);


--
-- Name: user_roles user_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_pkey PRIMARY KEY (user_id, role_id);


--
-- Name: user_sessions user_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_sessions
    ADD CONSTRAINT user_sessions_pkey PRIMARY KEY (session_id);


--
-- Name: user_sessions user_sessions_session_token_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_sessions
    ADD CONSTRAINT user_sessions_session_token_key UNIQUE (session_token);


--
-- Name: user_verifications user_verifications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_verifications
    ADD CONSTRAINT user_verifications_pkey PRIMARY KEY (id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: idx_activity_user_time; Type: INDEX; Schema: analytics; Owner: postgres
--

CREATE INDEX idx_activity_user_time ON analytics.user_activity USING btree (user_id, created_at);


--
-- Name: idx_counselling_sessions_lead; Type: INDEX; Schema: analytics; Owner: postgres
--

CREATE INDEX idx_counselling_sessions_lead ON analytics.counselling_sessions USING btree (lead_id);


--
-- Name: idx_leads_assigned_status; Type: INDEX; Schema: analytics; Owner: postgres
--

CREATE INDEX idx_leads_assigned_status ON analytics.leads USING btree (assigned_to, status);


--
-- Name: idx_leads_institution; Type: INDEX; Schema: analytics; Owner: postgres
--

CREATE INDEX idx_leads_institution ON analytics.leads USING btree (institution_id);


--
-- Name: idx_payments_user; Type: INDEX; Schema: analytics; Owner: postgres
--

CREATE INDEX idx_payments_user ON analytics.payments USING btree (user_id);


--
-- Name: idx_applications_user; Type: INDEX; Schema: discovery; Owner: postgres
--

CREATE INDEX idx_applications_user ON discovery.applications USING btree (user_id);


--
-- Name: idx_brochures_inst; Type: INDEX; Schema: discovery; Owner: postgres
--

CREATE INDEX idx_brochures_inst ON discovery.institution_brochures USING btree (institution_id);


--
-- Name: idx_inst_affiliation_inst; Type: INDEX; Schema: discovery; Owner: postgres
--

CREATE INDEX idx_inst_affiliation_inst ON discovery.institution_affiliations USING btree (institution_id);


--
-- Name: idx_inst_approvals_inst; Type: INDEX; Schema: discovery; Owner: postgres
--

CREATE INDEX idx_inst_approvals_inst ON discovery.institution_approvals USING btree (institution_id);


--
-- Name: idx_inst_facility_inst; Type: INDEX; Schema: discovery; Owner: postgres
--

CREATE INDEX idx_inst_facility_inst ON discovery.institution_facilities USING btree (institution_id);


--
-- Name: idx_inst_highlights_inst; Type: INDEX; Schema: discovery; Owner: postgres
--

CREATE INDEX idx_inst_highlights_inst ON discovery.institution_highlights USING btree (institution_id);


--
-- Name: idx_institution_courses_inst_course; Type: INDEX; Schema: discovery; Owner: postgres
--

CREATE INDEX idx_institution_courses_inst_course ON discovery.institution_courses USING btree (institution_id, course_id);


--
-- Name: idx_qna_inst; Type: INDEX; Schema: discovery; Owner: postgres
--

CREATE INDEX idx_qna_inst ON discovery.qna USING btree (institution_id);


--
-- Name: idx_videos_inst; Type: INDEX; Schema: discovery; Owner: postgres
--

CREATE INDEX idx_videos_inst ON discovery.institution_videos USING btree (institution_id);


--
-- Name: idx_answer_question; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_answer_question ON public.community_answers USING btree (question_id);


--
-- Name: idx_article_category; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_article_category ON public.news_articles USING btree (category);


--
-- Name: idx_article_slug; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_article_slug ON public.news_articles USING btree (slug);


--
-- Name: idx_attempt_test; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_attempt_test ON public.test_attempts USING btree (test_id);


--
-- Name: idx_attempt_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_attempt_user ON public.test_attempts USING btree (user_id);


--
-- Name: idx_audit_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_audit_user ON public.audit_log USING btree (user_id);


--
-- Name: idx_banners_placement; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_banners_placement ON public.banners USING btree (placement);


--
-- Name: idx_college_location; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_college_location ON public.colleges USING btree (state, city);


--
-- Name: idx_college_name_search; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_college_name_search ON public.colleges USING gin (to_tsvector('english'::regconfig, (college_name)::text));


--
-- Name: idx_college_slug; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_college_slug ON public.colleges USING btree (slug);


--
-- Name: idx_courses_college_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_courses_college_id ON public.courses USING btree (college_id);


--
-- Name: idx_courses_degree_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_courses_degree_type ON public.courses USING btree (degree_type);


--
-- Name: idx_courses_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_courses_status ON public.courses USING btree (status);


--
-- Name: idx_courses_stream; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_courses_stream ON public.courses USING btree (stream);


--
-- Name: idx_cutoff_college; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_cutoff_college ON public.exam_cutoffs USING btree (college_id);


--
-- Name: idx_cutoff_exam; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_cutoff_exam ON public.exam_cutoffs USING btree (exam_id);


--
-- Name: idx_exam_category; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_exam_category ON public.exams USING btree (exam_category);


--
-- Name: idx_exam_slug; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_exam_slug ON public.exams USING btree (slug);


--
-- Name: idx_facility_college; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_facility_college ON public.college_facilities USING btree (college_id);


--
-- Name: idx_faqs_category; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_faqs_category ON public.faqs USING btree (category);


--
-- Name: idx_loan_provider; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_loan_provider ON public.education_loans USING btree (loan_provider);


--
-- Name: idx_media_college; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_media_college ON public.college_media USING btree (college_id);


--
-- Name: idx_newsletter_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_newsletter_email ON public.newsletter_subscribers USING btree (email);


--
-- Name: idx_notification_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_notification_status ON public.notifications USING btree (status);


--
-- Name: idx_notification_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_notification_user ON public.notifications USING btree (user_id);


--
-- Name: idx_password_resets_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_password_resets_user ON public.password_resets USING btree (user_id);


--
-- Name: idx_payment_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_payment_status ON public.payments USING btree (payment_status);


--
-- Name: idx_payment_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_payment_user ON public.payments USING btree (user_id);


--
-- Name: idx_placement_college; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_placement_college ON public.placements USING btree (college_id);


--
-- Name: idx_profile_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_profile_user ON public.user_profiles USING btree (user_id);


--
-- Name: idx_question_college; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_question_college ON public.community_questions USING btree (college_id);


--
-- Name: idx_question_test; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_question_test ON public.questions USING btree (test_id);


--
-- Name: idx_question_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_question_user ON public.community_questions USING btree (user_id);


--
-- Name: idx_ranking_college; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_ranking_college ON public.college_rankings USING btree (college_id);


--
-- Name: idx_ranking_year; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_ranking_year ON public.college_rankings USING btree (ranking_year);


--
-- Name: idx_review_college; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_review_college ON public.reviews USING btree (college_id);


--
-- Name: idx_review_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_review_status ON public.reviews USING btree (status);


--
-- Name: idx_review_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_review_user ON public.reviews USING btree (user_id);


--
-- Name: idx_reviews_college_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_reviews_college_id ON public.reviews USING btree (college_id);


--
-- Name: idx_reviews_created_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_reviews_created_at ON public.reviews USING btree (created_at);


--
-- Name: idx_reviews_deleted_at; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_reviews_deleted_at ON public.reviews USING btree (deleted_at);


--
-- Name: idx_reviews_status; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_reviews_status ON public.reviews USING btree (status);


--
-- Name: idx_reviews_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_reviews_user_id ON public.reviews USING btree (user_id);


--
-- Name: idx_saved_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_saved_user ON public.saved_items USING btree (user_id);


--
-- Name: idx_schedule_exam; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_schedule_exam ON public.exam_schedules USING btree (exam_id);


--
-- Name: idx_scholarship_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_scholarship_type ON public.scholarships USING btree (scholarship_type);


--
-- Name: idx_search_created; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_search_created ON public.search_logs USING btree (created_at);


--
-- Name: idx_search_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_search_user ON public.search_logs USING btree (user_id);


--
-- Name: idx_series_exam; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_series_exam ON public.test_series USING btree (exam_id);


--
-- Name: idx_session_token; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_session_token ON public.user_sessions USING btree (session_token);


--
-- Name: idx_session_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_session_user ON public.user_sessions USING btree (user_id);


--
-- Name: idx_site_notifications_active; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_site_notifications_active ON public.site_notifications USING btree (is_active, valid_from, valid_to);


--
-- Name: idx_test_series; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_test_series ON public.tests USING btree (series_id);


--
-- Name: idx_user_consents_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_consents_user ON public.user_consents USING btree (user_id);


--
-- Name: idx_user_verifications_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_verifications_user ON public.user_verifications USING btree (user_id);


--
-- Name: idx_users_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_users_email ON public.users USING btree (email);


--
-- Name: idx_users_phone; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_users_phone ON public.users USING btree (phone);


--
-- Name: idx_users_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_users_type ON public.users USING btree (user_type);


--
-- Name: counselling_sessions counselling_sessions_counsellor_id_fkey; Type: FK CONSTRAINT; Schema: analytics; Owner: postgres
--

ALTER TABLE ONLY analytics.counselling_sessions
    ADD CONSTRAINT counselling_sessions_counsellor_id_fkey FOREIGN KEY (counsellor_id) REFERENCES public.users(user_id) ON DELETE SET NULL;


--
-- Name: counselling_sessions counselling_sessions_lead_id_fkey; Type: FK CONSTRAINT; Schema: analytics; Owner: postgres
--

ALTER TABLE ONLY analytics.counselling_sessions
    ADD CONSTRAINT counselling_sessions_lead_id_fkey FOREIGN KEY (lead_id) REFERENCES analytics.leads(id) ON DELETE CASCADE;


--
-- Name: lead_notes lead_notes_lead_id_fkey; Type: FK CONSTRAINT; Schema: analytics; Owner: postgres
--

ALTER TABLE ONLY analytics.lead_notes
    ADD CONSTRAINT lead_notes_lead_id_fkey FOREIGN KEY (lead_id) REFERENCES analytics.leads(id) ON DELETE CASCADE;


--
-- Name: lead_notes lead_notes_user_id_fkey; Type: FK CONSTRAINT; Schema: analytics; Owner: postgres
--

ALTER TABLE ONLY analytics.lead_notes
    ADD CONSTRAINT lead_notes_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE SET NULL;


--
-- Name: leads leads_assigned_to_fkey; Type: FK CONSTRAINT; Schema: analytics; Owner: postgres
--

ALTER TABLE ONLY analytics.leads
    ADD CONSTRAINT leads_assigned_to_fkey FOREIGN KEY (assigned_to) REFERENCES public.users(user_id) ON DELETE SET NULL;


--
-- Name: leads leads_institution_id_fkey; Type: FK CONSTRAINT; Schema: analytics; Owner: postgres
--

ALTER TABLE ONLY analytics.leads
    ADD CONSTRAINT leads_institution_id_fkey FOREIGN KEY (institution_id) REFERENCES public.colleges(college_id) ON DELETE SET NULL;


--
-- Name: leads leads_user_id_fkey; Type: FK CONSTRAINT; Schema: analytics; Owner: postgres
--

ALTER TABLE ONLY analytics.leads
    ADD CONSTRAINT leads_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE SET NULL;


--
-- Name: payments payments_institution_id_fkey; Type: FK CONSTRAINT; Schema: analytics; Owner: postgres
--

ALTER TABLE ONLY analytics.payments
    ADD CONSTRAINT payments_institution_id_fkey FOREIGN KEY (institution_id) REFERENCES public.colleges(college_id);


--
-- Name: payments payments_user_id_fkey; Type: FK CONSTRAINT; Schema: analytics; Owner: postgres
--

ALTER TABLE ONLY analytics.payments
    ADD CONSTRAINT payments_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: user_activity user_activity_user_id_fkey; Type: FK CONSTRAINT; Schema: analytics; Owner: postgres
--

ALTER TABLE ONLY analytics.user_activity
    ADD CONSTRAINT user_activity_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- Name: application_documents application_documents_application_id_fkey; Type: FK CONSTRAINT; Schema: discovery; Owner: postgres
--

ALTER TABLE ONLY discovery.application_documents
    ADD CONSTRAINT application_documents_application_id_fkey FOREIGN KEY (application_id) REFERENCES discovery.applications(id) ON DELETE CASCADE;


--
-- Name: application_documents application_documents_verified_by_fkey; Type: FK CONSTRAINT; Schema: discovery; Owner: postgres
--

ALTER TABLE ONLY discovery.application_documents
    ADD CONSTRAINT application_documents_verified_by_fkey FOREIGN KEY (verified_by) REFERENCES public.users(user_id);


--
-- Name: applications applications_institution_course_id_fkey; Type: FK CONSTRAINT; Schema: discovery; Owner: postgres
--

ALTER TABLE ONLY discovery.applications
    ADD CONSTRAINT applications_institution_course_id_fkey FOREIGN KEY (institution_course_id) REFERENCES discovery.institution_courses(id) ON DELETE CASCADE;


--
-- Name: applications applications_user_id_fkey; Type: FK CONSTRAINT; Schema: discovery; Owner: postgres
--

ALTER TABLE ONLY discovery.applications
    ADD CONSTRAINT applications_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- Name: course_admissions course_admissions_institution_course_id_fkey; Type: FK CONSTRAINT; Schema: discovery; Owner: postgres
--

ALTER TABLE ONLY discovery.course_admissions
    ADD CONSTRAINT course_admissions_institution_course_id_fkey FOREIGN KEY (institution_course_id) REFERENCES discovery.institution_courses(id) ON DELETE CASCADE;


--
-- Name: course_fees course_fees_institution_course_id_fkey; Type: FK CONSTRAINT; Schema: discovery; Owner: postgres
--

ALTER TABLE ONLY discovery.course_fees
    ADD CONSTRAINT course_fees_institution_course_id_fkey FOREIGN KEY (institution_course_id) REFERENCES discovery.institution_courses(id) ON DELETE CASCADE;


--
-- Name: course_specializations course_specializations_institution_course_id_fkey; Type: FK CONSTRAINT; Schema: discovery; Owner: postgres
--

ALTER TABLE ONLY discovery.course_specializations
    ADD CONSTRAINT course_specializations_institution_course_id_fkey FOREIGN KEY (institution_course_id) REFERENCES discovery.institution_courses(id) ON DELETE CASCADE;


--
-- Name: institution_affiliations institution_affiliations_institution_id_fkey; Type: FK CONSTRAINT; Schema: discovery; Owner: postgres
--

ALTER TABLE ONLY discovery.institution_affiliations
    ADD CONSTRAINT institution_affiliations_institution_id_fkey FOREIGN KEY (institution_id) REFERENCES public.colleges(college_id) ON DELETE CASCADE;


--
-- Name: institution_approvals institution_approvals_institution_id_fkey; Type: FK CONSTRAINT; Schema: discovery; Owner: postgres
--

ALTER TABLE ONLY discovery.institution_approvals
    ADD CONSTRAINT institution_approvals_institution_id_fkey FOREIGN KEY (institution_id) REFERENCES public.colleges(college_id) ON DELETE CASCADE;


--
-- Name: institution_brochures institution_brochures_institution_id_fkey; Type: FK CONSTRAINT; Schema: discovery; Owner: postgres
--

ALTER TABLE ONLY discovery.institution_brochures
    ADD CONSTRAINT institution_brochures_institution_id_fkey FOREIGN KEY (institution_id) REFERENCES public.colleges(college_id) ON DELETE CASCADE;


--
-- Name: institution_courses institution_courses_institution_id_fkey; Type: FK CONSTRAINT; Schema: discovery; Owner: postgres
--

ALTER TABLE ONLY discovery.institution_courses
    ADD CONSTRAINT institution_courses_institution_id_fkey FOREIGN KEY (institution_id) REFERENCES public.colleges(college_id) ON DELETE CASCADE;


--
-- Name: institution_facilities institution_facilities_facility_id_fkey; Type: FK CONSTRAINT; Schema: discovery; Owner: postgres
--

ALTER TABLE ONLY discovery.institution_facilities
    ADD CONSTRAINT institution_facilities_facility_id_fkey FOREIGN KEY (facility_id) REFERENCES discovery.facilities(id) ON DELETE CASCADE;


--
-- Name: institution_facilities institution_facilities_institution_id_fkey; Type: FK CONSTRAINT; Schema: discovery; Owner: postgres
--

ALTER TABLE ONLY discovery.institution_facilities
    ADD CONSTRAINT institution_facilities_institution_id_fkey FOREIGN KEY (institution_id) REFERENCES public.colleges(college_id) ON DELETE CASCADE;


--
-- Name: institution_highlights institution_highlights_institution_id_fkey; Type: FK CONSTRAINT; Schema: discovery; Owner: postgres
--

ALTER TABLE ONLY discovery.institution_highlights
    ADD CONSTRAINT institution_highlights_institution_id_fkey FOREIGN KEY (institution_id) REFERENCES public.colleges(college_id) ON DELETE CASCADE;


--
-- Name: institution_videos institution_videos_institution_id_fkey; Type: FK CONSTRAINT; Schema: discovery; Owner: postgres
--

ALTER TABLE ONLY discovery.institution_videos
    ADD CONSTRAINT institution_videos_institution_id_fkey FOREIGN KEY (institution_id) REFERENCES public.colleges(college_id) ON DELETE CASCADE;


--
-- Name: qna qna_answered_by_fkey; Type: FK CONSTRAINT; Schema: discovery; Owner: postgres
--

ALTER TABLE ONLY discovery.qna
    ADD CONSTRAINT qna_answered_by_fkey FOREIGN KEY (answered_by) REFERENCES public.users(user_id) ON DELETE SET NULL;


--
-- Name: qna qna_institution_id_fkey; Type: FK CONSTRAINT; Schema: discovery; Owner: postgres
--

ALTER TABLE ONLY discovery.qna
    ADD CONSTRAINT qna_institution_id_fkey FOREIGN KEY (institution_id) REFERENCES public.colleges(college_id) ON DELETE CASCADE;


--
-- Name: qna qna_user_id_fkey; Type: FK CONSTRAINT; Schema: discovery; Owner: postgres
--

ALTER TABLE ONLY discovery.qna
    ADD CONSTRAINT qna_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE SET NULL;


--
-- Name: qna_votes qna_votes_qna_id_fkey; Type: FK CONSTRAINT; Schema: discovery; Owner: postgres
--

ALTER TABLE ONLY discovery.qna_votes
    ADD CONSTRAINT qna_votes_qna_id_fkey FOREIGN KEY (qna_id) REFERENCES discovery.qna(id) ON DELETE CASCADE;


--
-- Name: qna_votes qna_votes_user_id_fkey; Type: FK CONSTRAINT; Schema: discovery; Owner: postgres
--

ALTER TABLE ONLY discovery.qna_votes
    ADD CONSTRAINT qna_votes_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- Name: review_moderation review_moderation_moderated_by_fkey; Type: FK CONSTRAINT; Schema: discovery; Owner: postgres
--

ALTER TABLE ONLY discovery.review_moderation
    ADD CONSTRAINT review_moderation_moderated_by_fkey FOREIGN KEY (moderated_by) REFERENCES public.users(user_id);


--
-- Name: review_moderation review_moderation_review_id_fkey; Type: FK CONSTRAINT; Schema: discovery; Owner: postgres
--

ALTER TABLE ONLY discovery.review_moderation
    ADD CONSTRAINT review_moderation_review_id_fkey FOREIGN KEY (review_id) REFERENCES public.reviews(review_id) ON DELETE CASCADE;


--
-- Name: user_favorites user_favorites_user_id_fkey; Type: FK CONSTRAINT; Schema: discovery; Owner: postgres
--

ALTER TABLE ONLY discovery.user_favorites
    ADD CONSTRAINT user_favorites_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: cities cities_state_id_fkey; Type: FK CONSTRAINT; Schema: geo_master; Owner: postgres
--

ALTER TABLE ONLY geo_master.cities
    ADD CONSTRAINT cities_state_id_fkey FOREIGN KEY (state_id) REFERENCES geo_master.states(state_id);


--
-- Name: states states_country_id_fkey; Type: FK CONSTRAINT; Schema: geo_master; Owner: postgres
--

ALTER TABLE ONLY geo_master.states
    ADD CONSTRAINT states_country_id_fkey FOREIGN KEY (country_id) REFERENCES geo_master.countries(country_id);


--
-- Name: admin_audit_logs admin_audit_logs_admin_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_audit_logs
    ADD CONSTRAINT admin_audit_logs_admin_id_fkey FOREIGN KEY (admin_id) REFERENCES public.admin_users(admin_id);


--
-- Name: admin_sessions admin_sessions_admin_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_sessions
    ADD CONSTRAINT admin_sessions_admin_id_fkey FOREIGN KEY (admin_id) REFERENCES public.admin_users(admin_id);


--
-- Name: audit_log audit_log_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.audit_log
    ADD CONSTRAINT audit_log_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE SET NULL;


--
-- Name: banner_analytics banner_analytics_banner_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.banner_analytics
    ADD CONSTRAINT banner_analytics_banner_id_fkey FOREIGN KEY (banner_id) REFERENCES public.banners(id) ON DELETE CASCADE;


--
-- Name: banner_analytics banner_analytics_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.banner_analytics
    ADD CONSTRAINT banner_analytics_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: banners banners_created_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.banners
    ADD CONSTRAINT banners_created_by_fkey FOREIGN KEY (created_by) REFERENCES public.users(user_id);


--
-- Name: college_facilities college_facilities_college_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.college_facilities
    ADD CONSTRAINT college_facilities_college_id_fkey FOREIGN KEY (college_id) REFERENCES public.colleges(college_id) ON DELETE CASCADE;


--
-- Name: college_media college_media_college_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.college_media
    ADD CONSTRAINT college_media_college_id_fkey FOREIGN KEY (college_id) REFERENCES public.colleges(college_id) ON DELETE CASCADE;


--
-- Name: college_rankings college_rankings_agency_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.college_rankings
    ADD CONSTRAINT college_rankings_agency_id_fkey FOREIGN KEY (agency_id) REFERENCES public.ranking_agencies(agency_id);


--
-- Name: college_rankings college_rankings_college_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.college_rankings
    ADD CONSTRAINT college_rankings_college_id_fkey FOREIGN KEY (college_id) REFERENCES public.colleges(college_id) ON DELETE CASCADE;


--
-- Name: community_answers community_answers_question_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.community_answers
    ADD CONSTRAINT community_answers_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.community_questions(question_id) ON DELETE CASCADE;


--
-- Name: community_answers community_answers_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.community_answers
    ADD CONSTRAINT community_answers_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE SET NULL;


--
-- Name: community_questions community_questions_college_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.community_questions
    ADD CONSTRAINT community_questions_college_id_fkey FOREIGN KEY (college_id) REFERENCES public.colleges(college_id);


--
-- Name: community_questions community_questions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.community_questions
    ADD CONSTRAINT community_questions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE SET NULL;


--
-- Name: contact_queries contact_queries_assigned_to_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.contact_queries
    ADD CONSTRAINT contact_queries_assigned_to_fkey FOREIGN KEY (assigned_to) REFERENCES public.users(user_id) ON DELETE SET NULL;


--
-- Name: courses courses_college_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.courses
    ADD CONSTRAINT courses_college_id_fkey FOREIGN KEY (college_id) REFERENCES public.colleges(college_id) ON DELETE CASCADE;


--
-- Name: exam_cutoffs exam_cutoffs_college_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exam_cutoffs
    ADD CONSTRAINT exam_cutoffs_college_id_fkey FOREIGN KEY (college_id) REFERENCES public.colleges(college_id) ON DELETE CASCADE;


--
-- Name: exam_cutoffs exam_cutoffs_exam_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exam_cutoffs
    ADD CONSTRAINT exam_cutoffs_exam_id_fkey FOREIGN KEY (exam_id) REFERENCES public.exams(exam_id) ON DELETE CASCADE;


--
-- Name: exam_schedules exam_schedules_exam_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exam_schedules
    ADD CONSTRAINT exam_schedules_exam_id_fkey FOREIGN KEY (exam_id) REFERENCES public.exams(exam_id) ON DELETE CASCADE;


--
-- Name: institute_accounts institute_accounts_account_manager_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.institute_accounts
    ADD CONSTRAINT institute_accounts_account_manager_id_fkey FOREIGN KEY (account_manager_id) REFERENCES public.users(user_id);


--
-- Name: institute_accounts institute_accounts_institution_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.institute_accounts
    ADD CONSTRAINT institute_accounts_institution_id_fkey FOREIGN KEY (institution_id) REFERENCES public.colleges(college_id);


--
-- Name: institute_users institute_users_institution_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.institute_users
    ADD CONSTRAINT institute_users_institution_id_fkey FOREIGN KEY (institution_id) REFERENCES public.colleges(college_id);


--
-- Name: institute_users institute_users_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.institute_users
    ADD CONSTRAINT institute_users_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: news_articles news_articles_author_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.news_articles
    ADD CONSTRAINT news_articles_author_id_fkey FOREIGN KEY (author_id) REFERENCES public.users(user_id);


--
-- Name: notification_preferences notification_preferences_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notification_preferences
    ADD CONSTRAINT notification_preferences_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- Name: notifications notifications_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.notifications
    ADD CONSTRAINT notifications_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- Name: password_resets password_resets_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.password_resets
    ADD CONSTRAINT password_resets_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- Name: payments payments_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: placements placements_college_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.placements
    ADD CONSTRAINT placements_college_id_fkey FOREIGN KEY (college_id) REFERENCES public.colleges(college_id) ON DELETE CASCADE;


--
-- Name: questions questions_test_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT questions_test_id_fkey FOREIGN KEY (test_id) REFERENCES public.tests(test_id) ON DELETE CASCADE;


--
-- Name: reviews reviews_college_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_college_id_fkey FOREIGN KEY (college_id) REFERENCES public.colleges(college_id) ON DELETE CASCADE;


--
-- Name: reviews reviews_replied_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_replied_by_fkey FOREIGN KEY (replied_by) REFERENCES public.users(user_id);


--
-- Name: reviews reviews_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reviews
    ADD CONSTRAINT reviews_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE SET NULL;


--
-- Name: saved_items saved_items_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.saved_items
    ADD CONSTRAINT saved_items_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- Name: search_logs search_logs_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.search_logs
    ADD CONSTRAINT search_logs_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: test_attempts test_attempts_test_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test_attempts
    ADD CONSTRAINT test_attempts_test_id_fkey FOREIGN KEY (test_id) REFERENCES public.tests(test_id) ON DELETE CASCADE;


--
-- Name: test_attempts test_attempts_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test_attempts
    ADD CONSTRAINT test_attempts_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- Name: test_series test_series_exam_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.test_series
    ADD CONSTRAINT test_series_exam_id_fkey FOREIGN KEY (exam_id) REFERENCES public.exams(exam_id);


--
-- Name: testimonials testimonials_institution_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.testimonials
    ADD CONSTRAINT testimonials_institution_id_fkey FOREIGN KEY (institution_id) REFERENCES public.colleges(college_id);


--
-- Name: tests tests_series_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tests
    ADD CONSTRAINT tests_series_id_fkey FOREIGN KEY (series_id) REFERENCES public.test_series(series_id) ON DELETE CASCADE;


--
-- Name: user_consents user_consents_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consents
    ADD CONSTRAINT user_consents_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: user_profiles user_profiles_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_profiles
    ADD CONSTRAINT user_profiles_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- Name: user_roles user_roles_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(id) ON DELETE CASCADE;


--
-- Name: user_roles user_roles_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT user_roles_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- Name: user_sessions user_sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_sessions
    ADD CONSTRAINT user_sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- Name: user_verifications user_verifications_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_verifications
    ADD CONSTRAINT user_verifications_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

