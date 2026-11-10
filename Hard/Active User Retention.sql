SELECT count(distinct user_id case when extract (year from event_date)=2022 and extract(month from event_date) then 1 end)
as monthly_active_users,
extract(month from user_actions) as month
from user_actions
group by extract(month from user_actions) as month;