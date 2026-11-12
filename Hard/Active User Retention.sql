-- Question:
-- Find the number of monthly active users (MAUs) in July 2022.
-- An active user must have performed an action in July 2022
-- and also have performed an action in the previous month (June 2022).

-- Approach:
-- 1. Use the user_actions table for July users as curr_month.
-- 2. Use EXISTS to check whether the same user was active in the previous month.
-- 3. Inside EXISTS, use the same table again with the alias last_month.
-- 4. Match the same user using user_id.
-- 5. Check that last_month is the month immediately before curr_month.
-- 6. Filter curr_month to July 2022.
-- 7. Count DISTINCT user_id because one user can have multiple actions.
-- 8. Group by the month.

SELECT
    EXTRACT(MONTH FROM curr_month.event_date) AS month,
    COUNT(DISTINCT curr_month.user_id) AS monthly_active_users
FROM user_actions AS curr_month
WHERE EXISTS (
    SELECT last_month.user_id
    FROM user_actions AS last_month
    WHERE last_month.user_id = curr_month.user_id
      AND EXTRACT(MONTH FROM last_month.event_date)
          = EXTRACT(MONTH FROM curr_month.event_date - INTERVAL '1 month')
)
AND EXTRACT(MONTH FROM curr_month.event_date) = 7
AND EXTRACT(YEAR FROM curr_month.event_date) = 2022
GROUP BY month;