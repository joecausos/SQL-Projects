# Operational Data Analysis with Six Sigma Methodology

This project applies Six Sgima principles to analyze  customer service-related data using SQL. By examining field returns, failures, and customer behaviors, we aim to uncover key insights that improve product quality and customer satisfaction while reducing field failures. This analysis follows the Six Sigma DMAIC framework: Define, Measure, Analyze, Improve, and Control.

---

## Table of Contents
1. [Project Purpose](#project-purpose)
2. [Six Sigma and SQL: Why Use Them?](#six-sigma-and-sql-why-use-them)
3. [Six Sigma Framework](#six-sigma-framework)
4. [Data Privacy and Security Approach](#data-privacy-and-security-approach)
5. [Data Analysis Scope](#data-analysis-scope)
    - [Basic SQL Analysis](#basic-sql-analysis)
    - [Intermediate SQL Analysis](#intermediate-sql-analysis)
    - [Advanced SQL Analysis](#advanced-sql-analysis)

6. [SQL Techniques Used](#sql-techniques-used)  
7. [Technologies](#technologies)  
8. [Future Plans](#future-plans)

## Project Purpose

The primary goal of this project is to transform raw operational data into meaningful insights that guide strategic and tactical decisions. By identifying inefficiencies and recurring issues in service processes, the project aims to:
- **Improve Product Quality:** Detect and resolve underlying issues impacting reliability.
- **Optimize Service Processes:** Enhannce the efficiency of service workflows and reduce turnaround time.
- **Reduce Unnecessary Field Return:** Pinpoint and address cases of "Unverified Issue Cases (UIC) and External Impact Case (EIC).
- **Enhance Customer Satisfaction:** Use data-driven insights to refine customer support and warranty policies.

---

## Six Sigma and SQL: Why Use Them?

### Why use Six Sigma for Data Analysis?
Six sigma is a proven methodology for improving process efficiency and reducing defects. Its structures DMAIC (Define, Measure, Analyze, Improve, Control) approach is ideal for identifying root problem, optimizing processes, and delivering measurable results. By combining Six Sigma principles with data analysis -- can achieve: 
- Process Optimization: Identify and Eliminated inefficiencies.
- Defect Reduction: Minimize product failures and customer dissatisfaction.
- Data-Driven Decision Making: Use quantitative insights to prioritize improvements.

### Why Use SQL for Six Sigma Data Analysis?
SQL is a powerfultool for quereying and analyzing data stored in a relational databases. Here's why SQL is an excellent choice for Six Sigma projects:
- **Scalability:** SQL handle large datasets efficiently, which is crucial for enterprise-level data analysis.
- **Flexibility:** Supports a whole ride range of tasks, from basic aggregations to advanced analysis using window function, recursive queris, and complex joins.
- **Real-Time Insights:** Enables direct querying of live operational databases, providing real-time updates on key performance indicators (KPIs).
- **Integrations:** Easily intergrates with tools like PowerBi and Tableau for reporting and visualization.

### Why Not Minitab for Data Analysis?

Minitab is a valuable statistical tool, but it has limitations compared to SQL for operational data analysis:
- **Data Size:** Minitab is not optimized for large-scale datasets, whereas SQL excels at largedata volumes.
- **Real-Time Analysis:** SQL allows live data querying,while Minitab typicall requires pre-exported datasets.
- **Automation and Integration:**  SQL queries can be automated and integrated into workflows and dashboards. Minitab is primarily suited for ad-hoc analysis.
- **Cost:** SQL is often free or included in existing database system, whereas Minitab requires licensing.

| Criteria 	     | SQL			       | Minitab 			  |
| ------------------ | ------------------------------- | -------------------------------- |
| Data Size          | Excellent for large datasets    | Limited to small/medium datasets |
| Real-Time Analysis | Yes                             | No (requires data export)        |
| Automation         | Easy to automate via scripts    | Mostly manual                    |
| Cost               | Often free 		       | Requires Licensing               |   

However, Minitab remains useful for tasks like hypothesis testingm ANOVA, and control charting, complementing SQL for specific statistical needs.

---

## Six Sigma Framework

This project is structured around Six Sigma's DMAIC methodology:

1. **Define:** Establish objectives and identify critical metrics for quality improvement.  
2. **Measure:** Collect relevant data and compute key performance indicators (KPIs).  
3. **Analyze:** Identify patterns, root causes, and correlations in the data.  
4. **Improve:** Develop and propose actionable solutions to address defects and inefficiencies.  
5. **Control:** Implement controls, such as dashboards or monitoring systems, to sustain improvements.


---

## Data Privacy and Security Approach

Ensuring data privacy and security is a critical aspect of this project. To comply with data protection standards and maintain confidentiality, the following measures have been implemented:

1. **Data Anonymization**: All sensitive information in the dataset has been anonymized to prevent the identification of individuals or proprietary information.
2. **MD5 Hashing**: The MD5 algorithm has been applied to sensitive data fields to create irreversible hashed values. This ensures that original data cannot be reconstructed, safeguarding its confidentiality.
3. **Descriptive Column Labels**: Sensitive or proprietary column headers have been replaced with generic, descriptive labels that maintain the analytical integrity of the dataset while ensuring confidentiality.
4. **Commitment to Data Privacy**: This project is committed to adhering to the highest standards of data privacy and security throughout all stages of analysis, from data collection to reporting and visualization.

These measures not only uphold data privacy principles but also ensure compliance with relevant legal and ethical standards.

---

## Data Analysis Scope

The project addresses the following key questions, categorized by the complexity of SQL techniques used.

### Basic SQL Analysis

1. **What is the "Unverified Issue Cases (UIC) rate?**
   <br>
   Purpose: To measure inefficiencies in the return process by identifying returns labeled as "Unverified Issue Cases".

   **EXPECTED RESULT:**
   | uic_rate |
   | -------- |
   | 6.193%   |

   **SOLUTION:**

   ``` sql
   SELECT ROUND(
            COUNT(
                CASE
                    WHEN category ='UIC' THEN 1
                END
                ) * 100.0 / (COUNT(*), 3
            ) || '%' AS UIC_Rate
   FROM staging_table st;
   ```
   **After understanding the UIC rate, the next step is to evaluate failure trends over time to assess whether quality improvements are effective.**

3. **WHat are the field failure trends over time?**
   <br>
   Purpose: To identify seasonal patterns or long-term trends in failure rates, aiding in quality improvement efforts.

   **EXPECTED RESULT:**

   | year|month|total_returns    |defective_returns_within_90D|
   | ----|-----|-----------------|-----------------|
   | 2020|    1|               11|                0|
   | 2020|    3|                9|                0|
   | 2020|    5|               16|                0|
   | 2020|    6|               26|                0|
   | 2020|    7|               35|                2|
   | 2020|    8|               13|                1|
   | 2020|    9|               57|                0|
   | 2020|   10|               29|                0|
   | 2020|   11|              144|                1|
   | 2020|   12|             5630|                1|
   | 2021|    1|            11650|                0|
   | 2021|    2|             8739|                1|
   | 2021|    3|            10222|                1|
   | 2021|    4|             6495|                0|
   | ... |	... | ...             | ...		|
   | ... |	... | ...             | ...		|
   | ... |	... | ...             | ...		|
   | 2024|    7|            29924|             2427|
   | 2024|    8|            30973|             2729|
   | 2024|    9|            23989|             2182|
   | 2024|   10|            30954|             2562|
   | 2024|   11|            26677|             2195|
   | 2024|   12|            25301|             2062|
   | 2025|    1|            68735|             6081|
   | 2025|    2|            32079|             1929|
   | 2025|    3|             8949|              478|

   **SOLUTION:**

   ```sql
   SELECT
   	EXTRACT (YEAR FROM request_date) AS YEAR,
    	EXTRACT (MONTH FROM request_date) AS MONTH,
     	COUNT (*) AS ttl_field_failure_returns,
	COUNT (CASE WHEN rma_remarks = '4-Fail<90' THEN 1 END) AS defective_returns
   FROM staging_table st
   GROUP BY YEAR,MONTH
   ORDER BY YEAR, MONTH ;

   ```

   **With the failure trends established, focus shifts to understand the External Impact Cases (EIC) to identify potential issues.**

4. **WHat is the rate of External Impact Case (EIC)?**
   <br>
   Purpose: To measure the percentage of returns caused by external impact misuse, highlighting potential exchange of best practices or product design changes.

   **EXPECTED REUSLT:**

   | eic_rate |
   | -------- |
   | 28.198%  |

   **SOLUTION:**

   ```sql

   SELECT
    ROUND(
        COUNT(
            CASE
                WHEN category = 'EIC' THEN 1
            END ) * 100.0 / COUNT(*), 3
        ) || '%' AS eic_rate
   FROM staging_table;

   ```
   Understanding External Issue EIC rates sets the stage for analyzing recurring returns, which can highlight systemic quality issues.

6. **Are there repeat return for the same device based on device id**
   <br>
   Purpose: To identify recurring defects or systemic issues in product quality by analyzing device id with muutiple returns.

   **EXPECTED RESULT:**

   |device_id | repeat_return|
   |--------- | ------------|
   |7790385A35|           13|
   |D7A72A927E|           12|
   |8DDB357183|           12|
   |335FF20F13|           11|
   |806E092F0E|           11|
   |DF60E219F3|           10|
   |3FDCBBB3CF|           10|
   |C6D1269E90|           10|
   |1397427CD3|           10|
   |D9DDA3C8BA|           10|
   |8D1C95B90C|           10|
   |6EA9099336|            9|
   |86F6B0F85D|            9|
   |F51D5A8A17|            9|
   |040AE1360C|            9|
   |003E41A94C|            9|
   | ...      | ...         |
   |F05DB8AB95|            2|
   |8C3C2E8558|            2|
   |FB123F98B9|            2|
   |2ECC28FBED|            2|
   |CF0DC92FCD|            2|

   **SOLUTION:**

   ```sql
   SELECT
   	device_id,
   	COUNT(*) AS repeat_return
   
   FROM staging_table st
   GROUP BY device_id
   HAVING COUNT(*)  > 1
   ORDER BY repeat_return DESC;

   ```
   **After identifying recurring returns, we next evaluate early failures, which are strong indicators of product quality issues.**

7. **What is the rate of early field failures?**
   <br>
   Purpose: To quantify early failures and assess assembly or design defects within the first 90 days of use.

   **EXPECTED RESULT:**

   |early_failure_rate|
   |------------------|
   |10.630%           |

   **SOLUTION:**
   ``` sql

   SELECT ROUND(	
		COUNT(
			CASE 
				WHEN  (request_date - last_shipment) <= 90 THEN 1 
			END 
		) * 100.0 / COUNT(*), 3 
	) || '%' AS early_failure_rate
   FROM staging_table st ;

   ```
   **After early failures have been assessed, the next focus is on calculating the Mean Time Between Failures (MTBF) to understand product reliability.**

8. **What is the Mean Time Between Failures (MTBF)?**
   <br>
   Purpose: To calculate the average time between failures for devices, a critical metric for reliability and warranty policies.

   **EXPECTED RESULT:**

   |mtbf               |
   |-------------------|
   |45.0832170584236700|

   **SOLUTION**
   ```sql
   SELECT 
	AVG(request_date - last_shipment) AS mtbf

   FROM staging_table st
   WHERE rma_remarks = '4-Fail<90';

   ```


### Intermediate SQL Analysis
1. **What is the cumulative failure rate over time?**
   <br>
   Purpose: To calculate how failure rates accumulate over time, providing insights into overall trends and their impact.
   
   ```sql
   SELECT
   	request_date,
   	SUM(CASE WHEN rma_remarks = '4-FAIL<90' THEN 1 ELSE 0 END) 
        OVER (ORDER BY request_date) * 100.0 / COUNT(*) 
        OVER () AS cumulative_failure_rate

   FROM
   	staging_table st;
   ```
   
2. **What are the top 10 failure description by frequency?**
   <br>
   Purpose: To identify and prioritize the most frequent failure types for targeted quality improvement efforts.

   ```sql
   SELECT
   	field_failure,
   	COUNT(*) AS frequency
   FROM
   	staging_table st
   GROUP BY
   	field_failure
   ORDER BY
   	frequency DESC
   LIMIT 10;
   ```
   
3. **Which customer ares responsible for the highest return rates?**
   <br>
   Purpose: To identify customers contributing the most to returns, enabling targeted interventions like education or support.

   ```sql
   SELECT
   	device_id,
   	COUNT(*) AS return_count
   FROM
   	staging_table st
   GROUP BY
   	customer_id
   ORDER BY
   	return_count DESC
   LIMIT 10;
   ```	   

5. **What is the average time to finish device service by failure type?**
   <br>
   Purpose: To evaluate repair efficiency and identify failure types that require process optimization.
   
   ```sql
   SELECT
   	failure_description,
    	AVG(repair_end_date - repair_start_date) AS avg_repair_time

   FROM
   	staging_table st
   WHERE
   	repair_start_date IS NOT NULL AND repair_end_date IS NOT NULL
   GROUP BY
   	failure_description
   ORDER BY
   	avg_repair_time DESC;
   ```

6. **How do warranty claims difer by product category?**
   <br>
   Purpose: To analyze warranty claims by product category, providing insights into product performance and warranty effectiveness.
   
   ```sql
   SELECT
   	product_category,
   	COUNT(*) AS total_claims,
   	COUNT(CASE WHEN warranty_status = 'Active' THEN 1 END) AS active_warranty_claims

   FROM
   	db_bounce_1NF
   GROUP BY
   	product_category;

### Advance SQL Analysis
1. **What is the pareto analysis of failure types?**
   <br>
   Purpose: To perform Pareto analysis, identifying the failure types that contribute to 80% of the issues based on the Pareto principle.

   ```sql
   WITH FailureCounts AS (
   	SELECT
   		field_failure,
   		COUNT (*) AS frequency

   	FROM
   		staging_stable st
   	GROUP BY
   		field_failure
   ),

   CumulativeFailures AS (
   	SELECT
   		field_failure,
   		frequency,
   		SUM(frequency) OVER (ORDER BY frequency DESC) * 100.0 /
   		(SELECT SUM(frequency) FROM FailureCounts) AS cumulative_percentage

   	FROM
    		FailureCounts
   )

   	SELECT
   		field_failure,
   		frequency,
   		cumulative_percentage

   	FROM
   		CumulativeFailures
   	WHERE
   		cumulative_percentage <= 80;
	
   ```

   
2. **What is the trend of failure rates using a rolling average?**
   <br>
   Purpose: To calculate rolling averages for failure rates, providing a smoothed trend analysis.
   
   ```sql
   SELECT
   	request_date,
   	AVG(CASE WHEN rma_remarks = '4-FAIL<90' THEN 1 ELSE 0 END)
   	OVER (ORDER BY request_date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW)
   	AS rolling_failure_rate
   FROM
   	staging_table st;

   ```

  
3. **Which failure type have the highest correlation with early failures?**
   <br>
   Purpose: To identify failure types strongly associated with early failures, highlighting potential manufacturing defects.

   ```sql
   SELECT
   	field_failure,
    	COUNT(CASE WHEN EXTRACT(DAY FROM request_date - mb_birth_year) <= 90 THEN 1 END) * 100.0 / COUNT(*) AS early_failure_correlation

   FROM
   	staging_table st
   GROUP BY 
   	field_failure
   ORDER by
   	early_failure_correlation DESC;

   ```

  
4. **How can we identify seasonal patterns in failure trends?&**
   <br>
   Purpose: To analyze seasonal patterns in failures, optimizing production planning and resource allocation.
   ```sql
   SELECT
   	EXTRACT(MONTH FROM request_date) AS month,
   	COUNT(*) AS failure_count

   FROM
   	staging_table
   GROUP BY
   	month
   ORDER BY
   	month;
   ```

