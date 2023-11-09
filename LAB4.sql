--1
create database lab4;
--2
create table Warehouses(
    code integer,
    location character varying(255),
    capacity integer
);

create table Packs (
    code character(4),
    contents character varying(255),
    value real,
    warehouses integer
);
--3
INSERT INTO Warehouses(code, location, capacity) VALUES(1, 'Chicago', 3);
INSERT INTO Warehouses(code, location, capacity) VALUES(2, 'Rocks', 4);
INSERT INTO Warehouses(code, location, capacity) VALUES(3, 'New York', 7);
INSERT INTO Warehouses(code, location, capacity) VALUES(4, 'Los Angeles', 2);
INSERT INTO Warehouses(code, location, capacity) VALUES(5, 'San Francisko', 8);

INSERT INTO Packs(code, contents, value, warehouses) VALUES ('0MN7', 'Rocks', 180, 3);
INSERT INTO Packs(code, contents, value, warehouses) VALUES ('4H8P', 'Rocks', 250, 1);
INSERT INTO Packs(code, contents, value, warehouses) VALUES ('4RT3', 'Scissors', 190, 4);
INSERT INTO Packs(code, contents, value, warehouses) VALUES ('7G3H', 'Rocks', 200, 1);
INSERT INTO Packs(code, contents, value, warehouses) VALUES ('8JN6', 'Papers', 75, 1);
INSERT INTO Packs(code, contents, value, warehouses) VALUES ('8Y6U', 'Papers', 50, 3);
INSERT INTO Packs(code, contents, value, warehouses) VALUES ('9J6F', 'Papers', 175, 2);
INSERT INTO Packs(code, contents, value, warehouses) VALUES ('LL08', 'Rocks', 140, 4);
INSERT INTO Packs(code, contents, value, warehouses) VALUES ('P0H6', 'Scissors', 125, 1);
INSERT INTO Packs(code, contents, value, warehouses) VALUES ('P2T6', 'Scissors', 150, 2);
INSERT INTO Packs(code, contents, value, warehouses) VALUES ('TUSS', 'Papers', 90, 5);

--4
select * from Packs;
--5
select * from Packs
where value > 190;
--6
select distinct contents
from Packs;
--7
select w.code ,
       COUNT(p.code)
from Warehouses w,
     Packs p
where w.code = p.warehouses
group by w.code;
--8
select w.code as warehouse_code,
       COUNT(p.code) as number_of_packs
from Warehouses w,
     Packs p
where w.code = p.warehouses
group by w.code
having COUNT(p.code) > 2;
--9
insert into Warehouses (code, location, capacity)
values ('code', 'Texas', 5);
--10
insert into Packs (code, contents, value, warehouses)
values ('H5RT', 'PAPERS', 150, 2);
--11
update Packs
set value = value * 0.82
where value in (
    select value
    from Packs
    order by value
    limit 1 offset 2
);
select value from Packs
order by value;
--12
delete from packs
where value < 150;
--13
delete from packs
where warehouses = 'Chicago';
