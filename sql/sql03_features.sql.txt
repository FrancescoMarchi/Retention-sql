-- 03_features.sql — adds tenure buckets + charge deciles (view)
SET search_path = retention, public;

DROP VIEW IF EXISTS v_customers_features;

CREATE VIEW v_customers_features AS
WITH ranked AS (
  SELECT
    c.*,
    NTILE(10) OVER (ORDER BY c.monthly_charges) AS charge_decile
  FROM customers c
)
SELECT
  r.*,
  CASE
    WHEN tenure_months IS NULL THEN 'unknown'
    WHEN tenure_months = 0     THEN '0'
    WHEN tenure_months BETWEEN 1 AND 6   THEN '01-06'
    WHEN tenure_months BETWEEN 7 AND 12  THEN '07-12'
    WHEN tenure_months BETWEEN 13 AND 24 THEN '13-24'
    WHEN tenure_months BETWEEN 25 AND 48 THEN '25-48'
    ELSE '49+'
  END AS tenure_bucket
FROM ranked r;

-- Quick peek:
-- SELECT charge_decile, tenure_bucket, COUNT(*) 
-- FROM v_customers_features GROUP BY 1,2 ORDER BY 1,2;
