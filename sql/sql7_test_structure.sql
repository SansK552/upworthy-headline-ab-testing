SELECT
    package_count,
    COUNT(*) AS number_of_tests
FROM (
    SELECT
        clickability_test_id,
        COUNT(*) AS package_count
    FROM packages
    GROUP BY clickability_test_id
) AS test_sizes
GROUP BY package_count
ORDER BY package_count;