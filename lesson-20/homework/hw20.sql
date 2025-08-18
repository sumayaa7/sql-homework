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

--6.
SELECT Name,
ISNULL([Apple], 0)  AS Apple,
ISNULL([Orange], 0) AS Orange,
ISNULL([Banana], 0) AS Banana
FROM 
(
SELECT Name, Fruit
FROM Fruits
) AS Source
PIVOT 
(
COUNT(Fruit)
FOR Fruit IN ([Apple], [Orange], [Banana])
) AS PivotTable

--7.
create table Family(ParentId int, ChildID int)
insert into Family values (1, 2), (2, 3), (3, 4)
select * from Family

-- если перед этим был другой оператор, начни CTE с ;  (важно для T-SQL)
;WITH FamilyTree AS (
    -- якорь: прямые связи родитель -> ребёнок
SELECT ParentId, ChildID
FROM dbo.Family
UNION ALL

    -- рекурсия: находим потомков дальше по цепочке
SELECT f.ParentId, ft.ChildID
FROM dbo.Family AS f
JOIN FamilyTree AS ft
ON f.ChildID = ft.ParentId
)
SELECT ParentId AS PID, ChildID AS CHID
FROM FamilyTree
GROUP BY ParentId, ChildID          -- на всякий случай убираем дубликаты
ORDER BY PID, CHID
OPTION (MAXRECURSION 100);           -- чтоб избежать бесконечных циклов

--8.
SELECT o.CustomerID, o.OrderID, o.DeliveryState, o.Amount
FROM #Orders o
WHERE o.DeliveryState = 'TX'
AND EXISTS (
SELECT 1
FROM #Orders c
WHERE c.CustomerID = o.CustomerID
AND c.DeliveryState = 'CA'
)

--9.
UPDATE #residents
SET address = 
CASE 
WHEN address NOT LIKE '%name=%' 
THEN address + ' name=' + fullname
ELSE address
END
select  * from #residents

--10.
;WITH RoutePaths AS (
    -- стартуем из Ташкента
SELECT RouteID, DepartureCity, ArrivalCity,Cost,
CAST(DepartureCity + ' -> ' + ArrivalCity AS VARCHAR(MAX)) AS Path
FROM #Routes
WHERE DepartureCity = 'Tashkent'
UNION ALL
    -- продолжаем строить маршрут
SELECT r.RouteID, rp.DepartureCity, r.ArrivalCity, rp.Cost + r.Cost,
CAST(rp.Path + ' -> ' + r.ArrivalCity AS VARCHAR(MAX))
FROM RoutePaths rp
JOIN #Routes r ON rp.ArrivalCity = r.DepartureCity
WHERE rp.ArrivalCity <> 'Khorezm'
),
Cheapest AS 
(
SELECT TOP 1 'Cheapest' AS RouteType, Path, Cost
FROM RoutePaths
WHERE ArrivalCity = 'Khorezm'
ORDER BY Cost ASC
),
MostExpensive AS 
(
SELECT TOP 1 'Most Expensive' AS RouteType, Path, Cost
FROM RoutePaths
WHERE ArrivalCity = 'Khorezm'
ORDER BY Cost DESC
)
SELECT * FROM Cheapest
UNION ALL
SELECT * FROM MostExpensive

