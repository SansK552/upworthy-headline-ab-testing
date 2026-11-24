WITH test_number_ctr AS (
    SELECT
        clickability_test_id,
        CASE
            WHEN headline REGEXP '[0-9]'
                THEN 'Contains number'
            ELSE 'No number'
        END AS number_feature,
        SUM(impressions) AS impressions,
        SUM(clicks) AS clicks,
        SUM(clicks) / SUM(impressions) AS ctr
    FROM packages_clean
    GROUP BY
        clickability_test_id,
        number_feature
),
paired_tests AS (
    SELECT
        clickability_test_id,
        MAX(
            CASE
                WHEN number_feature = 'Contains number'
                THEN ctr
            END
        ) AS number_ctr,
        MAX(
            CASE
                WHEN number_feature = 'No number'
                THEN ctr
            END
        ) AS no_number_ctr
    FROM test_number_ctr
    GROUP BY clickability_test_id
)
SELECT
    clickability_test_id,
    number_ctr,
    no_number_ctr,
    number_ctr - no_number_ctr AS ctr_difference
FROM paired_tests
WHERE number_ctr IS NOT NULL
  AND no_number_ctr IS NOT NULL
ORDER BY ctr_difference DESC;


WITH test_question_ctr AS (
    SELECT
        clickability_test_id,
        CASE
            WHEN TRIM(headline) LIKE '%?'
                THEN 'Question'
            ELSE 'Statement'
        END AS question_feature,
        SUM(impressions) AS impressions,
        SUM(clicks) AS clicks,
        SUM(clicks) / SUM(impressions) AS ctr
    FROM packages_clean
    GROUP BY
        clickability_test_id,
        question_feature
),
paired_tests AS (
    SELECT
        clickability_test_id,
        MAX(
            CASE
                WHEN question_feature = 'Question'
                THEN ctr
            END
        ) AS question_ctr,
        MAX(
            CASE
                WHEN question_feature = 'Statement'
                THEN ctr
            END
        ) AS statement_ctr
    FROM test_question_ctr
    GROUP BY clickability_test_id
)
SELECT
    clickability_test_id,
    question_ctr,
    statement_ctr,
    question_ctr - statement_ctr AS ctr_difference
FROM paired_tests
WHERE question_ctr IS NOT NULL
  AND statement_ctr IS NOT NULL
ORDER BY ctr_difference DESC;


WITH test_avg_length AS (
    SELECT
        clickability_test_id,
        AVG(
            CHAR_LENGTH(headline)
        ) AS avg_test_length
    FROM packages_clean
    GROUP BY clickability_test_id
),
classified AS (
    SELECT
        p.clickability_test_id,
        CASE
            WHEN CHAR_LENGTH(p.headline) < t.avg_test_length
                THEN 'Shorter than test average'
            WHEN CHAR_LENGTH(p.headline) > t.avg_test_length
                THEN 'Longer than test average'
            ELSE 'Equal to test average'
        END AS length_feature,
        p.impressions,
        p.clicks
    FROM packages_clean AS p
    INNER JOIN test_avg_length AS t
        ON p.clickability_test_id =
           t.clickability_test_id
)
SELECT
    clickability_test_id,
    length_feature,
    SUM(impressions) AS impressions,
    SUM(clicks) AS clicks,
    ROUND(
        SUM(clicks) / SUM(impressions),
        4
    ) AS ctr
FROM classified
WHERE length_feature <> 'Equal to test average'
GROUP BY
    clickability_test_id,
    length_feature
ORDER BY clickability_test_id;