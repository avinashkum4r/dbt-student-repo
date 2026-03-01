SELECT r.listing_id, r.reviewer_name, r.review_date, d.created_at from {{ ref('fct_reviews')}} AS r
LEFT JOIN {{ ref('dim_listings_cleansed')}} AS d
    ON r.listing_id = d.listing_id
WHERE r.review_date < d.created_at