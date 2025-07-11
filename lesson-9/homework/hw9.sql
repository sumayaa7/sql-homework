1. 
SELECT p.ProductName, s.SupplierName
FROM Products p
CROSS JOIN Suppliers s;


2.
SELECT d.DepartmentName, e.EmployeeName
FROM Departments d
CROSS JOIN Employees e;


3.SELECT s.SupplierName, p.ProductName
FROM Products p
INNER JOIN Suppliers s ON p.SupplierID = s.SupplierID;


4.
SELECT c.CustomerName, o.OrderID
FROM Orders o
INNER JOIN Customers c ON o.CustomerID = c.CustomerID;


5. 
SELECT s.StudentName, c.CourseName
FROM Students s
CROSS JOIN Courses c;


6.
SELECT p.ProductName, o.OrderID
FROM Products p
INNER JOIN Orders o ON p.ProductID = o.ProductID;


7.
SELECT e.EmployeeName, d.DepartmentName
FROM Employees e
INNER JOIN Departments d ON e.DepartmentID = d.DepartmentID;


8.
SELECT s.StudentName, e.CourseID
FROM Students s
INNER JOIN Enrollments e ON s.StudentID = e.StudentID;


9.
SELECT o.OrderID, p.PaymentID
FROM Orders o
INNER JOIN Payments p ON o.OrderID = p.OrderID;


10.
SELECT o.OrderID, p.ProductName, p.Price
FROM Orders o
INNER JOIN Products p ON o.ProductID = p.ProductID
WHERE p.Price > 100;

11. 
SELECT e.EmployeeName, d.DepartmentName
FROM Employees e
CROSS JOIN Departments d
WHERE e.DepartmentID <> d.DepartmentID;

12.
SELECT o.OrderID, p.ProductName
FROM Orders o
INNER JOIN Products p ON o.ProductID = p.ProductID
WHERE o.Quantity > p.Stock;

13.
SELECT c.CustomerName, s.ProductID
FROM Sales s
INNER JOIN Customers c ON s.CustomerID = c.CustomerID
WHERE s.Amount >= 500;

14.
SELECT s.StudentName, c.CourseName
FROM Enrollments e
INNER JOIN Students s ON e.StudentID = s.StudentID
INNER JOIN Courses c ON e.CourseID = c.CourseID;

15.
SELECT p.ProductName, s.SupplierName
FROM Products p
INNER JOIN Suppliers s ON p.SupplierID = s.SupplierID
WHERE s.SupplierName LIKE '%Tech%';


16.
SELECT o.OrderID, p.Amount AS PaymentAmount, o.TotalAmount
FROM Orders o
INNER JOIN Payments p ON o.OrderID = p.OrderID
WHERE p.Amount < o.TotalAmount;


17.
SELECT e.EmployeeName, d.DepartmentName
FROM Employees e
INNER JOIN Departments d ON e.DepartmentID = d.DepartmentID;

18.
SELECT p.ProductName, c.CategoryName
FROM Products p
INNER JOIN Categories c ON p.CategoryID = c.CategoryID
WHERE c.CategoryName IN ('Electronics', 'Furniture');


19. 
SELECT s.SaleID, c.CustomerName
FROM Sales s
INNER JOIN Customers c ON s.CustomerID = c.CustomerID
WHERE c.Country = 'USA';

20.
SELECT o.OrderID, c.CustomerName, o.TotalAmount
FROM Orders o
INNER JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE c.Country = 'Germany' AND o.TotalAmount > 100;



21. 
SELECT 
    E1.EmployeeID AS Employee1_ID,
    E1.Name AS Employee1_Name,
    E2.EmployeeID AS Employee2_ID,
    E2.Name AS Employee2_Name
FROM 
    Employees E1
JOIN 
    Employees E2 ON E1.EmployeeID < E2.EmployeeID
WHERE 
    E1.DepartmentID <> E2.DepartmentID;


22.
SELECT 
    Pay.PaymentID,
    Pay.OrderID,
    Pay.Amount,
    O.Quantity,
    P.Price,
    (O.Quantity * P.Price) AS ExpectedAmount
FROM 
    Payments Pay
JOIN 
    Orders O ON Pay.OrderID = O.OrderID
JOIN 
    Products P ON O.ProductID = P.ProductID
WHERE 
    Pay.Amount <> (O.Quantity * P.Price);


23. 
SELECT 
    S.StudentID, 
    S.Name
FROM 
    Students S
LEFT JOIN 
    Enrollments E ON S.StudentID = E.StudentID
WHERE 
    E.EnrollmentID IS NULL;

24. 
SELECT 
    M.EmployeeID AS ManagerID,
    M.Name AS ManagerName,
    M.Salary AS ManagerSalary,
    E.EmployeeID AS EmployeeID,
    E.Name AS EmployeeName,
    E.Salary AS EmployeeSalary
FROM 
    Employees M
JOIN 
    Employees E ON E.ManagerID = M.EmployeeID
WHERE 
    M.Salary <= E.Salary;


25.
SELECT 
    C.CustomerID,
    C.FirstName,
    C.LastName,
    O.OrderID
FROM 
    Customers C
JOIN 
    Orders O ON C.CustomerID = O.CustomerID
LEFT JOIN 
    Payments P ON O.OrderID = P.OrderID
WHERE 
    P.PaymentID IS NULL;

