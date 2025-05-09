-- Query 1: Rank EV models by electric range within each manufacturer
-- Purpose: Compare model performance within each EV brand
SELECT 
  emk.maker_name,
  em.model,
  ep.electric_range,
  RANK() OVER (PARTITION BY emk.maker_name ORDER BY ep.electric_range DESC) AS range_rank
FROM ev_population ep
JOIN ev_model em ON ep.model_id = em.model_id
JOIN ev_maker emk ON em.maker_id = emk.maker_id
ORDER BY emk.maker_name, range_rank;

-- Query 2: Calculate the average MSRP and show each EV's % difference from the average of its model
-- Purpose: Detect pricing outliers within the same model group
SELECT 
  em.model,
  ep.base_msrp,
  ROUND(AVG(ep.base_msrp) OVER (PARTITION BY em.model), 2) AS model_avg_price,
  ROUND(
    100.0 * (ep.base_msrp - AVG(ep.base_msrp) OVER (PARTITION BY em.model)) 
    / NULLIF(AVG(ep.base_msrp) OVER (PARTITION BY em.model), 0), 2
  ) AS price_diff_pct
FROM ev_population ep
JOIN ev_model em ON ep.model_id = em.model_id
ORDER BY model, price_diff_pct DESC;

-- Query 3: Calculate running total of EVs by state over time (assuming model_year is year of sale)
-- Purpose: Show EV adoption growth per state over time
SELECT 
  ec.state,
  em.model_year,
  COUNT(*) AS vehicles_in_year,
  SUM(COUNT(*)) OVER (PARTITION BY ec.state ORDER BY em.model_year) AS cumulative_evs
FROM ev_population ep
JOIN ev_country ec ON ep.country_id = ec.country_id
JOIN ev_model em ON ep.model_id = em.model_id
GROUP BY ec.state, em.model_year
ORDER BY ec.state, em.model_year;

-- Query 4: Get top 3 EVs with the highest MSRP per city
-- Purpose: Discover luxury EV models dominating local markets
SELECT *
FROM (
  SELECT 
    ec.city,
    em.model,
    ep.base_msrp,
    RANK() OVER (PARTITION BY ec.city ORDER BY ep.base_msrp DESC) AS city_msrp_rank
  FROM ev_population ep
  JOIN ev_model em ON ep.model_id = em.model_id
  JOIN ev_country ec ON ep.country_id = ec.country_id
) ranked
WHERE city_msrp_rank <= 3
ORDER BY city, city_msrp_rank;

-- Query 5: % contribution of each manufacturer to total EVs sold (based on VIN count)
-- Purpose: Visualize brand market share
SELECT 
  emk.maker_name,
  COUNT(*) AS total_vehicles,
  ROUND(
    100.0 * COUNT(*) OVER (PARTITION BY emk.maker_name) 
    / COUNT(*) OVER (), 2
  ) AS market_share_pct
FROM ev_population ep
JOIN ev_maker emk ON ep.maker_id = emk.maker_id
ORDER BY market_share_pct DESC;