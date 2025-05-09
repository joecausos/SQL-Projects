-- 1. Count total EVs recorded
SELECT COUNT(*) AS total_evs FROM ev_population;

-- 2. List all unique electric vehicle types
SELECT DISTINCT electric_vehicle_type FROM ev_population;

-- 3. Top 5 most common EV models
SELECT em.model, COUNT(*) AS total
FROM ev_population ep
JOIN ev_model em ON ep.model_id = em.model_id
GROUP BY em.model
ORDER BY total DESC
LIMIT 5;

-- 4. Average electric range by EV category
SELECT ev_category, AVG(electric_range) AS avg_range
FROM ev_population
GROUP BY ev_category;

-- 5. Total EVs by state
SELECT ec.state, COUNT(*) AS total
FROM ev_population ep
JOIN ev_country ec ON ep.country_id = ec.country_id
GROUP BY ec.state
ORDER BY total DESC;

-- 6. EVs eligible for CAFV (Clean Alternative Fuel Vehicle)
SELECT COUNT(*) AS cafv_eligible_count
FROM ev_population
WHERE cafv_eligible ILIKE 'eligible';

-- 7. Most expensive EVs (Top 10 by MSRP)
SELECT vin, base_msrp
FROM ev_population
ORDER BY base_msrp DESC
LIMIT 10;

-- 8. Distribution of EVs by maker
SELECT emk.maker_name, COUNT(*) AS total
FROM ev_population ep
JOIN ev_maker emk ON ep.maker_id = emk.maker_id
GROUP BY emk.maker_name
ORDER BY total DESC;

-- 9. EV count by model year
SELECT em.model_year, COUNT(*) AS total
FROM ev_population ep
JOIN ev_model em ON ep.model_id = em.model_id
GROUP BY em.model_year
ORDER BY em.model_year;

-- 10. Total EVs by city and state
SELECT ec.city, ec.state, COUNT(*) AS total
FROM ev_population ep
JOIN ev_country ec ON ep.country_id = ec.country_id
GROUP BY ec.city, ec.state
ORDER BY total DESC;