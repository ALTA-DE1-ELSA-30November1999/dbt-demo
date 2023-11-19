SELECT
    brands_name
    , order_date
    , sum(quantity) AS total_quantity
    , sum(price) AS total_revenue
FROM {{ ref('stg_store_details') }}
GROUP BY 1,2