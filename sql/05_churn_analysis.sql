WITH month_series AS (
    SELECT TO_CHAR(generate_series(
        DATE_TRUNC('month', (SELECT MIN(churn_date) FROM churn_events)),
        DATE_TRUNC('month', (SELECT MAX(churn_date) FROM churn_events)),
        '1 month'::interval
    ), 'YYYY-MM') AS year_month
)
SELECT 
	ms.year_month AS churn_month,
	COALESCE(COUNT(DISTINCT account_id), 0) AS total_accounts,
	ROUND(
		COUNT(*) FILTER (WHERE is_reactivation)::numeric / COUNT(*) * 100.0, 
		2
	) AS reactivation_rate
FROM churn_events ce
RIGHT JOIN month_series ms
ON ms.year_month = TO_CHAR(ce.churn_date, 'YYYY-MM')
GROUP BY churn_month
ORDER BY churn_month; -- Monthly churned accounts and reactivation rates

DROP VIEW IF EXISTS churn_analysis;

CREATE VIEW churn_analysis AS
WITH churn_status AS (
	SELECT 
		a.account_id, 
		MAX(ce.churn_date) AS churn_date,
		CASE
			WHEN MAX(ce.churn_date) IS NOT NULL THEN 'Yes'
			ELSE 'No'
		END AS is_churned
	FROM accounts a
	LEFT JOIN churn_events ce
	ON a.account_id = ce.account_id
	GROUP BY a.account_id
),
first_sub_start AS (
	SELECT 
		account_id,
		MIN(start_date) AS first_subscription_start_date
	FROM subscriptions
	GROUP BY account_id
),
intermediate AS (
	SELECT 
		c.account_id,
		first_subscription_start_date,
		churn_date,
		is_churned,
		churn_date - first_subscription_start_date AS days_to_churn
	FROM first_sub_start f
	INNER JOIN churn_status c
	ON f.account_id = c.account_id
)
SELECT 
	account_id,
	first_subscription_start_date,
	churn_date,
	is_churned,
	days_to_churn,
	CASE
		WHEN days_to_churn >= 0 AND days_to_churn <= 30 THEN '0-30'
		WHEN days_to_churn >= 31 AND days_to_churn <= 90 THEN '31-90'
		WHEN days_to_churn >= 91 AND days_to_churn <= 180 THEN '91-180'
		WHEN days_to_churn >= 181 THEN '180+'
	END AS churn_stage
FROM intermediate
WHERE days_to_churn >= 0 OR days_to_churn IS NULL; -- Time to churn analysis by account
-- Accounts that have not churned will have NULL churn_date, days_to_churn and churn_stage
-- Cleaned dirty data where churn_date is before first subscription start date

SELECT
    s.account_id,
    COUNT(*) AS total_tickets,
    ROUND(AVG(first_response_time_minutes), 2) AS avg_first_response_time_min,
    ROUND(
        COUNT(*) FILTER(WHERE escalation_flag)::numeric / COUNT(*) * 100.0,
        2
    ) AS escalation_rate,
    ROUND(AVG(satisfaction_score)::numeric, 2) AS avg_satisfaction_score
FROM support_tickets s
INNER JOIN churn_analysis c
ON s.account_id = c.account_id
GROUP BY s.account_id; -- Support ticket metrics

SELECT
	c.is_churned,
	COUNT(*) AS total_tickets,
	ROUND(AVG(first_response_time_minutes), 2) AS avg_first_response_time_min,
	ROUND(
		COUNT(*) FILTER(WHERE escalation_flag)::numeric / COUNT(*) * 100.0,
		2
	) AS escalation_rate,
	ROUND(AVG(satisfaction_score)::numeric, 2) AS avg_satisfaction_score
FROM support_tickets s
INNER JOIN churn_analysis c
ON s.account_id = c.account_id
GROUP BY c.is_churned; -- Support ticket metrics by churn status (churned vs retained)

SELECT
	ROUND(
		COUNT(*) FILTER(WHERE preceding_upgrade_flag)::numeric / COUNT(*) * 100.0,
		2
	) AS recent_upgrade_rate,
	ROUND(
		COUNT(*) FILTER(WHERE preceding_downgrade_flag)::numeric / COUNT(*) * 100.0,
		2
	) AS recent_downgrade_rate
FROM churn_events; -- Recent subscription changes before churn
-- upgrade: 20.50%
-- downgrade: 8.83%

