CREATE TABLE students (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    age INT
);

INSERT INTO students (id, name, age) VALUES
(1, 'Alice', 25),
(2, 'Bob', NULL),
(3, 'Charlie', NULL);


-- Show the bottom two rows only in order 
SELECT * FROM students
ORDER BY id
OFFSET  (SELECT COUNT(*) - 2 FROM students) ROWS
FETCH NEXT 2 ROWS ONLY;

/* 
If NUll IS NULL WHAT WILL BE THE OUTPUT
NULL == NULL? WHAT WILL BE THE OUTPUT  
*/

 IF NULL IS NULL
 PRINT 'TRUE'

 ELSE 
 PRINT 'FALSE'

-- Difference between null = null and null is null 
SELECT * FROM students WHERE age = NULL;  -- This will not give any output

SELECT * FROM students WHERE age is NULL  -- This will give an output
