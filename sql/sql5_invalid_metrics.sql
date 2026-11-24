SELECT
    COUNT(*) AS total_rows,
    SUM(impressions IS NULL) AS null_impressions,
    SUM(impressions <= 0) AS non_positive_impressions,
    SUM(clicks IS NULL) AS null_clicks,
    SUM(clicks < 0) AS negative_clicks,
    SUM(clicks > impressions) AS clicks_greater_than_impressions
FROM packages;