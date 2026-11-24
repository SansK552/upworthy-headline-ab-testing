SELECT
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
    ) AS average_headline_length
FROM packages_clean;

SELECT
    clickability_test_id,
    headline,
    impressions,
    clicks,
    ROUND(
        clicks / impressions,
        4
    ) AS ctr
FROM packages_clean
ORDER BY ctr DESC;

SELECT
    clickability_test_id,
    COUNT(*) AS package_count,
    SUM(impressions) AS total_impressions,
    SUM(clicks) AS total_clicks,
    ROUND(
        SUM(clicks) / SUM(impressions),
        4
    ) AS test_ctr
FROM packages_clean
GROUP BY clickability_test_id
ORDER BY test_ctr DESC;