SELECT
    MIN(created_at) AS earliest_created_at,
    MAX(created_at) AS latest_created_at,
    COUNT(*) AS total_packages,
    SUM(
        DATE(created_at) BETWEEN '2013-06-25' AND '2014-01-10'
    ) AS packages_in_problem_period,
    COUNT(DISTINCT CASE
        WHEN DATE(created_at) BETWEEN '2013-06-25' AND '2014-01-10'
        THEN clickability_test_id
    END) AS tests_in_problem_period
FROM packages;