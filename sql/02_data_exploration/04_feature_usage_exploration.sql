-- ================================
-- Feature usage exploration
-- ================================

-- From 01_table_overview.sql:
-- Total number of subscriptions with feature usage: 4967 

WITH feature_users AS (
	SELECT account_id, s.subscription_id FROM subscriptions s
	LEFT JOIN feature_usage f
	ON f.subscription_id = s.subscription_id
	ORDER BY account_id
)
SELECT COUNT(DISTINCT account_id) FROM feature_users; -- Unique accounts with feature usage: 500 (all)

SELECT feature_name, COUNT(*) FROM feature_usage
GROUP BY feature_name
ORDER BY count DESC; -- Feature usage counts by feature name
-- Note: feature 32 & 12 are the most used features

SELECT feature_name, SUM(error_count) AS error_count FROM feature_usage
WHERE error_count != 0
GROUP BY feature_name 
ORDER BY error_count DESC; -- Feature error counts by feature name
-- Note: feature 4 & 26 has the highest error counts of 418 & 417 respectively

WITH feature_users AS (
	SELECT 
		account_id, 
		MIN(usage_date) AS first_feature_usage 
	FROM subscriptions s
	LEFT JOIN feature_usage f
	ON f.subscription_id = s.subscription_id
	GROUP BY account_id
),
activation_days AS (
	SELECT 
		a.account_id, 
		signup_date, 
		first_feature_usage,  
		first_feature_usage - signup_date AS activation_period_days
	FROM accounts a
	INNER JOIN feature_users f
	ON a.account_id = f.account_id
	WHERE first_feature_usage >= signup_date
)
SELECT ROUND(AVG(activation_period_days), 2) FROM activation_days; -- Mean activation period (days) between signup and first feature usage
-- Note: Had to exclude invalid data where feature usage date is before signup date

