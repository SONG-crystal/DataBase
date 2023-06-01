-- ***********************
-- Name: Sae-mi Park
-- ID: 121333223
-- Name: Suna Kim
-- ID: 104690227
-- Name: Sujung Song
-- ID: 172745218
-- Date: 25/May/2023
-- Purpose: Lab 2 DBS311
-- ***********************

-- Question 1.	For each job title, display the number of employees. Sort the result according to the number of employees.
-- Q1 SOLUTION --
SELECT job_title, COUNT(employee_id) AS employees
FROM employees
GROUP BY job_title
ORDER BY 2
;


-- Question 2. Display the highest, lowest, and average customer credit limits. Name these results high, low, and average. Add a column that shows the difference between the highest and the lowest credit limits named �High and Low Difference�. Round the average to 2 decimal places.
-- Q2 SOLUTION --
SELECT 
MAX(credit_limit) AS HIGH,
MIN(credit_limit) AS LOW,
ROUND(AVG(credit_limit),2) AS AVERAGE,
MAX(credit_limit) - MIN(credit_limit) "High Low Difference"
FROM customers
;


-- Question 3. Display the order id, the total number of products, and the total order amount for orders with the total amount over $1,000,000. Sort the result based on total amount from the high to low values.
-- Q3 SOLUTION --
SELECT 
ORDER_ID,
SUM(quantity) AS TOTAL_ITEMS,
SUM(quantity*unit_price) AS TOTAL_AMOUNT
FROM order_items
GROUP BY order_id
HAVING SUM(quantity*unit_price) > 1000000
ORDER BY 3 desc
;

-- Question 4. Display the warehouse id, warehouse name, and the total number of products for each warehouse. Sort the result according to the warehouse ID.
-- Q4 SOLUTION --
SELECT w.warehouse_id, w.warehouse_name,
SUM(i.Quantity) AS total_products
FROM warehouses w
JOIN inventories i
ON w.warehouse_id = i.warehouse_id
GROUP BY w.warehouse_id, w.warehouse_name
ORDER BY 1
;



-- Question 5. For each customer, display customer number, customer full name, and the total number of orders issued by the customer.  
      --If the customer does not have any orders, the result shows 0.
      --Display only customers whose customer name starts with �Song� and contains �e�.
      --Include also customers whose customer name ends with�t�.
      --Show the customers with highest number of orders first.
-- Q5 SOLUTION --
SELECT customer_id, name AS "customer name",
COUNT(order_id) AS "total numbers OF orders"
FROM customers 
LEFT JOIN orders --LEFT JOIN 
USING (customer_id)
WHERE name LIKE 'O%e%' OR name LIKE '%t' --!
GROUP BY customer_id, name
ORDER BY 3 desc
; 




-- Question 6. Write a SQL query to show the total and the average sale amount for each category. Round the average to 2 decimal places.
-- Q6 SOLUTION --
SELECT 
category_id, 
ROUND(sum(quantity*unit_price),2) AS TOTAL_AMOUNT,
ROUND(AVG(quantity*unit_price),2) AS AVERAGE_AMOUNT
FROM products 
JOIN order_items 
USING (product_id)
GROUP BY category_id
ORDER BY 2 desc
;


