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
