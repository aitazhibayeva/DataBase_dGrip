--1
create database lab5;
--2
create table customers(
    customer_id int,
    cust_name varchar(225),
    city varchar(225),
    grade int,
    salesman_id int
);

create table orders(
    ord_no int,
    purch_amt decimal(10, 2),
    ord_date date,
    customer_id int,
    salesman_id int,
    name varchar(255),
    city varchar(255),
    commission decimal
);

insert into customers(customer_id, cust_name, city, grade, salesman_id)
values(3002, 'Nick Rimando', 'New York', 100, 5001);
insert into customers(customer_id, cust_name, city, grade, salesman_id)
values(3005, 'Graham Zusi', 'California', 200, 5002);
insert into customers(customer_id, cust_name, city, grade, salesman_id)
values(3001, 'Brand Guzan', 'London', null, 5005);
insert into customers(customer_id, cust_name, city, grade, salesman_id)
values(3004, 'Fabinn Johns', 'Paris', 300, 5006);
insert into customers(customer_id, cust_name, city, grade, salesman_id)
values(3007, 'Brad Davis', 'New York', 300, 5006);
insert into customers(customer_id, cust_name, city, grade, salesman_id)
values(3004, 'Geoff camero', 'Berlin', 300, 5006);
insert into customers(customer_id, cust_name, city, grade, salesman_id)
values(3004, 'Julian Green', 'London', 300, 5006);

insert into orders(ord_no, purch_amt, ord_date, customer_id, salesman_id, name, city, commission)
values(70001, 150.5, '2012-10-05', 3005, 5002, 'James Hoog', 'New York', 0.15);
insert into orders(ord_no, purch_amt, ord_date, customer_id, salesman_id, name, city, commission)
values(70009, 270.65, '2012-09-10', 3001, 5005, 'Nail Knite', 'Paris', 0.13);
insert into orders(ord_no, purch_amt, ord_date, customer_id, salesman_id, name, city, commission)
values(70002, 65.26, '2012-10-05', 3002, 5001, 'Pit Alex', 'London', 0.11);
insert into orders(ord_no, purch_amt, ord_date, customer_id, salesman_id, name, city, commission)
values(70004, 110.5, '2012-08-17', 3009, 5003, 'Mc Lyon', 'Paris', 0.14);
insert into orders(ord_no, purch_amt, ord_date, customer_id, salesman_id, name, city, commission)
values(70007, 948.5, '2012-09-10', 3005, 5002, 'Lauson Hen', null, 0.12);
insert into orders(ord_no, purch_amt, ord_date, customer_id, salesman_id, name, city, commission)
values(70005, 2400.6, '2012-07-27', 3007, 5001, 'Paul Adam', 'Rome', 0.13);
insert into orders(ord_no, purch_amt, ord_date, customer_id, salesman_id, name, city, commission)
values(70008, 5760, '2012-09-10', 3002, 5001,null,null,null);

--3 Select the total purchase amount of all orders.
SELECT SUM(purch_amt) AS total_purchase_amount
FROM orders;

--4 Select the average purchase amount of all orders.
SELECT AVG(purch_amt) AS average_purchase_amount
FROM orders;

--5 Select how many customer have listed their names.
SELECT COUNT(cust_name) AS customer_count
FROM customers;

--6 Select the minimum purchase amount of all the orders.
SELECT MIN(purch_amt) AS minimum_purchase_amount
FROM orders;

--7 Select customer with all information whose name ends with the letter 'b'.
SELECT *
FROM customers
WHERE cust_name LIKE '%b';

--8 Select orders which made by customers from ‘New York’.
SELECT *
FROM orders
WHERE city = 'New York';

--9 Select customers with all information who has order with purchase amount more than 10.
SELECT customers.*
FROM customers
INNER JOIN orders ON customers.customer_id = orders.customer_id
WHERE orders.purch_amt > 10;

--10 Select total grade of all customers.
SELECT SUM(grade) AS total_customer_grade
FROM customers;

--11 Select all customers who have listed their names.
SELECT *
FROM customers
WHERE cust_name IS NOT NULL;

--12 Select the maximum grade of all the customers
SELECT MAX(grade) AS maximum_customer_grade
FROM customers;
