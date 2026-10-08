-- Question:
-- Find all employees who earn more than their direct managers.
-- Display the employee's ID and name.

-- Solution:
-- The employee and manager are stored in the same table,
-- so we use a SELF JOIN.
-- e represents the employee.
-- m represents the manager.
-- e.manager_id = m.employee_id connects each employee
-- with their direct manager.
-- WHERE e.salary > m.salary checks if the employee
-- earns more than their manager.

SELECT e.employee_id, e.name
FROM employee e
JOIN employee m
    ON e.manager_id = m.employee_id
WHERE e.salary > m.salary;