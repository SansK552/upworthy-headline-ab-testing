SELECT
    COUNT(*) AS total_rows,
    SUM(clickability_test_id IS NULL) AS null_test_id,
    SUM(headline IS NULL) AS null_headline,
    SUM(impressions IS NULL) AS null_impressions,
    SUM(clicks IS NULL) AS null_clicks,
    SUM(significance IS NULL) AS null_significance,
    SUM(first_place IS NULL) AS null_first_place,
    SUM(winner IS NULL) AS null_winner,
    SUM(test_week IS NULL) AS null_test_week
FROM packages;