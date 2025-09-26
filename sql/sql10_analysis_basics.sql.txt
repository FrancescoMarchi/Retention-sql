SET search_path = retention, public;

-- Headline metrics
SELECT COUNT(*) AS customers,
       SUM(churn_flag::int) AS churners,
       ROUND(100.0 * AVG(churn_flag::int), 2) AS churn_pct
FROM customers;

-- Numeric ranges / percentiles
WITH stats AS (
  SELECT
    MIN(tenure_months)  AS tenure_min,
    MAX(tenure_months)  AS tenure_max,
    percentile_disc(0.5)  WITHIN GROUP (ORDER BY tenure_months)   AS tenure_p50,
    percentile_disc(0.9)  WITHIN GROUP (ORDER BY tenure_months)   AS tenure_p90,
    MIN(monthly_charges) AS mc_min,
    MAX(monthly_charges) AS mc_max,
    percentile_disc(0.5)  WITHIN GROUP (ORDER BY monthly_charges) AS mc_p50,
    percentile_disc(0.9)  WITHIN GROUP (ORDER BY monthly_charges) AS mc_p90,
    MIN(total_charges)   AS tc_min,
    MAX(total_charges)   AS tc_max
  FROM customers
)
SELECT * FROM stats;

-- Null checks
SELECT
  SUM((tenure_months   IS NULL)::int) AS null_tenure,
  SUM((monthly_charges IS NULL)::int) AS null_monthly,
  SUM((total_charges   IS NULL)::int) AS null_total
FROM customers;

-- Distinct categorical values
SELECT 'contract_type' AS col, contract_type AS value, COUNT(*) AS n
FROM customers GROUP BY 1,2 ORDER BY 3 DESC;

SELECT 'payment_method' AS col, payment_method AS value, COUNT(*) AS n
FROM customers GROUP BY 1,2 ORDER BY 3 DESC;

SELECT 'internet_service' AS col, internet_service AS value, COUNT(*) AS n
FROM customers GROUP BY 1,2 ORDER BY 3 DESC;

-- Tenure buckets distribution (from features view)
SELECT tenure_bucket, COUNT(*) AS customers
FROM v_customers_features
GROUP BY 1
ORDER BY
  CASE tenure_bucket
    WHEN '0' THEN 0
    WHEN '01-06' THEN 1
    WHEN '07-12' THEN 2
    WHEN '13-24' THEN 3
    WHEN '25-48' THEN 4
    ELSE 5
  END;
