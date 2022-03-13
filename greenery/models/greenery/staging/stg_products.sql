SELECT 
    product_id
    , name
    , price
    , inventory
FROM 
    {{ source('greenery_source', 'products') }}