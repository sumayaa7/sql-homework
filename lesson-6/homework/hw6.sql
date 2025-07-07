2. CREATE TABLE TestMultipleZero (
     A INT,
	   B INT,
	   C INT,
	   D INT,
	);
INSERT INTO TestMultipleZero(A,B,C,D)
VALUES 
    (0,0,0,1),
    (0,0,1,0),
    (0,1,0,0),
    (1,0,0,0),
    (0,0,0,0),
    (1,1,1,0);

SELECT *
FROM TestMultipleZero
WHERE NOT (A = 0 AND B = 0 AND C = 0 AND D = 0);

3. create table section1(id int, name varchar(20))
insert into section1 values (1, 'Been'),
       (2, 'Roma'),
       (3, 'Steven'),
       (4, 'Paulo'),
       (5, 'Genryh'),
       (6, 'Bruno'),
       (7, 'Fred'),
       (8, 'Andro')

  SELECT *
FROM section1
WHERE id % 2 = 1;

4. SELECT *
FROM section1
ORDER BY id ASC
LIMIT 1;

5. SELECT *
FROM section1
ORDER BY id DESC
LIMIT 1;

6. SELECT *
FROM section1
WHERE LOWER(name) LIKE 'b%';

7.SELECT *
FROM ProductCodes
WHERE Code LIKE '%\_%' ESCAPE '\';
