-- Here is the table and questions which I have practised to excel in my skills

CREATE TABLE ExampleTable (
    ID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Age INT,
    City VARCHAR(50),
    Country VARCHAR(50)
);


INSERT INTO ExampleTable (ID, FirstName, LastName, Age, City, Country)
VALUES
(1, 'John', 'Doe', 25, 'New York', 'USA'),
(2, 'Jane', 'Smith', 30, 'London', 'UK'),
(3, 'Bob', 'Johnson', 22, 'Sydney', 'Australia'),
(4, 'Alice', 'Brown', 28, 'Paris', 'France'),
(5, 'Charlie', 'White', 35, 'Tokyo', 'Japan'),
(6, 'Eva', 'Black', 27, 'Berlin', 'Germany'),
(7, 'David', 'Lee', 32, 'Toronto', 'Canada');

select * from ExampleTable

-- Intermediate-Level Questions

-- Retrieve all records from the table:
SELECT * FROM ExampleTable

-- Count the number of records in the table:
SELECT COUNT(*) AS [COUNT] FROM ExampleTable

-- Retrieve distinct cities from the table:
SELECT DISTINCT City FROM ExampleTable

-- Find the average age of all individuals in the table:
SELECT AVG(AGE) AS [AVERAGE AGE] FROM ExampleTable

-- Retrieve records where the age is greater than 25:
SELECT * FROM ExampleTable WHERE AGE>25

-- List individuals from the 'USA' or 'Canada':
SELECT * FROM ExampleTable WHERE COUNTRY IN('USA','CANADA')

-- Update the age of 'Jane Smith' to 31:
SELECT * FROM ExampleTable
UPDATE ExampleTable SET AGE = 31 WHERE FirstName = 'JANE' AND LastName = 'SMITH'

-- Calculate the total number of records for each city:
SELECT COUNT(*) AS [CITY COUNT], CITY FROM ExampleTable GROUP BY CITY

-- Retrieve the oldest person in the table:
SELECT TOP 1 FIRSTNAME, AGE FROM ExampleTable ORDER BY AGE DESC

-- Delete records of individuals from 'Germany':
DELETE FROM ExampleTable WHERE Country = 'GERMANY'

-- Level-up

-- 1. Retrieve the full names (concatenation of first and last name) of individuals aged 30 or older
SELECT FIRSTNAME + ' ' + LASTNAME AS [FULL NAME] FROM ExampleTable WHERE AGE>=30
-- OR 
SELECT CONCAT(FIRSTNAME ,' ', LASTNAME) AS [FULL NAME] FROM ExampleTable WHERE AGE>=30


-- 2. Find the top 3 cities with the highest average age of individuals:
SELECT TOP 3 CITY, AVG(AGE) AS [AVERAGE AGE] FROM ExampleTable GROUP BY City ORDER BY [AVERAGE AGE] DESC

-- 3. Calculate the percentage of individuals from each country in the table:
SELECT Country, COUNT(*) * 100.0/COUNT(*) OVER() AS Percentage
FROM ExampleTable GROUP BY Country;


--4. Retrieve the records of individuals who have the same first name but different last names:

-- 5. Update the City to 'Unknown' for individuals with a null City:

-- 6. Find the individuals with the highest age in each country:

--7. Retrieve the records of individuals who have a duplicate combination of first name and last name:

--8. Calculate the age difference between each individual and the youngest person in the same city:

-- 9. Delete records of individuals with an age less than 25 and a city not equal to 'Unknown':

-- 10. Retrieve the individuals who have the same age as at least one other person in the table:




