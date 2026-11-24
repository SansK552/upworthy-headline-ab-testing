SELECT
    CASE
        WHEN winner = 1
            THEN 'Winner'
        ELSE 'Non-winner'
    END AS winner_status,
    COUNT(*) AS package_count,
    COUNT(DISTINCT clickability_test_id) AS test_count,
    SUM(impressions) AS total_impressions,
    SUM(clicks) AS total_clicks,
    ROUND(
        SUM(clicks) / SUM(impressions),
        4
    ) AS overall_ctr
FROM packages_clean
GROUP BY winner_status;


SELECT
    CASE
        WHEN headline REGEXP '[0-9]'
            THEN 'Contains number'
        ELSE 'No number'
    END AS number_feature,
    COUNT(*) AS package_count,
    SUM(winner = 1) AS winner_count,
    ROUND(
        AVG(winner),
        4
    ) AS winner_rate
FROM packages_clean
GROUP BY number_feature;


SELECT
    CASE
        WHEN TRIM(headline) LIKE '%?'
            THEN 'Question'
        ELSE 'Statement'
    END AS question_feature,
    COUNT(*) AS package_count,
    SUM(winner = 1) AS winner_count,
    ROUND(
        AVG(winner),
        4
    ) AS winner_rate
FROM packages_clean
GROUP BY question_feature;