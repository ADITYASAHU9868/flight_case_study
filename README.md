Flight Data Analysis using SQL
Overview

This project analyzes a real-world flight dataset using SQL. It focuses on data cleaning, feature engineering, and extracting meaningful insights related to flight duration, pricing, and travel patterns.

Dataset

The dataset contains the following columns:

Airline
Date_of_Journey
Source
Destination
Dep_Time
Duration
Total_Stops
Additional_Info
Price
Project Workflow
1. Data Cleaning
Converted Date_of_Journey to DATE format
Created departure column (date + time)
Converted Duration to numeric duration_min
Handled inconsistent formats (2h 50m, 5h, 45m)
2. Feature Engineering
Extracted month, day, and quarter
Classified weekday vs weekend
Created time slots (morning, afternoon, evening, night)
Generated:
duration_min
arrival_time
arrival_date
3. Analysis Performed
Month with highest number of flights
Most expensive travel day
IndiGo flights per month
Flights between 10 AM and 2 PM
Weekend flight count from Bangalore
Arrival time and arrival date calculation
Flights spanning multiple days
Average duration between city pairs
Overnight flights analysis
Quarter-wise flights per airline
Longest flight per airline
Flights with more than one stop
Weekend vs time-slot frequency grid
Weekly average price analysis
Sample Queries
Average Duration Between Cities
SELECT 
    Source,
    Destination,
    AVG(duration_min) AS avg_duration
FROM flights
GROUP BY Source, Destination;
Longest Flight per Airline
SELECT f.*
FROM flights f
JOIN (
    SELECT Airline, MAX(duration_min) AS max_duration
    FROM flights
    GROUP BY Airline
) t
ON f.Airline = t.Airline 
AND f.duration_min = t.max_duration;
Key Insights
Flight duration increases with number of stops
Weekend and weekday travel patterns differ
Certain airlines operate longer routes consistently
Peak traffic occurs during specific time slots
Tech Stack
MySQL
SQL (Joins, Aggregations, CASE, Date Functions)
How to Run
Import dataset into MySQL
Execute data cleaning queries
Run analysis queries
Modify queries for further insights
Project Structure
flight-data-analysis/
│── data/
│   └── flights.csv
│── sql/
│   ├── data_cleaning.sql
│   ├── feature_engineering.sql
│   └── analysis_queries.sql
│── README.md
Future Work
Dashboard creation using Power BI or Tableau
Predictive modeling for ticket prices
Adding features like delays and seasonal trends
Author

Aditya Sahu
