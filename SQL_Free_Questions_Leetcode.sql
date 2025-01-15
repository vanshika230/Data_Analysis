-- Find the names of the customer that are not referred by the customer with id = 2.
select name from Customer where referee_id!=2 or referee_id is null;

-- nth highest salary
SELECT Salary 
    FROM (
      SELECT Salary, DENSE_RANK() OVER (ORDER BY Salary DESC) AS ranking
      FROM Employee
    ) AS ranked_salaries
    WHERE ranking = N
    LIMIT 1

-- rank score
SELECT score, DENSE_RANK() OVER(ORDER BY score DESC) as 'rank'
FROM scores

-- customers who never order
SELECT name as Customers
from Customers
where id not in (
    select customerId
    from Orders
);

-- department highest salary
with new as
(select *, dense_rank() over(partition by departmentId order by salary desc) as rn from employee)

select d.name as department, new.name as employee , salary from new
join department d on d.id=new.departmentId
where rn=1

-- Combine two table
select p.firstName, p.lastName, a.city, a.state from person p left join address a on p.personId=a.personId;

-- find duplicate emails
select email from person group by email having count(email)>1 ;

-- find top traveller dec distance asc name
select u.name, if(sum(r.distance) is null, 0, sum(r.distance)) as travelled_distance
from Users u
left join Rides r on u.id = r.user_id
group by u.id
order by travelled_distance desc ,u.name 

-- month ko col mein dikha do
SELECT 
    id, 
    sum( if( month = 'Jan', revenue, null ) ) AS Jan_Revenue,
    sum( if( month = 'Feb', revenue, null ) ) AS Feb_Revenue,
    sum( if( month = 'Mar', revenue, null ) ) AS Mar_Revenue,
    sum( if( month = 'Apr', revenue, null ) ) AS Apr_Revenue,
    sum( if( month = 'May', revenue, null ) ) AS May_Revenue,
    sum( if( month = 'Jun', revenue, null ) ) AS Jun_Revenue,
    sum( if( month = 'Jul', revenue, null ) ) AS Jul_Revenue,
    sum( if( month = 'Aug', revenue, null ) ) AS Aug_Revenue,
    sum( if( month = 'Sep', revenue, null ) ) AS Sep_Revenue,
    sum( if( month = 'Oct', revenue, null ) ) AS Oct_Revenue,
    sum( if( month = 'Nov', revenue, null ) ) AS Nov_Revenue,
    sum( if( month = 'Dec', revenue, null ) ) AS Dec_Revenue
FROM 
    Department
GROUP BY 
    id;

-- Write a solution to report the products that were only sold in the first quarter of 2019. That is, between 2019-01-01 and 2019-03-31 inclusive.
-- Wherever you are given a range, keep MIN() and MAX() in mind
SELECT Product.product_id, Product.product_name FROM Product 
JOIN Sales 
ON Product.product_id = Sales.product_id 
GROUP BY Sales.product_id 
HAVING MIN(Sales.sale_date) >= "2019-01-01" AND MAX(Sales.sale_date) <= "2019-03-31";

-- Write a solution to find the first login date for each player.
select player_id, min(event_date) as first_login from activity group by player_id;

-- re arrange product table
SELECT product_id, 'store1' AS store, store1 AS price 
FROM Products 
WHERE store1 IS NOT NULL
UNION 
SELECT product_id, 'store2', store2 
FROM Products 
WHERE store2 IS NOT NULL
UNION 
SELECT product_id, 'store3', store3 
FROM Products 
WHERE store3 IS NOT NULL

-- For each date_id and make_name, find the number of distinct lead_id's and distinct partner_id's.
select date_id, make_name , count(distinct(lead_id)) as unique_leads, count(distinct(partner_id)) as unique_partners from DailySales GROUP BY date_id, make_name;

-- Write a solution to report the IDs of all the employees with missing information. The information of an employee is missing if:
-- The employee's name is missing, or
-- The employee's salary is missing.
-- Return the result table ordered by employee_id in ascending order.
(
SELECT e.employee_id 
FROM Employees e  
LEFT  JOIN  salaries s on s.employee_id = e.employee_id
WHERE s.employee_id is null
UNION
SELECT s.employee_id 
FROM Employees e  
Right JOIN  salaries s on s.employee_id = e.employee_id
WHERE e.employee_id is null
)
ORDER BY employee_id ASC

-- Write a solution to report the name and balance of users with a balance higher than 10000. The balance of an account is equal to the sum of the amounts of all transactions involving that account
select u.name , sum(t.amount) as balance from users u inner join transactions t on u.account=t.account group by name having balance>10000;

