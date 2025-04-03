--5. How does the number of border crossings vary by mode of transportation (e.g., pedestrian, vehicle, train)?
--   - Examining the modes of transportation used for crossings can provide insights into infrastructure needs and traveler preferences.

SELECT measure, COUNT (*) AS mode_of_transportation
FROM border_crossing bc 
GROUP BY bc.measure 
ORDER BY mode_of_transportation DESC;
