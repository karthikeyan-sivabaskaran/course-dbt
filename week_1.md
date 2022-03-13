
### Note: compiled version of below queries are available under analyses folder
https://github.com/karthikeyan-sivabaskaran/course-dbt/blob/main/greenery/analyses/week_1_project_queries/queries.sql

# How many users do we have?
```sql
SELECT COUNT(user_id) AS users_count FROM {{ ref('stg_users') }};
```

> Result: 130

# On average, how many orders do we receive per hour?
```sql
WITH orders_count_per_hour_cte AS (
SELECT COUNT(*) AS orders_count_per_hour FROM {{ ref('stg_orders') }}
GROUP BY DATE_TRUNC('hour', created_at)
)

SELECT AVG(orders_count_per_hour) FROM orders_count_per_hour_cte;
```

> Result: 7.5208333333333333

# On average, how long does an order take from being placed to being delivered?
```sql
SELECT AVG(delivered_at - created_at) FROM {{ ref('stg_orders') }};
```

> Result: 3 days 21:24:11.803279

# How many users have only made one purchase? Two purchases? Three+ purchases?
```sql
WITH purchase_categories_cte AS (
SELECT 
	user_id,
	CASE 
	WHEN COUNT(*) = 1 THEN 'One Purchase' 
	WHEN COUNT(*) = 2 THEN 'Two Purchases' ELSE 'Three+ Purchases' END AS purchase_categories 
	FROM {{ ref('stg_orders') }}
GROUP BY user_id
)

SELECT 
	purchase_categories, 
	COUNT(purchase_categories) 
FROM purchase_categories_cte
GROUP BY purchase_categories;
```

| purchase_categories   | count |
| --------------------- | ----- |
| One Purchase          | 25    |
| Two Purchases         | 28    |
| Three+ Purchases      | 71    |


# On average, how many unique sessions do we have per hour?
```sql
WITH sessions_count_per_hour_cte AS (
SELECT COUNT(distinct session_id) AS sessions_count_per_hour FROM {{ ref('stg_events') }}
GROUP BY DATE_TRUNC('hour', created_at)
)

SELECT AVG(sessions_count_per_hour) FROM sessions_count_per_hour_cte;
```

> Result: 16.3275862068965517


# Self Reflection Questions
## Part 2
* Were you able to create schema.yml files with model names and descriptions? Yes 
* Were you able to run your dbt models against the data warehouse? Yes

## Part 3
* Could you run the queries to answer key questions from the project instructions? Yes

## Reflection 
* What was most challenging/surprising in completing this week’s project? - 

* Is there anywhere you are still stuck or confused? Or Is there a particular part of the project where you want focused feedback from your reviewers?
I am wondering how the `dbt commands` are running quite faster in gitpod.io, whereas in out porject we are using `dbt-core`, but takes few seeconds to minutes to run the `dbt commands`