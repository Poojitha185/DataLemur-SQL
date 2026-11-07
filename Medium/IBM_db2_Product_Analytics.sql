with unique_employe_count as(SELECT employees.employee_id,
COUNT(DISTINCT queries.query_id) as unique_queries
from employees
left join queries on queries.employee_id=employees.employee_id and
extract (month from query_starttime) between 07 and 09
and extract (year from query_starttime)=2023
group by  employees.employee_id
)

select unique_queries,
count(employee_id) as employee_count
from unique_employe_count
group by unique_queries
order by unique_queries;