Flight Data Analysis using SQL
Project Overview

This project focuses on analyzing a real-world flight dataset using SQL. The objective is to clean raw data, perform feature engineering, and extract meaningful insights related to flight duration, pricing, and travel patterns.

Dataset Description

The dataset contains the following fields:

Airline – Name of airline
Date_of_Journey – Travel date
Source – Departure city
Destination – Arrival city
Dep_Time – Departure time
Duration – Flight duration (text format)
Total_Stops – Number of stops
Additional_Info – Extra details
Price – Ticket price
Data Cleaning and Preprocessing
Converted Date_of_Journey to proper DATE format
Created departure column by combining date and time
Converted Duration into numeric duration_min
Created arrival_time and arrival_date columns
Handled inconsistent formats such as:
2h 50m
5h
45m
Feature Engineering
Extracted:
Month, Day, Quarter
Weekday vs Weekend
Time slots (Morning, Afternoon, Evening, Night)
Created:
duration_min
arrival_time
arrival_date
Analysis Performed
Month with highest number of flights
Costliest day of travel
IndiGo flights per month
Flights between specific time window (10 AM – 2 PM)
Weekend flights count from Bangalore
Arrival time calculation
Arrival date extraction
Flights spanning multiple dates
Average duration between city pairs
Overnight flights analysis
Quarter-wise flights per airline
Longest flight based on duration
Flights with more than one stop
Air India flights from Delhi
Longest flight per airline
Flights with duration greater than 3 hours
Weekend vs time-slot frequency grid
Weekly average price grid
Key Insights
Flight duration is strongly influenced by the number of stops
Weekend travel patterns differ from weekdays
Some airlines consistently operate longer routes
Peak travel hours are concentrated in specific time slots
Tools and Technologies
MySQL
SQL (Joins, Aggregations, CASE, Date Functions)
How to Use
Import the dataset into MySQL
Run preprocessing queries
Execute analysis queries
Modify queries for deeper insights
Future Improvements
Build dashboards using Power BI or Tableau
Perform predictive analysis on ticket prices
Add features such as delays and seasonal trends
Contributing

Feel free to fork the repository and improve queries or add visualizations.

Contact

For suggestions or collaboration, feel free to connect.
