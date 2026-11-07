-- Question:
-- Find the number of unique queries made by each employee
-- between July and September 2023.
-- Then find how many employees made each number of unique queries.
-- Include employees who made zero queries.
-- Output: unique_queries, employee_count.

-- Approach:
-- 1. Start with employees table to include all employees.
-- 2. Use LEFT JOIN to connect employees with their queries.
-- 3. Apply date conditions in ON clause to retain employees
--    who made zero queries.
-- 4. Use COUNT(DISTINCT query_id) to count unique queries
--    made by each employee.
-- 5. GROUP BY employee_id to calculate queries per employee.
-- 6. Use a CTE to store the employee-wise query counts.
-- 7. In the outer query, GROUP BY unique_queries to count
--    how many employees made the same number of queries.
-- 8. Use ORDER BY unique_queries to display results in ascending order.

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