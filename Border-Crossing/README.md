## This project analyzes U.S. Border Crossing data from Data.gov, leveraging SQL to extract insights. The dataset contains information on vehicles, and cargo crossings, categorized by border, port of entry, transportation mode, and time.

### Tools & Technologies
- Database: PostgreSQL
- SQL IDE: DBeaver
- Visualization: Power BI (Coming soon)
- Data Source: Border Crossing Entry Data

## Categories of analysis
- General analysis
  - How many total border crossings are recorded in the dataset?
  - What is the distribution of border crossing by year and month?
  - Which border has the highest number of crossing?
  - What are the top 5 ports of entry with the highest number of crossings?
  - How does the number of border crossing vary by mode of transportation? 
    
- Temporal analysis
  - What are the trends in border crossing over time (e.g. increase or decrease)?
  - Are there any seasonal patterns in boarder crossings (e.g. higher in summer, lower in winter)?
  - How do border crossing compare year-over-year?
  
- Mode of Transportation analysis
  - What is the most common mode of transportation for border crossing?
  - How has the mode of transportation changed over the years?
  - What is the distribution of border crossing by mode of transportation for each order?
  
- Port of Entry analysis
  - Which ports of entry have seen the most significant changes in crossing numbers?
  - How does the distribution of crossing vary across ports of entry?
     
- Event-Based analysis
  - Are there any significant events or policy changes that have affected border crossings?
    
- Anomalies and Outliers
  - Are there any anomalies or outliers in the border crossing data?
    
- Comparative analysis 
  - How do border crossings compare between weekdays and weekends?
  - How do border crossings compare between different times of the day (e.g. morning, afternoon, evening)?
    
- Data quality and Completeness
  - Are there any missing or incomplete records in the dataset?

***


## Get Started by Creating Table for Data Analysis

```sql

CREATE TABLE border_crossing 
	(
		port_name VARCHAR(50),
		state VARCHAR(50),
		por_code VARCHAR(50),
		boder VARCHAR(100),
		date DATE,
		measure VARCHAR(50),
		value VARCHAR(50)
	);	
```

***
## General Analysis

- How many total border crossings are recorded in the dataset?

	Expected results:
	
	| ttl_border_crossing |
	| ------------------- |
	| 399,406             |
	
	
	Answer:
	
	```sql
	SELECT COUNT(*) AS ttl_border_crossing
	FROM border_crossing bc;
	
	-- By understanding the overall volumeof border crossing helps gauge the scale of the data
	-- and provide a baseline for further analysis.
	```



- What is the distribution of border crossing by year and month?

	#### Expected results:
	
	| year | month | ttl_border_cross |
	| ---- | ----- | ---------------- |
	| 1996 | 1     | 1,236             |
	| 1996 | 2     | 1,236             |
	| 1996 | 3     | 1,236             |
	| 1996 | 4     | 1,236             |
	| 1996 | 5     | 1,236             |
	| 1996 | 6     | 1,236             |
	| ...  | ...   | ...              |
	| 2025 | 2     | 748              |
		
	#### Answer:
	
	```sql
	SELECT EXTRACT(YEAR FROM date) as year,
		EXTRACT (MONTH FROM date) as month,
		COUNT (*) as ttl_border_crossing
	FROM border_crossing bc
	GROUP BY EXTRACT(YEAR FROM date), EXTRACT(MONTH FROM date)
	ORDER BY YEAR, MONTH;
	
	-- Analyzing the distribution by year and month can reveail trends and patterns over time, such as increasing or decreasing in border crossing.
	```


- Which border has the highest number of crossing?

	#### Expected Result:
	  
	| border           | ttl_border_cross |
	| ---------------- | ---------------- |
	| US-Canada Border | 305,172         |
	| US-Mexico Border | 94,234          |

	#### Answer:
	``` sql
	SELECT border, COUNT (*) AS ttl_number_per_border
	FROM border_crossing bc
	GROUP BY bc.boder
	ORDER BY ttl_number_per_border DESC;
	
	-- Identifying the busiest border can help focus on regions with the most activity and potential issues.
	```


- How does the number of border crossing vary by mode of transportation?

	#### Expected Result:
	  
	| measure           		| mode_of_transpo	|
	| ----------------------------- | --------------------- |
	| Personal Vehicles 		| 37,794			|
	| Personal Vehicle Passengers	| 37,769			|
	| Trucks			| 36,693			|
	| Truck Containers Empty	| 36,511			|
	| Truck Containers Loaded	| 35,997			|
	| Pedestrians			| 32,623			|
	| Buses				| 31,678			|
	| Bus Passengers		| 31,661			|
	| Trains			| 29,837			|
	| Rail Containers Empty		| 29,815			|
	| Rail Containers Loaded	| 29,718			|
	| Train Passengers		| 29,310			|


	#### ANSWER:
	```sql
 	SELECT measure, COUNT (*) AS mode_of_transpo
 	FROM border_crossing bc
 	GROUP BY bc.measure
 	ORDER BY mode_of_transpo DESC;

 	-- Validating the modes of transportation used for crossing the border can provide insights for advancements (e.g. Insfrastructure needs and travelers prefernces).
 	```

