--8. How do border crossings compare year-over-year?
--   - Year-over-year comparisons can highlight long-term trends and the impact of policy changes or global events.

SELECT EXTRACT(YEAR FROM date) AS YEAR, COUNT(*) AS ttl_YoY_crossing
FROM border_crossing bc
GROUP BY EXTRACT(YEAR FROM date)
ORDER BY YEAR;