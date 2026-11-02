WITH yearly_spend AS (
    -- Calculate total spend for each product in each year
    SELECT
        EXTRACT(YEAR FROM transaction_date) AS year,
        product_id,
        SUM(spend) AS current_year_spend
    FROM user_transactions
    GROUP BY EXTRACT(YEAR FROM transaction_date), product_id
),

previous_year AS (
    -- Get previous year's spend for each product
    SELECT
        year,
        product_id,
        current_year_spend,
        LAG(current_year_spend) OVER (
            PARTITION BY product_id
            ORDER BY year
        ) AS previous_year_spend
    FROM yearly_spend
)

-- Calculate year-on-year growth rate
SELECT
    year,
    product_id,
    current_year_spend,
    previous_year_spend,
    ROUND(
        (current_year_spend - previous_year_spend)
        * 100.0 / previous_year_spend,
        2
    ) AS yoy_growth_percentage
FROM previous_year
ORDER BY year ASC, product_id;