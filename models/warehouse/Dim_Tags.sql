

WITH tags AS (
SELECT 
    tag_id,    
    tag

FROM {{ ref('stg_genome_tags') }} 
 )

SELECT 
    ROW_NUMBER() OVER(ORDER BY tag_id) AS tag_key,
    tag_id, 
    tag
FROM tags