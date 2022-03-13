SELECT 
    address_id
    , address
    , zipcode
    , state
    , country
FROM 
    {{ source('greenery_source', 'addresses') }}