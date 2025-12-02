{{ config(materialized='table') }}

WITH base AS (
    SELECT
        toDate(transaction_time) AS transaction_date,
        us_state,
        amount,
        amount_bucket
    FROM {{ ref('stg_transactions') }}
)

SELECT
    transaction_date,
    us_state,
    count() AS tx_count,
    sum(amount) AS total_amount,
    avg(amount) AS avg_check,
    quantileExact(0.95)(amount) AS p95_amount,
    sumIf(1, amount_bucket = 'high') / count() AS large_tx_share
FROM base
GROUP BY
    transaction_date,
    us_state
ORDER BY
    transaction_date,
    us_state;
