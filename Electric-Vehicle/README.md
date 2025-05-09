# Electric Vehicle Data Analysis Project

## Overview
This repository is dedicated to analyzing and normalizing an Electric Vehicle dataset downloaded from [data.gov](https://data.gov). The dataset has been cleaned and normalized manually using Excel and will be utilized for advanced data analysis using SQL.

## Objectives
1. Design and implement a normalized database schema for Electric Vehicle data.
2. Provide SQL scripts for data ingestion, querying, and analysis.
3. Document SQL query questions from beginner to advanced levels.
4. Offer a platform for collaboration and learning for data enthusiasts and engineers.

## Dataset
The dataset includes information about:
- Countries, counties, cities, and postal codes.
- Electric Vehicle manufacturers, models, and production years.
- Electric Vehicle population data, including vehicle identification numbers (VINs), categories, ranges, and utilities.

The dataset has been normalized into the following tables:
1. `ev_country`: Contains geographical information.
2. `ev_maker`: Stores details about EV manufacturers.
3. `ev_model`: Contains EV model data, linked to manufacturers.
4. `ev_population`: Stores EV-specific data, linked to geography, manufacturers, and models.
