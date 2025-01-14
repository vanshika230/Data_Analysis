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

