--4. What are the top 5 ports of entry with the highest number of crossings?
--   - Knowing the busiest ports of entry can assist in resource allocation and understanding high-traffic areas.
SELECT port_name, COUNT(*) AS top_port_crossing
FROM border_crossing bc 
GROUP BY bc.port_name
ORDER BY top_port_crossing DESC
LIMIT 5 ;
