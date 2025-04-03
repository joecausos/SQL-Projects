-- 7. Are there any seasonal patterns in border crossings (e.g., higher in summer, lower in winter)?
--   - Seasonal patterns can indicate peak travel times and help in planning for increased activity.

SELECT EXTRACT(MONTH FROM date) AS MONTH, COUNT (*) AS seasonal_MoM_trend 
FROM border_crossing bc
GROUP BY EXTRACT(MONTH FROM date)
ORDER BY MONTH;
