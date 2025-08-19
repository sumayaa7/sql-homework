--1.Assign a row number to each sale based on the SaleDate
SELECT SaleID, ProductName, SaleDate, SaleAmount,
ROW_NUMBER() OVER (ORDER BY SaleDate) AS RowNum
FROM ProductSales

--2.Rank products based on the total quantity sold (same rank for ties, без пропусков)
SELECT ProductName,
       SUM(Quantity) AS TotalQuantity,
       DENSE_RANK() OVER (ORDER BY SUM(Quantity) DESC) AS ProductRank
FROM ProductSales
GROUP BY ProductName

--3.Identify the top sale for each customer based on SaleAmount
SELECT * FROM 
(
SELECT CustomerID, SaleID, ProductName, SaleAmount,
       ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY SaleAmount DESC) AS rn
FROM ProductSales
) t
WHERE rn = 1

--4.Each sale amount along with the next sale amount (по дате)
SELECT SaleID, SaleAmount,
       LEAD(SaleAmount) OVER (ORDER BY SaleDate) AS NextSaleAmount
FROM ProductSales

--5.Each sale amount along with the previous sale amount
SELECT SaleID, SaleAmount,
       LAG(SaleAmount) OVER (ORDER BY SaleDate) AS PreviousSaleAmount
FROM ProductSales

--6.Sales amounts greater than the previous sale-----
SELECT SaleID, SaleAmount,
       LAG(SaleAmount) OVER (ORDER BY SaleDate) AS PreviousSaleAmount
FROM ProductSales
WHERE SaleAmount > LAG(SaleAmount) OVER( 
ORDER BY SaleDate
)
--7.Difference in sale amount from the previous sale (по продукту)
SELECT SaleID, ProductName, SaleAmount,
       LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS PrevAmount,
       SaleAmount - LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS DiffFromPrev
FROM ProductSales

--8.Compare current sale with the next in terms of % change
SELECT SaleID, ProductName, SaleAmount,
       LEAD(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS NextAmount,
CASE 
WHEN LEAD(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) IS NULL 
THEN NULL
ELSE ROUND (
            (LEAD(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) - SaleAmount) * 100.0 / SaleAmount, 2
        )
END AS PercentChange
FROM ProductSales

--9.Ratio of current sale to previous sale (в рамках продукта)
SELECT SaleID, ProductName, SaleAmount,
       LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS PrevAmount,
       CAST(SaleAmount AS DECIMAL(10,2)) /
       NULLIF(LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate), 0) AS Ratio
FROM ProductSales

--10.Difference from the very first sale of the product
SELECT SaleID, ProductName, SaleAmount,
       FIRST_VALUE(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS FirstSaleAmount,
       SaleAmount - FIRST_VALUE(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS DiffFromFirst
FROM ProductSales

--11.Find continuously increasing sales for a product
SELECT * FROM 
(
SELECT SaleID, ProductName, SaleAmount,
       LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS PrevAmount
FROM ProductSales
) t
WHERE SaleAmount > PrevAmount

--12.Running total ("closing balance") of sales amounts
SELECT SaleID, ProductName, SaleDate, SaleAmount,
       SUM(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RunningTotal
FROM ProductSales

--13.Moving average (3 последних продаж)
SELECT SaleID, ProductName, SaleAmount,
       AVG(SaleAmount) OVER (
       PARTITION BY ProductName 
       ORDER BY SaleDate 
       ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
) AS MovingAvg3
FROM ProductSales

--14.Difference between each sale and the average sale amount
SELECT SaleID, ProductName, SaleAmount, SaleAmount - AVG(SaleAmount) OVER () AS DiffFromAvg
FROM ProductSales

--15.Find employees who have the same salary rank
;WITH SalaryRanks AS (
SELECT EmployeeID, Name, Department, Salary,
       DENSE_RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
FROM Employees1
)
SELECT * FROM SalaryRanks
WHERE SalaryRank IN 
(
SELECT SalaryRank
FROM SalaryRanks
GROUP BY SalaryRank
HAVING COUNT(*) > 1
)

--16.Identify the Top 2 highest salaries in each department
SELECT * FROM (
SELECT EmployeeID, Name, Department, Salary,
       DENSE_RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) AS rnk
FROM Employees1
) t
WHERE rnk <= 2

--17.Find the lowest-paid employee in each department
SELECT * FROM (
SELECT EmployeeID, Name, Department, Salary,
       ROW_NUMBER() OVER (PARTITION BY Department ORDER BY Salary ASC) AS rnk
FROM Employees1
) t
WHERE rnk = 1

--18.Calculate the running total of salaries in each department
SELECT EmployeeID, Name, Department, Salary,
       SUM(Salary) OVER (PARTITION BY Department ORDER BY Salary) AS RunningTotal
FROM Employees1

--19.Find the total salary of each department without GROUP BY
SELECT DISTINCT Department,
SUM(Salary) OVER (PARTITION BY Department) AS TotalSalary
FROM Employees1

--20.Calculate the average salary in each department without GROUP BY
SELECT DISTINCT Department,
AVG(Salary) OVER (PARTITION BY Department) AS AvgSalary
FROM Employees1

--21.Find the difference between an employee’s salary and their department’s average
SELECT EmployeeID, Name, Department, Salary,
Salary - AVG(Salary) OVER (PARTITION BY Department) AS DiffFromDeptAvg
FROM Employees1

--22.Calculate the moving average salary over 3 employees (previous, current, next)
SELECT EmployeeID, Name, Department, Salary,
AVG(Salary) OVER (ORDER BY EmployeeID ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS MovingAvg
FROM Employees1

--23.Find the sum of salaries for the last 3 hired employees
SELECT SUM(Salary) AS Last3TotalSalary
FROM (
    SELECT TOP 3 Salary
    FROM Employees1
    ORDER BY HireDate DESC
) t