***
## Temporal Analysis

- What are the trends in border crossing over time (Increase or Descrease)?

	#### Expected Result:

	| year | ttl_YoY_border_crossing |
	| ---- | -------------------	|
	| 1996 |	14,832		|
	| 1997 |	14,832		|
	| 1998 | 	14,832		|
	| 1999 | 	14,832		|
	| 2000 | 	14,832		|
	| 2001 |	14,832		|
	| 2002 |	14,832		|
	| 2003 |	15,588		|
	| 2004 |	15,984		|
	| 2005 | 	16,128		|
	| 2006 | 	16,128		|
	| 2007 |	16,056		|
	| 2008 |	16,056		|
	| 2009 |	16,056		|
	| 2010 | 	16,200		|
	| 2011 | 	15,840		|
	| 2012 |	15,840		|
	| 2013 | 	15,840		|
	| 2014 |	15,840		|
	| 2015 | 	15,984		| 
	| 2016 | 	13,754		|
	| 2017 | 	9,717		|
	| 2018 | 	9,529		|
	| 2019 | 	9,588		|
	| 2020 | 	8,477		|
	| 2021 | 	8,430		|
	| 2022 | 	8,876		|
	| 2023 | 	9,087		|
	| 2024 | 	9,087		|
	| 2025 | 	1,497		|

	Answer:

	```sql
 	SELECT EXTRACT (YEAR FROM date) AS year, COUNT(*) ttl_YoY_border_crossing
 	FROM border_cross bc
 	GROUP BY EXTRACT(YEAR FROM date
 	ORDER BY year;
 
 	-- Observing trends over time can help indicate peak travel and help in planning for resource allocation.
 	```

- Are there any seasonal patterns in border crossing (e.g. higher in summer, lower in winter)?

	#### Expected Result:

	|month|seasonal_mom_trend|
	|-----|------------------|
	|    1|             34,011|
	|    2|             34,083|
	|    3|             33,260|
	|    4|             33,231|
	|    5|             33,389|
	|    6|             33,448|
	|    7|             33,408|
	|    8|             32,998|
	|    9|             32,994|
	|   10|             32,965|
	|   11|             32,8b9|
	|   12|             32,790|


  	#### Answer:

  	```sql
	SELECT EXTRACT (MONTH FROM date) AS month, COUNT(*) ttl_MoM_border_crossing
   	FROM border_crossing bc
   	GROUP BY EXTRACT (MONTH from date)
   	ORDER BY month;
   	```

-  How do border crossings compare year-over-year?

	#### Expected Result:
	
	| year | ttl_yoy_crossing |
	| ---- | ---------------- |
	| 1996|           14832	|
	| 1997|           14832|
	| 1998|           14832|
	| 1999|           14832|
	| 2000|           14832|
	| 2001|           14832|
	| 2002|           14832|
	| 2003|           15588|
	| 2004|           15984|
	| 2005|           16128|
	| 2006|           16128|
	| 2007|           16056|
	| 2008|           16056|
	| 2009|           16056|
	| 2010|           16200|
	| 2011|           15840|
	| 2012|           15840|
	| 2013|           15840|
	| 2014|           15840|
	| 2015|           15984|
	| 2016|           13754|
	| 2017|            9717|
	| 2018|            9529|
	| 2019|            9588|
	| 2020|            8477|
	| 2021|            8430|
	| 2022|            8876|
	| 2023|            9087|
	| 2024|            9087|
	| 2025|            1497|

	#### Answer
	```sql
	SELECT EXTRACT(YEAR FROM date) AS year, COUNT(*) AS ttl_YoY_crossing
	FROM border_crossing
	GROUP BY EXTRACT(YEAR FROM date)
	ORDER BY year;

 	-- Year-over-year comparisons can highlight long-term trends and the impact of policy changes or global events.
 	```
***
## Mode of Transportation Analysis

