SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT CONCAT_WS('|',
        row_id,
        created_at,
        updated_at,
        clickability_test_id,
        headline,
        impressions,
        clicks
    )) AS unique_records
FROM packages;