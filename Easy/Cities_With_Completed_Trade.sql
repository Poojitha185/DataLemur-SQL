-- Question:
-- Find the top 3 cities with the highest number of completed trade orders.

-- Approach:
-- LEFT JOIN or JOIN users and trades using user_id to keep all users.
-- COUNT(CASE WHEN ...) counts only completed trade orders.
-- GROUP BY city to calculate the total orders for each city.
-- ORDER BY total_orders DESC to sort from highest to lowest.
-- LIMIT 3 to return the top 3 cities.

SELECT
    city,
    COUNT(CASE WHEN trades.status = 'Completed' THEN 1 END) AS total_orders
FROM users
LEFT JOIN trades     
    ON users.user_id = trades.user_id
GROUP BY city
ORDER BY total_orders DESC
LIMIT 3;