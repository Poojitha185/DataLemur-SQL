-- Question:
-- Calculate the activation rate of users who confirmed their
-- account through text messages.
-- Round the result to 2 decimal places.

-- Approach:
-- 1. Use LEFT JOIN to combine emails and texts tables using email_id.
--    LEFT JOIN ensures all users from the emails table are included.

-- 2. Use CASE WHEN to check whether signup_action is 'Confirmed'.
--    COUNT() counts only the confirmed records.

-- 3. Use COUNT(DISTINCT emails.email_id) to count each registered
--    user only once, because a user may receive multiple text messages.

-- 4. Divide the confirmed user count by the total unique user count
--    to calculate the activation rate.

-- 5. Multiply by 1.0 to avoid integer division and preserve decimals.

-- 6. Use ROUND() to round the activation rate to 2 decimal places.

SELECT round(
(

    (count(case when texts.signup_action='Confirmed' then 1 end))*1.0)/
    (count(distinct emails.email_id)),2
    
    )
     as confirm_rate
FROM emails
left join texts on emails.email_id=texts.email_id;