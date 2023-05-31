


/*------------------------------------------------------------------
 * Урок 3. SQL – выборка данных, сортировка, агрегатные функции
 */

create table if not exists salespeople (
	id int auto_increment primary key,
	snum int,
	sname varchar(20),
	city varchar(50),
	comm decimal(10, 2)
);

insert into salespeople (snum, sname, city, comm)
values 
(1001, 'Peel', 'London', 0.12),
(1002, 'Serres', 'San Jose', 0.13),
(1004, 'Motika', 'London', 0.11),
(1007, 'Rifkin', 'Barcelona', 0.15),
(1003, 'Axelrod', 'New York', 0.10);



create table if not exists customers (
	id int auto_increment primary key,
	cnum int,
	cname varchar(20),
	city varchar(50),
	rating int,
	snum int
);

insert into customers (cnum, cname, city, rating, snum)
values
(2001, 'Hoffman', 'London', 100, 1001),
(2002, 'Giovanni', 'Rome', 200, 1003),
(2003, 'Liu', 'San Jose', 200, 1002),
(2004, 'Grass', 'Berlin', 300, 1002),
(2006, 'Clemens', 'London', 100, 1001),
(2008, 'Cisneros', 'San Jose', 300, 1007),
(2007, 'Pereira', 'Rome', 100, 1004);


create table if not exists orders (
	id int auto_increment primary key, 
	onum int,
	amt decimal(10, 2),
	odate date,
	cnum int,
	snum int
);


insert into orders (onum, amt, odate, cnum, snum)
values
(3001, 18.69, '1990-10-03', 2008, 1007),
(3003, 767.19, '1990-10-03', 2001, 1001),
(3002, 1900.10, '1990-10-03', 2007, 1004),
(3005, 5160.45, '1990-10-03', 2003, 1002),
(3006, 1098.16, '1990-10-03', 2008, 1007),
(3009, 1713.23, '1990-10-04', 2002, 1003),
(3007, 75.75, '1990-10-04', 2004, 1002),
(3008, 4723.00, '1990-10-05', 2006, 1001),
(3010, 1309.95, '1990-10-06', 2004, 1002),
(3011, 9891.88, '1990-10-06', 2006, 1001);


-- Домашнее задание

-- 1)

-- 1. Напишите запрос, который вывел бы таблицу со столбцами в следующем порядке: city, sname, snum, comm. (к первой или второй таблице, используя SELECT)

select city, sname, snum, comm 
from salespeople;


-- 2. Напишите команду SELECT, которая вывела бы оценку(rating), сопровождаемую именем
--    каждого заказчика в городе San Jose. (“заказчики”)

select rating, cname
from customers
where city = 'San Jose';


-- 3. Напишите запрос, который вывел бы значения snum всех продавцов из таблицы заказов без
--    каких бы то ни было повторений. (уникальные значения в “snum“ “Продавцы”)

select distinct snum
from orders;

-- 5. Напишите запрос, который может дать вам все заказы со значениями суммы выше чем $1,000.
--    (“Заказы”, “amt” - сумма)

select * 
from orders
where amt > 1000;


-- 6. Напишите запрос который выбрал бы наименьшую сумму заказа.
--    (Из поля “amt” - сумма в таблице “Заказы” выбрать наименьшее значение)

select min(amt)
from orders;


-- 7. Напишите запрос к таблице “Заказчики”, который может показать всех заказчиков, у которых
--    рейтинг больше 100 и они находятся не в Риме.

select *
from customers 
where rating > 100 and city != 'Rome';


-- 2)

create table if not exists employees (
	id int auto_increment primary key,
	name varchar(20),
	surname varchar(20),
	specialty varchar(50),
	seniority int,
	salary int, 
	age int
);

insert into employees (name, surname, specialty, seniority, salary, age)
values
('Вася', 'Васыкин', 'начальник', 40, 100000, 60),
('Петя', 'Петькин', 'начальник', 8, 70000, 30),
('Катя', 'Каткина', 'инженер', 2, 70000, 25),
('Саша', 'Сашкин', 'инженер', 12, 50000, 35),
('Иван', 'Иванов', 'рабочий', 40, 30000, 59),
('Петр', 'Петров', 'рабочий', 20, 25000, 40),
('Сидор', 'Сидоров', 'рабочий', 10, 20000, 35),
('Антон', 'Антонов', 'рабочий', 8, 19000, 28),
('Юра', 'Юркин', 'рабочий', 5, 15000, 25),
('Максим', 'Воронин', 'рабочий', 2, 11000, 22),
('Юра', 'Галкин', 'рабочий', 3, 12000, 24),
('Люся', 'Люськина', 'уборщик', 10, 10000, 49);


-- 1. Отсортируйте поле “зарплата” в порядке убывания и возрастания

select *
from employees
order by salary;

select * 
from employees
order by salary desc;



-- 2. ** Отсортируйте по возрастанию поле “Зарплата” и выведите 5 строк с
--       наибольшей заработной платой (возможен подзапрос)

select * 
from employees 
order by salary
limit 5;


-- 3. Выполните группировку всех сотрудников по специальности ,
--    суммарная зарплата которых превышает 100000

select specialty, sum(salary) as total_salary 
from employees 
group by specialty
having total_salary > 100000;

