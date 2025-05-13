{{ config(
    materialized='table'
) }}

WITH source_dates AS (
    SELECT DISTINCT "GRADE DATE" AS grade_date
    FROM {{ source('nyc_restaurant', 'restaurant_grades') }}
    WHERE "GRADE DATE" IS NOT NULL
    
    UNION
    
    SELECT DISTINCT "RECORD DATE" AS record_date
    FROM {{ source('nyc_restaurant', 'restaurant_grades') }}
    WHERE "RECORD DATE" IS NOT NULL
),

all_dates AS (
    SELECT 
        grade_date AS date_value,
        'grade_date' AS date_type
    FROM source_dates
    
    UNION
    
    SELECT 
        record_date AS date_value,
        'record_date' AS date_type
    FROM source_dates
),

extracted_components AS (
    SELECT
        date_value,
        EXTRACT(YEAR FROM date_value) AS year,
        EXTRACT(MONTH FROM date_value) AS month
    FROM all_dates
),

combined_dates AS (
    SELECT DISTINCT
        date_value,
        year,
        month
    FROM extracted_components
)

SELECT
    {{ dbt_utils.generate_surrogate_key(['date_value']) }} AS date_id,
    date_value AS full_date,
    CASE 
        WHEN EXTRACT(DOW FROM date_value) = 0 THEN 'Sunday'
        WHEN EXTRACT(DOW FROM date_value) = 1 THEN 'Monday'
        WHEN EXTRACT(DOW FROM date_value) = 2 THEN 'Tuesday'
        WHEN EXTRACT(DOW FROM date_value) = 3 THEN 'Wednesday'
        WHEN EXTRACT(DOW FROM date_value) = 4 THEN 'Thursday'
        WHEN EXTRACT(DOW FROM date_value) = 5 THEN 'Friday'
        WHEN EXTRACT(DOW FROM date_value) = 6 THEN 'Saturday'
    END AS day_of_week,
    EXTRACT(DAY FROM date_value) AS day_of_month,
    month AS month_number,
    CASE
        WHEN month = 1 THEN 'January'
        WHEN month = 2 THEN 'February'
        WHEN month = 3 THEN 'March'
        WHEN month = 4 THEN 'April'
        WHEN month = 5 THEN 'May'
        WHEN month = 6 THEN 'June'
        WHEN month = 7 THEN 'July'
        WHEN month = 8 THEN 'August'
        WHEN month = 9 THEN 'September'
        WHEN month = 10 THEN 'October'
        WHEN month = 11 THEN 'November'
        WHEN month = 12 THEN 'December'
    END AS month_name,
    year AS year_number,
    CASE
        WHEN month IN (1, 2, 3) THEN 'Q1'
        WHEN month IN (4, 5, 6) THEN 'Q2'
        WHEN month IN (7, 8, 9) THEN 'Q3'
        WHEN month IN (10, 11, 12) THEN 'Q4'
    END AS quarter
FROM combined_dates
ORDER BY date_value