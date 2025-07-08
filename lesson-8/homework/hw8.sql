1. 
SELECT Category, COUNT(*) AS TotalProducts
FROM Products
GROUP BY Category;


2. 
SELECT AVG (Price) AS AvgElectronicsPrice
FROM Products
WHERE Category = 'Electronics';


3. 
SELECT * FROM Customers
WHERE City LIKE 'L%';


4.
SELECT ProductName
FROM Products
WHERE ProductName LIKE '%er';


5. 
SELECT * FROM Customers
WHERE Country LIKE '%a';


6. 
SELECT MAX(Price) AS HighestPrice
FROM Products;


7. 
SELECT ProductName, Quantity,
       CASE 
           WHEN Quantity < 30 THEN 'Low Stock'
           ELSE 'Sufficient'
       END AS StockStatus
FROM Products;


8. 
SELECT Country, COUNT(*) AS TotalCustomers
FROM Customers
GROUP BY Country;


9. 
SELECT MIN(Quantity) AS MinQty, MAX(Quantity) AS MaxQty
FROM Orders;


10. 
SELECT DISTINCT o.CustomerID
FROM Orders o
LEFT JOIN Invoices i ON o.OrderID = i.OrderID
WHERE o.OrderDate BETWEEN '2023-01-01' AND '2023-01-31'
  AND i.InvoiceID IS NULL;


11. 
SELECT ProductName FROM Products
UNION ALL
SELECT ProductName FROM Products_Discounted;


12. 
SELECT ProductName FROM Products
UNION
SELECT ProductName FROM Products_Discounted;


13. 
SELECT YEAR(OrderDate) AS OrderYear, AVG(OrderAmount) AS AvgOrderAmount
FROM Orders
GROUP BY YEAR(OrderDate);


14. 
SELECT ProductName, Price,
       CASE
           WHEN Price < 100 THEN 'Low'
           WHEN Price BETWEEN 100 AND 500 THEN 'Mid'
           ELSE 'High'
       END AS PriceGroup
FROM Products;


15. 
SELECT City, 
       [2012], 
       [2013]
INTO Population_Each_Year
FROM (
    SELECT City, Year, Population
    FROM City_Population
) AS SourceTable
PIVOT (
    SUM(Population)
    FOR Year IN ([2012], [2013])
) AS PivotTable;


16. 
SELECT ProductID, SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY ProductID;


17. 
SELECT ProductName
FROM Products
WHERE ProductName LIKE '%oo%';


18. 
SELECT Year,
       [Bektemir],
       [Chilonzor],
       [Yakkasaroy]
INTO Population_Each_City
FROM (
    SELECT City, Year, Population
    FROM City_Population
) AS SourceTable
PIVOT (
    SUM(Population)
    FOR City IN ([Bektemir], [Chilonzor], [Yakkasaroy])
) AS PivotTable;


19. 
SELECT 
    CustomerID, 
    SUM(TotalAmount) AS TotalSpent
FROM 
    Invoices
GROUP BY 
    CustomerID
ORDER BY 
    TotalSpent DESC
LIMIT 3;


20. 
SELECT 
    district_id,
    district_name,
    population,
    year
FROM
    city_population;
SELECT 1 AS district_id, 'Chilonzor' AS district_name, 2500 AS population, '2012' AS year
UNION ALL
SELECT 1, 'Chilonzor', 2800, '2013'
-- And so on for other districts


21. 
SELECT 
    p.ProductName,
    COUNT(s.SaleID) AS TimesSold
FROM 
    Products p
JOIN 
    Sales s ON p.ProductID = s.ProductID
GROUP BY 
    p.ProductName
ORDER BY 
    TimesSold DESC;


22. 
SELECT 'Chilonzor' AS district_name, 2500 AS population, '2012' AS year
UNION ALL
SELECT 'Chilonzor', 2800, '2013'
UNION ALL
SELECT 'Yakkasaroy', 1500, '2012'
UNION ALL
SELECT 'Yakkasaroy', 1900, '2013'
-- Add remaining rows similarly
