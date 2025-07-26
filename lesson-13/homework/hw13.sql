--1.
select
CONCAT(EMPLOYEE_ID, '-', FIRST_NAME, ' ', LAST_NAME)
from Employees  

--2.
select phone_number 
from Employees
update Employees
set phone_number = replace (phone_number, '124', '999');

--3.
select FIRST_NAME, len(FIRST_NAME) as NameLenght
from Employees
where FIRST_NAME like 'A%'or FIRST_NAME like 'J%' or FIRST_NAME like 'M%' 
order by first_name 

--4.
select MANAGER_ID, sum (Salary) as TotalSalary
from Employees  
group by MANAGER_ID

--5.
select Year1, 
max (Max1)
from TestMax as HighestValue 
group by Year1 

--6.
select id, movie, description
from cinema 
where id % 2 = 1 and description <> 'boring'
order by id 

--7.



--8.
select
case  
when ssn is not null then ssn
when passportid  is not null then passportid
when  itin is not null then itin
else null
end as FirstNonNull
from person

--9.
select
left(StudentName, charindex(' ', StudentName) - 1)
 
substring(
StudentName,  
charindex (' ', StudentName) + 1,
charindex (' ', StudentName, charindex(' ', StudentName) + 1) - charindex(' ', StudentName) - 1
  ) as MiddleName
 
right(
StudentName,
len(StudentName) - charindex(' ', StudentName, charindex(' ', StudentName) + 1)
  ) as LastName
from Student

--10.
  select *
from Orders
where DeliveryState = 'TX'
and CustomerID in (
select CustomerID
from Orders
where DeliveryState = 'CA'
)

--11.
select SequenceNumber, string_agg(String, ', ') as ConcatenatedValues
from DMLTable 
group by SequenceNumber

--12.
select *from Employees
where LEN(REPLACE(CONCAT(FIRST_NAME, LAST_NAME), 'a', '')) <=
      LEN(CONCAT(FIRST_NAME, LAST_NAME)) - 3;

--13.


--14.
SELECT 
  JobDescription,
  MAX_BY(SpacemanID, Experience) AS MostExperiencedID,
  MIN_BY(SpacemanID, Experience) AS LeastExperiencedID
FROM Personal
GROUP BY JobDescription;

--15.




