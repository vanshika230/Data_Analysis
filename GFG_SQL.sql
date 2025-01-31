SQL BASICS
1. https://www.hackerrank.com/challenges/revising-the-select-query/problem?isFullScreen=true
Select * from CITY where population>100000 AND CountryCode="USA";

2. https://www.hackerrank.com/challenges/revising-the-select-query-2/problem?isFullScreen=true
Select NAME from CITY where population>120000 and countrycode="USA";

3. https://www.hackerrank.com/challenges/select-by-id/problem?isFullScreen=true
Select * from CITY where id=1661;

4. https://www.hackerrank.com/challenges/japanese-cities-attributes/problem?isFullScreen=true
Select * from city where countrycode="jpn";

5. https://www.hackerrank.com/challenges/japanese-cities-name/problem?isFullScreen=true
Select name from city where countrycode="jpn";

6. https://www.hackerrank.com/challenges/weather-observation-station-1/problem?isFullScreen=true
Select city,state from station;

7. https://www.hackerrank.com/challenges/weather-observation-station-3/problem?isFullScreen=true
Select distinct(city) from station where id%2=0;

8. https://www.hackerrank.com/challenges/weather-observation-station-4/problem?isFullScreen=true
Select count(*)-count(distinct(city)) from station;

9. https://www.hackerrank.com/challenges/weather-observation-station-5/problem?isFullScreen=true
SELECT city, Length(City) FROM Station ORDER BY length(city) asc, City asc Limit 1;
SELECT city, Length(City) FROM Station ORDER BY length(city) desc, City asc Limit 1;

10. https://www.hackerrank.com/challenges/weather-observation-station-6/problem?isFullScreen=true
select distinct(city) as list from station where city like 'a%' or city like 'e%' or city like 'i%' or city like 'o%' or city like 'u%';

11. https://www.hackerrank.com/challenges/weather-observation-station-7/problem?isFullScreen=true
select distinct(city) as list from station where city like '%a' or city like '%e' or city like '%i' or city like '%o' or city like '%u';

12. https://www.hackerrank.com/challenges/weather-observation-station-8/problem?isFullScreen=true
select distinct(city) from station where left(city,1) in ('a','e','i','o','u') and right(city,1) in ('a','e','i','o','u');

13. https://www.hackerrank.com/challenges/weather-observation-station-9/problem?isFullScreen=true
select distinct(city) from station where left(city,1) not in ('a','e','i','o','u') ;

14. https://www.hackerrank.com/challenges/weather-observation-station-10/problem?isFullScreen=true
select distinct(city) from station where right(city,1) not in ('a','e','i','o','u') ;

15. https://www.hackerrank.com/challenges/weather-observation-station-11/problem?isFullScreen=true
select distinct(city) from station where left(city,1) not in ('a','e','i','o','u') or right(city,1) not in ('a','e','i','o','u') ;

16. https://www.hackerrank.com/challenges/weather-observation-station-12/problem?isFullScreen=true
select distinct(city) from station where left(city,1) not in ('a','e','i','o','u') and right(city,1) not in ('a','e','i','o','u') ;

17. https://www.hackerrank.com/challenges/more-than-75-marks/problem?isFullScreen=true
Select name from students where marks>75 order by right(name,3),id;

18. https://www.hackerrank.com/challenges/name-of-employees/problem?isFullScreen=true
select name from employee order by name;

19. https://www.hackerrank.com/challenges/salary-of-employees/problem?isFullScreen=true
select name from employee where salary>2000 and months<10 order by employee_id;

20.https://www.hackerrank.com/challenges/what-type-of-triangle/problem?isFullScreen=true
Select CASE WHEN (A=B and B = C) then "Equilateral" WHEN (A+B <= C OR B+C<=A OR C+A<=B) THEN "Not A Triangle" WHEN (A!=b and B!=C AND C!=A) THEN "Scalene" ELSE 'Isosceles' END as Type from Triangles ;

21. https://www.hackerrank.com/challenges/the-pads/problem?isFullScreen=true
  select concat(name,'(',left(occupation,1),')') from occupations order by name; select concat('There are a total of ',count(occupation),' ',lower(occupation),'s.') from occupations group by occupation
order by count(occupation);

22. https://www.hackerrank.com/challenges/revising-aggregations-the-count-function/problem?isFullScreen=true
Select count(*) from city where population>100000;

23. https://www.hackerrank.com/challenges/revising-aggregations-sum/problem?isFullScreen=true
select sum(population) from city where district="California";

24. https://www.hackerrank.com/challenges/revising-aggregations-the-average-function/problem?isFullScreen=true
select avg(population) from city where district="California";

