1. https://leetcode.com/problems/game-play-analysis-ii/description/

select player_id, device_id
from Activity
where (player_id, event_date) in
    (select player_id, min(event_date)
    from Activity
    group by player_id)
  
with CTE as
    (select player_id, device_id, 
        row_number() over(partition by player_id order by event_date) as rn
    from Activity)

select player_id, device_id
from CTE 
where rn = 1

2. https://leetcode.com/problems/game-play-analysis-iii/description/
select player_id, event_date, 
    sum(games_played) over(partition by player_id order by event_date) as games_played_so_far
from Activity

3. https://leetcode.com/problems/median-employee-salary/description/
with T1 as (
  select id,company,salary, Row_number() over(partition by company order by salary) as rn, count(*) over (partition by company)
  as cc from employee
  )
select id, company,salary from T1 where rn in ((cc+1)DIV 2, (cc+2) DIV 2)

4. https://leetcode.com/problems/find-median-given-frequency-of-numbers/description/
select avg(number)
from (select t.*,
             sum(freq) over (order by number asc) as sum_freq,
             sum(freq) over () as cnt
      from t
     ) t
where cnt <= 2 * sum_freq and
      cnt >= 2 * (sum_freq - freq);

5. https://leetcode.com/problems/winning-candidate/description/
SELECT name
FROM
    Candidate AS c
    LEFT JOIN Vote AS v ON c.id = v.candidateId
GROUP BY c.id
ORDER BY COUNT(1) DESC
LIMIT 1;

6. https://leetcode.com/problems/get-highest-answer-rate-question/description/ 
SELECT question_id AS survey_log
FROM SurveyLog
GROUP BY 1
ORDER BY SUM(action = 'answer') / SUM(action = 'show') DESC, 1
LIMIT 1;

7. https://leetcode.com/problems/find-cumulative-salary-of-an-employee/description/
# Write your MySQL query statement below
WITH
    T AS (
        SELECT
            id,
            month,
            SUM(salary) OVER (
                PARTITION BY id
                ORDER BY month
                RANGE 2 PRECEDING
            ) AS salary,
            RANK() OVER (
                PARTITION BY id
                ORDER BY month DESC
            ) AS rk
        FROM Employee
    )
SELECT id, month, salary
FROM T
WHERE rk > 1
ORDER BY 1, 2 DESC;

8. https://leetcode.com/problems/count-student-number-in-departments/description/
SELECT dept_name, COUNT(student_id) AS student_number
FROM
    Department
    LEFT JOIN Student USING (dept_id)
GROUP BY dept_id
ORDER BY 2 DESC, 1;

9. https://leetcode.com/problems/friend-requests-i-overall-acceptance-rate/description/
SELECT
    ROUND(
        IFNULL(
            (
                SELECT COUNT(DISTINCT requester_id, accepter_id)
                FROM RequestAccepted
            ) / (SELECT COUNT(DISTINCT sender_id, send_to_id) FROM FriendRequest),
            0
        ),
        2
    ) AS accept_rate;

10. https://leetcode.com/problems/consecutive-available-seats/
SELECT DISTINCT a.seat_id
FROM
    Cinema AS a
    JOIN Cinema AS b ON ABS(a.seat_id - b.seat_id) = 1 AND a.free AND b.free
ORDER BY 1;

11. https://leetcode.com/problems/shortest-distance-in-a-plane/
SELECT ROUND(SQRT(POW(p1.x - p2.x, 2) + POW(p1.y - p2.y, 2)), 2) AS shortest
FROM
    Point2D AS p1
    JOIN Point2D AS p2 ON p1.x != p2.x OR p1.y != p2.y
ORDER BY 1
LIMIT 1;

12. https://leetcode.com/problems/shortest-distance-in-a-line/
SELECT MIN(p2.x - p1.x) AS shortest
FROM
    Point AS p1
    JOIN Point AS p2 ON p1.x < p2.x;

13. https://leetcode.com/problems/second-degree-follower/description/
SELECT follower, COUNT(*) AS num
FROM follow 
WHERE follower IN (SELECT followee FROM follow)
GROUP BY follower;

14. https://leetcode.com/problems/average-salary-departments-vs-company/description/
WITH
    t AS (
        SELECT
            DATE_FORMAT(pay_date, '%Y-%m') AS pay_month,
            department_id,
            AVG(amount) OVER (PARTITION BY pay_date) AS company_avg_amount,
            AVG(amount) OVER (PARTITION BY pay_date, department_id) AS department_avg_amount
        FROM
            Salary AS s
            JOIN Employee AS e ON s.employee_id = e.employee_id
    )
SELECT DISTINCT
    pay_month,
    department_id,
    CASE
        WHEN company_avg_amount = department_avg_amount THEN 'same'
        WHEN company_avg_amount < department_avg_amount THEN 'higher'
        ELSE 'lower'
    END AS comparison
FROM t;

15. https://leetcode.com/problems/students-report-by-geography/description/
select America, Asia, Europe from (
select name as America , row_number() over() as index1 from student where continet="America" order by America
left join 
select name as Asia , row_number() over() as index1 from student where continet="Asia" order by Asia
on index1=index2 
left join
select name as Europe , row_number() over() as index1 from student where continet="Europe" order by Europe
index1=index3 
)





