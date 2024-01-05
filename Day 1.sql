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



