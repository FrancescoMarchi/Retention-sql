-- 02_cleaning.sql — transform RAW→CLEAN (typed), safe casts
SET search_path = retention, public;

TRUNCATE TABLE customers;

INSERT INTO customers (
  customer_id, gender, senior_citizen, partner, dependents,
  tenure_months, phone_service, multiple_lines, internet_service,
  online_security, online_backup, device_protection, tech_support,
  streaming_tv, streaming_movies, contract_type, paperless_billing,
  payment_method, monthly_charges, total_charges, churn_flag
)
SELECT
  s.customer_id,
  s.gender,
  (NULLIF(trim(s.senior_citizen),'')::int = 1)         AS senior_citizen,
  (lower(trim(s.partner))           = 'yes')           AS partner,
  (lower(trim(s.dependents))        = 'yes')           AS dependents,
  NULLIF(trim(s.tenure),'')::int                        AS tenure_months,
  (lower(trim(s.phone_service))     = 'yes')           AS phone_service,
  trim(s.multiple_lines)                                AS multiple_lines,
  trim(s.internet_service)                              AS internet_service,
  trim(s.online_security)                               AS online_security,
  trim(s.online_backup)                                 AS online_backup,
  trim(s.device_protection)                             AS device_protection,
  trim(s.tech_support)                                  AS tech_support,
  trim(s.streaming_tv)                                  AS streaming_tv,
  trim(s.streaming_movies)                              AS streaming_movies,
  trim(s.contract)                                      AS contract_type,
  (lower(trim(s.paperless_billing)) = 'yes')           AS paperless_billing,
  trim(s.payment_method)                                AS payment_method,
  NULLIF(trim(s.monthly_charges),'')::numeric(10,2)     AS monthly_charges,
  NULLIF(trim(s.total_charges),'')::numeric(12,2)       AS total_charges,
  (lower(trim(s.churn))              = 'yes')           AS churn_flag
FROM stg_telco_raw s;

-- Sanity checks (optional)
-- SELECT (SELECT COUNT(*) FROM stg_telco_raw) AS raw_rows,
--        (SELECT COUNT(*) FROM customers)     AS clean_rows;
-- SELECT churn_flag, COUNT(*) FROM customers GROUP BY 1 ORDER BY 1;
