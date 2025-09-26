-- 00_schema.sql — schema + raw & clean tables (Postgres)
CREATE SCHEMA IF NOT EXISTS retention;
SET search_path = retention, public;

-- RAW staging table (all text, matches CSV order)
DROP TABLE IF EXISTS stg_telco_raw;
CREATE TABLE stg_telco_raw (
  customer_id        text,
  gender             text,
  senior_citizen     text,
  partner            text,
  dependents         text,
  tenure             text,
  phone_service      text,
  multiple_lines     text,
  internet_service   text,
  online_security    text,
  online_backup      text,
  device_protection  text,
  tech_support       text,
  streaming_tv       text,
  streaming_movies   text,
  contract           text,
  paperless_billing  text,
  payment_method     text,
  monthly_charges    text,
  total_charges      text,
  churn              text
);

-- CLEAN typed table
DROP TABLE IF EXISTS customers;
CREATE TABLE customers (
  customer_id       text PRIMARY KEY,
  gender            text CHECK (gender IN ('Male','Female')),
  senior_citizen    boolean,
  partner           boolean,
  dependents        boolean,
  tenure_months     integer CHECK (tenure_months >= 0),
  phone_service     boolean,
  multiple_lines    text,
  internet_service  text,
  online_security   text,
  online_backup     text,
  device_protection text,
  tech_support      text,
  streaming_tv      text,
  streaming_movies  text,
  contract_type     text,
  paperless_billing boolean,
  payment_method    text,
  monthly_charges   numeric(10,2),
  total_charges     numeric(12,2),
  churn_flag        boolean
);

-- Helpful indexes
CREATE INDEX IF NOT EXISTS ix_customers_churn    ON customers (churn_flag);
CREATE INDEX IF NOT EXISTS ix_customers_contract ON customers (contract_type);
CREATE INDEX IF NOT EXISTS ix_customers_payment  ON customers (payment_method);
CREATE INDEX IF NOT EXISTS ix_customers_tenure   ON customers (tenure_months);
CREATE INDEX IF NOT EXISTS ix_customers_senior   ON customers (senior_citizen);
