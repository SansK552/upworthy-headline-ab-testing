SELECT
    CASE
        WHEN headline REGEXP '[0-9]'
            THEN 'Contains number'
        ELSE 'No number'
    END AS number_feature,
    COUNT(*) AS package_count,
    COUNT(DISTINCT clickability_test_id) AS test_count,
    SUM(impressions) AS total_impressions,
    SUM(clicks) AS total_clicks,
    ROUND(
        SUM(clicks) / SUM(impressions),
        4
    ) AS overall_ctr
FROM packages_clean
GROUP BY
    CASE
        WHEN headline REGEXP '[0-9]'
            THEN 'Contains number'
        ELSE 'No number'
    END;
    

SELECT
    CASE
        WHEN TRIM(headline) LIKE '%?'
            THEN 'Question'
        ELSE 'Statement'
    END AS question_feature,
    COUNT(*) AS package_count,
    COUNT(DISTINCT clickability_test_id) AS test_count,
    SUM(impressions) AS total_impressions,
    SUM(clicks) AS total_clicks,
    ROUND(
        SUM(clicks) / SUM(impressions),
        4
    ) AS overall_ctr
FROM packages_clean
GROUP BY
    CASE
        WHEN TRIM(headline) LIKE '%?'
            THEN 'Question'
        ELSE 'Statement'
    END;
    
    
SELECT
    CASE
        WHEN CHAR_LENGTH(headline) < 50
            THEN 'Short (<50)'
        WHEN CHAR_LENGTH(headline) < 80
            THEN 'Medium (50-79)'
        WHEN CHAR_LENGTH(headline) < 110
            THEN 'Long (80-109)'
        ELSE 'Very long (110+)'
    END AS length_bucket,
    COUNT(*) AS package_count,
    COUNT(DISTINCT clickability_test_id) AS test_count,
    SUM(impressions) AS total_impressions,
    SUM(clicks) AS total_clicks,
    ROUND(
        SUM(clicks) / SUM(impressions),
        4
    ) AS overall_ctr,
    ROUND(
        AVG(CHAR_LENGTH(headline)),
        1
    ) AS average_length
FROM packages_clean
GROUP BY
    CASE
        WHEN CHAR_LENGTH(headline) < 50
            THEN 'Short (<50)'
        WHEN CHAR_LENGTH(headline) < 80
            THEN 'Medium (50-79)'
        WHEN CHAR_LENGTH(headline) < 110
            THEN 'Long (80-109)'
        ELSE 'Very long (110+)'
    END
ORDER BY MIN(CHAR_LENGTH(headline));