--1.
GO
CREATE OR ALTER PROCEDURE sp_GetEmployeeBonus
AS
BEGIN
    -- Создание временной таблицы
CREATE TABLE #EmployeeBonus (
EmployeeID INT,
FullName NVARCHAR(120),
Department NVARCHAR(50),
Salary DECIMAL(10,2),
BonusAmount DECIMAL(10,2)
);

    -- Заполнение временной таблицы
INSERT INTO #EmployeeBonus (EmployeeID, FullName, Department, Salary, BonusAmount)
SELECT e.EmployeeID, e.FirstName + ' ' + e.LastName AS FullName, e.Department, e.Salary,
       e.Salary * db.BonusPercentage / 100 AS BonusAmount
FROM Employees e
JOIN DepartmentBonus db ON e.Department = db.Department;

    -- Вывод результата
SELECT * FROM #EmployeeBonus;
END

--2.
GO
CREATE OR ALTER PROCEDURE sp_UpdateSalaryByDepartment_V2 
@DeptName NVARCHAR(50),
@IncreasePct DECIMAL(5,2)
AS
BEGIN
UPDATE Employees
SET Salary = Salary + (Salary * @IncreasePct / 100)
OUTPUT inserted.*
WHERE Department = @DeptName;
END

--3.
MERGE Products_Current AS target
USING Products_New AS source
ON target.ProductID = source.ProductID

-- обновление если есть совпадение
WHEN MATCHED THEN
UPDATE SET 
target.ProductName = source.ProductName,
target.Price = source.Price

-- вставка если в Current нет продукта
WHEN NOT MATCHED BY TARGET THEN
INSERT (ProductID, ProductName, Price)
VALUES (source.ProductID, source.ProductName, source.Price)

-- удаление если в New нет продукта
WHEN NOT MATCHED BY SOURCE THEN
DELETE;

-- возвращаем итог
SELECT * FROM Products_Current

--4.
SELECT t.id,
CASE
WHEN t.p_id IS NULL THEN 'Root'
WHEN EXISTS (SELECT 1 FROM Tree WHERE p_id = t.id) THEN 'Inner'
ELSE 'Leaf'
END AS type
FROM Tree t
ORDER BY t.id

--6.
SELECT id, name, salary
FROM employees
WHERE salary = (SELECT MIN(salary) FROM employees)
