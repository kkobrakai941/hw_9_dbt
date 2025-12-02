{{ config(materialized='table') }}

SELECT
    cat_id,
    count() AS total_transactions,
    sum(is_fraud) AS fraud_transactions,
    sum(is_fraud) / count() AS fraud_rate,
    sum(amount) AS total_amount,
    sumIf(amount, is_fraud = 1) AS fraud_amount
FROM {{ ref('stg_transactions') }}
GROUP BY cat_id
ORDER BY fraud_rate DESC;
