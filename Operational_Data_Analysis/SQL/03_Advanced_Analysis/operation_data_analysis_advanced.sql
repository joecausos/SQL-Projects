-- ### Advanced SQL Analysis

-- 1. What is the Pareto analysis of failure types?
-- Purpose: To perform Pareto analysis, identifying the failure types that contribute to 80% of the issues based on the Pareto principle.
WITH FailureCounts AS (
    SELECT 
        failure_description,
        COUNT(*) AS frequency
    FROM 
        db_bounce_1NF
    GROUP BY 
        failure_description
), CumulativeFailures AS (
    SELECT 
        failure_description,
        frequency,
        SUM(frequency) OVER (ORDER BY frequency DESC) * 100.0 / 
        (SELECT SUM(frequency) FROM FailureCounts) AS cumulative_percentage
    FROM 
        FailureCounts
)
SELECT 
    failure_description,
    frequency,
    cumulative_percentage
FROM 
    CumulativeFailures
WHERE 
    cumulative_percentage <= 80;

-- Transition: After Pareto analysis, we calculate rolling averages for failure rates to smooth out short-term fluctuations in trends.

-- 2. What is the trend of failure rates using a rolling average?
-- Purpose: To calculate rolling averages for failure rates, providing a smoothed trend analysis.
SELECT 
    request_date,
    AVG(CASE WHEN rma_remarks = 'D - DFR<90' THEN 1 ELSE 0 END) 
        OVER (ORDER BY request_date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) 
        AS rolling_failure_rate
FROM 
    db_bounce_1NF;

-- Transition: Next, we analyze failure types to understand their correlation with early failures.

-- 3. Which failure types have the highest correlation with early failures?
-- Purpose: To identify failure types strongly associated with early failures, highlighting potential manufacturing defects.
SELECT 
    failure_description,
    COUNT(CASE WHEN EXTRACT(DAY FROM request_date - mfg_birth_date_year) <= 90 THEN 1 END) * 100.0 / COUNT(*) AS early_failure_correlation
FROM 
    db_bounce_1NF
GROUP BY 
    failure_description
ORDER BY 
    early_failure_correlation DESC;

-- Transition: From early failures, we move on to identify seasonal patterns in failure trends.

-- 4. How can we identify seasonal patterns in failure trends?
-- Purpose: To analyze seasonal patterns in failures, optimizing production planning and resource allocation.
SELECT 
    EXTRACT(MONTH FROM request_date) AS month,
    COUNT(*) AS failure_count
FROM 
    db_bounce_1NF
GROUP BY 
    month
ORDER BY 
    month;

-- Transition: Finally, we evaluate repair throughput for different repair centers to assess operational performance.

-- 5. What is the repair throughput for different repair centers?
-- Purpose: To analyze repair center throughput, evaluating operational efficiency and resource allocation.
SELECT 
    repair_center,
    COUNT(*) AS total_repairs,
    AVG(repair_end_date - repair_start_date) AS avg_repair_time
FROM 
    db_bounce_1NF
GROUP BY 
    repair_center
    total_repairs DESC;
ORDER BY 