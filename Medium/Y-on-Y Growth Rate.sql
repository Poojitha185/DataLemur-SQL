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