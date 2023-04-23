-- Create CUSTOMER table
CREATE TABLE mcCUSTOMERS (
    cusNumber NUMBER(4) PRIMARY KEY NOT NULL,
    cusFirstName VARCHAR2(25) NOT NULL,
    cusLastName VARCHAR2(25) NOT NULL,
    cusPhone VARCHAR2(10) NOT NULL
);

-- Create mcEMPLOYEES table
CREATE TABLE mcEMPLOYEES (
    employeeID NUMBER(4) PRIMARY KEY NOT NULL,
    empFirstName VARCHAR2(25) NOT NULL,
    empLastName VARCHAR2(25) NOT NULL,
    empPhone VARCHAR2(10) NOT NULL,
    department VARCHAR2(25) NOT NULL,
    jobTitle VARCHAR2(25) NOT NULL,
    CONSTRAINT emp_employeeID_check CHECK (
        employeeID > 0
        AND employeeID < 10000
    )
);

-- Create PAYMENT table
CREATE TABLE mcPAYMENTS (
    paymentId NUMBER(4) PRIMARY KEY NOT NULL,
    cusNumber NUMBER(4) NOT NULL,
    payDate DATE NOT NULL,
    payAmount NUMBER(10, 2) NOT NULL,
    CONSTRAINT pmt_customer_number_check CHECK (
        cusNumber > 0
        AND cusNumber < 10000
    ),
    CONSTRAINT fk_payment_customer FOREIGN KEY (cusNumber) REFERENCES mcCUSTOMERS(cusNumber)
);



-- Create mcFOODS table
CREATE TABLE mcFOODS (
    foodId VARCHAR2(5) PRIMARY KEY NOT NULL,
    foodName VARCHAR2(50) NOT NULL,
    price NUMBER(9, 2) NOT NULL,
    calories NUMBER(4) NOT NULL,
    respEmployeeID NUMBER(4) NOT NULL,
    CONSTRAINT fod_calories_check CHECK (
        calories > 0
        AND calories < 2000
    ),
    CONSTRAINT fk_food_employee FOREIGN KEY (respEmployeeID) REFERENCES mcEMPLOYEES(employeeID)
);

-- Create ORDER table
CREATE TABLE mcORDERS (
    orderNumber VARCHAR2(5) PRIMARY KEY NOT NULL,
    orderDate DATE NOT NULL,
    ORDERStatus VARCHAR2(25) NOT NULL,
    cusNumber NUMBER(4) NOT NULL,
    itemId VARCHAR2(5) NOT NULL,
    CONSTRAINT ord_customer_number_check CHECK (
        cusNumber > 0
        AND cusNumber < 10000
    ),
    CONSTRAINT fk_order_customer FOREIGN KEY (cusNumber) REFERENCES mcCUSTOMERS(cusNumber),
    CONSTRAINT fk_order_item FOREIGN KEY (itemId) REFERENCES mcFOODS(foodId)
);

-- Create mcDRINKS table
CREATE TABLE mcDRINKS (
    drinkId VARCHAR2(5) PRIMARY KEY NOT NULL,
    drinkName VARCHAR2(35) NOT NULL,
    price NUMBER(9, 2) NOT NULL,
    calories NUMBER(3) NOT NULL,
    respEmployeeID NUMBER(4) NOT NULL,
    CONSTRAINT drk_calories_check CHECK (
        calories > 0
        AND calories < 1000
    ),
    CONSTRAINT fk_drink_employee FOREIGN KEY (respEmployeeID) REFERENCES mcEMPLOYEES(employeeID)
);



-- Create cusPayment view

CREATE VIEW cusPayment AS 
SELECT c.cusnumber, c.cusfirstname, c.cuslastname, c.cusphone,
        p.paymentid, p.paydate, p.payamount
FROM mccustomers c
JOIN mcpayments p
ON c.cusnumber = p.cusnumber;

SELECT * FROM cusPayment
ORDER BY cusnumber;


-- Create cusOrder view
CREATE VIEW cusOrder AS 
SELECT c.cusnumber, c.cusfirstname, c.cuslastname, c.cusphone,
        o.ordernumber, o.orderdate, o.orderstatus, o.itemid  
FROM mccustomers c
JOIN mcorders o 
ON c.cusnumber = o.cusnumber;

SELECT * FROM cusOrder
ORDER BY cusnumber;

-- Create foodOrders view
CREATE VIEW foodOrders AS 
SELECT o.ordernumber, o.orderdate, o.orderstatus, o.itemid,
       f.foodname, f.calories, f.price
FROM mcorders o
LEFT JOIN mcfoods f
ON o.itemid = f.foodid;

SELECT * FROM foodOrders
ORDER BY foodorders.ordernumber;


-- Create mcEmploy view
CREATE VIEW mcEmploy AS 
SELECT e.employeeid, e.empfirstname, e.emplastname, e.empphone,
       e.department, e.jobtitle,
       f.foodid, f.foodname,
       d.drinkid, d.drinkname
FROM mcemployees e
LEFT JOIN mcfoods f
ON e.employeeid = f.respemployeeid
LEFT JOIN mcdrinks d
ON e.employeeid = d.respEmployeeid;

SELECT * FROM mcEmploy
ORDER BY employeeid;