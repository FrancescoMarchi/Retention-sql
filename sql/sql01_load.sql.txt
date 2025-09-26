-- 01_load.sql — we load via psql client (\copy) to avoid GUI issues
-- Steps we actually ran (copy/paste reference):

-- \c retention_sql
-- SET search_path = retention, public;
-- TRUNCATE TABLE stg_telco_raw;

-- \copy stg_telco_raw(
--   customer_id, gender, senior_citizen, partner, dependents, tenure,
--   phone_service, multiple_lines, internet_service, online_security, online_backup,
--   device_protection, tech_support, streaming_tv, streaming_movies, contract,
--   paperless_billing, payment_method, monthly_charges, total_charges, churn
-- )
-- FROM 'C:/Users/Francesco/Documents/GitHub projects/Retention-sql/data/telco_churn.csv'
-- WITH (FORMAT csv, HEADER true, DELIMITER ',', QUOTE '"');

-- Quick checks:
-- SELECT COUNT(*) FROM retention.stg_telco_raw;  -- expect 7043
