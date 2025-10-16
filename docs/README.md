![Dashboard Cover](docs/visuals/Risk Drivers & Interventions.png)


📊 Customer Retention Analysis – SQL → Metabase → Power BI Pipeline

Objective:
Analyze churn behavior and retention drivers for a telecommunications company using SQL, Metabase, and Power BI — building a full modern analytics workflow from data extraction to executive visualization.

⚙️ Workflow Overview
Stage	Tool	Description
🧩 Data Modeling	PostgreSQL	SQL views created to clean, join, and aggregate customer data into analytical tables (v_customers_features, v_churn_summary, etc.)
🔍 Exploration	Metabase	Interactive visual exploration of churn by tenure, contract, tech support, gender, senior citizen, and partner — using dynamic filters connected to SQL queries
📈 Visualization	Power BI	Final executive dashboards with KPIs, combo charts, and slicers, following best-practice star schema modeling
🧠 What We Found

1️⃣ Churn is heavily front-loaded.
Over 50 % of churn occurs in the first six months of tenure — customer onboarding and early experience are critical retention windows.

2️⃣ Contract type is the strongest churn predictor.
Month-to-month customers churn 4× more than those on two-year contracts.

3️⃣ Lack of tech support doubles churn risk.
Customers without tech support have a 45 % high-risk rate vs 18 % for supported customers.

4️⃣ Senior and partner demographics show no major difference,
but their inclusion improved segmentation flexibility for dashboard filters.

🧮 Metrics & Measures (Power BI)
KPI	Formula (DAX)	Description
Total Customers	COUNTROWS(customers_features)	Total active customers
Churners	CALCULATE([Total Customers], customers_features[churn_flag] = TRUE())	Count of churned customers
Churn Rate %	DIVIDE([Churners], [Total Customers])	Share of churned customers
Retained	[Total Customers] - [Churners]	Still-active customers
High-Risk %	DIVIDE(CALCULATE([Total Customers], customers_features[risk_bucket]="High (5–6)"), [Total Customers])	Share of customers in top risk band
🧱 Data Model (Star Schema)
DimSenior      → customers_features ← DimPartner
                                 ↑
                              (fact)


DimSenior / DimPartner: Boolean “Yes/No” dimension tables mapped to boolean fields in customers_features

customers_features: Fact table containing customer IDs, churn flags, risk scores, service features, and demographic attributes

Relationships: Many-to-One, Single direction, no ambiguity

🧭 Key Visuals (Power BI)

(Insert screenshots here — three from your dashboard)

Customer Retention Overview: Combo chart of churn rate vs customer count by tenure group

Customer Risk Overview: Donut + combo chart of risk bucket distribution and churn intensity

Risk Drivers & Interventions: Tech support and contract type breakdowns with interactive slicers for senior, partner, and gender

🧰 Technical Highlights

Metabase SQL filters: Implemented field-linked text + boolean filters ([[AND gender={{gender}}]], etc.)

Boolean conversion: Added Power Query columns (SeniorBool, PartnerBool) to replace 0/1 flags with logical types

Dynamic relationships: Built clean dimension tables (DimSenior, DimPartner) using DATATABLE()

Cross-tool consistency: Verified same insights in Metabase and Power BI

🚀 Recommendations

Introduce loyalty incentives after 6 months to counter early churn.

Encourage contract upgrades via retention campaigns.

Prioritize proactive outreach to customers without tech support.

🖼️ Demo Material

📸 /assets/screenshots/

retention_overview.png

risk_overview.png

drivers_interventions.png

🎥 /assets/demo/

retention_dashboard_demo.mp4 (~15 s scrolling video recommended)

💬 Summary

This project demonstrates a full analytics pipeline:

SQL modeling in PostgreSQL

Business-oriented exploration in Metabase

Final storytelling dashboard in Power BI

It combines strong data modeling, modern BI integration, and communication of actionable insights — exactly what employers look for in data analysts.

## 👤 Author
**Francesco Marchì**  
📍 Ho Chi Minh City, Vietnam  
📧 [marchi.frncsc@gmail.com]  
🔗 [LinkedIn Profile](https://www.linkedin.com/in/francesco-march%C3%AC-115657205/)  
