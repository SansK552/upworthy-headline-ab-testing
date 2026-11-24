DROP TABLE IF EXISTS valid_tests;
CREATE TABLE valid_tests AS
SELECT
    clickability_test_id,
    COUNT(*) AS package_count,
    MIN(created_at) AS test_start,
    MAX(created_at) AS test_end,
    SUM(impressions) AS total_impressions,
    SUM(clicks) AS total_clicks
FROM packages
GROUP BY clickability_test_id
HAVING
    COUNT(*) >= 2
    AND NOT (
        DATE(MIN(created_at))
        BETWEEN '2013-06-25' AND '2014-01-10'
    );
    
SELECT
    COUNT(*) AS valid_test_count
FROM valid_tests;

SELECT
    MIN(test_start) AS earliest_valid_test,
    MAX(test_start) AS latest_valid_test,
    MIN(package_count) AS minimum_packages,
    MAX(package_count) AS maximum_packages
FROM valid_tests;