25. https://www.hackerrank.com/challenges/average-population/problem?isFullScreen=true
SELECT FLOOR(AVG(POPULATION)) AS AVG_POPULATION FROM CITY;

26. https://www.hackerrank.com/challenges/japan-population/problem?isFullScreen=true
  Select sum(population) from city where countrycode="jpn";

27. https://www.hackerrank.com/challenges/the-blunder/problem?isFullScreen=true
select Ceil(avg(salary)-AVG(Replace(salary,'0',''))) from Employees

28. https://www.hackerrank.com/challenges/population-density-difference/problem?isFullScreen=true
  Select max(population)-min(population) from city;

29. https://www.hackerrank.com/challenges/earnings-of-employees/problem?isFullScreen=true
  SELECT (salary*months) AS ctc, COUNT(*) FROM employee
GROUP BY ctc
ORDER BY ctc DESC LIMIT 1;

30. https://www.hackerrank.com/challenges/weather-observation-station-2/problem?isFullScreen=true
  Select round(sum(LAT_N),2), round(sum(LONG_W),2) FROM station;

31. https://www.hackerrank.com/challenges/weather-observation-station-13/problem?isFullScreen=true
  Select round(sum(Lat_n),4) from station where lat_n between 38.7880 and 137.2345;

32. https://www.hackerrank.com/challenges/weather-observation-station-14/problem?isFullScreen=true
  select round(max(Lat_n),4)from station where lat_n<137.2345;

33. https://www.hackerrank.com/challenges/weather-observation-station-15/problem?isFullScreen=true
   select round(long_w,4) from station where lat_n = (select max(Lat_n)from station where lat_n<137.2345);

34. https://www.hackerrank.com/challenges/weather-observation-station-16/problem?isFullScreen=true
   select round(min(Lat_n),4)from station where lat_n>38.7780;

35. https://www.hackerrank.com/challenges/weather-observation-station-17/problem?isFullScreen=true
    select round(long_w,4) from station where lat_n= (select min(Lat_n)from station where lat_n>38.7780);

36. https://www.hackerrank.com/challenges/weather-observation-station-18/problem?isFullScreen=true
  with cte as(
select min(lat_n) as a, min(long_w) as b, max(lat_n) as c, max(long_w) as d from station
    )

SELECT ROUND(ABS(c + d) - ABS(a + b),4) FROM CTE;

37. https://www.hackerrank.com/challenges/weather-observation-station-19/problem?isFullScreen=true
   with cte as(
select min(lat_n) as a, min(long_w) as b, max(lat_n) as c, max(long_w) as d from station
    )

SELECT ROUND(SQRT(POWER(b - d, 2) + POWER(a - c, 2)), 4) AS Distance FROM CTE;

38. https://www.hackerrank.com/challenges/asian-population/problem?isFullScreen=true
  select sum(c.population) from city c inner join country co on c.countrycode=co.code where co.continent="asia";

39. https://www.hackerrank.com/challenges/african-cities/problem?isFullScreen=true
  select c.name from city c inner join country co on c.countrycode=co.code where co.continent="africa";

40. https://www.hackerrank.com/challenges/average-population-of-each-continent/problem?isFullScreen=true
select co.continent, floor(avg(c.population)) from city c inner join country co on c.countrycode=co.code group by co.continent;


MEDIUM SQL
1. https://www.hackerrank.com/challenges/the-company/problem?isFullScreen=true
Select c.company_code, c.founder, COUNT(DISTINCT e.lead_manager_code), COUNT(DISTINCT e.senior_manager_code), COUNT(DISTINCT e.manager_code), COUNT(DISTINCT e.employee_code) 
FROM employee e 
INNER JOIN company c 
on c.company_code = e.company_code
GROUP BY c.company_code, c.founder;

2. https://www.hackerrank.com/challenges/the-report/problem?isFullScreen=true
SELECT 
    IF(Grade < 8, NULL,Name), Grade, Marks
FROM Students s JOIN Grades g
ON s.marks BETWEEN g.Min_Mark AND g.Max_Mark
ORDER BY 
        Grade DESC,
    CASE WHEN Grade < 8 THEN  Marks ELSE Name END
  
3. https://www.hackerrank.com/challenges/full-score/problem?isFullScreen=true
SELECT h.hacker_id, h.name FROM hackers h 
JOIN submissions s 
    ON h.hacker_id = s.hacker_id 
JOIN challenges c 
    ON s.challenge_id = c.challenge_id 
JOIN difficulty d 
    ON c.difficulty_level = d.difficulty_level
WHERE s.score = d.score 
GROUP BY h.hacker_id, h.name 
HAVING COUNT(s.challenge_id) > 1 
ORDER BY COUNT(s.challenge_id) DESC, h.hacker_id;

4. 
