-- SELECT
-- Find the IDs of products that are both low fat and recyclable.
SELECT product_id 
FROM products 
WHERE low_fats = 'Y' AND recyclable = 'Y';

-- Find the names of customers that are not referred by the customer with id = 2.
SELECT name 
FROM Customer 
WHERE referee_id != 2 OR referee_id IS NULL;

-- Find the name, population, and area of big countries.
-- A country is considered big if:
-- 1. It has an area of at least 3 million km², OR
-- 2. It has a population of at least 25 million.
SELECT name, population, area 
FROM world 
WHERE area >= 3000000 OR population >= 25000000;

-- Find all authors that viewed at least one of their own articles.
SELECT DISTINCT(author_id) AS id 
FROM views 
WHERE author_id = viewer_id 
ORDER BY author_id;

-- Find the IDs of invalid tweets.
-- A tweet is invalid if its content has more than 15 characters.
SELECT tweet_id 
FROM Tweets 
WHERE CHAR_LENGTH(content) > 15;

-- Joins

-- Show the unique ID of each user; if a user does not have a unique ID, display NULL.
SELECT u.unique_id, e.name 
FROM employees e 
LEFT JOIN Employeeuni u 
ON e.id = u.id;

-- Report the product name, year, and price for each sale_id in the Sales table.
SELECT p.product_name, s.year, s.price 
FROM Sales s 
INNER JOIN Product p 
ON s.product_id = p.product_id;

-- Find the IDs of users who visited without making any transactions and the number of such visits.
SELECT v.customer_id, COUNT(v.visit_id) AS count_no_trans 
FROM Visits v 
LEFT JOIN transactions t 
ON v.visit_id = t.visit_id 
WHERE t.transaction_id IS NULL 
GROUP BY v.customer_id;

-- Find all date IDs with higher temperatures compared to the previous day.
-- Tip: When comparing rows, consider creating two instances of the same table.
SELECT w1.id 
FROM Weather w1, Weather w2
WHERE DATEDIFF(w1.recordDate, w2.recordDate) = 1 
AND w1.temperature > w2.temperature;

-- Find the average time each machine takes to complete a process.
-- Create two instances of the same table to compare start and end times.
SELECT a1.machine_id, 
       ROUND(AVG(a2.timestamp - a1.timestamp), 3) AS processing_time 
FROM Activity a1
JOIN Activity a2 
ON a1.machine_id = a2.machine_id 
AND a1.process_id = a2.process_id 
AND a1.activity_type = 'start' 
AND a2.activity_type = 'end'
GROUP BY a1.machine_id;

-- Report the name and bonus amount of employees with a bonus less than 1000.
SELECT e.name, b.bonus 
FROM employee e 
LEFT JOIN bonus b 
ON e.empId = b.empId 
WHERE b.bonus < 1000 OR b.bonus IS NULL;

-- Find the number of times each student attended each exam.
SELECT st.student_id, st.student_name, su.subject_name, 
       COUNT(e.subject_name) AS attended_exams
FROM Students st
CROSS JOIN Subjects su
LEFT JOIN Examinations e 
ON st.student_id = e.student_id 
AND su.subject_name = e.subject_name
GROUP BY st.student_id, su.subject_name
ORDER BY st.student_id, su.subject_name;

-- Find managers with at least five direct reports.
SELECT name 
FROM Employee 
WHERE id IN (
    SELECT managerId 
    FROM Employee 
    GROUP BY managerId 
    HAVING COUNT(*) >= 5
);

-- Find the confirmation rate of each user.
-- The confirmation rate is calculated as:
-- (Number of confirmed messages) / (Total number of confirmation requests).
SELECT 
    s.user_id, 
    ROUND(AVG(IF(c.action = "confirmed", 1, 0)), 2) AS confirmation_rate
FROM 
    Signups s
LEFT JOIN 
    Confirmations c 
ON 
    s.user_id = c.user_id
GROUP BY 
    s.user_id;

-- Basic aggregate functions

-- Write a solution to report the movies with an odd-numbered ID and a description that is not "boring".
SELECT 
    *
FROM 
    Cinema
WHERE
    MOD(id, 2) = 1
    AND description != 'boring'
ORDER BY 
    rating DESC;

-- Write a solution to find the average selling price for each product.
SELECT 
    p.product_id, 
    IFNULL(ROUND(SUM(units * price) / SUM(units), 2), 0) AS average_price
FROM 
    Prices p 
LEFT JOIN 
    UnitsSold u
ON 
    p.product_id = u.product_id 
    AND u.purchase_date BETWEEN start_date AND end_date
GROUP BY 
    product_id;

-- Write a solution to find the average years of experience for each project.
SELECT 
    p.project_id, 
    ROUND(AVG(e.experience_years), 2) AS average_years