-- Write a solution to find the names of all the salespersons who did not have any orders related to the company with the name "RED".
SELECT sp.name
FROM SalesPerson sp
WHERE sp.name NOT IN(
    SELECT sp.name
    FROM SalesPerson sp
        LEFT JOIN Orders o ON sp.sales_id = o.sales_id
        LEFT JOIN Company c ON o.com_id = c.com_id
    WHERE c.name = 'Red'
);

-- Write a solution to calculate the total time in minutes spent by each employee on each day at the office. 
-- Note that within one day, an employee can enter and leave more than once. The time spent in the office for a single entry is out_time - in_time.
select event_day as day, emp_id, sum(out_time-in_time) as total_time from employees group by emp_id, event_day;

-- Write a solution to calculate the bonus of each employee. 
-- The bonus of an employee is 100% of their salary if the ID of the employee is an odd number and the employee's name does not start with the character 'M'. The bonus of an employee is 0 otherwise.
SELECT employee_id, IF(name NOT LIKE "M%" AND employee_id%2 <> 0, salary, 0) AS bonus 
FROM Employees
ORDER BY employee_id

-- Write a solution to find all the pairs (actor_id, director_id) where the actor has cooperated with the director at least three times.
select actor_id,director_id
from ActorDirector 
group by actor_id,director_id
Having count(timestamp)>=3;

-- Write a solution to swap all 'f' and 'm' values (i.e., change all 'f' values to 'm' and vice versa) with a single update statement and no intermediate temporary tables.
UPDATE salary SET sex =
CASE sex
    WHEN 'm' THEN 'f'
    ELSE 'm'
END;

--Write a solution to find for each user, the join date and the number of orders they made as a buyer in 2019.
SELECT u.user_id as buyer_id, u.join_date, count(o.order_id) as 'orders_in_2019'
FROM users u
LEFT JOIN Orders o
ON o.buyer_id=u.user_id AND YEAR(order_date)='2019'
GROUP BY u.user_id

-- Write a solution to report the Capital gain/loss for each stock.
--The Capital gain/loss of a stock is the total gain or loss after buying and selling the stock one or many times.
select stock_name
, sum(if(operation = 'Buy', -1, 1) * price) as capital_gain_loss
from stocks
group by stock_name

-- Write a solution to report the latest login for all users in the year 2020. Do not include the users who did not login in 2020.
select user_id, max(time_stamp) as last_stamp from logins where year(time_Stamp)='2020' group by user_id ;

-- Write a solution to find the customer_number for the customer who has placed the largest number of orders.
select customer_number from orders group by customer_number order by count(order_number) desc limit 1;

-- Write a solution to report the type of each node in the tree.
SELECT id, CASE WHEN p_id IS NULL THEN 'Root'
                WHEN id IN (SELECT DISTINCT p_id FROM Tree) THEN 'Inner'
                ELSE 'Leaf'
            END AS type
FROM Tree

-- Write a solution to find the cancellation rate of requests with unbanned users (both client and driver must not be banned) each day between "2013-10-01" and "2013-10-03". Round Cancellation Rate to two decimal points.
SELECT
    T.request_at AS 'Day',
    ROUND(
        1-( SUM(T.status='completed')/COUNT(T.id) )
    ,2) AS 'Cancellation Rate'
FROM Trips T JOIN Users C 
    ON T.client_id=C.users_id
JOIN Users D 
    ON T.driver_id=D.users_id
WHERE D.banned='No' AND C.banned='No'
GROUP BY T.request_at
HAVING T.request_at BETWEEN "2013-10-01" AND "2013-10-03"

-- Human traffic if stadium>100  over 3 consecutive rows
with q1 as (
select *, 
     count(*) over( order by id range between current row and 2 following ) following_cnt,
     count(*) over( order by id range between 2 preceding and current row ) preceding_cnt,
     count(*) over( order by id range between 1 preceding and 1 following ) current_cnt
from stadium
where people > 99
)
select id, visit_date, people
from q1
where following_cnt = 3 or preceding_cnt = 3 or current_cnt = 3
order by visit_date

SELECT ID
    , visit_date
    , people
FROM (
    SELECT ID
        , visit_date
        , people
        , LEAD(people, 1) OVER (ORDER BY id) nxt
        , LEAD(people, 2) OVER (ORDER BY id) nxt2
        , LAG(people, 1) OVER (ORDER BY id) pre
        , LAG(people, 2) OVER (ORDER BY id) pre2
    FROM Stadium
) cte 
WHERE (cte.people >= 100 AND cte.nxt >= 100 AND cte.nxt2 >= 100) 
    OR (cte.people >= 100 AND cte.nxt >= 100 AND cte.pre >= 100)  
    OR (cte.people >= 100 AND cte.pre >= 100 AND cte.pre2 >= 100) 
