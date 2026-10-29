with third_transactions as(
select user_id,spend,transaction_date, 
dense_rank() over(partition by user_id
 ORDER BY transaction_date) as transaction_number
FROM transactions)

select user_id ,spend,transaction_date
from third_transactions
where transaction_number=3;