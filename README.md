# 📊 SaaS Product Analysis &mdash;  RavenStack

## Project Overview
This project analyzes user behavior, retention, revenue, and churn for RavenStack, a fictional AI-powered collaboration SaaS platform.

The goal is to simulate a real-world SaaS product analytics workflow, using SQL to extract actionable insights that could inform product, growth, and customer success decisions.

<details>
<summary>More on RavenStack</summary>
RavenStack is a fictional AI-powered collaboration SaaS platform designed to simulate real-world product and business analytics scenarios. <br>
The dataset consists of five relational tables representing customer accounts, subscriptions, product usage, support interactions, and churn events. It is intentionally structured to support realistic SQL analysis including funnel analysis, retention cohorts, revenue tracking, and churn drivers.
</details>

### Key focus areas:
- User activation and feature adoption
- Retention and cohort behavior
- Subscription revenue trends
- Churn patterns and drivers

## Key Highlights

- **Enterprise plan** contributes the majority of revenue despite similar subscription counts
- **Early lifecycle retention is strong** (≈97% at Day 14), but drops to ≈85% by Day 90
- **Feature-related issues** are the most common churn reason overall
- **Churn is not purely early-stage** — most churned accounts leave after 180+ days
- **Churned accounts generate >2× support tickets** and have higher escalation rates
- **20.5% of churned accounts upgraded** shortly before leaving, suggesting unmet expectations

## Business Context
SaaS businesses rely on recurring revenue, long-term user engagement, and low churn to remain sustainable.

Understanding when users activate, why they retain, and what leads to churn is critical for product strategy and revenue growth.

This analysis aims to approach RavenStack as if it were a real company seeking to:
- Improve trial-to-paid conversion
- Increase long-term retention
- Reduce preventable churn

## Findings & Insights

This project uncovered patterns across acquisition, retention, feature adoption, and churn behavior.  
Detailed analysis, supporting charts, and interpretations are documented in `findings.md`.

## Strategic Recommendations

1. **Strengthen long-term value delivery**
   - Provide in-app guidance, tutorials, or tips for advanced features to ensure users realize the full value of their subscriptions.
   - Highlight key benefits post-upgrade to prevent expectation–value mismatches.

2. **Proactively manage support touchpoints**

   - Identify accounts with high ticket volumes and offer personalized assistance.
   - Reduce escalations by improving response consistency and offering proactive troubleshooting resources.

3. **Focus on critical retention windows**

   - Engage users between Day 30–90 with targeted campaigns and feature nudges to sustain engagement.
   - Monitor and support accounts that recently upgraded plans to ensure satisfaction with higher-tier features.

4. **Leverage feature engagement insights**

   - Encourage early exploration of high-value features to drive deeper engagement.
   - Track feature adoption patterns to identify friction points and optimize onboarding flows.
   
## My Approach
The analysis follows a structured, end-to-end analytics workflow:

1. Data validation and anomaly detection
2. Exploratory analysis of accounts, subscriptions, feature usage, support and churn trends
3. Cohort-based retention analysis
4. Behavioral comparisons of feature usage between retained and churned users
5. Lifecycle-based churn analysis at the account level

Each step builds on the previous to progressively narrow from broad trends to actionable drivers.

## Limitations & Future Work

While the dataset simulates real-world SaaS behavior, it has limitations:

- **Data Errors:** Misalignment in data such as earliest feature usage happening before earliest sign up suggests possible data errors

- **Partial Insight:** Synthetic data may not capture all real user behaviors

- **Short Time Range:** Limited time horizon for long-term retention analysis

- **Data Gaps:** Not all users have complete data due to optional data entries, which could skew metrics

Future work could include:

- **Predictive churn modeling:** Predict and identify customers that are likely to churn to enable proactive retention strategies before they leave

- **Dashboarding with Business Intelligence (BI) tools:** Create interactive visual displays that aggregate and present key metrics in real-time

## 🔧 Tools & Technologies
- SQL (PostgreSQL)
- pgAdmin 4
- Git & GitHub
- Data Cleaning & Transformation (SQL Views, CTEs)

## 🙌 Acknowledgment
- Dataset by [River @ Rivalytics](https://www.kaggle.com/datasets/rivalytics/saas-subscription-and-churn-analytics-dataset?resource=download)
- Licensed under [MIT](https://www.mit.edu/~amini/LICENSE.md)
- With reference to [this GitHub repo by @rahmasayed18](https://github.com/rahmasayed18/saas-product-analytics) 




