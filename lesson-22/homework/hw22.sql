--1.Running Total Sales per Customer
SELECT customer_id, customer_name, order_date, total_amount,
       SUM(total_amount) OVER (
       PARTITION BY customer_id 
       ORDER BY order_date
       ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
) AS running_total
FROM sales_data
ORDER BY customer_id, order_date

--2.Count the Number of Orders per Product Category
SELECT product_category,
COUNT(*) AS order_count
FROM sales_data
GROUP BY product_category

--3.Maximum Total Amount per Product Category
SELECT product_category,
MAX(total_amount) AS max_total_amount
FROM sales_data
GROUP BY product_category

--4.Minimum Price of Products per Product Category
SELECT product_category,
MIN(unit_price) AS min_price
FROM sales_data
GROUP BY product_category

--5.Moving Average of Sales of 3 Days (prev, curr, next)
SELECT order_date, total_amount,
AVG(total_amount) OVER (
ORDER BY order_date 
ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
) AS moving_avg
FROM sales_data
ORDER BY order_date

--6.Total Sales per Region
SELECT region,
SUM(total_amount) AS total_sales
FROM sales_data
GROUP BY region

--7.Rank Customers Based on Their Total Purchase Amount
SELECT customer_id, customer_name,
SUM(total_amount) AS total_purchase,
RANK() OVER (ORDER BY SUM(total_amount) DESC) AS customer_rank
FROM sales_data
GROUP BY customer_id, customer_name
ORDER BY total_purchase DESC

--8.Difference Between Current and Previous Sale Amount per Customer
SELECT customer_id, customer_name, order_date, total_amount, total_amount - LAG(total_amount) OVER (
PARTITION BY customer_id ORDER BY order_date
) AS diff_from_prev
FROM sales_data
ORDER BY customer_id, order_date

--9.Top 3 Most Expensive Products in Each Category
SELECT * FROM (
SELECT product_category, product_name, unit_price,
RANK() OVER (PARTITION BY product_category ORDER BY unit_price DESC) AS rnk
FROM sales_data
) t
WHERE rnk <= 3
ORDER BY product_category, rnk

--10.Cumulative Sum of Sales Per Region by Order Date
SELECT region, order_date,
SUM(total_amount) OVER (
PARTITION BY region ORDER BY order_date
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
) AS cumulative_sales
FROM sales_data
ORDER BY region, order_date
