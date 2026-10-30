-- Question:
-- Calculate the average star rating for each product for each month.
-- Round the average rating to 2 decimal places.
-- Display the product, month, and average stars.
-- Sort the result by month and then by product ID.

-- Solution:
-- AVG(stars) calculates the average rating.
-- ROUND(..., 2) rounds the average to 2 decimal places.
-- EXTRACT(MONTH FROM submit_date) gets the month from the date.
-- GROUP BY product_id, mth creates a separate group for each product in each month.
-- ORDER BY mth, product sorts the result by month and product ID.

SELECT 
    ROUND(AVG(stars), 2) AS avg_stars,
    product_id AS product,
    EXTRACT(MONTH FROM submit_date) AS mth
FROM reviews
GROUP BY product, mth
ORDER BY mth, product;