FROM 
    Project p 
LEFT JOIN 
    Employee e
ON 
    p.employee_id = e.employee_id
GROUP BY 
    p.project_id;

-- Write a solution to find the percentage of the users registered in each contest rounded to two decimals.
-- Return the result table ordered by percentage in descending order. In case of a tie, order it by contest_id in ascending order.
SELECT 
    contest_id, 
    ROUND(COUNT(DISTINCT user_id) * 100 / (SELECT COUNT(user_id) FROM Users), 2) AS percentage
FROM  
    Register
GROUP BY 
    contest_id
ORDER BY 
    percentage DESC, contest_id;

-- We define query quality as: 
-- The average of the ratio between query rating and its position. 
-- We also define poor query percentage as: 
-- The percentage of all queries with rating less than 3.
-- Write a solution to find each query_name, the quality, and poor_query_percentage.
SELECT 
    query_name,
    ROUND(AVG(CAST(rating AS DECIMAL) / position), 2) AS quality,
    ROUND(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) * 100 / COUNT(*), 2) AS poor_query_percentage
FROM 
    Queries
GROUP BY 
    query_name;

-- Write a solution to find for each month and country, the number of transactions and their total amount, 
-- the number of approved transactions, and their total amount.
SELECT 
    LEFT(trans_date, 7) AS month,
    country, 
    COUNT(id) AS trans_count,
    SUM(state = 'approved') AS approved_count,
    SUM(amount) AS trans_total_amount,
    SUM((state = 'approved') * amount) AS approved_total_amount
FROM 
    Transactions
GROUP BY 
    month, country;

-- Write a solution to find the percentage of immediate orders in the first orders of all customers, rounded to 2 decimal places.
SELECT 
    ROUND(AVG(order_date = customer_pref_delivery_date) * 100, 2) AS immediate_percentage
FROM 
    Delivery 
WHERE 
    (customer_id, order_date) IN (
        SELECT 
            customer_id, 
            MIN(order_date) AS first_order
        FROM 
            Delivery
        GROUP BY 
            customer_id
    );

-- Write a solution to report the fraction of players that logged in again on the day after the day they first logged in, rounded to 2 decimal places. 
WITH temp AS (
    SELECT 
        player_id, 
        MIN(event_date) AS first_login_date
    FROM 
        Activity 
    GROUP BY 
        player_id
)
SELECT 
    ROUND(
        SUM(DATEDIFF(a.event_date, t.first_login_date) = 1) / COUNT(DISTINCT a.player_id), 2
    ) AS fraction
FROM 
    Activity a
JOIN 
    temp t 
ON 
    a.player_id = t.player_id;

-- SORTING &  GROUPING 
-- Write a solution to calculate the number of unique subjects each teacher teaches in the university.
SELECT 
    teacher_id, 
    COUNT(DISTINCT subject_id) AS cnt 
FROM 
    teacher 
GROUP BY 
    teacher_id;

-- Write a solution to find the daily active user count for a period of 30 days ending 2019-07-27 inclusively. 
-- A user was active on a specific day if they made at least one activity on that day.
SELECT 
    activity_date AS day, 
    COUNT(DISTINCT user_id) AS active_users
FROM 
    Activity
WHERE 
    activity_date > "2019-06-27" AND activity_date <= "2019-07-27"
GROUP BY 
    activity_date;

-- Write a solution to select the product ID, year, quantity, and price for the first year of every product sold.
SELECT 
    product_id, 
    year AS first_year, 
    quantity, 
    price
FROM 
    Sales
WHERE 
    (product_id, year) IN (
        SELECT 
            product_id, 
            MIN(year)
        FROM 
            Sales
        GROUP BY 
            product_id
    );

-- Write a solution to find all the classes that have at least five students.
SELECT 
    class 
FROM 
    courses 
GROUP BY 
    class 
HAVING 
    COUNT(student) >= 5;

-- Write a solution that will, for each user, return the number of followers.
SELECT 
    user_id, 
    COUNT(follower_id) AS followers_count 
FROM 
    followers 
GROUP BY 
    user_id 
ORDER BY 
    user_id;

-- A single number is a number that appeared only once in the MyNumbers table. Find the largest single number. If there is no single number, report NULL.
SELECT 
    MAX(num) AS num 
FROM (
    SELECT 
        num 
    FROM 
        MyNumbers 
    GROUP BY 
        num 
    HAVING 
        COUNT(num) = 1
) AS nums;

-- Write a solution to report the customer IDs from the Customer table that bought all the products in the Product table.
SELECT 
    customer_id
FROM 
    Customer
GROUP BY 
    customer_id
HAVING 
    COUNT(DISTINCT product_key) = (
        SELECT 
            COUNT(DISTINCT product_key) 
        FROM 
            Product
    );


