DROP VIEW IF EXISTS retention_analysis;

CREATE VIEW retention_analysis AS
WITH retention AS (
	SELECT 
		subscription_id,
		CASE 
			WHEN is_90_days = 'Yes' THEN 'retained'
			WHEN is_30_days = 'No' THEN 'early churn'
			ELSE 'exclude'
		END AS retention_group,
		active_days,
		start_date
	FROM subscription_retention
)
SELECT subscription_id, retention_group, active_days, start_date FROM retention
WHERE retention_group != 'exclude'; -- categorize subscriptions into 'retained' and 'early churn' based on retention status
-- Note: 'exclude' group filters out subscriptions that are neither retained nor early churn

DROP VIEW IF EXISTS feature_adoption_analysis;

CREATE VIEW feature_adoption_analysis AS
WITH filtered_usage AS (
	SELECT 
		s.subscription_id, 
		feature_name, 
		error_count, 
		s.start_date, 
		f.usage_date 
	FROM feature_usage f
	INNER JOIN subscription_retention s
	ON s.subscription_id = f.subscription_id
	WHERE f.usage_date - s.start_date <= 14 AND f.usage_date - s.start_date >= 0
)
SELECT 
	r.subscription_id,
	retention_group,
	COUNT(DISTINCT(feature_name)) AS distinct_features,
	SUM(error_count) AS total_errors
FROM filtered_usage
INNER JOIN retention_analysis r 
ON r.subscription_id = filtered_usage.subscription_id
GROUP BY r.subscription_id, retention_group; -- analyze feature adoption within first 14 days based on retention group (retained vs early churn)

SELECT 
	retention_group,
	ROUND(AVG(distinct_features), 2) AS avg_features_used,
	ROUND(AVG(total_errors), 2) AS avg_errors
FROM feature_adoption_analysis 
GROUP BY retention_group; -- average features used and errors by retention group
