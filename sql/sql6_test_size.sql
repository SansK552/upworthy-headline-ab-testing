SELECT
    clickability_test_id,
    COUNT(*) AS package_count
FROM packages
GROUP BY clickability_test_id
ORDER BY package_count, clickability_test_id;