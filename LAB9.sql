create database lab9;

create table employees(
    id serial primary key,
    name text,
    position text,
    department text,
    salary int
);
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name TEXT,
    category TEXT,
    description TEXT,
    price NUMERIC
);
INSERT INTO products (name, category, description, price) VALUES
('Laptop', 'Electronics', 'High-performance laptop', 1200.00),
('Smartphone', 'Electronics', 'Latest model smartphone', 800.00),
('Headphones', 'Electronics', 'Noise-cancelling headphones', 150.00),
('Coffee Maker', 'Home Appliances', 'Automatic coffee maker', 100.00),
('Blender', 'Home Appliances', 'Kitchen blender for smoothies', 50.00);

insert into employees(name, position, department, salary) values ('John', 'Senior-Front', 'Google', 100000);
insert into employees(name, position, department, salary) values ('John', 'Strong Senior-Front', 'Facebook', 200000);
insert into employees(name, position, department, salary) values ('Max', 'Junior-Front', 'Yandex', 23000);

-- 1
create procedure inc(inout val integer)
language PLPGSQL as $$
    begin
        val:= val+10;
    end;
$$;
call inc(10);

-- 2
CREATE OR REPLACE PROCEDURE compare_numbers(a int, b int, INOUT result text)
LANGUAGE PLPGSQL AS $$
BEGIN
    IF a > b THEN
        result := 'Greater';
    ELSIF a = b THEN
        result := 'Equal';
    ELSE
        result := 'Lesser';
    END IF;
END;
$$;

DO $$
DECLARE
    result_text text;
BEGIN
    CALL compare_numbers_proc(2, 1, result_text);
    RAISE NOTICE 'Result: %', result_text;
END
$$;


-- 3
CREATE OR REPLACE FUNCTION number_series(n INT)
RETURNS setof int AS $$
BEGIN
    FOR i IN 1..n LOOP
        RETURN NEXT i;
    END LOOP;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM number_series(5);


-- 4
CREATE OR REPLACE FUNCTION find_employee(employee_name TEXT)
RETURNS TABLE(emp_id INT, emp_name TEXT, emp_position TEXT, emp_department TEXT, emp_salary INT) AS $$
BEGIN
    RETURN QUERY SELECT id, name, "position", department, salary FROM employees WHERE name = employee_name;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM find_employee('John');


-- 5
CREATE OR REPLACE FUNCTION list_products(input_category TEXT)
RETURNS TABLE(p_id INT, p_name TEXT, p_description TEXT, p_price NUMERIC) AS $$
BEGIN
    RETURN QUERY SELECT id, name, description, price FROM products WHERE category = input_category;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM list_products('Electronics');


-- 6
CREATE OR REPLACE FUNCTION calculate_bonus(employee_id INT)
RETURNS NUMERIC AS $$
DECLARE
    bonus NUMERIC;
BEGIN
    bonus := 1000;
    RETURN bonus;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE PROCEDURE update_salary(employee_id INT)
LANGUAGE plpgsql AS $$
DECLARE
    bonus_amount NUMERIC;
BEGIN
    bonus_amount := calculate_bonus(employee_id);
    UPDATE employees SET salary = salary + bonus_amount WHERE id = employee_id;
END;
$$;


CALL update_salary(1);
select * from employees;


-- 7
CREATE OR REPLACE PROCEDURE complex_calculation(
    IN param_integer INTEGER,
    IN param_varchar VARCHAR
)
LANGUAGE plpgsql AS $$
DECLARE
    result_numeric INTEGER;
    result_string VARCHAR;
    result VARCHAR;
BEGIN
    BEGIN
        result_numeric := param_integer * 2;
    END;

    BEGIN
        result_string := 'Processed: ' || param_varchar;
    END;
    result := result_string || ' - Numeric Result: ' || result_numeric;
    RAISE NOTICE 'The result is: %', result;
END;

$$;
CALL complex_calculation(10, 'ExampleString');