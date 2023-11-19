-- SELECT 
--     orders.order_date
--     , details.quantity
--     , details.price
--     , products.name AS product_name
--     , brands.name AS brands_name
-- FROM {{ source('store', 'orders') }} AS orders 
-- LEFT JOIN {{ source('store', 'order_details') }} AS details 
--     ON orders.order_id = details.order_id
-- LEFT JOIN {{ source('store', 'products') }} AS products
--     ON details.product_id = products.product_id
-- LEFT JOIN {{ source ('store', 'brands') }} AS brands
--     ON products.brand_id = brands.brand_id

with detail as (
    SELECT 
        orders.order_date
        , orders.customer_phone
        , details.quantity
        , details.price
        , products.name AS product_name
        , brands.name AS brands_name
        , {{ normalize_phone_number('customer_phone') }} AS normalized_phone
    FROM {{ source('store', 'orders') }} AS orders 
    LEFT JOIN {{ source('store', 'order_details') }} AS details 
        ON orders.order_id = details.order_id
    LEFT JOIN {{ source('store', 'products') }} AS products
        ON details.product_id = products.product_id
    LEFT JOIN {{ source ('store', 'brands') }} AS brands
        ON products.brand_id = brands.brand_id
)
SELECT *
    , case
        when normalized_phone like '62%' then 'Indonesia'
        when normalized_phone like '91%' then 'India'
    end AS country
FROM detail