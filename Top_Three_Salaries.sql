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