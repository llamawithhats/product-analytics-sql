DROP VIEW IF EXISTS subscription_retention;

CREATE VIEW subscription_retention AS
WITH subscription_active AS (
    SELECT 
        subscription_id, 
        start_date, 
        end_date, 
        TO_CHAR(start_date, 'YYYY-MM') AS cohort_month,
        (COALESCE(end_date, '2024-12-31') - start_date) AS active_days
    FROM subscriptions
)
SELECT 
    subscription_id, 
    start_date, 
    end_date, 
    cohort_month,
    active_days,
    CASE 
        WHEN active_days >= 14 THEN 'Yes' ELSE 'No'
    END AS is_14_days,
    CASE 
        WHEN active_days >= 30 THEN 'Yes' ELSE 'No'
    END AS is_30_days,
    CASE 
        WHEN active_days >= 90 THEN 'Yes' ELSE 'No'
    END AS is_90_days
FROM subscription_active; -- retention cohorts based on subscription active days
-- Note: active_days if no end date is calculated up to '2024-12-31' (last data date)

DROP VIEW IF EXISTS cohort_retention;

CREATE VIEW cohort_retention AS
SELECT 
	cohort_month,
	COUNT(*) AS cohort_size,
	ROUND(
		SUM(CASE WHEN is_14_days = 'Yes' THEN 1 ELSE 0 END)::numeric / 
		COUNT(*) * 100, 
		2) AS day_14_retention,
	ROUND(
		SUM(CASE WHEN is_30_days = 'Yes' THEN 1 ELSE 0 END)::numeric / 
		COUNT(*) * 100, 
		2) AS day_30_retention,
	ROUND(
		SUM(CASE WHEN is_90_days = 'Yes' THEN 1 ELSE 0 END)::numeric / 
		COUNT(*) * 100, 
		2) AS day_90_retention
FROM subscription_retention
GROUP BY cohort_month
ORDER BY cohort_month; -- aggregate retention rates by cohort month

SELECT 'Day 14' AS checkpoint, AVG(day_14_retention) AS avg_retention FROM cohort_retention
UNION ALL
SELECT 'Day 30', AVG(day_30_retention) FROM cohort_retention
UNION ALL
SELECT 'Day 90', AVG(day_90_retention) FROM cohort_retention; -- average retention rates across each checkpoint
	