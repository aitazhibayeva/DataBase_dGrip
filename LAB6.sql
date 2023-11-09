--1
create database lab6;

--2
create table locations(
    location_id serial primary key,
    street_address varchar(25),
    postal_code varchar(12),
    city varchar(30),
    state_province varchar(12)
);

create table departments(
    department_id int primary key,
    department_name varchar(50) unique,
    budget integer,
    location_id integer references locations
);

create table employees(
    employee_id serial primary key,
    first_name varchar(50),
    last_name varchar(50),
    email varchar(50),
    phone_number varchar(20),
    salary integer,
    department_id integer references departments
);

--3
insert into locations (street_address, postal_code, city, state_province) values
    ('123 Main St', '12345', 'New York', 'NY'),
    ('456 Elm St', '54321', 'Los Angeles', 'CA'),
    ('789 Oak St', '98765', 'Moscow', 'IL'),
    ('101 Pine St', '23456', 'San Francisco', 'CA'),
    ('202 Maple St', '67890', 'Houston', 'TX');


insert into departments (department_id, department_name, budget, location_id) values
    (30, 'HR', 100000, 1),
    (50, 'Marketing', 150000, 2),
    (60, 'Finance', 200000, 3),
    (70, 'Engineering', 250000, 4),
    (80, 'Sales', 300000, 5);

insert into employees (first_name, last_name, email, phone_number, salary, department_id) values
    ('John', 'Doe', 'johndoe@email.com', '123-456-7890', 60000, 30),
    ('Jane', 'Smith', 'janesmith@email.com', '987-654-3210', 70000, 50),
    ('Robert', 'Johnson', 'robertjohnson@email.com', '234-567-8901', 80000, 60),
    ('Mary', 'Williams', 'marywilliams@email.com', '345-678-9012', 90000, 70),
    ('David', 'Lee', 'davidlee@email.com', '456-789-0123', 100000, 80);


--4
select e.first_name, e.last_name, e.department_id, d.department_name
from employees e
inner join departments d on d.department_id = e.department_id;

--5
select e.first_name, e.last_name, e.department_id, d.department_name
from employees e
inner join departments d on d.department_id = e.department_id
where d.department_id = 80 or d.department_id = 30;

--6
select e.first_name, e.last_name, d.department_name, l.city, l.state_province
from employees e
inner join departments d on e.department_id = d.department_id
inner join locations l on d.location_id = l.location_id;

--7
select d.department_name, count(e.employee_id) as employee_count
from departments d
left join employees e ON d.department_id = e.department_id
group by d.department_name;

--8
select e.first_name, e.last_name, d.department_name, count(e.department_id) as department_id
from employees e
left join departments d on d.department_id = e.department_id
group by e.first_name, e.last_name, d.department_name;


--9
select e.first_name, e.last_name
from employees e
inner join departments d on e.department_id = d.department_id
inner join locations l on d.location_id = l.location_id
where l.city = 'Moscow';
