
-- Question:
-- Given a user_transactions table containing transaction details
-- for different products, calculate the year-on-year (YoY) growth
-- rate of the total spend for each product.

-- Approach:
-- 1. Extract year from transaction_date using EXTRACT().
-- 2. Use LAG() to get the previous year's spend.
-- 3. PARTITION BY product_id to calculate separately for each product.
-- 4. ORDER BY year to arrange transactions chronologically.
-- 5. Calculate YoY growth rate using the formula:
--    ((current spend - previous spend) / previous spend) * 100.
-- 6. Use ROUND() to round the growth rate to 2 decimal places.

with yearly_spend_cte as(SELECT
extract(year from transaction_date)as yeear,
product_id,
spend as cur_year_spend,
lag(spend) over(partition by product_id order by extract (year from transaction_date)) as prev_year_spend
from user_transactions)

select
yeear,product_id,cur_year_spend,prev_year_spend,
round(((cur_year_spend-prev_year_spend)/(prev_year_spend))*100,2)as yoy_rate
from yearly_spend_cte;