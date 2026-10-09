-- Question:
-- Calculate the final balance for each account.
-- Final balance = Total Deposits - Total Withdrawals.

-- Solution:
-- CASE WHEN checks the transaction type.
-- SUM() calculates the total deposit amount.
-- SUM() calculates the total withdrawal amount.
-- Subtract total withdrawals from total deposits to get the final balance.
-- GROUP BY account_id calculates the balance separately for each account.

SELECT
    account_id,
    SUM(CASE WHEN transaction_type = 'Deposit' THEN amount ELSE 0 END)
    -
    SUM(CASE WHEN transaction_type = 'Withdrawal' THEN amount ELSE 0 END)
    AS final_balance
FROM transactions
GROUP BY account_id;