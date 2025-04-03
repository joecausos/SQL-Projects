-- Temporal Analysis:
-- 6. What are the trends in border crossings over time (e.g., increase or decrease)?
--   - Observing trends over time can help identify periods of growth or decline and correlate them with external factors.
  
   
 SELECT EXTRACT(YEAR FROM date)AS year, COUNT(*) AS ttl_YoY_border_passing
 FROM border_crossing bc
 GROUP BY EXTRACT(YEAR FROM date)
 ORDER BY year;
 