-- How many users do we have?
SELECT COUNT(user_id) AS users_count FROM "dbt"."dbt_karthikeyan_s"."stg_users";

-- Result
-- 130

-- On average, how many orders do we receive per hour?
WITH orders_count_per_hour_cte AS (
SELECT COUNT(*) AS orders_count_per_hour FROM "dbt"."dbt_karthikeyan_s"."stg_orders"
GROUP BY DATE_TRUNC('hour', created_at)
)

SELECT AVG(orders_count_per_hour) FROM orders_count_per_hour_cte;

-- Result
-- 7.5208333333333333

-- On average, how long does an order take from being placed to being delivered?
SELECT AVG(delivered_at - created_at) FROM "dbt"."dbt_karthikeyan_s"."stg_orders";

-- Result
-- 3 days 21:24:11.803279

-- How many users have only made one purchase? Two purchases? Three+ purchases?
WITH purchase_categories_cte AS (
SELECT 
	user_id,
	CASE 
	WHEN COUNT(*) = 1 THEN 'One Purchase' 
	WHEN COUNT(*) = 2 THEN 'Two Purchases' ELSE 'Three+ Purchases' END AS purchase_categories 
	FROM "dbt"."dbt_karthikeyan_s"."stg_orders"
GROUP BY user_id
)

SELECT 
	purchase_categories, 
	COUNT(purchase_categories) 
FROM purchase_categories_cte
GROUP BY purchase_categories;

-- Result
/*
Two Purchases       28
One Purchase        25
Three+ Purchases    71
*/

-- On average, how many unique sessions do we have per hour?
WITH sessions_count_per_hour_cte AS (
SELECT COUNT(distinct session_id) AS sessions_count_per_hour FROM "dbt"."dbt_karthikeyan_s"."stg_events"
GROUP BY DATE_TRUNC('hour', created_at)
)

SELECT AVG(sessions_count_per_hour) FROM sessions_count_per_hour_cte;

-- Result
-- 16.3275862068965517