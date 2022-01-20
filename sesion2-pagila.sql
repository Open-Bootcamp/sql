
-- Explorar tablas
SELECT * FROM actor;
SELECT * FROM actor WHERE last_name = 'WAHLBERG';

SELECT * FROM address;
SELECT * FROM address WHERE district = 'California';
SELECT * FROM address WHERE district = 'California' AND postal_code = '17886';
SELECT * FROM address WHERE district = 'California' AND postal_code = '17886' OR postal_code = '2299';
SELECT * FROM address WHERE postal_code = '17886' OR postal_code = '2299';

SELECT * FROM category;
SELECT * FROM category WHERE name = 'Action';

SELECT * FROM city;
SELECT * FROM city WHERE city = 'Akron';
SELECT * FROM city WHERE city LIKE 'A%';

SELECT * FROM country;
SELECT * FROM country WHERE country = 'Spain';

SELECT * FROM customer;
SELECT * FROM customer WHERE last_name = 'WILLIAMS';
SELECT * FROM customer WHERE activebool = FALSE;
SELECT * FROM customer WHERE activebool = TRUE;

UPDATE customer SET activebool = FALSE WHERE customer_id = 1;
UPDATE customer SET activebool = TRUE WHERE customer_id = 1;

SELECT * FROM film;
SELECT * FROM film WHERE description = 'A Epic Drama of a Feminist And a Mad Scientist who must Battle a Teacher in The Canadian Rockies';
SELECT * FROM film WHERE description LIKE '%Drama%';

SELECT * FROM film_actor;
SELECT * FROM film_actor WHERE film_id = 1;
SELECT * FROM film_actor WHERE actor_id = 1;

SELECT * FROM film_category;

SELECT * FROM inventory;

SELECT * FROM language;
SELECT * FROM payment;
SELECT * FROM rental;
SELECT * FROM staff;
SELECT * FROM store;

-- insertar datos
select * from actor;

INSERT INTO actor (first_name, last_name) VALUES ('ALAN', 'SASTRE');


select * from customer;
select * from address;
select * from store;

INSERT INTO address (address, district, city_id, postal_code, phone)
VALUES ('Calle falsa', 'Nueva América', 300, '28004', '12334354352');

-- address 606

INSERT INTO customer(store_id, first_name, last_name, email, address_id, activebool, create_date)
VALUES (1, 'CUSTOMER NEW', 'LASTNAME EXAMPLE', 'customernew@company.com', 606, TRUE, '2021-12-1');






