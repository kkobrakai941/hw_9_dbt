{{ config(materialized='table') }}

WITH customer_stats AS (
    SELECT
        concat(name_1, ' ', name_2) AS customer_name,
        count() AS tx_count,
        sum(amount) AS total_amount,
        avg(amount) AS avg_amount,
        sum(is_fraud) AS fraud_count,
        sum(is_fraud) / count() AS fraud_rate
    FROM {{ ref('stg_transactions') }}
    GROUP BY customer_name
)

SELECT
    customer_name,
    tx_count,
    total_amount,
    avg_amount,
    fraud_count,
    fraud_rate,
    CASE
        WHEN fraud_rate > 0.05 THEN 'HIGH'
        WHEN fraud_rate > 0.01 THEN 'MEDIUM'
        ELSE 'LOW'
    END AS risk_level
FROM customer_stats
ORDER BY fraud_rate DESC;
