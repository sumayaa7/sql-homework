 --1.
--2. total sales per employee

select * from Sales
select * from Employees

select e.EmployeeID, es.TotalSales  
from Employees e  
join (  
select EmployeeID, SUM(SalesAmount) as TotalSales  
from Sales  
group by EmployeeID  
) as es on e.EmployeeID = es.EmployeeID

--3. avg salary of emp in CTE
select * from Employees

;with AvgSalaryCTE as (
select AVG(Salary) as AverageSalary
from Employees
)
select e.EmployeeID, e.Salary
from Employees e
cross join AvgSalaryCTE a
where e.Salary > a.AverageSalary

--4. highest sales for each product 

select * from Sales
select * from Products

select p.ProductID, p.ProductName, hs.HighestSales
from Products p
join (
select ProductID, SUM(SalesAmount) as HighestSales
from Sales 
group by ProductID
) as hs on p.ProductID = hs.ProductID 

--5.

--6. get names of emp who made more than 5 sales CTE

select * from Sales
select * from Employees 

;with ProductSales as (
 select p.ProductID, p.CategoryID,
 SUM(s.SalesAmount) as TotalSales
 from Products p
 join Sales s 
 on p.ProductID = s.ProductID
 group by p.ProductID, p.CategoryID
)
select ps.ProductID, ps.CategoryID, ps.TotalSales
from ProductSales ps
where ps.TotalSales > 500

--7. all products with sales > $500

select * from Sales
select * from Employees

;with ProductSales as (
select s.ProductID,
SUM(s.SalesAmount) as TotalSales
from Sales s
group by s.ProductID
)
select p.ProductName, ps.TotalSales
from ProductSales ps
join Products p on p.ProductID = ps.ProductID
where ps.TotalSales > 500


--8. emp with AvgSalary 

select * from Employees

;with AvgSalary as (
select AVG(Salary) as AvgSal 
from Employees
)
select * from Employees
where Salary > (select AvgSal from AvgSalary)

--9.

select * from Employees
select * from Sales

select  top 5 e.FirstName, e.LastName, OrderCount
from 
(
select EmployeeID, COUNT(*) as OrderCount
from Sales
group by EmployeeID
) as SalesCount
join Employees e on e.EmployeeID = SalesCount.EmployeeID
order by OrderCount desc

--10.

select * from Sales
select * from Products

select p.CategoryID, SUM(s.SalesAmount) as TotalSales
from Sales s
join 
(
select ProductID, CategoryID
from Products
) as p on s.ProductID = p.ProductID
group by p.CategoryID

--11.Factorial of each value in Numbers1

select * from Numbers1

;with FactorialCTE as (
select Number as N, Number as Curr, 1 as Result
from Numbers1
union all
select f.N, f.Curr - 1, f.Result * (f.Curr)
from FactorialCTE f
where f.Curr > 1
)
select N as Number, MAX(Result) as Factorial
from FactorialCTE
group by N
order by N

--12.Split string into rows

select * from Example

;with SplitCTE as (
select Id, String, 1 as Pos, SUBSTRING(String, 1, 1) as Ch
from Example
union all
select Id, String, Pos + 1, SUBSTRING(String, Pos + 1, 1)
from SplitCTE
where Pos < LEN(String)
)
select Id, Ch
from SplitCTE
order by Id, Pos

--13. Sales difference (current month vs previous month)

select * from Sales

;with MonthlySales as (
select YEAR(SaleDate) as yr, MONTH(SaleDate) as mm, SUM(SalesAmount) as TotalSales
from Sales
group by YEAR(SaleDate), MONTH(SaleDate)
),
DiffCTE as (
select yr, mm, TotalSales,
LAG(TotalSales) OVER (order by yr, mm) AS PrevMonthSales
from MonthlySales
)
select yr, mm, TotalSales, PrevMonthSales,
       TotalSales - ISNULL(PrevMonthSales,0) AS SalesDiff
from DiffCTE

--14. Employees with sales > 45000

select * from Sales
select *from Employees

select e.EmployeeID, e.FirstName, e.LastName, s.yr, s.Quarter, s.TotalSales
from Employees e
join (
select  EmployeeID, YEAR(SaleDate) as yr, DATEPART(QUARTER, SaleDate) as Quarter,
        SUM(SalesAmount) as TotalSales
from Sales
group by EmployeeID, YEAR(SaleDate), DATEPART(QUARTER, SaleDate)
) s on e.EmployeeID = s.EmployeeID
where s.TotalSales > 45000
order by yr, Quarter, TotalSales desc


--15. Fibonacci numbers
;with Fibonacci (n, a, b) as (
select 1, 0, 1
union all
select n+1, b, a+b
from Fibonacci
where n < 15   -- generate first 15 numbers
)
select n, a as FibonacciNumber
from Fibonacci


--16.Find strings where all characters are the same

select * from FindSameCharacters

select Id, Vals
from FindSameCharacters
where Vals is not null
and LEN(Vals) > 1
and LEN(LTRIM(RTRIM(REPLACE(Vals, LEFT(Vals,1), '')))) = 0

--17.Numbers table growing like 1,12,123,...
;with Numbers as (
select  1 as n, CAST('1' as varchar(20)) as Sequence
union all
select n+1, Sequence + CAST(n+1 as varchar(20))
from Numbers
where n < 5
)
select * from Numbers

--18.Employees with most sales in last 6 months

select * from Employees
select * from Sales

select TOP 1 with TIES 
e.EmployeeID, e.FirstName, e.LastName, t.TotalSales
from Employees e
join (
select EmployeeID, SUM(SalesAmount) as TotalSales
from Sales
where SaleDate >= DATEADD(MONTH, -6, GETDATE())
group by EmployeeID
) t on e.EmployeeID = t.EmployeeID
order by t.TotalSales desc

--19.Remove duplicate integers & single digits

select * from RemoveDuplicateIntsFromNames

;with SplitCTE as (
select PawanName, Pawan_slug_name, 1 as Pos,
       SUBSTRING(Pawan_slug_name, 1, 1) as Ch
from RemoveDuplicateIntsFromNames
union all
select PawanName, Pawan_slug_name, Pos + 1,
       SUBSTRING(Pawan_slug_name, Pos + 1, 1)
from SplitCTE
where Pos < LEN(Pawan_slug_name)
),
Filtered as (
select distinct PawanName, Pawan_slug_name, Ch
from SplitCTE
where Ch LIKE '[0-9]' -- только цифры
)
select PawanName, Pawan_slug_name,
       STRING_AGG(Ch, '') as CleanedDigits
from Filtered
group by PawanName, Pawan_slug_name


