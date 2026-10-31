-- Question:
-- Calculate the percentage of time spent on 'send' and 'open'
-- activities for each age group.
-- Round the percentages to 2 decimal places.

-- Approach:
-- 1. INNER JOIN activities and age_breakdown using user_id
--    to get the age group of each user.

-- 2. Use WHERE to consider only 'send' and 'open' activities.

-- 3. GROUP BY age_bucket to calculate percentages
--    separately for each age group.

-- 4. Use SUM() with FILTER (WHERE):
--    a) Calculate total time spent on 'send' activities.
--    b) Calculate total time spent on 'open' activities.

-- 5. Divide each activity's total time by the overall
--    time spent and multiply by 100 to get percentages.

-- 6. Use ROUND() to display percentages up to 2 decimal places.

SELECT age.age_bucket,
round(((sum(activities.time_spent) filter (where activities.activity_type='send') )/ (sum(activities.time_spent))*100.0),2) as send_perc,
round(((sum(activities.time_spent) filter (where activities.activity_type='open') )/(sum(activities.time_spent))*100.0),2)as open_arc
from activities
inner join age_breakdown as age
on activities.user_id=age.user_id
where activities.activity_type in ('send','open')
group by age.age_bucket;