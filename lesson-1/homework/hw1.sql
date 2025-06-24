Easy;
1. Definitions:
  Data:
Raw facts and figures without context. For example, “John, 25” is data, but we don’t know if 25 is his age, score, or salary.
  Database:
An organized collection of data that can be easily accessed, managed, and updated. Databases store information in a structured way.
  Relational Database:
A type of database that stores data in tables with rows and columns. These tables can be related to each other using keys (like foreign keys and primary keys). Examples: SQL Server, MySQL, Oracle.
  Table:
A collection of related data organized into rows (records) and columns (fields). Each table represents a specific type of data — e.g., a “Customers” table might have columns like Name, Email, and Phone

2. Five Key Features of SQL Server:
 1. Data Storage & Management:
Allows efficient storing, updating, and retrieving of data using T-SQL.
 2. Security & Authentication:
Supports various security models including role-based access, encryption, and authentication methods.
 3. Backup & Recovery:
Provides tools for full, differential, and transaction log backups to ensure data protection.
 4. Data Integrity & Constraints:
Ensures accuracy and consistency of data using constraints (e.g., primary key, foreign key, unique, check).
 5. Support for Stored Procedures and Triggers:
Automates and optimizes operations using programmable objects like procedures, views, functions, and triggers.

3. Authentication Modes in SQL Server (at least 2):
 1. Windows Authentication:
Uses the Windows account of the user to connect. It’s more secure and integrates with Active Directory.
 2. SQL Server Authentication:
Uses a separate username and password defined within SQL Server. This is useful when Windows accounts are not available.

Medium;
1,2. CREATE DATABASE SchoolIDB;
go
CREATE TABLE Students (studentsID int, primary key, name varchar(50), age int) ;

3. SQL Server
A database management system (DBMS) developed by Microsoft. It stores, retrieves, and manages data using SQL. Think of it as the engine that powers databases.
SSMS
SQL Server Management Studio is a tool/interface to interact with SQL Server — you can write SQL queries, manage databases, and perform backups, all in one GUI.
SQL
Structured Query Language, a programming language used to query and manipulate data in relational databases like SQL Server, MySQL, PostgreSQL, etc.


Hard;

1. DQL (Data Query Language)
 Purpose: To retrieve data from the database.
  Main command:
  SELECT.

2. DML (Data Manipulation Language)
  Purpose: To manipulate data inside existing tables — such as adding, updating, or deleting rows.
  Main commands:
  INSERT, UPDATE, DELETE.

3. DDL (Data Definition Language)
  Purpose: To define or change the structure of the database — like creating or dropping tables.
  Main commands:
  CREATE, ALTER, DROP

4. DCL (Data Control Language)
  Purpose: To control access to data by granting or revoking user permissions.
  Main commands:
  GRANT, REVOKE.

5. TCL (Transaction Control Language)
  Purpose: To manage transactions, which are groups of SQL statements that are executed together.
  Main commands:
  BEGIN, COMMIT, ROLLBACK, SAVEPOINT


2.
INSERT INTO Students (StudentID, Name, Age)
values (1, 'Sora', 20), (2, 'Samira', 22), (3, 'Sumaya', 19);










