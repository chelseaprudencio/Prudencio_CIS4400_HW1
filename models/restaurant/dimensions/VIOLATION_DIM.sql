{{ config(
    materialized='table'
) }}

WITH source_data AS (
    SELECT DISTINCT
        "VIOLATION DESCRIPTION" AS violation_desc
    FROM {{ source('nyc_restaurant', 'restaurant_grades') }}
    WHERE "VIOLATION DESCRIPTION" IS NOT NULL
),

categorized_violations AS (
    SELECT
        violation_desc,
        CASE
            WHEN violation_desc LIKE '%food%temperature%' OR 
                 violation_desc LIKE '%cook%temperature%' OR
                 violation_desc LIKE '%reheating%' THEN 'Temperature Control'
            WHEN violation_desc LIKE '%pest%' OR 
                 violation_desc LIKE '%mice%' OR 
                 violation_desc LIKE '%roach%' OR 
                 violation_desc LIKE '%insect%' OR
                 violation_desc LIKE '%vermin%' THEN 'Pest Control'
            WHEN violation_desc LIKE '%clean%' OR 
                 violation_desc LIKE '%sanit%' OR 
                 violation_desc LIKE '%wash%' THEN 'Cleanliness'
            WHEN violation_desc LIKE '%food protect%' OR 
                 violation_desc LIKE '%contaminat%' THEN 'Food Protection'
            WHEN violation_desc LIKE '%handwashing%' OR 
                 violation_desc LIKE '%personal hygiene%' THEN 'Personal Hygiene'
            WHEN violation_desc LIKE '%facilit%' OR 
                 violation_desc LIKE '%equipment%' OR 
                 violation_desc LIKE '%surface%' THEN 'Facilities & Equipment'
            WHEN violation_desc LIKE '%food source%' OR 
                 violation_desc LIKE '%spoil%' THEN 'Food Quality'
            ELSE 'Other'
        END AS violation_category
    FROM source_data
)

SELECT
    {{ dbt_utils.generate_surrogate_key(['violation_desc']) }} AS violation_id,
    violation_desc,
    violation_category
FROM categorized_violations