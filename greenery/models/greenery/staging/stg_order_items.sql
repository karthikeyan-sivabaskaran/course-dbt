SELECT 
    order_id
    , product_id
    , quantity
FROM 
    {{ source('greenery_source', 'order_items') }}