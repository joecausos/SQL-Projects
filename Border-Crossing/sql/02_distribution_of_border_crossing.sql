--2. What is the distribution of border crossings by year and month?
--   - Analyzing the distribution by year and month can reveal trends and patterns over time, such as increases or decreases in crossings.

SELECT EXTRACT(YEAR FROM date) AS year, EXTRACT(MONTH FROM date) AS month, COUNT(*) AS total_border_crossing
FROM border_crossing bc
GROUP BY EXTRACT(YEAR FROM date), EXTRACT(MONTH FROM date)
ORDER BY YEAR,MONTH;