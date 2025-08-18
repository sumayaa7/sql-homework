--1.report of all distributors and their sales by region.
select * from #RegionSales

select r.Region, d.Distributor, isnull(s.Sales, 0) as Sales
from (select distinct Region from #RegionSales) r
cross join (select distinct Distributor from #RegionSales) d
left join #RegionSales s
on r.Region = s.Region and d.Distributor = s.Distributor
order by d.Distributor, r.Region

--2.Find managers with at least five direct reports

select * from Employee

select e.name
from Employee e
join Employee sub on e.id = sub.managerId
group by e.id, e.name
having COUNT(sub.id) >= 5

--3.solution to get the names of products that have at least 100 units ordered in February 2020 and their amount
 
select * from Products
select * from Orders



select p.product_name, SUM(o.unit) as unit
from Products p
join Orders o on p.product_id = o.product_id
where o.order_date BETWEEN '2020-02-01' AND '2020-02-29'
group by p.product_name
having SUM(o.unit) >= 100

--4. returns the vendor from which each customer has placed the most orders

select * from Orders

select CustomerID, Vendor
from (
select CustomerID, Vendor,
ROW_NUMBER() OVER (PARTITION BY CustomerID order by COUNT(*) desc) as rn
from Orders
group by CustomerID, Vendor
) t
where rn = 1

--5.
declare @Check_Prime int = 91;
declare @i int = 2, @isPrime bit = 1;

while @i <= SQRT(@Check_Prime)
begin
if @Check_Prime % @i = 0
begin
set @isPrime = 0;
break;
end
set @i += 1;
end

if @isPrime = 1 AND @Check_Prime > 1
print 'This number is prime';
else
print 'This number is not prime';

--6.
CREATE TABLE Device(
  Device_id INT,
  Locations VARCHAR(25)
);
INSERT INTO Device VALUES
(12,'Bangalore'), (12,'Bangalore'), (12,'Bangalore'), (12,'Bangalore'),
(12,'Hosur'), (12,'Hosur'),
(13,'Hyderabad'), (13,'Hyderabad'), (13,'Secunderabad'),
(13,'Secunderabad'), (13,'Secunderabad');

select * from Device

;WITH Ranked AS (
select  Locations, COUNT(*) AS cnt
from Device
group by Locations
)
select Locations, cnt
from Ranked

--7.

select * from Employee

select e.EmpID, e.EmpName, e.Salary
from Employee e
join 
(
select DeptID, AVG(Salary) as avg_sal
from Employee
group by DeptID
) t on e.DeptID = t.DeptID
where e.Salary > t.avg_sal

  --8.
select * from Numbers
select * from Tickets

-- пример: посчитать число совпадений каждого билета
;with Expanded as (
select t.TicketID,
value as num
from Tickets t
cross apply STRING_SPLIT(t.Numbers, ',')
),
Matches as (
select e.TicketID,
       COUNT(*) as match_count
from Expanded e
join WinningNumbers w
on e.num = w.num
group by e.TicketID
)
select TicketID, match_count
from Matches

--9.
select * from Spending

select Spend_date,
case 
when has_mobile = 1 and has_desktop = 1 then 'Both'
when has_mobile = 1 then 'Mobile'
else 'Desktop'
end as Platform,
       SUM(Amount) as Total_Amount,
       COUNT(distinct User_id) as Total_users
from (
select s.User_id, s.Spend_date,
         MAX(case when Platform='Mobile' then 1 else 0 end) as has_mobile,
         MAX(case when Platform='Desktop' then 1 else 0 end) as has_desktop,
         SUM(Amount) as Amount
from Spending s
group by s.User_id, s.Spend_date
) t
group by Spend_date,
case 
when has_mobile = 1 and has_desktop = 1 then 'Both'
when has_mobile = 1 then 'Mobile'
else 'Desktop'
end
order by Spend_date

--10.
select * from Grouped

;with Numbers as (
select 1 as n
union all
select n+1 from Numbers 
where n < (select MAX(Quantity) from Grouped)
)
select g.Product, 1 as Quantity
from Grouped g
join Numbers n on n.n <= g.Quantity
option (MAXRECURSION 0)
