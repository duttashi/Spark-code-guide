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