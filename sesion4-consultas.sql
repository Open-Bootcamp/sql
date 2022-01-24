/* BASE DE DATOS PAGILA */

/*
 distinct
*/

-- 604 resultados
select * from address;

-- 604 resultados
select district from address;

-- obtener distritos únicos 379 resultados
select distinct district from address;

-- 600 resultados
select first_name from customer;

-- 592 resultados
select distinct first_name from customer;


/*
 and, or, not
 order by
 
 and: se tienen que cumplir si o si las condiciones
 or: con que se cumpla una condición es suficiente
 not: niega una condición
*/
select * from address where district = 'California';
select * from address where district != 'California';
select * from address where not district = 'California';
select * from address where not district = 'California' order by district;

select * from address where district = 'Abu Dhabi' or district = 'California';

select * from address where district is not null order by district;
select * from address where not district = '' order by district;

select * from address where address2 is not null and address_id = 1 order by district;

/*
	group by
*/

select address_id, district from address;
select district, count(district) from address group by district;
select district, count(district) from address group by district order by district;
select district, count(district) as veces  from address group by district order by district;

SELECT * FROM actor;
SELECT last_name, count(last_name) from actor group by last_name;
SELECT last_name, count(last_name) from actor group by last_name HAVING count(last_name) > 1;

-- obtener en cuantas películas actúa cada actor:
select * from film_actor;
select * from film;

select f.title, count(fa.actor_id) from film f
inner join film_actor fa on f.film_id = fa.film_id
group by f.title

-- stock de una película en base a su título
select * from inventory;

select f.title, count(i.inventory_id) as unidades from film f
inner join inventory i on i.film_id = f.film_id
GROUP BY title;

select f.title, count(i.inventory_id) as unidades from film f
inner join inventory i on i.film_id = f.film_id
WHERE title = 'FICTION CHRISTMAS'
GROUP BY title;

select f.title, count(i.inventory_id) as unidades from film f
inner join inventory i on i.film_id = f.film_id
GROUP BY title ORDER BY unidades;

select f.title, count(i.inventory_id) as unidades from film f
inner join inventory i on i.film_id = f.film_id
GROUP BY title ORDER BY unidades DESC;

/*
 SUM()
 */
 select * from customer;
  select * from payment;

SELECT * FROM payment p
inner join customer c on p.customer_id = c.customer_id

SELECT c.email, count(p.payment_id) as num_pagos FROM payment p
inner join customer c on p.customer_id = c.customer_id
group by c.email

SELECT c.email, sum(p.amount) as num_pagos FROM payment p
inner join customer c on p.customer_id = c.customer_id
group by c.email

select * from staff;

select * from payment p
inner join staff s on p.staff_id = s.staff_id

select s.first_name, count(p.payment_id) as num_ventas, sum(p.amount) cantidad_ventas from payment p
inner join staff s on p.staff_id = s.staff_id
group by s.first_name


-- joins

select * from customer;
select * from address;
select * from city;
select * from country;

-- consulta a 2 tablas: customer y address

select first_name, last_name, customer.address_id from customer 
inner join address on customer.address_id = address.address_id

select * from customer c
inner join address a on c.address_id = a.address_id

select c.email, a.address from customer c
inner join address a on c.address_id = a.address_id

-- consulta a 3 tablas: customer, address, city
SELECT * FROM customer cu
INNER JOIN address a ON cu.address_id = a.address_id
INNER JOIN city ci ON a.city_id = ci.city_id

SELECT cu.email, a.address, ci.city  FROM customer cu
INNER JOIN address a ON cu.address_id = a.address_id
INNER JOIN city ci ON a.city_id = ci.city_id

-- consulta a 4 tablas: customer, address, city, country
SELECT *  FROM customer cu
INNER JOIN address a ON cu.address_id = a.address_id
INNER JOIN city ci ON a.city_id = ci.city_id
INNER JOIN country co ON ci.country_id = co.country_id

