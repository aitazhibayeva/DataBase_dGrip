/*Create a database called 'lab2'*/
CREATE DATABASE lab2;
/*Write SQL statements describing tables with appropriate data types and
constraints that satisfy the following conditions (you may need additional
tables to store data atomically and efficiently):*/
CREATE TABLE employees
(
    birth_date date,
    first_name varchar(14),
    last_name  varchar(16),
    gender     char,
    hire_date  date,
    emp_no     integer primary key
);

CREATE TABLE titles(
    emp_no integer references employees(emp_no),
    title varchar(50),
    from_date date,
    to_date date
);

CREATE TABLE salaries(
    emp_no int references employees(emp_no),
    salary int,
    from_date date,
    to_date date
);

CREATE TABLE departments(
    dept_name varchar(40),
    dept_no char(4) primary key
);

CREATE TABLE dept_emp(
    emp_no int references employees(emp_no),
    dept_no char(4) references departments(dept_no),
    from_date date,
    to_date date
);

CREATE TABLE dept_manager(
    dept_no char(4) references departments(dept_no),
    emp_no int references employees(emp_no),
    from_date date,
    to_date date
);

/*Write SQL statements describing tables with appropriate data types
and constraints that satisfy the following conditions */
INSERT INTO employees
VALUES('2005-12-12','Harry','Potter', 'M', '2011-12-12',1);
INSERT INTO titles
VALUES (1,'Wizard','2000-02-02', '2000-01-01');
INSERT INTO salaries
VALUES(1, 200, '2011-01-02', '2011-02-01');
INSERT INTO departments
VALUES('h', 'bo-o');
INSERT INTO dept_emp
VALUES (1, 'bo-o', '2020-03-03', '2021-01-01');
INSERT INTO dept_manager
VALUES ('bo-o', 1, '2022-03-03', '2023-03-03');


UPDATE employees SET first_name='Harry'
WHERE first_name='Santa';
UPDATE salaries SET salary =300
WHERE salary = 200;
UPDATE titles SET title='Snowman'
WHERE title = 'Wizard';
UPDATE departments SET dept_name = 'dudu'
WHERE dept_name = 'bo-o';
UPDATE dept_manager SET to_date ='2000-12-21'
WHERE from_date = '2022-03-03';
UPDATE dept_emp SET from_date = '2000-05-05'
WHERE to_date = '2021-01-01';


DELETE FROM employees
WHERE first_name='Harry';
DELETE FROM salaries
WHERE salary =300;
DELETE FROM titles
WHERE title = 'melon';
DELETE FROM departments
WHERE dept_name='meow';
DELETE FROM dept_manager
WHERE to_date = '19.01.2020';
DELETE FROM dept_emp
WHERE from_date='10.01.2021';


CREATE TABLE students(
    full_name varchar NOT NULL,
    age int NOT NULL,
    birth_date date NOT NULL,
    gender varchar NOT NULL,
    avg_grade int NOT NULL,
    nation varchar NOT NULL,
    phone_numb int NOT NULL,
    soc_category varchar NOT NULL
);

CREATE TABLE instructors(
    full_name varchar NOT NULL,
    speak_lang  varchar NOT NULL,
    work_experience  varchar NOT NULL,
    remote_lessons boolean NOT NULL
);

CREATE TABLE relatives(
    full_name varchar NOT NULL,
    address   varchar NOT NULL,
    phone_numb  varchar NOT NULL,
    position  varchar NOT NULL
);

CREATE TABLE cos_students(
    school varchar NOT NULL,
    graduation date NOT NULL,
    address  varchar NOT NULL,
    region  varchar NOT NULL,
    country varchar NOT NULL,
    gpa int NOT NULL,
    honors text
);

/*Explain the difference between DDL and DML*/
CREATE TABLE book
(
    book_id integer,
    title    varchar(50),
    teacher  varchar(50),
    price   int,
    credits  integer
);

/*3 DDL commands*/
ALTER TABLE book
ADD PRIMARY KEY (book_id);

TRUNCATE TABLE book;

DROP TABLE book;

/*4 DML commands*/
INSERT INTO book
VALUES ('1', 'DataBase', 'Kuralbaev', 150000, 3);

DELETE FROM book
WHERE title = 'DataBase';

UPDATE book SET book_id = '2'
WHERE book_id = '1';

SELECT title FROM book
WHERE book_id = '1';

select * from book;
