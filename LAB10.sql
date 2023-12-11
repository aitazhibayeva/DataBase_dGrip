CREATE DATABASE lab10;

CREATE TABLE Books (
    book_id INTEGER PRIMARY KEY,
    title VARCHAR(255),
    author VARCHAR(255),
    price DECIMAL(10, 2),
    quantity INTEGER
);

CREATE TABLE Orders (
    order_id INTEGER PRIMARY KEY,
    book_id INTEGER,
    customer_id INTEGER,
    order_date DATE,
    quantity INTEGER,
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

CREATE TABLE Customers (
    customer_id INTEGER PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255)
);

INSERT INTO Books (book_id, title, author, price, quantity)
VALUES
    (1, 'Database 101', 'A. Smith', 40.00, 10),
    (2, 'Learn SQL', 'B. Johnson', 35.00, 15),
    (3, 'Advanced DB', 'C. Lee', 50.00, 5);

INSERT INTO Customers (customer_id, name, email)
VALUES
    (101, 'John Doe', 'johndoe@example.com'),
    (102, 'Jane Doe', 'janedoe@example.com');

INSERT INTO Orders (order_id, book_id, customer_id, order_date, quantity)
VALUES
    (1, 1, 101, '2023-12-01', 3),
    (2, 2, 102, '2023-12-02', 2),
    (3, 3, 101, '2023-12-03', 1);

--1
BEGIN TRANSACTION;
INSERT INTO Orders (order_id, book_id, customer_id, order_date, quantity)
VALUES (4, 1, 101, CURRENT_DATE, 2);
UPDATE Books
SET quantity = quantity - 2
WHERE book_id = 1;
COMMIT;

--2
BEGIN TRANSACTION;
INSERT INTO Orders (order_id, book_id, customer_id, order_date, quantity)
VALUES (5, 3, 102, CURRENT_DATE, 10);
DELETE FROM Orders
WHERE book_id = 3
AND customer_id = 102
AND quantity > (SELECT quantity FROM Books WHERE book_id = 3);
COMMIT;

--3
BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;
UPDATE Books
SET price = 29.99
WHERE book_id = 1;
COMMIT;

BEGIN TRANSACTION ISOLATION LEVEL READ COMMITTED;
SELECT price
FROM Books
WHERE book_id = 1;
COMMIT;

--4
BEGIN TRANSACTION;
UPDATE Customers
SET email = 'new_email@example.com'
WHERE customer_id = 101;
COMMIT;

SELECT *
FROM Customers
WHERE customer_id = 101;