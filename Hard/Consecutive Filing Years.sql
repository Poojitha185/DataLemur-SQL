-- Question:
-- Find user_ids who filed their taxes using any version of TurboTax
-- for 3 or more consecutive years.
-- Display the user_ids in ascending order.


-- Approach:
-- 1. Filter only TurboTax products using LIKE 'TurboTax%'.
-- 2. Extract the year from filing_date.
-- 3. Use DISTINCT so that each user has only one record for each year.
--
-- 4. Use ROW_NUMBER() for each user and arrange the years in ascending order.
--    For consecutive years, subtracting ROW_NUMBER() from year
--    gives the same value.
--    Example: 2021-1 = 2020, 2022-2 = 2020, 2023-3 = 2020.
--    Therefore, the same grp represents consecutive years.
--
-- 5. Group by user_id and grp and check if a group contains
--    3 or more years.
-- 6. Return the user_ids and sort them in ascending order.

WITH turbo_years AS (
    SELECT DISTINCT
        user_id,
        EXTRACT(YEAR FROM filing_date) AS year
    FROM filed_taxes
    WHERE product LIKE 'TurboTax%'
),

consecutive_years AS (
    SELECT
        user_id,
        year,
        year - ROW_NUMBER() OVER (
            PARTITION BY user_id
            ORDER BY year
        ) AS grp
    FROM turbo_years
)
SELECT distinct user_id
FROM consecutive_years
GROUP BY user_id, grp
HAVING COUNT(*) >= 3
ORDER BY user_id;