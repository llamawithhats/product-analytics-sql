-- ================================
-- Accounts & signups
-- ================================

-- From 01_table_overview.sql:
-- Total number of accounts: 500 

SELECT signup_date, COUNT(signup_date) FROM accounts
GROUP BY signup_date; -- Daily signups over time

SELECT 
	TO_CHAR(signup_date, 'YYYY-MM') AS year_month,
	COUNT(*)
FROM accounts 
GROUP BY year_month
ORDER BY year_month; -- Monthly signup trends






