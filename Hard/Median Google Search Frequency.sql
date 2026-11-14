-- Question:
-- Find the median number of searches made by a user.
-- The table stores the number of searches and how many users made that many searches.
-- Round the median to 1 decimal place.

-- Approach:
-- 1. Expand the table by repeating each 'searches' value according to 'num_users'.
-- 2. Use GENERATE_SERIES(1, num_users) to create the required number of rows.
-- 3. Use PERCENTILE_CONT(0.5) to find the 50th percentile (median).
-- 4. Order by searches before calculating the percentile.
-- 5. Cast the result to numeric so ROUND(value, 1) works in PostgreSQL.
-- 6. Round the final median to 1 decimal place.

WITH searches_expanded AS (
    SELECT searches
    FROM search_frequency
    GROUP BY searches,
             GENERATE_SERIES(1, num_users)
)
SELECT ROUND(
    PERCENTILE_CONT(0.5)
    WITHIN GROUP (
        ORDER BY searches
    )::numeric,
    1
) AS median
FROM searches_expanded;