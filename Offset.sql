select * from customer

SELECT * FROM customer ORDER BY [customer id] OFFSET 2 ROWS FETCH NEXT 3 ROWS ONLY;

select * from authors

select * from authors order by author_id offset 1 rows fetch next 3 rows only 

-- Get top 3 values in descending order 
  
with output_table as(
select top 3 * from authors order by author_id desc
) 
select * from output_table order by author_id

-- Difference between ISNULL and IS NULL 
/*
  ISNULL: The ISNULL function is used to replace NULL values with a specified replacement value. 
  It takes two parameters: the column or expression to check for NULL, and the value to return if the column or expression is NULL. 

  IS NULL: The IS NULL operator is used to check if a column or expression is NULL. It returns true if the value is NULL and false otherwise.
*/
CREATE TABLE Employees (
  EmployeeID INT PRIMARY KEY,
  FirstName VARCHAR(50),
  LastName VARCHAR(50),
  Salary DECIMAL(10, 2),
  Address VARCHAR(100)
);

select * from employees
INSERT INTO Employees (EmployeeID, FirstName, LastName, Salary, Address)
VALUES (1, 'John', 'Doe', 5000.00, '123 Main St');

INSERT INTO Employees (EmployeeID, FirstName, LastName, Salary, Address)
VALUES (2, 'Jane', 'Smith', 6000.00, '456 Elm St');

INSERT INTO Employees (EmployeeID, FirstName, LastName, Salary, Address)
VALUES (3, 'Michael', NULL, 4000.00, '789 Oak St');

SELECT EmployeeID, FirstName, ISNULL(LastName, 'N/A') AS LastName
FROM Employees;

SELECT EmployeeID, FirstName
FROM Employees
WHERE LastName IS NULL;


select * from employees
