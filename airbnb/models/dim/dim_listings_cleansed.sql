{{
    config (
        materialized= 'view'
    )
}}
with src_listings as (
    select * from {{ ref('src_listings') }}
)
select 
    listing_id,
    listing_name,
    room_type,
    iff(
        minimum_nights = 0, 1, minimum_nights
    ) as minimum_nights,
    host_id,
    replace(
        price_str, '$',''
    ) :: Number (10, 2) as price,
    created_at,
    updated_at
from 
    src_listings