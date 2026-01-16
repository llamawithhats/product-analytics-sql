SELECT COUNT(*) FROM accounts;

SELECT COUNT(DISTINCT account_id) FROM subscriptions; # Number of unique accounts: 500
SELECT COUNT(account_id) FROM subscriptions; # Total number of subscriptions: 5000

SELECT account_id FROM subscriptions
ORDER BY account_id; # Group identical account_ids together for visual inspection

SELECT DISTINCT(plan_tier) FROM subscriptions; # 3 unique plan tiers