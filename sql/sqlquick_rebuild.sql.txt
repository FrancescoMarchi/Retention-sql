-- Rebuild retention schema & tables
CREATE SCHEMA IF NOT EXISTS retention;
SET search_path=retention,public;

-- Staging table
CREATE TABLE IF NOT EXISTS retention.stg_telco_raw (
    customerID text,
    gender text,
    SeniorCitizen text,
    Partner text,
    Dependents text,
    tenure text,
    PhoneService text,
    MultipleLines text,
    InternetService text,
    OnlineSecurity text,
    OnlineBackup text,
    DeviceProtection text,
    TechSupport text,
    StreamingTV text,
    StreamingMovies text,
    Contract text,
    PaperlessBilling text,
    PaymentMethod text,
    MonthlyCharges text,
    TotalCharges text,
    Churn text
);

-- Clean table
CREATE TABLE IF NOT EXISTS retention.customers (
    customer_id text PRIMARY KEY,
    gender text,
    senior_citizen boolean,
    partner boolean,
    dependents boolean,
    tenure_months integer,
    phone_service boolean,
    multiple_lines text,
    internet_service text,
    online_security text,
    online_backup text,
    device_protection text,
    tech_support text,
    streaming_tv text,
    streaming_movies text,
    contract_type text,
    paperless_billing boolean,
    payment_method text,
    monthly_charges numeric(10,2),
    total_charges numeric(12,2),
    churn_flag boolean
);

-- Features view
DROP VIEW IF EXISTS retention.v_customers_features;
CREATE VIEW retention.v_customers_features AS
WITH ranked AS (
    SELECT c.*, NTILE(10) OVER (ORDER BY c.monthly_charges) AS charge_decile
    FROM retention.customers c
)
SELECT r.*,
       CASE
         WHEN tenure_months IS NULL THEN 'unknown'
         WHEN tenure_months=0 THEN '0'
         WHEN tenure_months BETWEEN 1 AND 6 THEN '01-06'
         WHEN tenure_months BETWEEN 7 AND 12 THEN '07-12'
         WHEN tenure_months BETWEEN 13 AND 24 THEN '13-24'
         WHEN tenure_months BETWEEN 25 AND 48 THEN '25-48'
         ELSE '49+'
       END AS tenure_bucket
FROM ranked r;
