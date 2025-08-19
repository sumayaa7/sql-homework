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

--11.Sample table
CREATE TABLE #Sample (
ID INT
)

INSERT INTO #Sample (ID) VALUES (1),(2),(3),(4),(5);

-- Cumulative sum query
SELECT ID,
SUM(ID) OVER (ORDER BY ID) AS SumPreValues
FROM #Sample

--12.
SELECT product_category, order_date,
SUM(total_amount) OVER (
PARTITION BY product_category 
ORDER BY order_date 
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
) AS CumulativeRevenue
FROM sales_data


--13.
CREATE TABLE OneColumn (
    Value SMALLINT
);
INSERT INTO OneColumn VALUES (10), (20), (30), (40), (100);

select * from OneColumn

-- Query for cumulative sum
SELECT Value,
SUM(Value) OVER (ORDER BY Value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS [Sum of Previous]
FROM OneColumn

--14.Find customers who have purchased items from more than one product_category
SELECT customer_id,customer_name,
COUNT(DISTINCT product_category) AS category_count
FROM sales_data
GROUP BY customer_id, customer_name
HAVING COUNT(DISTINCT product_category) > 1

--15.Find Customers with Above-Average Spending in Their Region
SELECT customer_id, customer_name, region,
SUM(total_amount) AS total_spent
FROM sales_data
GROUP BY customer_id, customer_name, region
HAVING SUM(total_amount) > (
SELECT AVG(region_total)
FROM (
SELECT region, SUM(total_amount) AS region_total
FROM sales_data
GROUP BY region
 ) r
WHERE r.region = sales_data.region
)

--16.Rank customers based on their total spending within each region
SELECT customer_id, customer_name, region,
SUM(total_amount) AS total_spent,
RANK() OVER (PARTITION BY region ORDER BY SUM(total_amount) DESC) AS spending_rank
FROM sales_data
GROUP BY customer_id, customer_name, region

--17.Calculate the running total (cumulative_sales) of total_amount for each customer_id, ordered by order_date
SELECT customer_id, customer_name, order_date, total_amount,
SUM(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date
ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sales
FROM sales_data
ORDER BY customer_id, order_date

--18.Calculate the sales growth rate (growth_rate) for each month compared to the previous month
;WITH monthly_sales AS (
SELECT 
FORMAT(order_date, 'yyyy-MM') AS sales_month,
SUM(total_amount) AS monthly_total
FROM sales_data
GROUP BY FORMAT(order_date, 'yyyy-MM')
)
SELECT sales_month, monthly_total,
       LAG(monthly_total) OVER (ORDER BY sales_month) AS prev_month_total,
CASE 
WHEN LAG(monthly_total) OVER (ORDER BY sales_month) = 0 
OR LAG(monthly_total) OVER (ORDER BY sales_month) IS NULL 
THEN NULL
ELSE ROUND(
(monthly_total - LAG(monthly_total) OVER (ORDER BY sales_month)) 
  * 100.0 / LAG(monthly_total) OVER (ORDER BY sales_month), 2
 )
END AS growth_rate
FROM monthly_sales
ORDER BY sales_month

--19.Identify customers whose total_amount is higher than their last order's total_amount
SELECT customer_id, customer_name, order_date, total_amount,
       LAG(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) AS previous_order_amount
FROM sales_data
WHERE total_amount > LAG(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date)
