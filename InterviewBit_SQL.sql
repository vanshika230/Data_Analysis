1. https://www.interviewbit.com/problems/town-selection/
SELECT * FROM Towns;

2. https://www.interviewbit.com/problems/student-query/
SELECT Name FROM STUDENT WHERE Class=1 AND SubjectCount>3;

3.https://www.interviewbit.com/problems/country-filtration/
SELECT Name from COUNTRY WHERE Code='NA';

4. https://www.interviewbit.com/problems/information-selector/
SELECT Name, Class FROM STUDENTS WHERE Age>15;

5. https://www.interviewbit.com/problems/town-of-threes/
SELECT TownName, Population from TOWNS where ID%3=0;

6. https://www.interviewbit.com/problems/conditional-work/ 
SELECT CASE
WHEN A + B + C = 0 THEN 'Zero'
WHEN A + B + C < 0 THEN 'Negative'
ELSE 'Positive'
END AS A
FROM NUMBERS;

7.https://www.interviewbit.com/problems/role-player/
SELECT CONCAT(Player,"(", LEFT(Role,1),")") as N from GAMERS ORDER BY N;

8. https://www.interviewbit.com/problems/role-counter/
SELECT CONCAT(ROLE, " Count is ", COUNT(Role)) as COUNT from GAMERS GROUP BY Role ORDER BY COUNT(ROLE);

9. https://www.interviewbit.com/problems/vowel-country/
SELECT COUNT(Country) FROM PLACES WHERE (Country LIKE '%a' OR Country LIKE '%e' OR Country LIKE '%i' OR Country LIKE '%o' OR Country LIKE '%u');

10. https://www.interviewbit.com/problems/engineers-joined/
SELECT SUM(ENGINEER.Count) as A FROM ENGINEER INNER JOIN DATA ON ENGINEER.ID = DATA.ID WHERE DATA.Type = 'FrontEnd';

11. https://www.interviewbit.com/problems/many-tables/ 
SELECT SUM(ENGINEER.Count) AS A FROM ENGINEER INNER JOIN DATA ON ENGINEER.ID = DATA.ID GROUP BY DATA.Type ORDER BY DATA.Type;

12. https://www.interviewbit.com/problems/top-performer/
SELECT CASE
    WHEN EVALUATION.Rating >= 6 THEN EMPLOYEE.Name
    ELSE NULL
    END AS Names, EVALUATION.Rating
FROM EMPLOYEE INNER JOIN EVALUATION ON EMPLOYEE.Points BETWEEN EVALUATION.Lower AND EVALUATION.Upper
ORDER BY EVALUATION.Rating DESC, Names ASC;

