## This project analyzes U.S. Border Crossing data from Data.gov, leveraging SQL to extract insights. The dataset contains information on vehicles, and cargo crossings, categorized by border, port of entry, transportation mode, and time.

- Tools & Technologies
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

The dataset used in this project was downloaded from data.gov (https://data.gov/) and is meant for learning and educational purposes.


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

	Expected results:
	
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
		
	Answer:
	
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

	Expected Result:
	  
	| border           | ttl_border_cross |
	| ---------------- | ---------------- |
	| US-Canada Border | 305,172         |
	| US-Mexico Border | 94,234          |

	Answer:
	``` sql
	SELECT border, COUNT (*) AS ttl_number_per_border
	FROM border_crossing bc
	GROUP BY bc.boder
	ORDER BY ttl_number_per_border DESC;
	
	-- Identifying the busiest border can help focus on regions with the most activity and potential issues.
	```


- How does the number of border crossing vary by mode of transportation?

	Expected Result:
	  
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


	ANSWER:
	```sql
 	SELECT measure, COUNT (*) AS mode_of_transpo
 	FROM border_crossing bc
 	GROUP BY bc.measure
 	ORDER BY mode_of_transpo DESC;

 	-- Validating the modes of transportation used for crossing the border can provide insights for advancements (e.g. Insfrastructure needs and travelers prefernces).
 	```


## Temporal Analysis

- What are the trends in border crossing over time (Increase or Descrease)?

 	Expected Result:

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

	Expected Result:

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


  	Answer:

  	```sql
	SELECT EXTRACT (MONTH FROM date) AS month, COUNT(*) ttl_MoM_border_crossing
   	FROM border_crossing bc
   	GROUP BY EXTRACT (MONTH from date)
   	ORDER BY month;
   	```
