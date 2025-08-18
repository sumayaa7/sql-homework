--1.Customers who purchased at least one item in March 2024
SELECT DISTINCT s1.CustomerName
FROM #Sales s1
WHERE EXISTS (
SELECT 1
FROM #Sales s2
WHERE s2.CustomerName = s1.CustomerName
AND s2.SaleDate >= '2024-03-01'
AND s2.SaleDate < '2024-04-01'
)

--2. Product with the highest total sales revenue
SELECT Product, SUM(Quantity * Price) AS TotalRevenue
FROM #Sales
GROUP BY Product
HAVING SUM(Quantity * Price) = 
(
SELECT MAX(TotalRev)
FROM (
SELECT SUM(Quantity * Price) AS TotalRev
FROM #Sales
GROUP BY Product
    ) AS t
)

--3. Second highest sale amount
SELECT MAX(SaleAmount) AS SecondHighestSale
FROM (
SELECT Quantity * Price AS SaleAmount
FROM #Sales
) AS t
WHERE SaleAmount < (
SELECT MAX(Quantity * Price)
FROM #Sales
)


--4.Total quantity of products sold per month
SELECT FORMAT(SaleDate, 'yyyy-MM') AS SaleMonth,
(
SELECT SUM(s2.Quantity)
FROM #Sales s2
WHERE FORMAT(s2.SaleDate, 'yyyy-MM') = FORMAT(s1.SaleDate, 'yyyy-MM')
) AS TotalQuantity
FROM #Sales s1
GROUP BY FORMAT(SaleDate, 'yyyy-MM')

--5.Customers who bought the same products as another customer
SELECT DISTINCT s1.CustomerName
FROM #Sales s1
WHERE EXISTS 
(
SELECT 1
FROM #Sales s2
WHERE s2.CustomerName <> s1.CustomerName
AND s2.Product = s1.Product
)
