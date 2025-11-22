

{{
    config(
        materialized= 'incremental',
        on_schema_change='fail' 
        )
}}

WITH ratings AS
(
    SELECT 
        u.user_key,
        m.movie_key,    
        d.date_key,
        r.rating
       -- CAST(r.rating_timestamp AS DATE) AS rating_date 
    FROM {{ref('stg_ratings')}} r       
    LEFT JOIN {{ref('Dim_Movies')}} m
        ON r.movie_id = m.movie_id
    LEFT JOIN {{ref('Dim_Users')}} u
        ON r.user_id = u.user_id
    LEFT JOIN {{ref('Dim_Date')}} d
        ON CAST(r.rating_timestamp AS DATE)= d.full_date
)

SELECT 
    ROW_NUMBER() OVER(ORDER BY movie_key, user_key, date_key) AS rate_key,
    * 
from ratings