SELECT cu.email, a.address, ci.city, co.country  FROM customer cu
INNER JOIN address a ON cu.address_id = a.address_id
INNER JOIN city ci ON a.city_id = ci.city_id
INNER JOIN country co ON ci.country_id = co.country_id


/*
 Función concat()
*/
select * from actor;

select first_name, last_name from actor;

select concat(first_name, ' ', last_name) from actor;

select concat(first_name, ' ', last_name) as full_name from actor;

/*
 LIKE
*/
select * from film;

SELECT * from film WHERE description LIKE '%Monastery';
SELECT * from film WHERE description LIKE '%Drama%';

select * from actor

select * from actor where last_name like '%LI%';
-- Orden ascendente, empieza por el principio y va hasta el final
select * from actor where last_name like '%LI%' order by last_name;
-- Orden descendente, empieza por el final y va hasta el principio
select * from actor where last_name like '%LI%' order by last_name DESC;


/*
 IN
*/

select * from country;

select * from country where country = 'Spain';
select * from country where country = 'Spain' or country = 'Germany';
select * from country where country = 'Spain' or country = 'Germany' or country = 'France';

SELECT * FROM country WHERE country IN('Spain', 'Germany', 'France', 'Mexico');

select * from customer;

SELECT * FROM customer WHERE customer_id = 15;

SELECT * FROM customer WHERE customer_id IN(15, 16, 17, 18);


/*
 Sub queries
*/

select * from film;
select * from language;

select distinct language_id from film;

select * from film f
inner join language l on f.language_id = l.language_id 

select l.name, count(f.film_id) from film f
inner join language l on f.language_id = l.language_id 
group by l.name

-- Cambiar idioma a algunas películas
UPDATE film SET language_id = 2 WHERE film_id > 100 and film_id < 200;
UPDATE film SET language_id = 3 WHERE film_id >= 200 and film_id < 300;
UPDATE film SET language_id = 4 WHERE film_id >= 300 and film_id < 400;

SELECT title from film
where language_id = (SELECT language_id FROM language WHERE name = 'English')

SELECT title from film
where language_id IN (SELECT language_id FROM language WHERE name = 'English' or name = 'Italian')

-- peliculas más alquiladas

select * from rental;
select * from inventory;
select * from film;


SELECT * from film f
inner join (select * from inventory i
inner join rental r on r.inventory_id = i.inventory_id) res on res.film_id = f.film_id
 
SELECT f.title, count(f.film_id) as veces_alquilada from film f
inner join (select * from inventory i
inner join rental r on r.inventory_id = i.inventory_id) res on res.film_id = f.film_id
group by f.title
order by veces_alquilada DESC


/* BASE DE DATOS concesionario */

select * from customer;
select * from employee;
select * from extra;
select * from extra_version;
select * from manufacturer;
select * from model;
select * from sale;
select * from vehicle;
select * from version;

-- count ventas por empleado

INSERT INTO sale(sale_date, channel, id_vehicle, id_employee, id_customer)
VALUES('2022-01-01', 'Phone', 1, 1, 1);

select * from sale s
inner join employee e on s.id_employee = e.id

select e.name, count(s.id) from sale s
inner join employee e on s.id_employee = e.id
group by e.name

-- count compras por cliente
select c.email, count(s.id) from sale s
inner join customer c on s.id_customer = c.id
group by c.email

-- fabricante mas vendido
select * from sale;
select * from vehicle;
select * from manufacturer;

select * from sale s
inner join vehicle v on s.id_vehicle = v.id
inner join manufacturer m on v.id_manufacturer = m.id

select m.name, count(s.id) from sale s
inner join vehicle v on s.id_vehicle = v.id
inner join manufacturer m on v.id_manufacturer = m.id
group by m.name

-- modelo mas vendido

-- version mas vendido

-- extra vendido

-- ventas agrupando por año, mes, dia
