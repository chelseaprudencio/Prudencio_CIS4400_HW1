{{ config(
    materialized='table'
) }}

WITH source_data AS (
    SELECT DISTINCT
        BORO AS boro,
        ZIPCODE AS zipcode,
        STREET AS street
    FROM {{ source('nyc_restaurant', 'restaurant_grades') }}
    WHERE BORO IS NOT NULL
      AND ZIPCODE IS NOT NULL
      AND STREET IS NOT NULL
),

deduplicated AS (
    SELECT
        boro,
        zipcode,
        street,
        ROW_NUMBER() OVER (PARTITION BY boro, zipcode, street ORDER BY boro) AS row_num
    FROM source_data
)

SELECT
    {{ dbt_utils.generate_surrogate_key(['boro', 'zipcode', 'street']) }} AS location_id,
    boro,
    zipcode,
    street
FROM deduplicated
WHERE row_num = 1