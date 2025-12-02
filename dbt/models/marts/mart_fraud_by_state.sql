{{ config(materialized='table') }}

SELECT
    us_state,
    sum(is_fraud) / count() AS fraud_rate,
    count(distinct concat(name_1, ' ', name_2)) AS unique_customers,
    count(distinct merch) AS unique_merchants,
    sum(amount) AS total_amount,
    sum(is_fraud) AS fraud_transactions
FROM {{ ref('stg_transactions') }}
GROUP BY us_state
ORDER BY fraud_rate DESC;
