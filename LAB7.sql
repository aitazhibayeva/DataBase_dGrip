create database lab7;

create table dealer (
    id integer primary key ,
    name varchar(255),
    location varchar(255),
    commission float
);

INSERT INTO dealer (id, name, location, commission) VALUES (101, 'Oleg', 'Astana', 0.15);
INSERT INTO dealer (id, name, location, commission) VALUES (102, 'Amirzhan', 'Almaty', 0.13);
INSERT INTO dealer (id, name, location, commission) VALUES (105, 'Ademi', 'Taldykorgan', 0.11);
INSERT INTO dealer (id, name, location, commission) VALUES (106, 'Azamat', 'Kyzylorda', 0.14);
INSERT INTO dealer (id, name, location, commission) VALUES (107, 'Rahat', 'Satpayev', 0.13);
INSERT INTO dealer (id, name, location, commission) VALUES (103, 'Damir', 'Aktobe', 0.12);

create table client (
    id integer primary key ,
    name varchar(255),
    city varchar(255),
    priority integer,
    dealer_id integer references dealer(id)
);

INSERT INTO client (id, name, city, priority, dealer_id) VALUES (802, 'Bekzat', 'Satpayev', 100, 101);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (807, 'Aruzhan', 'Almaty', 200, 101);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (805, 'Али', 'Almaty', 200, 102);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (808, 'Yerkhan', 'Taraz', 300, 102);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (804, 'Aibek', 'Kyzylorda', 300, 106);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (809, 'Arsen', 'Taldykorgan', 100, 103);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (803, 'Alen', 'Shymkent', 200, 107);
INSERT INTO client (id, name, city, priority, dealer_id) VALUES (801, 'Zhandos', 'Astana', null, 105);

create table sell (
    id integer primary key,
    amount float,
    date timestamp,
    client_id integer references client(id),
    dealer_id integer references dealer(id)
);

INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (201, 150.5, '2021-10-05 00:00:00.000000', 805, 102);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (209, 270.65, '2021-09-10 00:00:00.000000', 801, 105);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (202, 65.26, '2021-10-05 00:00:00.000000', 802, 101);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (204, 110.5, '2021-08-17 00:00:00.000000', 809, 103);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (207, 948.5, '2021-09-10 00:00:00.000000', 805, 102);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (205, 2400.6, '2021-07-27 00:00:00.000000', 807, 101);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (208, 5760, '2021-09-10 00:00:00.000000', 802, 101);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (210, 1983.43, '2021-10-10 00:00:00.000000', 804, 106);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (203, 2480.4, '2021-10-10 00:00:00.000000', 809, 103);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (212, 250.45, '2021-06-27 00:00:00.000000', 808, 102);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (211, 75.29, '2021-08-17 00:00:00.000000', 803, 107);
INSERT INTO sell (id, amount, date, client_id, dealer_id) VALUES (213, 3045.6, '2021-04-25 00:00:00.000000', 802, 101);

-- drop table client;
-- drop table dealer;
-- drop table sell;


--1
--a. find those clients with a priority less than 300
select * from client
where priority<300;

--b. combine each row of dealer table with each row of client table
select *
from dealer
cross join client;

--c. find all dealers along with client name, city, priority, sell number, date, and amount
select c.name, c.city, c.priority, s.id, s.date, s.amount
from dealer d
join client c on d.id = c.dealer_id
join sell s on c.id = s.client_id;

--d. find the dealer and client who reside in the same city
select *
from dealer d
join client c on c.city = d.location;

--e. find sell id, amount, client name, city those sells where sell amount exists between 200 and 500.
select s.id, s.amount, c.name, c.city
from client c
join dealer d on c.dealer_id = d.id
join sell s on c.id = s.client_id
where s.amount > 200 and s.amount < 500;

--f. find dealers who works either for one or more client or not yet join under any of the clients.
select *
from dealer
join client c on dealer.id = c.dealer_id;

--g. find the dealers and the clients he service, return client name, city, dealer name, commission.
select c.name, c.city, d.name, d.commission
from dealer d
join client c on d.id = c.dealer_id;

--h. find client name, client city, dealer, commission those dealers who received a commission from the sell more than 13%
select c.name, c.city, d.name, d.commission
from dealer d
join client c on d.id = c.dealer_id
join sell s on c.id = s.client_id
where d.commission > 0.13;

--i. make a report with client name, city, sell id, sell date, sell amount, dealer name and commission to find that
--either any of the existing clients haven’t made a purchase(sell) or made one or more purchase(sell) by their dealer or by own.
select c.name, c.city, s.id, s.date, s.amount, d.name, d.commission
from client c
join sell s on c.id = s.client_id
join dealer d on c.dealer_id = d.id;

--j. find dealers who either work for one or more clients. The client may have made, either one or more purchases, or purchase
--amount above 2000 and must have a priority, or he may not have made any purchase to the associated dealer. Print client name,
--client priority, dealer name, sell id, sell amount.
select c.name, c.priority, d.name, s.id, s.amount
from client c
join dealer d on c.dealer_id = d.id
join sell s on c.id = s.client_id
where s.amount is not null and s.amount > 2000 or c.priority is not null;


--2
--a. count the number of unique clients, compute average and total purchase amount of client orders by each date

create view view_unique_clients_purchase as
select date, count(distinct client_id) as unique_clients,
       avg(amount) as average_amount,
       sum(amount) as total_amount
from sell
group by date;

--b. find top 5 dates with the greatest total sell amount.

create view view_top as
select date, sum(amount) as total_sell_amount
from sell
group by date
order by total_sell_amount desc
limit 5;

--c. count the number of sales, compute average and total amount of all sales of each dealer

create view view_sales as
select dealer_id, count(*) as number_of_sales,
       avg(amount) as average_amount,
       sum(amount) as sum_amount
from sell
group by dealer_id;

--d. compute how much all dealers earned from commission (total sell amount *commission) in each location.

create view view_commission as
select d.location,
       sum(s.amount * d.commission) as total_earned
from sell s
join dealer d on s.dealer_id = d.id
group by d.location;

--e. compute number of sales, average and total amount of all sales dealers made in each location.

create view view_sales_by_location as
select d.location,
       count(*) as number_of_sales,
       avg(s.amount) as average_sale_amount,
       sum(s.amount) as total_sale_amount
from sell s
join dealer d on s.dealer_id = d.id
group by d.location;

--f. compute number of sales, average and total amount of expenses in each city clients made.

create view view_expenses_by_city as
select c.city,
       count(*) as number_of_sales,
       avg(s.amount) as average_sale_amount,
       sum(s.amount) as total_sale_amount
from sell s
join client c on s.client_id = c.id
group by c.city;

--f. compute number of sales, average and total amount of expenses in each city clients made.

create view view_cities_expenses as
select c.city
from client c
join sell s on c.id = s.client_id
group by c.city
having sum(s.amount) > (select coalesce(sum(amount), 0)
                        from sell);