- What is the most common mode of transportaion for border crossing?
	
	#### Expected Result:

	| measure                    |traspo_type|
	| ---------------------------|-----------|
	| Bus Passengers             |      31661|
	| Buses                      |      31678|
	| Pedestrians                |      32623|
	| Personal Vehicle Passengers|      37769|
	| Personal Vehicles          |      37794|

	#### Answer:
	
	```sql
	SELECT measure, COUNT(*) AS traspo_type
	FROM border_crossing bc 
	GROUP BY bc.measure 
	LIMIT 5;
	
	-- Identifying the most common transportation mode can guide infrastructure development and policy-making.
	 ```
 
 - How has the mode of transportation changed over the years?

	#### Expected Resutl:
	
	| year | measure                    | ttl_border |
	| ---- | ---------------------------|------------|
	| 1996 | Buses                      |      1236|
	| 1996 | Truck Containers Empty     |      1236|
	| 1996 | Bus Passengers             |      1236|
	| 1996 | Rail Containers Loaded     |      1236|
	| 1996 | Trucks                     |      1236|
	| 1996 | Truck Containers Loaded    |      1236|
	| 1996 | Train Passengers           |      1236|
	| 1996 | Trains                     |      1236|
	| 1996 | Rail Containers Empty      |      1236|
	| 1996 | Pedestrians                |      1236|
	| 1996 | Personal Vehicles          |      1236|
	| 1996 | Personal Vehicle Passengers|      1236|
	| ...  | ...                        |      ... |
	| ...  | ...                        |      ... |
	| ...  | ...                        |      ... |
	| 2025 | Truck Containers Empty     |       191|
	| 2025 | Pedestrians                |       102|
	| 2025 | Personal Vehicle Passengers|       213|
	| 2025 | Rail Containers Empty      |        60|
	| 2025 | Rail Containers Loaded     |        58|
	| 2025 | Trains                     |        60|
	| 2025 | Buses                      |        92|
	

	```sql
	SELECT EXTRACT (YEAR FROM date) AS YEAR, measure, COUNT(*) AS ttl_border
	FROM border_crossing bc
	GROUP BY EXTRACT(YEAR FROM date), measure
	ORDER BY YEAR;
	
	-- Analyzing changes in transportation modes can reveal shifts in traveler behavior and technological advancements.
	```

- What is the distribution of border crossings by mode of transportation for each border in 2025?

	#### Expected Result:
		
	| border          |measure                    |ttl_trans_types_in_2025|
	| ----------------|---------------------------|-----------------------|
	| US-Canada Border|Personal Vehicle Passengers|                    161|
	| US-Canada Border|Personal Vehicles          |                    161|
	| US-Canada Border|Trucks                     |                    152|
	| US-Canada Border|Truck Containers Empty     |                    149|
	| US-Canada Border|Truck Containers Loaded    |                    137|
	| US-Canada Border|Bus Passengers             |                     63|
	| US-Canada Border|Buses                      |                     63|
	| US-Mexico Border|Pedestrians                |                     55|
	| US-Mexico Border|Personal Vehicles          |                     52|
	| US-Mexico Border|Personal Vehicle Passengers|                     52|
	| US-Canada Border|Pedestrians                |                     47|
	| US-Canada Border|Trains                     |                     46|
	| US-Canada Border|Rail Containers Loaded     |                     46|
	| US-Canada Border|Rail Containers Empty      |                     46|
	| US-Mexico Border|Trucks                     |                     44|
	| US-Mexico Border|Truck Containers Loaded    |                     44|
	| US-Mexico Border|Truck Containers Empty     |                     42|
	| US-Canada Border|Train Passengers           |                     37|
	| US-Mexico Border|Bus Passengers             |                     29|
	| US-Mexico Border|Buses                      |                     29|
	| US-Mexico Border|Trains                     |                     14|
	| US-Mexico Border|Rail Containers Empty      |                     14|
	| US-Mexico Border|Rail Containers Loaded     |                     12|
	| US-Mexico Border|Train Passengers           |                      2|
		
	#### Answer:
	```sql
	SELECT border, measure,
		COUNT (CASE WHEN EXTRACT(YEAR FROM date) = 2025 THEN 1 END) AS ttl_trans_types_in_2025
	FROM border_crossing bc 
	WHERE EXTRACT(YEAR FROM date) = 2025
	GROUP BY border, measure
	ORDER BY ttl_trans_types_in_2025 DESC;

	-- Understanding the distribution by transportation mode for each border can highlight regional differences and needs.
	```

***
##  Port of Entry Analysis

