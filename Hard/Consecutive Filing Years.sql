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