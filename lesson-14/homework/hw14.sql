--1.
SELECT Id,
LTRIM(RTRIM(SUBSTRING(Name, 1, CHARINDEX(',', Name) - 1))) AS FirstName,
LTRIM(RTRIM(SUBSTRING(Name, CHARINDEX(',', Name) + 1, LEN(Name)))) AS LastName
FROM TestMultipleColumns

--2.
select * from TestPercent
WHERE Strs LIKE '%[%]%'

--3.
SELECT Vals,
LEN(Vals) - LEN(REPLACE(Vals, '.', '')) + 1 AS PartCount
FROM Splitter

--4.


--5.
SELECT * FROM testDots
WHERE LEN(Vals) - LEN(REPLACE(Vals, '.', '')) > 2

--6.
SELECT texts,
LEN(texts) - LEN(REPLACE(texts, ' ', '')) AS SpaceCount
FROM CountSpaces

--7.
SELECT e.Id,
e.Name AS EmployeeName,
e.Salary AS EmployeeSalary,
m.Id AS ManagerId,
m.Name AS ManagerName,
m.Salary AS ManagerSalary
FROM Employee e
JOIN Employee m
ON e.ManagerId = m.Id
WHERE e.Salary > m.Salary

--8.
SELECT 
EMPLOYEE_ID,
FIRST_NAME,
LAST_NAME,
HIRE_DATE,
DATEDIFF(YEAR, HIRE_DATE, GETDATE()) AS YearsOfService
FROM Employees
WHERE DATEDIFF(YEAR, HIRE_DATE, GETDATE()) > 10
AND DATEDIFF(YEAR, HIRE_DATE, GETDATE()) < 15

--9.
--10.
SELECT w1.id
FROM Weather w1
JOIN Weather w2
ON DATEDIFF (DAY, w1.RecordDate, w2.RecordDate) = 1
WHERE w1.Temperature > w2.Temperature

--11.
SELECT player_id,
MIN(event_date) AS first_event_date
FROM Activity
GROUP BY player_id

--12.
SELECT fruit_list,
PARSENAME(REPLACE(fruit_list, ',', '.'), 1) AS third_fruit
FROM fruits

--13.
SELECT p1.id,
CASE
WHEN p1.code = 0 then p2.code
ELSE p1.code
END AS final_code
FROM p1
JOIN p2 on p1.id = p2.id 

--14.
--15.
SELECT
EMPLOYEE_ID,
FIRST_NAME,
HIRE_DATE,
DATEDIFF(YEAR, HIRE_DATE, GETDATE()) AS years_worked,
CASE
WHEN DATEDIFF(YEAR, hire_date, GETDATE()) < 1 THEN 'New Hire'
WHEN DATEDIFF(YEAR, hire_date, GETDATE()) BETWEEN 1 AND 5 THEN 'Junior'
WHEN DATEDIFF(YEAR, hire_date, GETDATE()) BETWEEN 6 AND 10 THEN 'Mid-Level'
WHEN DATEDIFF(YEAR, hire_date, GETDATE()) BETWEEN 11 AND 20 THEN 'Senior'
ELSE 'Veteran'
END AS employment_stage
FROM Employees

--16.
SELECT Vals,
LEFT(Vals, PATINDEX('%[^0-9]%', Vals + 'a') - 1) AS ExtractedInt
FROM GetIntegers
WHERE Vals LIKE '[0-9]%'

--17.
SELECT Vals,  
LEFT(Vals, CHARINDEX(',', Vals) - 1) AS FirstPart,

SUBSTRING(
Vals,
CHARINDEX(',', Vals) + 1,
CHARINDEX(',', Vals, CHARINDEX(',', Vals) + 1) - CHARINDEX(',', Vals) - 1
) AS SecondPart,

SUBSTRING(
Vals,
CHARINDEX(',', Vals, CHARINDEX(',', Vals) + 1) + 1,
LEN(Vals)
) AS RemainingPart,

CONCAT(
SUBSTRING(
Vals,
CHARINDEX(',', Vals) + 1,
CHARINDEX(',', Vals, CHARINDEX(',', Vals) + 1) - CHARINDEX(',', Vals) - 1), ',',  

LEFT(Vals, CHARINDEX(',', Vals) - 1), ',', 

SUBSTRING(
Vals,
CHARINDEX(',', Vals, CHARINDEX(',', Vals) + 1),
LEN(Vals))
) AS Swapped
FROM MultipleVals

--18.
SELECT a.player_id, a.device_id
FROM Activity a
JOIN (
SELECT player_id, MIN(event_date) AS first_login
FROM Activity
GROUP BY player_id
) firsts
ON a.player_id = firsts.player_id
AND a.event_date = firsts.first_login

--19.




