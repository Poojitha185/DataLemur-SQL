-- Question:
-- Calculate the click-through rate (CTR) for each app in 2022.
-- CTR = (number of clicks / number of impressions) * 100.
-- Round the CTR to 2 decimal places.
-- Display the app ID and its CTR.

-- Solution:
-- COUNT(CASE WHEN event_type = 'click' THEN 1 END)
-- counts only the click events.
-- COUNT(CASE WHEN event_type = 'impression' THEN 1 END)
-- counts only the impression events.
-- 100.0 is used to calculate the percentage.
-- EXTRACT(YEAR FROM event_date) gets the year from the event date.
-- WHERE filters the events to only those from 2022.
-- GROUP BY app_id calculates CTR separately for each app.
-- ROUND(..., 2) rounds the CTR to 2 decimal places.

SELECT
    app_id,
    ROUND(
        COUNT(CASE WHEN event_type = 'click' THEN 1 END) * 100.0
        / COUNT(CASE WHEN event_type = 'impression' THEN 1 END),
        2
    ) AS ctr
FROM events
WHERE EXTRACT(YEAR FROM timestamp) = 2022
GROUP BY app_id;
