SELECT age.age_bucket,
round(((sum(activities.time_spent) filter (where activities.activity_type='send') )/ (sum(activities.time_spent))*100.0),2) as send_perc,
round(((sum(activities.time_spent) filter (where activities.activity_type='open') )/(sum(activities.time_spent))*100.0),2)as open_arc
from activities
inner join age_breakdown as age
on activities.user_id=age.user_id
where activities.activity_type in ('send','open')
group by age.age_bucket;