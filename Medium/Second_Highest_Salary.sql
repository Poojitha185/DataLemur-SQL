-- Question:
-- Find the second highest distinct salary among all employees.
-- If multiple employees have the same salary, display it only once.

-- Approach:
-- Use DISTINCT to remove duplicate salaries.
-- ORDER BY salary DESC to sort salaries from highest to lowest.
-- OFFSET 1 to skip the highest salary.
-- LIMIT 1 to return the second highest salary.

SELECT DISTINCT salary
FROM employee
ORDER BY salary DESC
LIMIT 1 OFFSET 1;
