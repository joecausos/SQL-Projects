CREATE TABLE ev_country
	(
		country_id SERIAL PRIMARY KEY,
		county VARCHAR (100),
		city VARCHAR (50),
		state VARCHAR (50),
		postal_code INT
	);
	

CREATE TABLE IF NOT EXISTS ev_maker
	(
		maker_id SERIAL PRIMARY KEY,
		maker_name VARCHAR (100)
	);
	

CREATE TABLE IF NOT EXISTS ev_model
	(
		model_id SERIAL PRIMARY KEY,
		maker_id INT REFERENCES ev_maker (maker_id),
		model VARCHAR (100),
		model_year INT 
	);
	

CREATE TABLE IF NOT EXISTS ev_population
	(
		population_id SERIAL PRIMARY KEY,
		country_id INT REFERENCES ev_country (country_id),
		maker_id INT REFERENCES ev_maker (maker_id),
		model_id INT REFERENCES ev_model (model_id),		
		ev_category VARCHAR (50),
		cafv_eligible VARCHAR (50),
		vin INT,
		electric_vehicle_type VARCHAR (100),
		cafv_remarks VARCHAR (150),
		electric_range INT,
		base_msrp INT,
		legislative_district INT,
		dol_vehicle_id INT,
		electric_utility VARCHAR (255),
		census_tract_2020 INT
	);