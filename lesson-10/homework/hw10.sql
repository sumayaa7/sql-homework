1. 
SELECT e.EmployeeName, e.Salary, d.DepartmentName
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE e.Salary > 50000;


2.
SELECT c.FirstName, c.LastName, o.OrderDate
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE YEAR(o.OrderDate) = 2023;


3. 
SELECT e.EmployeeName, d.DepartmentName
FROM Employees e
LEFT JOIN Departments d ON e.DepartmentID = d.DepartmentID;


4.
SELECT s.SupplierName, p.ProductName
FROM Suppliers s
LEFT JOIN Products p ON s.SupplierID = p.SupplierID;


5.
SELECT o.OrderID, o.OrderDate, p.PaymentDate, p.Amount
FROM Orders o
JOIN Payments p ON o.OrderID = p.OrderID;


6.
SELECT e.EmployeeName, m.EmployeeName AS ManagerName
FROM Employees e
LEFT JOIN Employees m ON e.ManagerID = m.EmployeeID;


7.
SELECT s.StudentName, c.CourseName
FROM Students s
JOIN Enrollments e ON s.StudentID = e.StudentID
JOIN Courses c ON e.CourseID = c.CourseID
WHERE c.CourseName = 'Math 101';


8.
SELECT c.FirstName, c.LastName, b.Quantity
FROM Customers c
JOIN Orders b ON c.CustomerID = b.CustomerID
WHERE b.Quantity > 3;


9.
SELECT e.EmployeeName, d.DepartmentName
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Human Resources';


10. 
SELECT d.DepartmentName, COUNT(e.EmployeeID) AS EmployeeCount
FROM Departments d
JOIN Employees e ON d.DepartmentID = e.DepartmentID
GROUP BY d.DepartmentName
HAVING COUNT(e.EmployeeID) > 5;

11.
SELECT p.ProductID, p.ProductName
FROM Products p
LEFT JOIN Sales s ON p.ProductID = s.ProductID
WHERE s.ProductID IS NULL;

12.
SELECT c.FirstName, c.LastName, COUNT(o.OrderID) AS TotalOrders
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.FirstName, c.LastName;


13.
SELECT e.EmployeeName, d.DepartmentName
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID;

14.
SELECT e1.EmployeeName AS Employee1, e2.EmployeeName AS Employee2, e1.ManagerID
FROM Employees e1
JOIN Employees e2 ON e1.ManagerID = e2.ManagerID
WHERE e1.EmployeeID < e2.EmployeeID AND e1.ManagerID IS NOT NULL;

15.
SELECT o.OrderID, o.OrderDate, c.FirstName, c.LastName
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE YEAR(o.OrderDate) = 2022;

16.
SELECT e.EmployeeName, e.Salary, d.DepartmentName
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Sales' AND e.Salary > 60000;

17.
SELECT o.OrderID, o.OrderDate, p.PaymentDate, p.Amount
FROM Orders o
JOIN Payments p ON o.OrderID = p.OrderID;

18.
SELECT p.ProductID, p.ProductName
FROM Products p
LEFT JOIN Orders o ON p.ProductID = o.ProductID
WHERE o.ProductID IS NULL;

19.
20.
21.
22.
23.
24.
SELECT 
    O.OrderID AS SaleID, 
    P.ProductName, 
    O.TotalAmount AS SaleAmount
FROM 
    Orders O
JOIN 
    Products P ON O.ProductID = P.ProductID
WHERE 
    O.TotalAmount > 500;

25.
26.
27.
