--1.
SELECT Id, Dt,
FORMAT(Dt, 'MM') AS MonthPrefixedWithZero
FROM Dates

--2.
SELECT 
COUNT(DISTINCT Id) AS Distinct_Ids, rID,
SUM(MaxVals) AS TotalOfMaxVals
FROM (
SELECT Id, rID,
MAX(Vals) AS MaxVals
FROM MyTabel
GROUP BY Id, rID
) t
GROUP BY rID

--3.
SELECT Id, Vals
FROM TestFixLengths
WHERE LEN(Vals) BETWEEN 6 AND 10

CREATE TABLE TestMaximum (
    ID INT,
    Item VARCHAR(20),
    Vals INT
);


--4.
;WITH Ranked AS (
SELECT ID,Item,Vals,
ROW_NUMBER() OVER (PARTITION BY ID ORDER BY Vals DESC) AS rn
FROM TestMaximum
)
SELECT ID, Item, Vals
FROM Ranked
WHERE rn = 1
ORDER BY ID

--5.
SELECT Id, SUM(MaxVal) AS SumOfMax
FROM (
SELECT Id, DetailedNumber, MAX(Vals) AS MaxVal
FROM SumOfMax
GROUP BY Id, DetailedNumber
) t
GROUP BY Id

--6.
SELECT Id, a, b, 
NULLIF(a - b, 0) AS Output
FROM TheZeroPuzzle

--7.Total revenue generated from all sales

SELECT SUM(QuantitySold * UnitPrice) AS TotalRevenue
FROM Sales


--8.Average unit price of products

SELECT AVG(UnitPrice) AS AvgUnitPrice
FROM Sales


--9.Number of sales transactions recorded

SELECT COUNT(*) AS TotalTransactions
FROM Sales


--10.Highest number of units sold in a single transaction

SELECT MAX(QuantitySold) AS MaxUnits
FROM Sales


--11.Number of products sold in each category

SELECT Category, SUM(QuantitySold) AS TotalUnits
FROM Sales
GROUP BY Category


--12.Total revenue for each region

SELECT Region, SUM(QuantitySold * UnitPrice) AS RegionRevenue
FROM Sales
GROUP BY Region


--13.Product generating the highest total revenue

SELECT TOP 1 Product, SUM(QuantitySold * UnitPrice) AS ProductRevenue
FROM Sales
GROUP BY Product
ORDER BY ProductRevenue DESC


--14.Running total of revenue by sale date

SELECT SaleDate,
SUM(QuantitySold * UnitPrice) OVER (ORDER BY SaleDate) AS RunningRevenue
FROM Sales


--15.Category contribution to total revenue

SELECT Category,
SUM(QuantitySold * UnitPrice) AS CategoryRevenue,
CAST(SUM(QuantitySold * UnitPrice) * 100.0 / SUM(SUM(QuantitySold * UnitPrice)) OVER () AS DECIMAL(10,2)) AS ContributionPercent
FROM Sales
GROUP BY Category


--16.Customers Table Queries

--All sales with customer names

SELECT s.SaleID, s.Product, s.QuantitySold, s.UnitPrice, s.SaleDate, 
       c.CustomerName, c.Region
FROM Sales s
JOIN Customers c ON s.CustomerID = c.CustomerID


--17.Customers with no purchases

SELECT c.CustomerID, c.CustomerName
FROM Customers c
LEFT JOIN Sales s ON c.CustomerID = s.CustomerID
WHERE s.CustomerID IS NULL


--18.Total revenue from each customer

SELECT c.CustomerID, c.CustomerName, SUM(s.QuantitySold * s.UnitPrice) AS CustomerRevenue
FROM Customers c
JOIN Sales s ON c.CustomerID = s.CustomerID
GROUP BY c.CustomerID, c.CustomerName


--19.Customer who contributed most revenue

SELECT TOP 1 c.CustomerID, c.CustomerName, SUM(s.QuantitySold * s.UnitPrice) AS CustomerRevenue
FROM Customers c
JOIN Sales s ON c.CustomerID = s.CustomerID
GROUP BY c.CustomerID, c.CustomerName
ORDER BY CustomerRevenue DESC


--20.Total sales per customer

SELECT c.CustomerID, c.CustomerName, COUNT(s.SaleID) AS TotalSales
FROM Customers c
LEFT JOIN Sales s ON c.CustomerID = s.CustomerID
GROUP BY c.CustomerID, c.CustomerName

--21.Products Table Queries

--Products sold at least once

SELECT DISTINCT p.ProductID, p.ProductName
FROM Products p
JOIN Sales s ON p.ProductName = s.Product


--22.Most expensive product

SELECT TOP 1 ProductID, ProductName, SellingPrice
FROM Products
ORDER BY SellingPrice DESC


--23.Products with selling price > avg in their category

SELECT p.*
FROM Products p
JOIN (
    SELECT Category, AVG(SellingPrice) AS AvgPrice
    FROM Products
    GROUP BY Category
) a ON p.Category = a.Category
WHERE p.SellingPrice > a.AvgPrice
