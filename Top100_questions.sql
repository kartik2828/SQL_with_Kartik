# Best 100 questions of SQL, All questions are available on Leetcode 

# 610. Triangle Judgement

SELECT *,
    CASE 
        WHEN (x + y) > z  and (x + z) > y  and (y+z) > x THEN 'Yes' 
        ELSE 'No' 
    END AS triangle
FROM triangle;


# 177. Nth Highest Salary

CREATE FUNCTION getNthHighestSalary(@N INT) RETURNS INT AS
BEGIN
    RETURN (
        /* Write your T-SQL query statement below. */
        SELECT DISTINCT Salary
        FROM (
            SELECT Salary, DENSE_RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
            FROM Employee
        ) AS RankedSalaries
        WHERE SalaryRank = @N
    );
END





