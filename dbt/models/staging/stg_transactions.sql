{{ config(materialized='table') }}

SELECT
    toDateTime(transaction_time) AS transaction_time,
    merch,
    cat_id,
    toDecimal64(amount, 2) AS amount,
    name_1,
    name_2,
    gender,
    street,
    one_city,
    us_state,
    toUInt32(post_code) AS post_code,
    toFloat64(lat) AS lat,
    toFloat64(lon) AS lon,
    toUInt32(population_city) AS population_city,
    jobs,
    toFloat64(merchant_lat) AS merchant_lat,
    toFloat64(merchant_lon) AS merchant_lon,
    toUInt8(target) AS is_fraud,
    {{ amount_bucket(amount) }} AS amount_bucket
FROM {{ source('transactions_db', 'transactions') }}
