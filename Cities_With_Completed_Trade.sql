SELECT
    city,
    COUNT(CASE WHEN trades.status = 'Completed' THEN 1 END) AS total_orders
FROM users
LEFT JOIN trades
    ON users.user_id = trades.user_id
GROUP BY city
ORDER BY total_orders DESC
LIMIT 3;