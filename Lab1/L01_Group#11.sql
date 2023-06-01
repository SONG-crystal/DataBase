-- **********************************************
-- Name: Sae-mi Park, Suna Kim, Sujung Song
-- ID: 121333223, 104690227, 172745218
-- Date: May 18, 2023
-- Purpose: Lab 1 DBS311
-- **********************************************

-- Question 1 – 
-- Q1: Write a query to display the tomorrow’s date in the following format: January 10th of year 2019
--     the result will depend on the day when you RUN/EXECUTE this query.  Label the column “Tomorrow”.

-- Q1 SOLUTION --
SELECT TO_CHAR(SYSDATE+1, 'Mon ddth "of year" YYYY') AS Tomorrow
FROM dual;




-- Question 2 – 
-- Q2: For each product in category 2, 3, and 5, show product ID, product name, list price, and the new list price increased by 2%. 
--     Display a new list price as a whole number.
--     In your result, add a calculated column to show the difference of old and new list prices.

-- Q2 Solution --
SELECT product_id,
       product_name,
       list_price,
       ROUND((list_price + (list_price*0.02))) AS "new list price",
       ROUND(((list_price + (list_price*0.02)))- list_price) AS "difference list price"
FROM products
WHERE category_id IN (2,3,5)
order by product_id;




-- Question 3 –
-- Q3: For employees whose manager ID is 2, write a query that displays the employee’s Full Name and Job Title in the following format:
--     SUMMER, PAYNE is Public Accountant.

-- Q3 Solution –-
SELECT (upper(first_name ||', '|| last_name)||' is '||job_title) AS "Employees"
FROM employees
WHERE manager_id = 2;




-- Question 4 –
-- Q4: For each employee hired before October 2016, display the employee’s last name, hire date and calculate the number of YEARS between TODAY and the date the employee was hired.
--  •	Label the column Years worked. 
--  •	Order your results by the number of years employed.  Round the number of years employed up to the closest whole number.

-- Q4 Solution –-
SELECT last_name AS "Last name",
       hire_date AS "Hire date",
       ROUND(MONTHS_BETWEEN (sysdate, hire_date)/12) AS "Years worked"
FROM employees
WHERE hire_date < TO_DATE('10-01-2016', 'mm-dd-yyyy')
ORDER BY "Years worked";


-- Question 5 –
--Q5: Display each employee’s last name, hire date, and the review date, which is the first Tuesday after a year of service, but only for those hired after 2016.  
--  •	Label the column REVIEW DAY. 
--  •	Format the dates to appear in the format like: TUESDAY, August the Thirty-First of year 2016
--  •	Sort by review date


-- Q5 Solution –-
SELECT last_name AS "Last name",
       hire_date AS "Hire date",
       to_char(next_day(ADD_MONTHS(hire_date,12),'Tuesday'),'FMDAY, Month "the" Ddspth "of year" yyyy')AS "Review Day"
FROM employees
WHERE hire_date >= to_date('2016-01-01','yyyy-mm-dd')
ORDER BY "Review Day";



-- Question 6 –
-- Q6: For all warehouses, display warehouse id, warehouse name, city, and state. 
--     For warehouses with the null value for the state column, display “unknown”. 

-- Q6 Solution –-
SELECT w.warehouse_id, 
       w.warehouse_name, 
       l.city, 
       nvl(l.state, 'unknown')
FROM warehouses w,
     locations l
WHERE l.location_id = w.location_id;
