-- ================================
-- Support & churn signals
-- ================================

-- From 01_table_overview.sql:
-- Total number of accounts with at least one support ticket: 492/500
-- Total number of churn events: 600
-- Total number of accounts that churned: 352/500

SELECT MIN(first_response_time_minutes) FROM support_tickets; -- Minimum first response time (1 min)
SELECT MAX(first_response_time_minutes) FROM support_tickets; -- Maximum first response time (180 min)
SELECT MIN(resolution_time_hours) FROM support_tickets; -- Minimum resolution time (1h)
SELECT MAX(resolution_time_hours) FROM support_tickets; -- Maximum resolution time (72h)

SELECT ROUND(AVG(satisfaction_score)::numeric, 2) FROM support_tickets; -- Average satisfaction score for support tickets: 3.98/5
-- Note: Service seems decent but there's room for improvement

WITH month_series AS (
    SELECT TO_CHAR(generate_series(
        DATE_TRUNC('month', (SELECT MIN(churn_date) FROM churn_events)),
        DATE_TRUNC('month', (SELECT MAX(churn_date) FROM churn_events)),
        '1 month'::interval
    ), 'YYYY-MM') AS year_month
)
SELECT 
    ms.year_month,
    COALESCE(COUNT(ce.churn_date), 0) AS count
FROM month_series ms
LEFT JOIN churn_events ce 
ON TO_CHAR(ce.churn_date, 'YYYY-MM') = ms.year_month
GROUP BY ms.year_month
ORDER BY ms.year_month; -- Monthly churn event trends

SELECT reason_code, COUNT(*) FROM churn_events
WHERE churn_date >= '2024-12-01' AND churn_date < '2025-01-01'
AND reason_code != 'unknown'
GROUP BY reason_code -- Churn reasons for December 2024 (significant spike month)

SELECT reason_code, COUNT(reason_code) FROM churn_events
GROUP BY reason_code
ORDER BY count DESC; -- Churn reason counts by reason code