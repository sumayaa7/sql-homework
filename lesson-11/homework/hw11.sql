1. 
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    Country VARCHAR(50)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

SELECT 
    o.OrderID, 
    c.CustomerName, 
    o.OrderDate
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE o.OrderDate > '2022-12-31';

2.
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100)
);

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(100),
    DepartmentID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

SELECT 
    e.EmployeeName, 
    d.DepartmentName
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName IN ('Sales', 'Marketing');

3.
SELECT 
    d.DepartmentName, 
    MAX(e.Salary) AS MaxSalary
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName;

4.
SELECT 
    c.CustomerName, 
    o.OrderID, 
    o.OrderDate
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE c.Country = 'USA'
  AND  (YEAR FROM o.OrderDate) = 2023;

5.
SELECT 
    c.CustomerName, 
    COUNT(o.OrderID) AS TotalOrders
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerName;

6.
CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY,
    SupplierName VARCHAR(100)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    SupplierID INT,
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);

SELECT 
    p.ProductName, 
    s.SupplierName
FROM Products p
JOIN Suppliers s ON p.SupplierID = s.SupplierID
WHERE s.SupplierName IN ('Gadget Supplies', 'Clothing Mart');

7.
SELECT 
    c.CustomerName, 
    MAX(o.OrderDate) AS MostRecentOrderDate
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerName;

8.
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderTotal DECIMAL(10, 2),
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

SELECT 
    c.CustomerName, 
    o.OrderTotal
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE o.OrderTotal > 500;

9.
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100)
);

CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    ProductID INT,
    SaleDate DATE,
    SaleAmount DECIMAL(10, 2),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

SELECT 
    p.ProductName, 
    s.SaleDate, 
    s.SaleAmount
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
WHERE EXTRACT(YEAR FROM s.SaleDate) = 2022
   OR s.SaleAmount > 400;

10.
SELECT 
    p.ProductName, 
    SUM(s.SaleAmount) AS TotalSalesAmount
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
GROUP BY p.ProductName;

11.
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100)
);

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(100),
    DepartmentID INT,
    Salary DECIMAL(10, 2),
    HireDate DATE,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

SELECT 
    e.EmployeeName, 
    d.DepartmentName, 
    e.Salary
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'HR'
  AND e.Salary > 60000;

12.
SELECT 
    p.ProductName, 
    s.SaleDate, 
    s.StockQuantity
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
WHERE EXTRACT(YEAR FROM s.SaleDate) = 2023
  AND s.StockQuantity > 100;

13.
SELECT 
    e.EmployeeName, 
    d.DepartmentName, 
    e.HireDate
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Sales'
   OR e.HireDate > '2020-12-31';

14.
SELECT 
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    o.OrderID,
    c.Address,
    o.OrderDate
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE c.Country = 'USA' AND c.Address LIKE '[0-9][0-9][0-9][0-9]%';

15.
SELECT 
    p.ProductName,
    c.CategoryName AS Category,
    s.SaleAmount
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
JOIN Categories c ON p.Category = c.CategoryID
WHERE c.CategoryName = 'Electronics' OR s.SaleAmount > 350;

16.
SELECT c.CategoryName, count (p.ProductID)
FROM Products p
JOIN Categories c on  p.Category = c.CategoryID
group by CategoryName

17. 
SELECT 
 CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
 c.City,
 o.OrderID,
 o.TotalAmount AS Amount
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE c.City = 'Los Angeles' AND o.TotalAmount > 300; 

18.
select e.Name as EmployeeName, DepartmentName from Employees e 
join Departments d on e.DepartmentID = d.DepartmentID 
where DepartmentName = 'Human Resources' or DepartmentName = 'Finance'
or e.Name like '%[a,e,i,o,u,A,E,I,O,U]%[a,e,i,o,u,A,E,I,O,U]%[a,e,i,o,u,A,E,I,O,U]%[a,e,i,o,u,A,E,I,O,U]%'

19.
select e.Name as EmployeeName, DepartmentName, Salary 
from Employees e
join Departments d on e.DepartmentID = d.DepartmentID
where (DepartmentName = 'Sales' or DepartmentName = 'Marketing')
and e.Salary > 60000
