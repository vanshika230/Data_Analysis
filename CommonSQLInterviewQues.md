![image](https://github.com/user-attachments/assets/d2ee4179-fbd0-49e5-a4eb-705619c00e67)

-- Q1 -  Write an SQL query to fetch “FIRST_NAME” from Worker table using the alias name as <WORKER_NAME>.
```sql
SELECT First_Name as worker_name from Worker;
```
-- Query 2
-- Write an SQL query to fetch “FIRST_NAME” from Worker table in upper case.
```sql
SELECT UPPER(First_Name) from Worker; 
```
-- Query 3
-- Write an SQL query to fetch unique values of DEPARTMENT from Worker table.
```sql
SELECT DISTINCT(DEPARTMENT) from Worker; 
```
-- Query 4
-- Write an SQL query to print the first three characters of  FIRST_NAME from Worker table.
-- SUBSTRING(string, start, length)
-- The start position. The first position in string is 1.
```sql
SELECT  from Worker; 
SELECT SUBSTRING(FIRST_NAME , 1, 3) FROM Worker;
```
-- Query 5
--  Write an SQL query to find the position of the alphabet (‘b’) in the first name column ‘Amitabh’ from Worker table.
The Below Query Would give me the Entries where the first Name is Amitabh.
SELECT * FROM Worker 
WHERE first_name = 'Amitabh';

Now to find the position of a SubString in a String, we use INSTR Function
INSTR(string1, string2)
String1 - the main string to be searched in
String2 - The string to be searched in string1 - 0 returned if not found
NOTE :- not case sensitive
```sql
SELECT INSTR(FIRST_NAME, 'b')
FROM Worker
WHERE FIRST_NAME = 'Amitabh';
```

-- Query 6
-- Write an SQL query to print the FIRST_NAME from Worker table after removing white spaces from the right side.
-- LTRIM() would remove it from the left Side.
```sql
SELECT RTRIM(FIRST_NAME) from Worker;
```

-- Query 7
-- Write an SQL query to print the FIRST_NAME from Worker table after removing white spaces from the left side.
```sql
SELECT LTRIM(FIRST_NAME) from Worker;
```

- Query 8
-- Write an SQL query that fetches the unique values of DEPARTMENT from Worker table and prints its length.
-- Length() Function is used to find the length of the string in a Table.
```sql
SELECT DISTINCT(DEPARTMENT), LENGTH(DEPARTMENT) FROM Worker;
```

-- Query 9
-- Write an SQL query to print the FIRST_NAME from Worker table after replacing ‘a’ with ‘A’.
-- REPLACE(string, from_string, new_string)
```sql
SELECT Replace(FIRST_NAME, 'a', 'A') FROM Worker;
```

-- Query 10
-- Write an SQL query to print the FIRST_NAME and LAST_NAME from Worker table into a single column COMPLETE_NAME.
-- A space char should separate them and the concat Function can take Whatever number of Arguments are given to it.
-- CONCAT(expression1, expression2, expression3,...)
```sql
SELECT CONCAT(FIRST_NAME , ' ', LAST_NAME)AS COMPLETE_NAME FROM Worker;
```

-- Query 11
-- Write an SQL query to print all Worker details from the Worker table order by FIRST_NAME Ascending.
-- By default, the Order that is given out would be in Ascending Order, therefore it is not important to mention the 'ASC' Clause
```sql
SELECT * FROM Worker
ORDER BY FIRST_NAME ASC;
```

-- Query 12
-- Write an SQL query to print all Worker details from the Worker table order by 
-- FIRST_NAME Ascending and DEPARTMENT Descending.
-- The order by clause can be passed multiple statements & not just ordering by some single column!
```sql 
SELECT * FROM Worker
ORDER BY FIRST_NAME ASC, DEPARTMENT desc;
```

-- Query 13
-- Write an SQL query to print details for Workers with the first name as “Vipul” and “Satish” from Worker table.
-- 'IN' Keyword can be used to pass Multiple Possible Arguments for the column being asked values from.
```sql
SELECT * FROM Worker
WHERE FIRST_NAME IN ("Vipul" , "Satish");
```

-- Query 14
-- Write an SQL query to print details of workers excluding first names, “Vipul” and “Satish” from Worker table.
-- The 'NOT' Keyword would exclude the values given in the Arguments mentioned by the user.
```sql
SELECT * FROM Worker
WHERE FIRST_NAME NOT IN ("Vipul" , "Satish");
```

-- Query 15
-- Write an SQL query to print details of Workers with DEPARTMENT name as “Admin*”.
-- The '*' means that after the 'admin' text you can have any text & it would be still shown in the results.
-- Therefore, we'll be using Wildcards here.

```sql
SELECT * FROM Worker
WHERE DEPARTMENT 
LIKE 'Admin%';
```

-- Query 16
-- Write an SQL query to print details of the Workers whose FIRST_NAME contains ‘a’.
-- The '%' sign is helpul where there are no characters [NULL Character] or even when they are there, there can be n number of characters
```sql
SELECT *
FROM Worker
WHERE FIRST_NAME LIKE '%a%';
```

-- Query 17
-- Write an SQL query to print details of the Workers whose FIRST_NAME ends with ‘a’.
```sql
SELECT *
FROM Worker
WHERE FIRST_NAME LIKE '%a';
```

-- Query 18
-- Write an SQL query to print details of the Workers whose FIRST_NAME ends with ‘h’ and contains six alphabets.
-- Now here, we can't place '%' because it can then be replaced with any number of characters - but here all we want are 6 total alphaberts in the output.
-- Since we are sure about the number of alphabets, we'll be using the '_'.
-- Therefore, the h character would be placed at the 6th position in the String like -> '_____ h'
```sql
SELECT * 
FROM Worker
where FIRST_NAME LIKE '_____h';
```

-- Query 19
-- Write an SQL query to print details of the Workers whose SALARY lies between 100000 and 500000.
-- We'll be using the 'BETWEEN' Keyword.
```sql
SELECT * FROM Worker
WHERE SALARY BETWEEN 100000 AND 500000;
```

-- Query 20
-- Write an SQL query to print details of the Workers who have joined in Feb’2014.
```sql
SELECT * FROM Worker
WHERE YEAR(Joining_Date) = 2014 AND MONTH(Joining_Date) = 02;
```

-- Query 21
-- Write an SQL query to fetch the count of employees working in the department ‘Admin’.
```sql
SELECT department,COUNT(Worker_ID) FROM Worker WHERE Department='Admin';
```

-- Query 22
-- Write an SQL query to fetch worker full names with salaries >= 50000 and <= 100000.
```sql
SELECT CONCAT(FIRST_NAME, ' ', Last_Name) AS Full_Name
From Worker WHERE (Salary >= 50000 AND Salary <= 100000);
```

-- Query 23
-- Write an SQL query to fetch the no. of workers for each department in the descending order.
```
SELECT Department, COUNT(Worker_id) FROM Worker GROUP BY Department ORDER BY COUNT(Department) DESC; 
```

-- Query 24
-- Write an SQL query to print details of the Workers who are also Managers.
```sql
SELECT  w.Worker_id, w.First_Name, w.Last_Name FROM Worker as w INNER JOIN Title as t ON w.Worker_id=t.WORKER_REF_ID WHERE t.WORKER_TITLE='Manager';
```

-- Query 25
-- Write an SQL query to fetch number (more than 1) of same titles in the ORG of different types.
```sql
SELECT WORKER_TITLE, count(WORKER_TITLE) AS "Count"
FROM Title 
GROUP BY WORKER_TITLE
HAVING count(WORKER_TITLE) > 1;
```

-- Query 26 [An IMPORTANT interesting Query]
-- Write an SQL query to show only odd rows from a table.
-- To do this, we'll be using the MOD Keyword 
-- The MOD() function returns the remainder of a number divided by another number.
-- Syntax: MOD(x,y) or (x MOD y) or (x%y)
```sql
SELECT * FROM Worker 
where MOD(WORKER_ID , 2) != 0;
```
-- We did the Mod with 'Worker ID' as it was Auto Incremented, so we'll get the odd ones out easily!
-- Also, there is one more sign that behaves exactly similar to the 'not equal to' sign which is '<>'

-- Query 27
-- Write an SQL query to show only even rows from a table.
``` sql
SELECT * FROM Worker
WHERE WORKER_ID%2 = 0;
```

-- Query 28
-- Write an SQL query to clone a new table from another table.
-- The 'Like' Clause can be used to create the clone of one table from some other.
-- It would completely copy the Schems but not the values!
CREATE TABLE WORKER_CLONE like Worker;
-- If you also wish to insert the same data into the clone from the parent table (the one you cloned this table from), you can write the following query
```sql
INSERT INTO WORKER_CLONE SELECT * FROM Worker;
```

-- Query 29
-- Write an SQL query to fetch INTERSECTING records of two tables.
```sql
SELECT w1.* FROM
Worker as w1 INNER JOIN WORKER_CLONE as w2
using(WORKER_ID);
```
-- Query 30
-- Write an SQL query to show records from one table that another table does not have.
-- Here, we'll use the MINUS SET Operation
-- The result Set where the Match doesn't happen for the WORKER_IDs get shown.
```sql
SELECT * from 
Worker LEFT JOIN WORKER_CLONE
Using(WORKER_ID)
WHERE WORKER_CLONE.WORKER_ID is NULL;
```

-- Query 31
-- Write an SQL query to show the current date and time.
-- For current Date And Time Operation, we are going to use the Dual Table.
-- The DUAL is special one row, one column table present by default in all Oracle databases.
```sql
SELECT curdate();
```
-- For time, we use the now() function - but it gives the complete date & time [the timestamp]
-- The time returned back are that of the server, it might not necessarily be similar to that of your current Location.
```sql
SELECT now();
```

-- Query 32
-- Write an SQL query to show the top n (say 5) records of a table order by descending salary.
-- The 'Limit' Keyword restricts the number of values being returned.
```sql
SELECT DISTINCT(Salary) FROM Worker ORDER BY Salary DESC LIMIT 5;
```

-- Query 33
-- Write an SQL query to determine the nth (say n=5) highest salary from a table.
-- There are two ways of doing it:
-- Way 1 [by using the limit keyword And the Offset Keyword]
-- The 'OFFSET' argument is used to identify the starting point to return rows from a result set. Basically, it excludes the first set of records.
-- The 'limit' keyword would be restricting the number of rows that should be given as an output.
-- The value of the OFFSET Keyword is 'n-1', it means that to get the nth highest record, you wish to start printing the values from n-1th row as indexing starts from 0.
```sql
SELECT DISTINCT(Salary) 
FROM Worker
ORDER BY Salary DESC
LIMIT 1 Offset 4;

-- OR it can also be done by this 
SELECT DISTINCT(Salary) 
FROM Worker
ORDER BY Salary DESC
LIMIT n-1, 1;

-- OR it can also be done by this 
SELECT DISTINCT(Salary) 
FROM Worker
ORDER BY Salary DESC
LIMIT 1 OFFSET n-1;
```
-- Query 34
-- Write an SQL query to determine the 5th highest salary without using LIMIT keyword.
```sql
SELECT Salary FROM Worker as w1
where 4  = (
  Select count(distinct(w2.salary))
  FROM Worker as w2
  WHERE w2.salary >= w1.salary
);
```

-- Query 35
-- Write an SQL query to fetch the list of employees with the same salary.
```sql
SELECT * FROM Worker as w1, Worker as w2 WHERE w1.salary=w2.salary;
```

-- Query 36
-- Write an SQL query to show the second highest salary from a table using sub-query.
```sql
SELECT MAX(DISTINCT(Salary))
From Worker
WHERE salary < (
  SELECT MAX(DISTINCT(SALARY))
  FROM Worker
);
```
-- The Above Query can be rewritten as:
```sql
SELECT MAX(Salary) FROM Worker
Where Salary NOT IN (SELECT MAX(SALARY) FROM Worker);
```

-- Query 37
-- Write an SQL query to show one row twice in results from a table. 
```sql
SELECT * FROM
Worker 
UNION 
SELECT * FROM
Worker;

SELECT * FROM
Worker 
UNION ALL
SELECT * FROM
Worker
ORDER BY worker_id;
```

-- Query 38
-- Write an SQL query to list worker_id who does not get bonus.
```sql
SELECT worker_id FROM Worker
where worker_id NOT IN (SELECT WORKER_REF_ID FROM Bonus);
```

-- Query 39
-- Write an SQL query to fetch the first 50% records from a table.
-- The worker table currently has 8 rows and we also know that the worker_id column is self-Incrementing therefore the actual ans would be where worker_id <= total count of worker ids in the table.
```sql
SELECT * 
FROM Worker
where worker_id <= (SELECT COUNT(worker_id)/2 from Worker);
```
-- Query 40
-- Write an SQL query to fetch the departments that have less than 4 people in it.
```sql
SELECT department, COUNT(department)
FROM Worker
GROUP BY department
HAVING COUNT(department) < 4;
```

-- Query 41
-- Write an SQL query to show all departments along with the number of people in there.
```sql
SELECT department, COUNT(department)
FROM Worker
GROUP BY department;
```

-- Query 42 [Interesting]
-- Write an SQL query to show the last record from a table.
-- We know that the worker id  is self-Incrementing, therefore we'll find the the max worker_id first and print the data corresponding to it
```sql
SELECT * 
FROM Worker
where worker_id = (
  SELECT MAX(worker_id)
  FROM Worker
);
```
-- Query 43
-- Write an SQL query to fetch the first row of a table.
-- Similar to the previous query, but here we find the Minimum value of Worker_id
```sql
SELECT * 
FROM Worker
where worker_id = (
  SELECT MIN(worker_id)
  FROM Worker
);
```

-- Query 44
-- Write an SQL query to fetch the last five records from a table.
-- Again, we use the Auto Incrmenting Property of Worker_id & order them in the descending order & then limit the results
```sql
SELECT * 
FROM Worker
ORDER BY worker_id DESC
LIMIT 5;
-- But the above query is actually reversing the order in which how the values were present in the table, so we need to correct this well & reverse its output to get the original way how the rows were stored in the Table
(
  SELECT * 
  FROM Worker
  ORDER BY worker_id DESC
  LIMIT 5
)ORDER BY worker_id;
```

-- Query 45
-- Write an SQL query to print the name of employees having the highest salary in each department.
```sql
SELECT Department, MAX(Salary) FROM Worker GROUP BY Department; 

SELECT w.department, w.first_name, w.salary
FROM(
  SELECT MAX(Salary) as Maxsal, department
  FROM Worker
  GROUP BY Department
) AS temp
Inner Join Worker as w 
ON w.Salary = temp.MaxSal;
 ``` 
-- Query 46
-- Write an SQL query to fetch three max salaries from a table using co-related subquery.
Select Distinct(Salary)
```sql
Select Distinct(Salary)
From Worker as w1
where 3>= (
  SELECT COUNT(DISTINCT(Salary))
  From Worker as w2
  where w2.Salary >= w1.Salary
) ORDER By Salary Desc;

-- Its Limit Form:
SELECT Distinct(Salary)
From Worker 
ORDER By Salary DESC
LIMIT 3;

```


-- Query 47
-- Write an SQL query to fetch three min salaries from a table using co-related subquery
```sql
Select Distinct(Salary)
From Worker as w1
where 3>= (
  SELECT COUNT(DISTINCT(Salary))
  From Worker as w2
  where w2.Salary <= w1.Salary
) ORDER By Salary;
```

-- Query 48
-- Write an SQL query to fetch departments along with the total salaries paid for each of them.
```
SELECT Department, SUM(salary) as depSal
FROM Worker
Group BY Department
ORDER BY depSal DESC;
```
-- Query 49
-- Write an SQL query to fetch the names of workers who earn the highest salary.
```sql
SELECT first_name, salary
FROM Worker Where 
Salary = (
  SELECT Max(Salary)
  FROM Worker
);
```
