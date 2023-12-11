create database lab8;

CREATE TABLE countries (
    country_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE departments (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL,
    budget DECIMAL(15, 2) NOT NULL
);

CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    surname VARCHAR(100) NOT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    department_id INT NOT NULL,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

INSERT INTO countries (name) VALUES
    ('United States'),
    ('Canada'),
    ('United Kingdom'),
    ('Germany');

INSERT INTO departments (department_name, budget) VALUES
    ('Sales', 500000),
    ('Marketing', 700000),
    ('Finance', 900000),
    ('HR', 600000);

INSERT INTO employees (name, surname, salary, department_id) VALUES
    ('John', 'Doe', 60000, 1),
    ('Jane', 'Smith', 70000, 2),
    ('Michael', 'Johnson', 85000, 3),
    ('Emily', 'Williams', 65000, 4);

--1. SELECT * FROM countries WHERE name = 'string' ;
CREATE INDEX idx_countries_name ON countries(name);

--2. SELECT * FROM employees WHERE name = 'string' AND surname = 'string' ;
CREATE INDEX idx_employees_name_surname ON employees(name, surname);

--3. SELECT * FROM employees WHERE salary < value AND salary > value2;
CREATE UNIQUE INDEX idx_employees_salary_range ON employees(salary);

--4. SELECT * FROM employees WHERE substring(name from 1 for 4) = 'abcd';
CREATE INDEX idx_employees_name_substring ON employees((substring(name from 1 for 4)='abcd'));

/*5. SELECT * FROM employees e JOIN departments d
ON d.department_id = e.department_id wHERE
d.budget > value 2 AND e.salary < value 2;*/
CREATE INDEX idx_join_departments_budget_salary ON employees(department_id, salary);
CREATE INDEX idx_join_employees_department_id ON departments(department_id, budget);