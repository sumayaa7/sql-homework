-- 1. Create employee table
CREATE TABLE Employees (
    EmpID INT,
    Name VARCHAR(50),
    Salary DECIMAL(10,2)
);

-- 2. Insert records (using different INSERT INTO)

-- Single-row insert
INSERT INTO Employees (EmpID, Name, Salary)
VALUES (1, 'Alice Johnson', 5000);

-- Another single-row insert
INSERT INTO Employees (EmpID, Name, Salary)
VALUES (2, 'Bob Bobson', 6000);

-- Multiple-row insert
INSERT INTO Employees (EmpID, Name, Salary)
VALUES 
(3, 'Charlies Brown', 5500);

-- 3. Update Salary for EmpID = 1
UPDATE Employees
SET Salary = 7000
WHERE EmpID = 1;

-- 4. Delete record where EmpID = 2
DELETE FROM Employees
WHERE EmpID = 2;

-- 5. Difference between DELETE, TRUNCATE, and DROP
/*
DELETE   - Removes rows based on condition; can be rolled back; logs each row deletion.
TRUNCATE - Removes all rows; faster than DELETE; cannot be rolled back in many RDBMS; minimal logging.
DROP     - Deletes the table structure and data; cannot be rolled back; table no longer exists.
*/

-- 6. Modify Name column to VARCHAR(100)
ALTER TABLE Employees
MODIFY Name VARCHAR(100);

-- 7. Add Department column
ALTER TABLE Employees
ADD Department VARCHAR(50);

-- 8. Change Salary data type to FLOAT
ALTER TABLE Employees
MODIFY Salary FLOAT;

-- 9. Create Departments table
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);

-- 10. Remove all records from Employees without deleting structure
TRUNCATE TABLE Employees;


--2.  
-- 1. Insert five records into Departments using INSERT INTO ... SELECT
-- First, use SELECT ALL to simulate data selection
INSERT INTO Departments (DepartmentID, DepartmentName)
SELECT 1, 'HR' SELECT ALL
SELECT 2, 'Finance' SELECT ALL
SELECT 3, 'IT' SELECT ALL
SELECT 4, 'Sales' SELECT ALL
SELECT 5, 'Marketing';

-- 2. Update Department of all employees where Salary > 5000 to 'Management'
UPDATE Employees
SET Department = 'Management'
WHERE Salary > 5000;

-- 3. Remove all employees but keep the table structure intact
TRUNCATE TABLE Employees;

-- 4. Drop the Department column from Employees table
ALTER TABLE Employees
DROP COLUMN Department;

-- 5. Rename the Employees table to StaffMembers
ALTER TABLE Employees
RENAME TO StaffMembers;

-- 6. Completely remove the Departments table from the database
DROP TABLE Departments;

--3.  
-- 1. Create Products table with constraints
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2) CHECK (Price > 0),
    Description TEXT -- additional 5th column
);

-- 2. Modify table to add StockQuantity column with DEFAULT value 50
ALTER TABLE Products
ADD StockQuantity INT DEFAULT 50;

-- 3. Rename Category to ProductCategory
ALTER TABLE Products
RENAME COLUMN Category TO ProductCategory;

-- 4. Insert 5 records into Products
INSERT INTO Products (ProductID, ProductName, ProductCategory, Price, Description)
VALUES 
(1, 'Laptop', 'Electronics', 1200, 'High-performance laptop'),
(2, 'Desk Chair', 'Furniture', 150, 'Ergonomic office chair'),
(3, 'Notebook', 'Stationery', 5.5, 'College-ruled notebook'),
(4, 'Coffee Maker', 'Appliances', 80, '12-cup programmable coffee maker'),
(5, 'Headphones', 'Electronics', 99.9, 'Wireless over-ear headphones');

-- 5. Create a backup table using SELECT INTO
SELECT * INTO Products_Backup
FROM Products;

-- 6. Rename Products table to Inventory
ALTER TABLE Products
RENAME TO Inventory;

-- 7. Change the data type of Price from DECIMAL(10,2) to FLOAT
ALTER TABLE Inventory
MODIFY COLUMN Price FLOAT;

-- 8. Add an IDENTITY column ProductCode starting from 1000 and incrementing by 5
-- Note: This syntax differs by SQL dialect. Here's an example for SQL Server and a MySQL-compatible alternative below.

-- SQL Server:
ALTER TABLE Inventory
ADD ProductCode INT IDENTITY(1000, 5);
    

