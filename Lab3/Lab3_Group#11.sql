--1
SELECT * FROM employees;
SELECT last_name, hire_date
FROM employees
WHERE hire_date < 
            (SELECT hire_date
             FROM employees
             WHERE employee_id = '107')
             AND hire_date > '31-Mar-16'
ORDER BY hire_date, employee_id;

--2
SELECT * FROM customers;
SELECT name, credit_limit
FROM customers
WHERE credit_limit IN
                    (SELECT MIN(credit_limit)
                     FROM customers)
ORDER BY customer_id;

--3
SELECT * FROM product_categories;
SELECT * FROM products;
SELECT category_id, product_id, product_name, list_price
FROM products
JOIN product_categories
USING (category_id)
WHERE list_price IN
                (SELECT MAX(list_price)
                 FROM products
                 GROUP BY category_id);

--4
SELECT * FROM product_categories;
SELECT * FROM products;

SELECT category_id, category_name
FROM products
JOIN product_categories
USING (category_id)
WHERE list_price IN
                    (SELECT MAX(list_price)
                     FROM products);


--5
SELECT * FROM products;

SELECT product_name, list_price
FROM products
WHERE category_id ='1' 
AND list_price <ANY
            (SELECT MIN(list_price)
            FROM products
            GROUP BY category_id)

ORDER BY list_price desc;


--6
SELECT * FROM products;
SELECT * FROM product_categories;

SELECT MAX(list_price)
FROM products
WHERE category_id IN 
                    (SELECT category_id
                    FROM products
                    WHERE list_price IN 
                                        (SELECT MIN(list_price) 
                                        FROM products))

;








SELECT * FROM employees;
SELECT last_name, hire_date
FROM employees
WHERE hire_date >
        TO_DATE('Apr 2016', 'Mon YYYY')
        AND hire_date < (SELECT hire_date
                         FROM employees
                         WHERE employee_id = '107') -- 07-JUN-16
ORDER BY hire_date, employee_id;


--2
SELECT * FROM customers;

SELECT name, credit_limit
FROM customers
WHERE credit_limit
            = 
            (SELECT MIN(credit_limit)
             FROM customers)
ORDER BY customer_id;


--3
SELECT * FROM products;

SELECT category_id, product_id, product_name, list_price
FROM products
WHERE list_price IN 
                (SELECT MAX(list_price)
                 FROM products
                 GROUP BY category_id)
ORDER BY category_id, product_id;

--4
SELECT * FROM product_CATEGORIES;
SELECT * FROM products;

SELECT category_id, category_name
FROM products
JOIN product_CATEGORIES
USING (category_id)
WHERE list_price IN
                (SELECT MAX(list_price)
                 FROM products);
                 
                 
--5
SELECT * FROM products;

SELECT product_name, list_price
FROM products
WHERE category_id = '1' 
AND list_price < ANY
                (SELECT MIN(list_price)
                 FROM products
                 --WHERE 
                 GROUP BY category_id)
                 ORDER BY list_price desc;


--6
SELECT MAX(LIST_PRICE)
FROM products
WHERE category_id
        IN
            (SELECT category_id
             FROM products 
             WHERE list_price IN
                                (SELECT MIN(list_price)
                                 FROM products ))
                                 ;
