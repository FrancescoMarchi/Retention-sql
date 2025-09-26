# Retention SQL: From churn signals to action

**Goal:** Demonstrate interview-ready SQL and product thinking on churn/retention using the Telco Customer Churn dataset.

## Data & pipeline
- **Dataset:** Kaggle Telco Customer Churn (7,043 rows, 21 columns).
- **Pipeline:** CSV → `retention.stg_telco_raw` (raw text) → `retention.customers` (typed clean) → `v_customers_features` (derived fields).
- **Cleaning:** `TRIM` + `NULLIF` → casts to `INT/NUMERIC/BOOLEAN`.
- **Features view:** `tenure_bucket`, `charge_decile`.

> No real dates in the dataset → analyses use **relative tenure (Month 0..N)**.  
> Optional calendarization view can be added purely for display and will be labeled as synthetic.

## How to run (local Postgres)
1. Run `sql/00_schema.sql`
2. Import CSV via psql (`\copy`) as documented in `sql/01_load.sql`
3. Run `sql/02_cleaning.sql`
4. Run `sql/03_features.sql`
5. (Optional) Run `sql/10_analysis_basics.sql` for quick profiling

## Quick facts (after cleaning)
- Rows: 7,043; Churn ≈ 26–27%
- `TotalCharges` has 11 NULLs (tenure=0)
- Views don’t store data; they simplify BI/analysis.

## AI usage
Used an assistant to draft queries faster; all SQL reviewed/validated by me.
