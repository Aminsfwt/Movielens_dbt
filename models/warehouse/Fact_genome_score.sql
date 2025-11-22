
{{
    config(
        materialized= 'incremental',
        on_schema_change='fail' 
        )
}}

WITH relevent AS
(
    SELECT
        t.tag_key, 
        m.movie_key,    
        g.relevance
    FROM {{ref('stg_genome_score')}} g
    LEFT JOIN {{ref('Dim_Movies')}} m
        ON g.movie_id = m.movie_id
    LEFT JOIN {{ref('Dim_Tags')}} t
        ON g.tag_id = t.tag_id   
)

SELECT 
    ROW_NUMBER() OVER(ORDER BY movie_key, tag_key) AS score_key,
    * 
from relevent