-- Question:
-- Update the payment status of each advertiser based on whether they
-- made a payment today.
-- Output user_id and the updated status, sorted by user_id.

-- Approach:
-- 1. Use FULL OUTER JOIN because we need users from both tables.
--    - advertiser only -> did not pay today -> CHURN
--    - daily_pay only -> new advertiser who paid -> NEW
--    - present in both -> paid today
--
-- 2. Use COALESCE() to get the user_id from whichever table has it.
--
-- 3. If paid is NULL, the advertiser did not pay today -> CHURN.
--
-- 4. If the advertiser paid:
--    - Previous status = CHURN -> RESURRECT
--    - Previous status = NEW/EXISTING/RESURRECT -> EXISTING
--    - No previous status -> NEW
--
-- 5. Sort the final result by user_id.

SELECT
    COALESCE(advertiser.user_id, daily_pay.user_id) AS user_id,
    CASE
        WHEN paid IS NULL THEN 'CHURN'
        WHEN paid IS NOT NULL
             AND advertiser.status IN ('NEW', 'EXISTING', 'RESURRECT')
            THEN 'EXISTING'
        WHEN paid IS NOT NULL
             AND advertiser.status = 'CHURN'
            THEN 'RESURRECT'
        WHEN paid IS NOT NULL
             AND advertiser.status IS NULL
            THEN 'NEW'
    END AS new_status
FROM advertiser
FULL OUTER JOIN daily_pay
    ON advertiser.user_id = daily_pay.user_id
ORDER BY user_id;
