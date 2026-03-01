SELECT * FROM {{ source('airbnbdev', 'listings') }}
WHERE minimum_nights < 1
LIMIT 10