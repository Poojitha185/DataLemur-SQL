-- Question:
-- Count the companies that have posted duplicate job listings.
-- Duplicates have the same company_id, title, and description.

-- Solution:
-- GROUP BY groups listings with the same company, title, and description.
-- HAVING COUNT(*) > 1 keeps only duplicate listings.
-- The subquery identifies companies with duplicate listings.
-- COUNT(DISTINCT company_id) counts each company only once.

SELECT COUNT(DISTINCT company_id) AS duplicate_companies
FROM (
    SELECT company_id
    FROM job_listings
    GROUP BY company_id, title, description
    HAVING COUNT(*) > 1
) AS duplicates;