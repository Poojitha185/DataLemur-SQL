/*
Question:
Find the third transaction made by every user.
Display user_id, spend, and transaction_date.

Approach:
1. Use a CTE to create a temporary result named third_transactions.
2. Use DENSE_RANK() to assign ranks to transactions.
3. PARTITION BY user_id ranks transactions separately for each user.
4. ORDER BY transaction_date ranks transactions from earliest to latest.
5. Filter the result using WHERE transaction_number = 3 to get the third transaction of every user.

*/

with third_transactions as(
select user_id,spend,transaction_date, 
dense_rank() over(partition by user_id
 ORDER BY transaction_date) as transaction_number
FROM transactions)

select user_id ,spend,transaction_date
from third_transactions
where transaction_number=3;