/*
Question:
Identify high earners in each department, defined as employees
whose salaries rank among the top 3 salary levels in their department.
If salaries are duplicated, include all employees with the same rank.
Sort by department name ascending, salary descending, and name ascending.

Approach:
1. Use DENSE_RANK() to rank salaries from highest to lowest.
2. Use PARTITION BY department_id to restart ranking for each department.
3. Use a CTE to store the salary rankings.
4. Filter for salary_rank <= 3 to get the top 3 salary levels.
5. Sort by department_name ASC, salary DESC, and name ASC.
*/

WITH ranked_employees AS (
    SELECT
        d.department_name,
        e.name,
        e.salary,
        DENSE_RANK() OVER (
            PARTITION BY e.department_id
            ORDER BY e.salary DESC
        ) AS salary_rank
    FROM employee e
    LEFT JOIN department d
        ON e.department_id = d.department_id
)
SELECT department_name, name, salary
FROM ranked_employees
WHERE salary_rank <= 3
ORDER BY department_name ASC, salary DESC, name ASC;