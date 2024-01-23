
CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Department NVARCHAR(50)
);

INSERT INTO Employee (EmployeeID, FirstName, LastName, Department)
VALUES
    (1, 'John', 'Doe', 'IT'),
    (2, 'Jane', 'Smith', 'HR'),
    (3, 'Bob', 'Johnson', 'Finance'),
    (4, 'Alice', 'Williams', 'IT'),
    (5, 'John', 'Doe', 'IT'),
    (6, 'Jane', 'Smith', 'HR');

-- Query to see the data
SELECT * FROM Employee;

-- How to check table datatype

SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'e1'

select table_name from information_schema.tables 
where table_type = 'base table'

select * from orders
 -- How to find duplicates records from the table 

SELECT *
FROM (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY FirstName ORDER BY EmployeeID) AS r
    FROM Employee
) AS final_table
WHERE final_table.r > 1
ORDER BY EmployeeID;

-- or

SELECT FirstName, LastName, COUNT(*) AS DuplicateCount
FROM Employee
GROUP BY FirstName, LastName
HAVING COUNT(*) > 1;

--or

with final_table as(
select *, row_number() over (partition by firstname order by employeeID) as r from employee
) 
select * from final_table where final_table.r>1 order by employeeID
