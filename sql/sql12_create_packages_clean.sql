DROP TABLE IF EXISTS packages_clean;
CREATE TABLE packages_clean AS
SELECT
    p.*
FROM packages AS p
INNER JOIN valid_tests AS v
    ON p.clickability_test_id = v.clickability_test_id;
    
SELECT
    COUNT(*) AS clean_package_count,
    COUNT(DISTINCT clickability_test_id) AS clean_test_count
FROM packages_clean;

SELECT
    MIN(created_at) AS earliest_clean_record,
    MAX(created_at) AS latest_clean_record,
    SUM(impressions) AS total_impressions,
    SUM(clicks) AS total_clicks
FROM packages_clean;