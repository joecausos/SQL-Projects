--1. How many total border crossings are recorded in the dataset?
--   - Understanding the overall volume of border crossings helps gauge the scale of the data and provides a baseline for further analysis.

SELECT COUNT(*) AS total_border_crossing
FROM border_crossing bc ;