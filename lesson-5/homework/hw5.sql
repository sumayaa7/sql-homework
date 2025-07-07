1, SELECT ProductName AS Name
FROM Products;

2.SELECT Client.CustomerName
FROM Customers AS Client;

3.SELECT ProductName FROM Products
UNION
SELECT ProductName FROM Products_Discounted;

4. SELECT ProductName FROM Products
INTERSECT
SELECT ProductName FROM Products_Discounted;

5.SELECT DISTINCT CustomerName, Country
FROM Customers;

6. SELECT ProductName,
       Price,
       CASE 
           WHEN Price > 1000 THEN 'High'
           ELSE 'Low'
       END AS PriceCategory
FROM Products;

7.SELECT ProductName,
       StockQuantity,
       IIF(StockQuantity > 100, 'Yes', 'No') AS InStock
FROM Products_Discounted;

8.SELECT ProductName FROM Products
UNION
SELECT ProductName FROM Products_Discounted;


9.SELECT ProductName FROM Products
EXCEPT
SELECT ProductName FROM Products_Discounted;

10. SELECT ProductName,
       Price,
       IIF(Price > 1000, 'Expensive', 'Affordable') AS PriceCategory
FROM Products;

11.SELECT *
FROM Employees
WHERE Age < 25 OR Salary > 60000;

12.UPDATE Employees
SET Salary = Salary * 1.10
WHERE Department = 'HR' OR EmployeeID = 5;

13.SELECT SaleID,
       SaleAmount,
       CASE
           WHEN SaleAmount > 500 THEN 'Top Tier'
           WHEN SaleAmount BETWEEN 200 AND 500 THEN 'Mid Tier'
           ELSE 'Low Tier'
       END AS SaleTier
FROM Sales;

14.SELECT CustomerID
FROM Orders
EXCEPT
SELECT CustomerID
FROM Sales;

  
