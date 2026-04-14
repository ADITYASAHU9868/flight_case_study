# Flight Data Analysis using SQL

## Overview
This project analyzes a flight dataset using SQL. It includes data cleaning, feature engineering, and extracting insights.

---

## Dataset
The dataset contains:

- Airline  
- Date_of_Journey  
- Source  
- Destination  
- Dep_Time  
- Duration  
- Total_Stops  
- Additional_Info  
- Price  

---

## Project Workflow

### 1. Data Cleaning
- Converted Date_of_Journey to DATE format  
- Created departure column (date + time)  
- Converted Duration to duration_min  
- Handled formats like 2h 50m, 5h, 45m  

### 2. Feature Engineering
- Extracted month, day, quarter  
- Created weekday vs weekend  
- Created time slots (morning, afternoon, evening, night)  
- Generated:
  - duration_min  
  - arrival_time  
  - arrival_date  

### 3. Analysis Performed
- Month with highest number of flights  
- Most expensive travel day  
- IndiGo flights per month  
- Flights between 10 AM and 2 PM  
- Weekend flight count  
- Arrival time and date calculation  
- Average duration between cities  
- Longest flight per airline  
- Weekend vs time-slot grid  

---

## Sample Queries

### Average Duration Between Cities
```sql
SELECT 
    Source,
    Destination,
    AVG(duration_min) AS avg_duration
FROM flights
GROUP BY Source, Destination;
