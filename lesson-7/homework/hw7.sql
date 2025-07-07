1. SELECT MIN(Price) AS MinPrice FROM Products;

2.SELECT MAX(Salary) AS MaxSalary FROM Employees;

3. SELECT COUNT(*) AS TotalCustomers FROM Customers;

4.SELECT COUNT(DISTINCT Category) AS UniqueCategories FROM Products;

5.SELECT SUM(Amount) AS TotalSales FROM Sales WHERE ProductID = 7;

6. SELECT AVG(Age) AS AverageAge FROM Employees;

7. SELECT DeptID, COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY DeptID;

8. SELECT Category, MIN(Price) AS MinPrice, MAX(Price) AS MaxPrice
FROM Products
GROUP BY Category;

9. SELECT CustomerID, SUM(Amount) AS TotalSales
FROM Sales
GROUP BY CustomerID;

10. SELECT DeptID
FROM Employees
GROUP BY DeptID
HAVING COUNT(*) > 5;

11. SELECT Category, SUM(Amount) AS TotalSales, AVG(Amount) AS AverageSales
FROM Sales
GROUP BY Category;

12. SELECT COUNT(*) AS HREmployees
FROM Employees
WHERE DeptName = 'HR'; -- or use DeptID if DeptName not available

13. SELECT DeptID, MAX(Salary) AS MaxSalary, MIN(Salary) AS MinSalary
FROM Employees
GROUP BY DeptID;

14. SELECT DeptID, AVG(Salary) AS AvgSalary
FROM Employees
GROUP BY DeptID;

15. SELECT DeptID, AVG(Salary) AS AvgSalary, COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY DeptID;

16.  SELECT Category
FROM Products
GROUP BY Category
HAVING AVG(Price) > 400;

17. SELECT YEAR(SaleDate) AS SaleYear, SUM(Amount) AS TotalSales
FROM Sales
GROUP BY YEAR(SaleDate);

18. SELECT CustomerID
FROM Sales
GROUP BY CustomerID
HAVING COUNT(*) >= 3;

19. SELECT DeptID
FROM Employees
GROUP BY DeptID
HAVING AVG(Salary) > 60000;

20. SELECT Category, AVG(Price) AS AvgPrice
FROM Products
GROUP BY Category
HAVING AVG(Price) > 150;

21. SELECT CustomerID, SUM(Amount) AS TotalSales
FROM Sales
GROUP BY CustomerID
HAVING SUM(Amount) > 1500;

22. SELECT DeptID, SUM(Salary) AS TotalSalary, AVG(Salary) AS AvgSalary
FROM Employees
GROUP BY DeptID
HAVING AVG(Salary) > 65000;

23. SELECT 
  CustomerID,
  SUM(CASE WHEN Freight > 50 THEN Freight ELSE 0 END) AS TotalHighFreight,
  MIN(Freight) AS LeastPurchase
FROM TSQL2012.Sales.Orders
GROUP BY CustomerID;
