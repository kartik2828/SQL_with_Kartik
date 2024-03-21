# Best 100 questions of SQL, All questions are available on Leetcode 

# 610. Triangle Judgement

SELECT *,
    CASE 
        WHEN (x + y) > z  and (x + z) > y  and (y+z) > x THEN 'Yes' 
        ELSE 'No' 
    END AS triangle
FROM triangle;




