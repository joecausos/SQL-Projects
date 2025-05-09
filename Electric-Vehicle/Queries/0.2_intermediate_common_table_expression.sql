-- Query 1: CTE to get average electric range and MSRP by model, then rank them
-- Purpose: Evaluate which EV models offer the best balance of range and cost, ranked by efficiency
WITH model_stats AS (
  SELECT 
    em.model,
    AVG(ep.electric_range) AS avg_range,
    AVG(ep.base_msrp) AS avg_price
  FROM ev_population ep
  JOIN ev_model em ON ep.model_id = em.model_id
  GROUP BY em.model
),
efficiency_ranked AS (
  SELECT 
    model,
    avg_range,
    avg_price,
    ROUND(avg_range / NULLIF(avg_price, 0), 4) AS range_per_dollar
  FROM model_stats
)
SELECT *
FROM efficiency_ranked
ORDER BY range_per_dollar DESC
LIMIT 10;

-- Query 2: CTE for top cities by EV population and their top 3 most common models
-- Purpose: Reveal local EV model preferences across leading EV cities
WITH top_cities AS (
  SELECT ec.city, ec.state, COUNT(*) AS vehicle_count
  FROM ev_population ep
  JOIN ev_country ec ON ep.country_id = ec.country_id
  GROUP BY ec.city, ec.state
  ORDER BY vehicle_count DESC
  LIMIT 5
),
city_models AS (
  SELECT ec.city, ec.state, em.model, COUNT(*) AS model_count
  FROM ev_population ep
  JOIN ev_country ec ON ep.country_id = ec.country_id
  JOIN ev_model em ON ep.model_id = em.model_id
  WHERE (ec.city, ec.state) IN (SELECT city, state FROM top_cities)
  GROUP BY ec.city, ec.state, em.model
)
SELECT *
FROM (
  SELECT *, 
         RANK() OVER (PARTITION BY city, state ORDER BY model_count DESC) AS rank
  FROM city_models
) ranked_models
WHERE rank <= 3;

-- Query 3: CTE to flag CAFV eligibility % by model year and classify adoption rate
-- Purpose: Analyze clean fuel adoption trends by generation of vehicle models
WITH year_eligibility AS (
  SELECT em.model_year,
         COUNT(*) AS total,
         COUNT(CASE WHEN ep.cafv_eligible ILIKE 'eligible' THEN 1 END) AS eligible_count
  FROM ev_population ep
  JOIN ev_model em ON ep.model_id = em.model_id
  GROUP BY em.model_year
),
year_classification AS (
  SELECT *,
         ROUND(100.0 * eligible_count / total, 2) AS eligible_pct,
         CASE 
           WHEN eligible_count::float / total >= 0.9 THEN 'High Adoption'
           WHEN eligible_count::float / total >= 0.5 THEN 'Moderate Adoption'
           ELSE 'Low Adoption'
         END AS adoption_class
  FROM year_eligibility
)
SELECT *
FROM year_classification
ORDER BY model_year;

-- Query 4: CTE to identify manufacturers whose average range is below the industry median
-- Purpose: Highlight potential laggards in EV battery performance
WITH maker_range AS (
  SELECT emk.maker_name, AVG(ep.electric_range) AS avg_range
  FROM ev_population ep
  JOIN ev_maker emk ON ep.maker_id = emk.maker_id
  GROUP BY emk.maker_name
),
industry_median AS (
  SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY avg_range) AS median_range
  FROM maker_range
)
SELECT mr.maker_name, mr.avg_range, im.median_range
FROM maker_range mr
CROSS JOIN industry_median im
WHERE mr.avg_range < im.median_range
ORDER BY mr.avg_range;

-- Query 5: CTE to find duplicate VINs and the number of times they appear
-- Purpose: Perform data integrity check – VIN should typically be unique
WITH vin_counts AS (
  SELECT vin, COUNT(*) AS occurrences
  FROM ev_population
  GROUP BY vin
)
SELECT *
FROM vin_counts
WHERE occurrences > 1
ORDER BY occurrences DESC;