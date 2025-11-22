WITH raw_genome_scores AS (
  SELECT * FROM {{source('netflix', 'RAW_GENOME_SCORES')}}
)

SELECT
  movieId AS movie_id,
  tagId AS tag_id,
  ROUND(relevance, 4) as relevance
FROM raw_genome_scores