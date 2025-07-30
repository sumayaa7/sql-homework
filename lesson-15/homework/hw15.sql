--1.
select min(salary) as MiniumSalary
from employees

--2.
select * from products
where price > (
select avg (price) from products) 

--3.
select * from employees
where department_id in ( 
select department_id	
from employees
group by department_id
)

--4.
select c.customer_id, c.name
from customers c 
left join orders o on c.customer_id = o.customer_id
where o.order_id is null 

--5.
select max (price) as Highestprice
from products

--6.
select * from employees 
where salary > (
select avg (salary) 
from employees
)

--7.
select e.id, e.name, e.salary, e.department_id
from employees e
where salary > (
select avg(e2.salary)
from employees e2
where e2.department_id = e.department_id
)

--8.
select * from students
where student_id in 
(
select student_id from grades
where grade = (
select max(grade) as MaxGrade
from grades a
where grades.course_id=a.course_id
group by course_id
		)
)


--9.

--10.
select * from employees e
where salary > (select avg(salary) from employees)
and salary < (
select max(salary)
from employees e2
where e2.department_id = e.department_id
)
