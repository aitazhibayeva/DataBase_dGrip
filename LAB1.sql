/*Create database called «lab1»*/
CREATE DATABASE lab1;


/*Create table «students» with following field*/
CREATE TABLE students(
    id serial,
    firstname VARCHAR(50),
    lastname VARCHAR (50)
);


/*Add integer column (0 or 1) «isadmin» to «students» table*/
ALTER TABLE students
ADD COLUMN isadmin INT;

INSERT INTO students(isadmin)
VALUES (1);

/*Change type of «isadmin» column to boolean*/
ALTER TABLE students
ALTER COLUMN isadmin set data type boolean USING isadmin::boolean;


/*Set default value as false to «isadmin» column*/
ALTER TABLE students
ALTER COLUMN isadmin SET DEFAULT false;


/*Add primary key constraint to id colum*/
ALTER TABLE students
ADD PRIMARY KEY (id);


/*Create table «tasks» with following fields*/
CREATE TABLE tasks(
    id serial,
    name VARCHAR (50),
    user_id INT
);


/*Delete «tasks» table*/
DROP TABLE tasks;


/*Delete «lab1» database*/
DROP DATABASE lab1;
