-- Question:
-- Calculate the 3-day rolling average of tweets for each user.
-- Display user_id, tweet_date and rolling average rounded to 2 decimal places.

-- Approach:
-- 1. Use AVG() to calculate the average tweet count.
-- 2. Use PARTITION BY user_id to calculate separately for each user.
-- 3. Use ORDER BY tweet_date to process tweets chronologically.
-- 4. Use ROWS BETWEEN 2 PRECEDING AND CURRENT ROW to consider
--    the current row and previous 2 rows (3 rows in total).
-- 5. Use ROUND(..., 2) to round the rolling average to 2 decimal places.

SELECT
    user_id,
    tweet_date,
    ROUND(
        AVG(tweet_count) OVER (
        PARTITION BY user_id
        ORDER BY tweet_date
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ), 2
    ) AS rolling_avg_3d
FROM tweets;