--3. Which border (e.g., US-Canada, US-Mexico) has the highest number of crossings?
--   - Identifying the busiest borders can help focus on regions with the most activity and potential issues.

SELECT border, COUNT(*) AS ttl_number_per_border
FROM border_crossing bc 
GROUP BY bc.border 
ORDER BY ttl_number_per_border DESC;