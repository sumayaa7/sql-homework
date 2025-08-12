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

