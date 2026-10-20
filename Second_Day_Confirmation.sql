SELECT DISTINCT e.user_id
FROM emails e
JOIN texts t
    ON e.email_id = t.email_id
WHERE t.action_date = e.signup_date + INTERVAL '2 days'
  AND t.signup_action = 'Confirmed';