-- Advanced Join and Select
-- Write a solution to report the ids and the names of all managers, the number of employees who report directly to them, and the average age of the reports rounded to the nearest integer.
SELECT
    emp1.employee_id,
    emp1.name,
    COUNT(emp2.employee_id) AS reports_count,
    ROUND(AVG(emp2.age)) AS average_age
FROM Employees emp1
INNER JOIN Employees emp2 ON emp1.employee_id = emp2.reports_to
GROUP BY emp1.employee_id
ORDER BY emp1.employee_id

-- Write a solution to report all the employees with their primary department. For employees who belong to one department, report their only department.
SELECT DISTINCT employee_id, department_id
FROM Employee
WHERE employee_id IN (
    SELECT employee_id
    FROM Employee
    GROUP BY employee_id
    HAVING COUNT(*) = 1
  )
  OR primary_flag = 'Y'
ORDER BY employee_id;

-- Report for every three line segments whether they can form a triangle.
SELECT *, IF(x+y>z and y+z>x and z+x>y, "Yes", "No") as triangle FROM Triangle

-- Find all numbers that appear at least three times consecutively.
-- Approach 1 -Using Joins
SELECT DISTINCT l1.num AS ConsecutiveNums
FROM Logs l1
JOIN Logs l2 ON l1.id = l2.id - 1
JOIN Logs l3 ON l1.id = l3.id - 2
WHERE l1.num = l2.num AND l2.num = l3.num;

-- Approach 2-Using  LEAD and LAG
SELECT DISTINCT num AS ConsecutiveNums
FROM (
    SELECT 
        LAG(id) OVER (ORDER BY id) AS prev_id,
        id,
        LEAD(id) OVER (ORDER BY id) AS next_id,
        LAG(num) OVER (ORDER BY id) AS prev_num,
        num,
        LEAD(num) OVER (ORDER BY id) AS next_num
    FROM logs
) subquery
WHERE prev_num = num 
  AND num = next_num
  AND next_id - id = 1 
  AND id - prev_id = 1;

-- Write a solution to find the prices of all products on 2019-08-16. Assume the price of all products before any change is 10.
WITH
  RankedProducts AS (
    SELECT
      product_id,
      new_price,
      RANK() OVER(
        PARTITION BY product_id
        ORDER BY change_date DESC
      ) AS `rank`
    FROM Products
    WHERE change_date <= '2019-08-16'
  ),
  ProductToLatestPrice AS (
    SELECT product_id, new_price
    FROM RankedProducts
    WHERE `rank` = 1
  )
SELECT
  Products.product_id,
  IFNULL(ProductToLatestPrice.new_price, 10) AS price
FROM Products
LEFT JOIN ProductToLatestPrice
  USING (product_id)
GROUP BY 1;

-- Write a solution to find the person_name of the last person that can fit on the bus without exceeding the weight limit. 
WITH CumulativeSum AS (
    SELECT person_name, SUM(weight) OVER (ORDER BY turn) AS cumulative_sum
    FROM Queue
)
SELECT person_name
FROM CumulativeSum
WHERE cumulative_sum <= 1000
ORDER BY cumulative_sum DESC
LIMIT 1;

-- Write a solution to calculate the number of bank accounts for each salary category. The salary categories are:
-- "Low Salary": All the salaries strictly less than $20000.
-- "Average Salary": All the salaries in the inclusive range [$20000, $50000].
-- "High Salary": All the salaries strictly greater than $50000.

SELECT 'Low Salary' as category, COUNT(*) as accounts_count
FROM Accounts
WHERE income<20000

UNION

SELECT 'Average Salary', COUNT(*)
FROM Accounts 
WHERE income BETWEEN 20000 AND 50000

UNION 

SELECT 'High Salary', COUNT(*)
FROM Accounts
WHERE income > 50000

-- Find the IDs of the employees whose salary is strictly less than $30000 and whose manager left the company.
-- When a manager leaves the company, their information is deleted from the Employees table, but the reports still have their manager_id set to the manager that left.
SELECT employee_id
FROM Employees
WHERE salary < 30000 
AND manager_id NOT IN (SELECT DISTINCT employee_id FROM Employees) 
ORDER BY employee_id

-- Write a solution to swap the seat id of every two consecutive students. If the number of students is odd, the id of the last student is not swapped.
SELECT 
    id,
    CASE
        WHEN id % 2 = 0 THEN LAG(student) OVER(ORDER BY id)
        ELSE COALESCE(LEAD(student) OVER(ORDER BY id), student)
    END AS student
FROM Seat

-- Write a solution to:
-- Find the name of the user who has rated the greatest number of movies. In case of a tie, return the lexicographically smaller user name.
-- Find the movie name with the highest average rating in February 2020. In case of a tie, return the lexicographically smaller movie name.

