SELECT
    clickability_test_id,
    headline,
    impressions,
    clicks,
    significance,
    first_place,
    winner,
    test_week
FROM packages
ORDER BY clickability_test_id
LIMIT 20;