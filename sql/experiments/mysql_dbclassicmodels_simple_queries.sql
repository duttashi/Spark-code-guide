# script create date: 10-Mar-2021
# script last modified date: 10-Mar-2021
use classicmodels;
# show all tables
show tables;
# show all tables schema 
SELECT * FROM INFORMATION_SCHEMA.TABLES;
# show column names
DESCRIBE classicmodels.employees;
# count the number of rows. counting is also aggregation
select orderNumber, 
count(*) as 'order_count' from orders;

# The following practise Qs were taken from https://www.richardtwatson.com/dm6e/Reader/ClassicModels.html

# Q. prepare a list of offices sorted by country, state, city
select * from offices GROUP BY country, state, city; 
select addressLine1, postalCode, city, state, country from offices GROUP BY country, state, city; 

# Q. How many employees are there in the company?
select jobTitle, count(*) from employees;
# Q. What is the total of payments received?
SELECT sum(amount) from payments;
# Q. What is the total of payments received per customer?
select customerNumber, paymentDate, sum(amount) from payments GROUP BY customerNumber;
# List the product lines that contain 'Cars'.
select productLine from products;
select * from products where productLine like '%Cars';
# Q. Report total payments for October 28, 2004.
select * from payments;
select customerNumber, sum(amount) from payments where paymentDate like '2004-10-28'; 
-- Report those payments greater than $100,000.
select amount from payments where amount > 100000;
-- List the products in each product line.
select productLine from products GROUP BY productLine;
-- How many products in each product line?
select productLine, count(productLine) as "product_count" from products GROUP BY productLine;
-- What is the minimum payment received?
select min(amount) from payments;
-- List all payments greater than twice the average payment.
select * from payments where amount > (SELECT AVG(amount)*2 FROM Payments);
-- What is the average percentage markup of the MSRP on buyPrice?
select buyPrice, avg(msrp/buyPrice) from products group	by msrp;
-- How many distinct products does ClassicModels sell?
select DISTINCT productName from products;
-- Report the name and city of customers who don't have sales representatives?
SELECT customerName, city, salesRepEmployeeNumber from customers where salesRepEmployeeNumber is NULL;
-- What are the names of executives with VP or Manager in their title? 
-- Use the CONCAT function to combine the employee's first name and last name into a single field for reporting.
-- Which orders have a value greater than $5,000?



