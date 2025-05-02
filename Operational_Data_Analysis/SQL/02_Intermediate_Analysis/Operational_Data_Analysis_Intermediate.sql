-- ### Intermediate SQL Analysis

-- 1. What is the cumulative failure rate over time?
-- Purpose: To calculate how failure rates accumulate over time, providing insights into overall trends and their impact.
SELECT 
    request_date,
    SUM(CASE WHEN rma_remarks = '4-FAIL<90' THEN 1 ELSE 0 END) 
        OVER (ORDER BY request_date) * 100.0 / COUNT(*) 
        OVER () AS cumulative_failure_rate
FROM 
    staging_table;

-- Transition: From cumulative rates, the next step is to identify the most frequent failure descriptions for prioritization.

-- 2. What are the top 10 failure descriptions by frequency?
-- Purpose: To identify and prioritize the most frequent failure types for targeted quality improvement efforts.
SELECT 
    failure_description,
    COUNT(*) AS frequency
FROM 
    db_bounce_1NF
GROUP BY 
    failure_description
ORDER BY 
    frequency DESC
LIMIT 10;

-- Transition: After identifying failure descriptions, we analyze customer behavior by looking at the highest return rates.

-- 3. Which customers are responsible for the highest return rates?
-- Purpose: To identify customers contributing the most to returns, enabling targeted interventions like education or support.
SELECT 
    customer_id,
    COUNT(*) AS return_count
FROM 
    db_bounce_1NF
GROUP BY 
    customer_id
ORDER BY 
    return_count DESC
LIMIT 10;

-- Transition: Moving forward, we calculate repair efficiency by analyzing average repair times by failure type.

-- 4. What is the average time to repair devices by failure type?
-- Purpose: To evaluate repair efficiency and identify failure types that require process optimization.
SELECT 
    failure_description,
    AVG(repair_end_date - repair_start_date) AS avg_repair_time
FROM 
    db_bounce_1NF
WHERE 
    repair_start_date IS NOT NULL AND repair_end_date IS NOT NULL
GROUP BY 
    failure_description
ORDER BY 
    avg_repair_time DESC;

-- Transition: Lastly, we examine warranty claims by product category to understand how warranty status impacts returns.

-- 5. How do warranty claims differ by product category?
-- Purpose: To analyze warranty claims by product category, providing insights into product performance and warranty effectiveness.
SELECT 
    product_category,
    COUNT(*) AS total_claims,
    COUNT(CASE WHEN warranty_status = 'Active' THEN 1 END) AS active_warranty_claims
FROM 
    db_bounce_1NF
GROUP BY 
    product_category;