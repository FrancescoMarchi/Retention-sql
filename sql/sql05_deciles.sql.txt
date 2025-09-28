-- Q5.1: Churn by price decile
CREATE OR REPLACE VIEW retention.v_decile_churn AS
SELECT charge_decile,
       COUNT(*) AS customers,
       SUM(churn_flag::int) AS churners,
       ROUND(100.0*AVG(churn_flag::int),2) AS churn_pct,
       ROUND(AVG(monthly_charges),2) AS avg_monthly_charge
FROM retention.v_customers_features
GROUP BY charge_decile
ORDER BY charge_decile;

-- Q5.2: Churn by price decile × tenure bucket (pivot style)
CREATE OR REPLACE VIEW retention.v_decile_tenure_churn AS
SELECT charge_decile,
       ROUND(100.0*AVG(churn_flag::int) FILTER (WHERE tenure_bucket='0'),2) AS churn_0,
       ROUND(100.0*AVG(churn_flag::int) FILTER (WHERE tenure_bucket='01-06'),2) AS churn_01_06,
       ROUND(100.0*AVG(churn_flag::int) FILTER (WHERE tenure_bucket='07-12'),2) AS churn_07_12,
       ROUND(100.0*AVG(churn_flag::int) FILTER (WHERE tenure_bucket='13-24'),2) AS churn_13_24,
       ROUND(100.0*AVG(churn_flag::int) FILTER (WHERE tenure_bucket='25-48'),2) AS churn_25_48,
       ROUND(100.0*AVG(churn_flag::int) FILTER (WHERE tenure_bucket='49+'),2) AS churn_49_plus
FROM retention.v_customers_features
GROUP BY charge_decile
ORDER BY charge_decile;
