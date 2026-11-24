SELECT
    clickability_test_id,
    COUNT(*) AS package_count,
    MIN(created_at) AS test_start,
    MAX(created_at) AS test_end,
    SUM(impressions) AS total_impressions,
    SUM(clicks) AS total_clicks,
    CASE
        WHEN COUNT(*) < 2 THEN 'Exclude - fewer than 2 packages'
        WHEN DATE(MIN(created_at))
             BETWEEN '2013-06-25' AND '2014-01-10'
        THEN 'Exclude - randomization period'
        ELSE 'Keep'
    END AS test_status
FROM packages
GROUP BY clickability_test_id
ORDER BY test_status, clickability_test_id;