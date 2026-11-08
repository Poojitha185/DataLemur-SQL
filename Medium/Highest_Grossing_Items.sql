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