# Write your MySQL query statement below
(SELECT name AS results
FROM MovieRating JOIN Users USING(user_id)
GROUP BY name
ORDER BY COUNT(*) DESC, name
LIMIT 1)

UNION ALL

(SELECT title AS results
FROM MovieRating JOIN Movies USING(movie_id)
WHERE EXTRACT(YEAR_MONTH FROM created_at) = 202002
GROUP BY title
ORDER BY AVG(rating) DESC, title
LIMIT 1);

-- Compute the moving average of how much the customer paid in a seven days window (i.e., current day + 6 days before). 
SELECT visited_on, amount, ROUND(amount/7, 2) average_amount
FROM (
    SELECT DISTINCT visited_on, 
    SUM(amount) OVER(ORDER BY visited_on RANGE BETWEEN INTERVAL 6 DAY   PRECEDING AND CURRENT ROW) amount, 
    MIN(visited_on) OVER() 1st_date 
    FROM Customer
) t
WHERE visited_on>= 1st_date+6;

--Write a solution to find the people who have the most friends and the most friends number.
SELECT id, COUNT(*) AS num 
FROM (
    SELECT requester_id AS id FROM RequestAccepted
    UNION ALL
    SELECT accepter_id FROM RequestAccepted
) AS friends_count
GROUP BY id
ORDER BY num DESC 
LIMIT 1;

--Write a solution to report the sum of all total investment values in 2016 tiv_2016, for all policyholders who:
-- have the same tiv_2015 value as one or more other policyholders, and
-- are not located in the same city as any other policyholder (i.e., the (lat, lon) attribute pairs must be unique).
select
    round(sum(tiv_2016), 2) as tiv_2016
from
    (
        select
            *
            , count(*) over (partition by tiv_2015) as tiv_2015_cnt
            , count(*) over (partition by lat, lon) as location_cnt
        from
            insurance
    ) t 
where tiv_2015_cnt > 1 and location_cnt = 1

--A company's executives are interested in seeing who earns the most money in each of the company's departments. 
-- A high earner in a department is an employee who has a salary in the top three unique salaries for that department.
SELECT Department, Employee, Salary
FROM (
SELECT Emp.id,Emp.name AS Employee,Emp.salary AS Salary, Dept.name AS Department,
DENSE_RANK() over (PARTITION BY Emp.departmentId ORDER BY Emp.salary DESC) AS Salary_Rank
FROM Employee as Emp LEFT JOIN Department Dept
ON Emp.departmentId = Dept.id)AS TMP
WHERE Salary_Rank <= 3

-- String Manipulation 
-- Write a solution to fix the names so that only the first character is uppercase and the rest are lowercase.
SELECT Users.user_id , CONCAT(UPPER(SUBSTR(Users.name,1,1)),LOWER(SUBSTR(Users.name,2))) AS name 
FROM Users
ORDER BY
Users.user_id ASC

-- Write a solution to find the patient_id, patient_name, and conditions of the patients who have Type I Diabetes. 
-- Type I Diabetes always starts with DIAB1 prefix.
select patient_id,patient_name,conditions from Patients
where conditions like 'DIAB1%'  or  conditions like '% DIAB1%' ;

-- Write a solution to delete all duplicate emails, keeping only one unique email with the smallest id.
delete p1 from person p1,person p2 
where p1.email=p2.email and p1.id>p2.id;

-- nth highest salary
WITH CTE AS
			(SELECT Salary, RANK () OVER (ORDER BY Salary desc) AS RANK_desc
			   FROM Employee)
SELECT MAX(salary) AS SecondHighestSalary
  FROM CTE
 WHERE RANK_desc = 2

-- sell_date  | num_sold | products                     |
+------------+----------+------------------------------+
| 2020-05-30 | 3        | Basketball,Headphone,T-shirt |
| 2020-06-01 | 2        | Bible,Pencil 
       
select sell_date, count( DISTINCT product ) as num_sold ,
GROUP_CONCAT( DISTINCT product order by product ASC separator ',' ) as products
FROM Activities GROUP BY sell_date order by sell_date ASC;

-- Write a solution to get the names of products that have at least 100 units ordered in February 2020 and their amount.
SELECT p.product_name AS product_name, sum(o.unit) AS unit FROM Products p
JOIN Orders o USING (product_id)
WHERE YEAR(o.order_date)='2020' AND MONTH(o.order_date)='02'
GROUP BY p.product_id
HAVING SUM(o.unit)>=100

-- Write a solution to find the users who have valid emails.
SELECT *
FROM Users
WHERE mail REGEXP '^[A-Za-z][A-Za-z0-9_\.\-]*@leetcode(\\?com)?\\.com$';
