-- ================================
-- Subscriptions overview
-- ================================

-- From 01_table_overview.sql:
-- Total number of accounts that subscribed: 500 (all)
-- Total number of subscriptions: 5000

SELECT COUNT(end_date) FROM subscriptions; -- Number of ended subscriptions: 486
SELECT ROUND(COUNT(end_date)::numeric / COUNT(*) * 100, 2) FROM subscriptions; -- Percentage of subscriptions that have ended: 9.72%
SELECT COUNT(DISTINCT account_id) FROM subscriptions
WHERE end_date IS NOT NULL; -- Number of unique accounts with ended subscriptions: 312

SELECT DISTINCT(plan_tier) FROM subscriptions; -- 3 unique plan tiers (Basic, Pro, Enterprise)
SELECT plan_tier, COUNT(*) FROM subscriptions
GROUP BY plan_tier; -- Subscription counts by plan tier
-- Note: 'Enterprise' is the most popular plan tier

SELECT 
	plan_tier, SUM(mrr_amount) AS monthly_revenue, 
	SUM(arr_amount) AS annual_revenue, COUNT(*) FROM subscriptions
GROUP BY plan_tier; -- MRR and ARR by plan tier
