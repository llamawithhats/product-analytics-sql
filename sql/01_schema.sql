CREATE TABLE accounts(
account_id VARCHAR(10) UNIQUE PRIMARY KEY,
account_name VARCHAR(30),
industry CHAR(30),
country CHAR(2),
signup_date	DATE,
referral_source TEXT,
plan_tier TEXT,
seats INTEGER,
is_trial BOOL,
churn_flag BOOL
);

CREATE TABLE subscriptions(
subscription_id VARCHAR(10) UNIQUE PRIMARY KEY,
account_id VARCHAR(10) REFERENCES accounts(account_id),
start_date DATE,
end_date DATE,
plan_tier CHAR(10),
seats INTEGER,
mrr_amount FLOAT,
arr_amount FLOAT,
is_trial BOOL,
upgrade_flag BOOL,
downgrade_flag BOOL,
churn_flag BOOL,
billing_frequency CHAR(10),
auto_renew_flag BOOL
);

CREATE TABLE feature_usage(
usage_id VARCHAR(10),
subscription_id VARCHAR(10) REFERENCES subscriptions(subscription_id),
usage_date DATE,
feature_name VARCHAR(20),
usage_count INTEGER,
usage_duration_secs INTEGER,
error_count INTEGER,
is_beta_feature BOOL
);

CREATE TABLE support_tickets(
ticket_id VARCHAR(10),
account_id VARCHAR(10) REFERENCES accounts(account_id),
submitted_at TIMESTAMP,
closed_at TIMESTAMP,
resolution_time_hours FLOAT,
priority CHAR(10),
first_response_time_minutes INTEGER,
satisfaction_score FLOAT,
escalation_flag BOOL
)

CREATE TABLE churn_events(
churn_event_id VARCHAR(10) UNIQUE PRIMARY KEY,
account_id	VARCHAR(10) REFERENCES accounts(account_id), 
churn_date DATE,
reason_code CHAR(15),
refund_amount_usd FLOAT,
preceding_upgrade_flag BOOL,
preceding_downgrade_flag BOOL,
is_reactivation	BOOL,
feedback_text TEXT
);



