{{ config(
    materialized='table'
) }}

WITH source_data AS (
    SELECT DISTINCT
        "CUISINE DESCRIPTION" AS cuisine_type
    FROM {{ source('nyc_restaurant', 'restaurant_grades') }}
    WHERE "CUISINE DESCRIPTION" IS NOT NULL
)

SELECT
    {{ dbt_utils.generate_surrogate_key(['cuisine_type']) }} AS cuisine_id,
    cuisine_type
FROM source_data