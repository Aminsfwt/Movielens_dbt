

WITH movies AS
(
    SELECT
        m.movie_id,
        m.title,
        m.genres,
        l.imdb_id,
        l.tmdb_id
    FROM {{ ref('stg_movies') }} m
    LEFT JOIN {{ ref('stg_links') }} l
    WHERE m.movie_id = l.movie_id
)

SELECT 
    ROW_NUMBER() OVER(ORDER BY movie_id) AS movie_key,
    *
FROM movies 
