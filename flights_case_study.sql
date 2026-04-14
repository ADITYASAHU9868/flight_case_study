SELECT * FROM cleaning.flights;
USE cleaning;
-- find the month with most n. of flights
SELECT 
    MONTH(Date_of_Journey) ,
    COUNT(*) AS total_flights
FROM flights
GROUP BY MONTH(Date_of_Journey)
ORDER BY total_flights DESC
LIMIT 1;

-- which week day have most costly flights
Select dayname(Date_of_Journey),
AVG(Price) AS 'avg_price'
FROM flights
GROUP BY dayname(Date_of_Journey)
ORDER BY avg_price DESC;

-- find the no. of fligths every month
SELECT 
    MONTH(Date_of_Journey) AS month_no,
    MONTHNAME(Date_of_Journey) AS month,
    COUNT(*) AS indigo_flights
FROM flights
WHERE Airline = 'IndiGo'
GROUP BY month_no, month
ORDER BY month_no;

-- find list of all flights that depart between 10AM and 2PM fromm delhi to banglore
SELECT *
FROM flights
WHERE Source = 'Banglore'
  AND Destination = 'Delhi'
  AND Dep_Time BETWEEN '10:00:00' AND '14:00:00';
  
-- find the no. of flights departing on weekend from banglore
SELECT COUNT(*) AS weekend_flights
FROM flights
WHERE Source = 'Banglore'
  AND DAYOFWEEK(Date_of_Journey) IN (1, 7);
  
-- calculate the arrival time for all flights by adding the duration to the departure time
ALTER TABLE flights
MODIFY Date_of_Journey DATE;

ALTER TABLE flights ADD COLUMN depature DATETIME;

UPDATE flights
SET departure = STR_TO_DATE(CONCAT(Date_of_Journey,' ',Dep_Time),'%Y-%m-%d %H:%i:%s');

ALTER TABLE flights ADD COLUMN duration_min integer,
ADD COLUMN arrival_time datetime;

SELECT Duration ,
REPLACE (substring_index(Duration,' ',1),'h','')*60 +
CASE WHEN substring_index(Duration,' ',-1) = substring_index(Duration,' ',1) then 0
else replace(substring_index(Duration,' ',-1),'m','')
end as 'min'
FROM flights;

UPDATE flights
SET duration_min = 
(
    CASE 
        WHEN Duration LIKE '%h%' 
        THEN CAST(SUBSTRING_INDEX(Duration,'h',1) AS UNSIGNED) * 60
        ELSE 0
    END
)
+
(
    CASE 
        WHEN Duration LIKE '%m%' 
        THEN CAST(
            TRIM(
                SUBSTRING_INDEX(
                    SUBSTRING_INDEX(Duration,'h',-1),'m',1
                )
            ) AS UNSIGNED
        )
        ELSE 0
    END
);

use cleaning;

UPDATE flights
SET arrival_time = DATE_ADD(departure, INTERVAL duration_min minute);

-- find arrivaldate of all flights

-- find no. of flights which travel on multiple dates
SELECT COUNT(*)
FROM flights
WHERE DATE(departure) != DATE(arrival_time);

-- calculate avg duration of flights btw all city
SELECT 
    Source,
    Destination,
    TIME_FORMAT(sec_to_time(AVG(duration_min)*60), '%hH:%im') AS avg_duration_minutes
FROM flights
GROUP BY Source, Destination
ORDER BY avg_duration_minutes;

-- find all flights departed before midnight but arrived at thier destination after midneight have only 0 stop
SELECT * FROM flights
WHERE Total_Stops = 'non-stop' and
DATE(departure) < DATE(arrival_time);

-- find quature wise no. of  flights for each airline
SELECT 
    Airline,
    QUARTER(Date_of_Journey) AS quarter,
    COUNT(*) AS total_flights
FROM flights
GROUP BY Airline, quarter
ORDER BY Airline, quarter;

-- avg time dration for flights that have 1 stop vs more than 1 stop
WITH temp_table AS
(
SELECT *,
CASE 
	when Total_Stops = 'non-stop'  THEN 'no_stop'
    ELSE 'with_stop'
END AS 'temp'
FROM flights)

select temp, TIME_FORMAT(sec_to_time(AVG(duration_min)*60), '%hH:%im') from temp_table
GROUP BY temp;

-- find all air india flights in a given date range originatinng from delhi
select * FROM flights
WHERE Source = 'Delhi' AND 
DATE(departure)  BETWEEN '2019-01-03' and '2019-01-05';

-- FIND LONGEST FLIGHT OF EACH AIRLINE
SELECT Airline, TIME_FORMAT(sec_to_time(max(duration_min)*60), '%hH:%im') as 'longer_flight'
FROM flights
GROUP BY Airline
ORDER BY longer_flight desc;

-- make the  grid
SELECT dayname(departure) ,

SUM(CASE 
	WHEN hour(departure) between 0 AND 5 THEN 1 ELSE 0 END) AS '12AM-5AM',
SUM(CASE 
	WHEN hour(departure) between 6 AND 11 THEN 1 ELSE 0 END) AS '6AM-11AM',
SUM(CASE 
	WHEN hour(departure) between 12 AND 17 THEN 1 ELSE 0 END) AS '12PM-16PM' ,
SUM(CASE 
	WHEN hour(departure) between 18 AND 24 THEN 1 ELSE 0 END) AS '7PM-12PM' 
FROM flights
where source = 'banglore' AND destination = 'Delhi'
GROUP BY dayname(departure) 
ORDER BY dayname(departure) asc;







