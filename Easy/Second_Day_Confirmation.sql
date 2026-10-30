/*
Question:
Find the user IDs of users who did not confirm their sign-up
on the first day but confirmed on the second day.

Approach:
1. Join the emails and texts tables using email_id.
2. Filter records where signup_action = 'Confirmed'.
3. Check whether action_date is one day after signup_date
   using INTERVAL '1 day'.
4. Select the user_id of the matching users.

SQL Concepts:
- JOIN
- WHERE
- INTERVAL
- DISTINCT (to avoid duplicate user IDs)
*/

SELECT DISTINCT e.user_id
FROM emails e
JOIN texts t
    ON e.email_id = t.email_id
WHERE t.action_date = e.signup_date + INTERVAL '2 days'
  AND t.signup_action = 'Confirmed';