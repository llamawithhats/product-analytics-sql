-- ===================================================
-- Sanity checks and basic exploration of the tables
-- ===================================================

-- Accounts table exploration
SELECT COUNT(*) FROM accounts; -- 500 total accounts
SELECT COUNT (DISTINCT account_id) FROM accounts; -- No duplicates in account_id
SELECT MIN(signup_date) FROM accounts; -- Earliest signup date (2023-01-02)
SELECT MAX(signup_date) FROM accounts; -- Latest signup date (2024-12-31)

-- Subscriptions table exploration
SELECT COUNT(*) FROM subscriptions; -- 5000 total subscriptions
SELECT COUNT(DISTINCT account_id) FROM subscriptions; -- Unique accounts: 500, each account has multiple subscriptions
SELECT MIN(start_date) FROM subscriptions; -- Earliest subscription start date (2023-01-09)
SELECT MAX(end_date) FROM subscriptions; -- Latest subscription end date (2024-12-31)

-- Feature Usage table exploration
SELECT COUNT (*) FROM feature_usage; -- 25000 total feature usage records
SELECT COUNT(DISTINCT subscription_id) FROM feature_usage; -- Unique subscriptions: 4967
SELECT MIN(usage_date) FROM feature_usage; -- Earliest usage date (2023-01-01)
-- features were used before account signups, indicating possible data entry errors
SELECT MAX(usage_date) FROM feature_usage; -- Latest usage date (2024-12-31)

-- Support Tickets table exploration
SELECT COUNT(*) FROM support_tickets; -- 2000 total support tickets
SELECT COUNT(DISTINCT account_id) FROM support_tickets; -- Unique accounts with tickets: 492
SELECT MIN(submitted_at) FROM support_tickets; -- Earliest ticket submission (2023-01-02 00:00:00)
SELECT MAX(submitted_at) FROM support_tickets; -- Latest ticket submission (2024-12-31 00:00:00)
SELECT MIN(closed_at) FROM support_tickets; -- Earliest ticket closure (2023-01-03 03:00:00)
SELECT MAX(closed_at) FROM support_tickets; -- Latest ticket closure (2024-12-31 19:00:00)

-- Churn Events table exploration
SELECT COUNT(*) FROM churn_events; -- 600 total churn events
SELECT COUNT(DISTINCT account_id) FROM churn_events; -- Unique accounts that churned: 352
SELECT MIN(churn_date) FROM churn_events; -- Earliest churn date (2023-01-25)
SELECT MAX(churn_date) FROM churn_events; -- Latest churn date (2024-12-31)
