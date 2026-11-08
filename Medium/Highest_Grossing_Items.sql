-- Question:
-- Find the top 2 highest-grossing products within each category
-- in the year 2022.
-- Output: category, product, total_spend.

-- Approach:
-- 1. Filter only transactions from 2022 using WHERE and EXTRACT().
-- 2. Use GROUP BY category, product to calculate
--    total spending for each product within each category.
-- 3. Use SUM(spend) to calculate total spend.
-- 4. Use RANK() with PARTITION BY category to rank
--    products separately within each category.
-- 5. ORDER BY SUM(spend) DESC gives the highest spend rank 1.
-- 6. Use ranking <= 2 to get the top 2 ranks.

with ranked_spending_cte as(SELECT 
product,
category,
sum(spend) as total_spend,
rank() over(
partition by category
order by sum(spend) desc) as ranking
from product_spend
where extract (year from transaction_date)=2022
group by product,category)

select 
category,product,total_spend 
from ranked_spending_cte
where ranking<=2;