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
select teacher_id, count(distinct(subject_id)) as cnt from teacher group by teacher_id;

-- 
