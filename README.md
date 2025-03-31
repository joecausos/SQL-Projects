This project contains SQL queries for analyzing border crossing data. The queries are organized into different categories based on the type of analysis they perform.

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

### General Analysis

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
	| 1996 | 1     | 1236             |
	| 1996 | 2     | 1236             |
	| 1996 | 3     | 1236             |
	| 1996 | 4     | 1236             |
	| 1996 | 5     | 1236             |
	| 1996 | 6     | 1236             |
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
	| US-Canada Border | 305, 172         |
	| US-Mexico Border | 94, 234          |

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
	| Personal Vehicles 		| 37794			|
	| Personal Vehicle Passengers	| 37769			|
	| Trucks			| 36693			|
	| Truck Containers Empty	| 36511			|
	| Truck Containers Loaded	| 35997			|
	| Pedestrians			| 32623			|
	| Buses				| 31678			|
	| Bus Passengers		| 31661			|
	| Trains			| 29837			|
	| Rail Containers Empty		| 29815			|
	| Rail Containers Loaded	| 29718			|
	| Train Passengers		| 29310			|


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

	| year | ttl_border_crossing 	|
	| ---- | -------------------	|
	| 1996 |	14832		|
	| 1997 |	14832		|
	| 1998 | 	14832		|
	| 1999 | 	14832		|
	| 2000 | 	14832		|
	| 2001 |	14832		|
	| 2002 |	14832		|
	| 2003 |	15588		|
	| 2004 |	15984		|
	| 2005 | 	16128		|
	| 2006 | 	16128		|
	| 2007 |	16056		|
	| 2008 |	16056		|
	| 2009 |	16056		|
	| 2010 | 	16200		|
	| 2011 | 	15840		|
	| 2012 |	15840		|
	| 2013 | 	15840		|
	| 2014 |	15840		|
	| 2015 | 	15984		| 
	| 2016 | 	13754		|
	| 2017 | 	9717		|
	| 2018 | 	9529		|
	| 2019 | 	9588		|
	| 2020 | 	8477		|
	| 2021 | 	8430		|
	| 2022 | 	8876		|
	| 2023 | 	9087		|
	| 2024 | 	9087		|
	| 2025 | 	1497		|

	Answer:

	```sql
 	SELECT EXTRACT (YEAR FROM date) AS year, COUNT(*) ttl_border_crossing
 	FROM border_cross bc
 	GROUP BY EXTRACT(YEAR FROM date
 	ORDER BY year;
 
 	-- Observing trends over time can help indicate peak travel and help in planning for resource allocation.
 	```

- Are there any seasonal patterns in border crossing (e.g. higher in summer, lower in winter)?

	Expected Result:

  
