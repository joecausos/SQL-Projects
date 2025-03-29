# sql-border-crossing-analysis

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

## The dataset used in this project was downloaded from data.gov (https://data.gov/) and is meant for learning and educational purposes.

## How to Run the Queries
1. Clone the repository to your local machine.
2. Open the SQL files in your preferred SQL editor.
3. Execute the queries against your database.

## License
Please note that the dataset used in this project is not owned by the repository owner and is used solely for educational purposes.

***

## Getting Started

Creating a table for data analysis.
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