- Between 2024 and 2025, which ports of entry have observed the most substantial changes in crossing numbers?

	#### Expected Result:
	
	| year | port_name         | ttl_port_crossing |
	| ---- | ------------------| ----------------- |
	| 2024 | Alcan             |               71  |
	| 2025 | Alcan             |               10  |
	| 2024 | Alexandria Bay    |               84  |
	| 2025 | Alexandria Bay    |               14  |
	| 2024 | Algonac           |               24  |
	| 2025 | Algonac           |                2  |
	| 2024 | Ambrose           |               28  |
	| 2025 | Ambrose           |                4  |
	| 2024 | Andrade           |               35  |
	| 2025 | Andrade           |                6  |
	
	### Answer:
	
	```sql
	SELECT EXTRACT(YEAR FROM date) AS YEAR, port_name, COUNT(*)AS ttl_port_crossing
	FROM border_crossing bc
	WHERE EXTRACT(YEAR FROM date) BETWEEN 2024 AND 2025
	GROUP BY port_name, EXTRACT(YEAR FROM date)
	ORDER BY port_name, YEAR
	LIMIT 10;
	
	-- Identifying ports with significant changes can help understand the reasons behind these shifts and address any issues.
	```

- In 2023, how does the distribution of crossings vary across different ports of entry? And compare it with 2024.

	#### Expected Result:
	
	| border          |measure                    |crossings_2023|crossings_2024|
	| ----------------|---------------------------|--------------|--------------|
	| US-Canada Border|Bus Passengers             |           403|           389|
	| US-Canada Border|Buses                      |           398|           391|
	| US-Canada Border|Pedestrians                |           347|           328|
	| US-Canada Border|Personal Vehicle Passengers|           973|           980|
	| US-Canada Border|Personal Vehicles          |           973|           979|
	| US-Canada Border|Rail Containers Empty      |           276|           276|
	| US-Canada Border|Rail Containers Loaded     |           276|           276|
	| US-Canada Border|Train Passengers           |           235|           233|
	| US-Canada Border|Trains                     |           276|           277|
	| US-Canada Border|Truck Containers Empty     |           890|           901|
	| US-Canada Border|Truck Containers Loaded    |           816|           813|
	| US-Canada Border|Trucks                     |           896|           909|
	| US-Mexico Border|Bus Passengers             |           176|           176|
	| US-Mexico Border|Buses                      |           179|           175|
	| US-Mexico Border|Pedestrians                |           329|           324|
	| US-Mexico Border|Personal Vehicle Passengers|           312|           312|
	| US-Mexico Border|Personal Vehicles          |           312|           312|
	| US-Mexico Border|Rail Containers Empty      |            84|            84|
	| US-Mexico Border|Rail Containers Loaded     |            72|            72|
	| US-Mexico Border|Train Passengers           |            21|            16|
	| US-Mexico Border|Trains                     |            84|            84|
	| US-Mexico Border|Truck Containers Empty     |           245|           252|
	| US-Mexico Border|Truck Containers Loaded    |           257|           264|
	| US-Mexico Border|Trucks                     |           257|           264|
	
	### Answer:
	
	```sql
	SELECT border, measure
		COUNT (CASE WHEN EXTRACT(YEAR FROM date) = 2023 THEN 1 END) AS crossing_2023,
		COUNT (CASE WHEN EXTRACT(YEAR FROM date) = 2024 THEN 1 END) AS crossing_2024
	FROM border_crossong bc
	WHERE EXTRACT(YEAR FROM date) IN (2023, 2024)
	GROUP BY border, measure,
	ORDER BY border, measure;
	
	-- Examining the distribution across ports can highlight which ports are under or over-utilized.
	```

***
## Event-Based Analysis

- Between 2022 - 2023 are there any significant events or policy changes that have affected border crossing?

	
	#### Expected Result:

	|year|month|ttl_border_crossing|
	|----|-----|------------------|
	|2022|    1|                710|
	|2022|    2|                717|
	|2022|    3|                704|
	|2022|    4|                728|
	|2022|    5|                728|
	|2022|    6|                752|
	|2022|    7|                759|
	|2022|    8|                762|
	|2022|    9|                767|
	|2022|   10|                759|
	|2022|   11|                745|
	|2022|   12|                745|
	|2023|    1|                732|
	|2023|    2|                755|
	|2023|    3|                743|
	|2023|    4|                746|
	|2023|    5|                765|
	|2023|    6|                762|
	|2023|    7|                756|
	|2023|    8|                777|
	|2023|    9|                777|
	|2023|   10|                775|
	|2023|   11|                753|
	|2023|   12|                746|
	
	### Answer:
	
	```sql
	SELECT EXTRACT (YEAR FROM date) AS YEAR, EXTRACT(MONTH FROM date) AS MONTH, COUNT(*) ttl_border_crossing
	FROM border_crossing
	WHERE date BETWEEN '2022-01-01' AND '2023-12-01'
	GROUP BY EXTRACT(YEAR FROM date), EXTRACT (MONTH FROM date)
	ORDER BY YEAR, MONTH;
	
	-- Correlating significant events or policy changes with crossing data can reveal their impact and effectiveness.
	```

***
## Anomalies and Outliers



