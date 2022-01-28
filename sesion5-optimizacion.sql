
/*
Importar base de datos:
1 - Crear base de datos northwind desde pgAdmin
2 - Ejecutar el comando para restaurar la base de datos:
	psql -U postgres -d northwind < northwind.sql
*/


/*
 Consultas de utilidad para explorar y administrar bases de datos y tablas
*/
-- Ver tamaño de las bases de datos
select pg_size_pretty (pg_database_size('northwind'))
select pg_size_pretty (pg_database_size('pagila'))

select pg_database.datname, pg_size_pretty (pg_database_size(pg_database.datname)) as size FROM pg_database;

-- ver tamaño de una tabla
select pg_size_pretty(pg_relation_size('orders'))

-- ver tamaño de las 10 tablas que más ocupan
SELECT
    relname AS "relation",
    pg_size_pretty (
        pg_total_relation_size (C .oid)
    ) AS "total_size"
FROM
    pg_class C
LEFT JOIN pg_namespace N ON (N.oid = C .relnamespace)
WHERE
    nspname NOT IN (
        'pg_catalog',
        'information_schema'
    )
AND C .relkind <> 'i'
AND nspname !~ '^pg_toast'
ORDER BY
    pg_total_relation_size (C .oid) DESC
LIMIT 10;


select current_schema();

select * from pg_matviews;

-- cargar extesiones
CREATE EXTENSION pgcrypto;

select * from employees
INSERT INTO employees (employee_id, last_name, first_name, notes) VALUES 
(11, 'em', 'Emp10', pgp_sym_encrypt('Emp10', 'password'))

SELECT employee_id, pgp_sym_decrypt(notes::bytea, 'password') as notes from employees;


/**
consultas joins
*/
select * from customers;
select * from orders;
select * from shippers;
select * from employees;

-- 1. INNER JOIN
select o.order_id, c.contact_name from orders o 
inner join customers c on o.customer_id = c.customer_id

select o.order_id, c.contact_name, s.company_name from orders o 
inner join customers c on o.customer_id = c.customer_id
inner join shippers s on o.ship_via = s.shipper_id

-- 2. LEFT JOIN
-- Fijarse en los resultados que aparecen 2 customers al final que no tienen order relacionada:
select c.contact_name, o.order_id from customers c 
left join orders o on c.customer_id = o.customer_id

select c.contact_name, o.order_id from customers c 
inner join orders o on c.customer_id = o.customer_id


-- 3. RIGHT JOIN
select o.order_id, e.first_name, e.last_name from orders o 
inner join employees e on o.employee_id = e.employee_id
-- Fijar que aparecen empleados sin order asociado
select o.order_id, e.first_name, e.last_name from orders o 
right join employees e on o.employee_id = e.employee_id

INSERT INTO employees (employee_id, last_name, first_name, title) VALUES 
(10, 'Emp10', 'Emp10', 'Director')


-- GROUP BY
select city, count(customer_id) as num_customers from customers group by city;
select city, count(customer_id) as num_customers from customers group by city order by city;
select city, count(customer_id) as num_customers from customers group by city order by num_customers;
select city, count(customer_id) as num_customers from customers group by city order by num_customers desc;

select country, count(customer_id) as num_customers from customers group by country order by num_customers desc;

select e.title, count(o.order_id) as num_orders  from orders o 
inner join employees e on o.employee_id = e.employee_id
group by e.title
order by num_orders desc

select e.first_name, e.last_name, count(o.order_id) as num_orders  from orders o 
inner join employees e on o.employee_id = e.employee_id
group by e.first_name, e.last_name
order by num_orders desc


/*
 vistas
 son una forma de guardar las consultas SQL bajo un identificador para ejecutarlas
 de manera más sencilla sin tener que repetir todo el código SQL
*/
create view num_orders_by_employee as
select e.first_name, e.last_name, count(o.order_id) as num_orders  from orders o 
inner join employees e on o.employee_id = e.employee_id
group by e.first_name, e.last_name
order by num_orders desc

select * from num_orders_by_employee;

/*
vistas materializadas

- guardan físicamente el resultado de una query y actualizan los datos periódicamente
- chachean el resultado de una query compleja y permiten refrescarlo
- para crear una vista materializada cargando datos tenemos la opción WITH DATA

CREATE MATERIALIZED VIEW [IF NOT EXISTS] view_name AS 
query
WITH [NO] DATA;
*/

create materialized view mv_num_orders_by_employee as
select e.first_name, e.last_name, count(o.order_id) as num_orders  from orders o 
inner join employees e on o.employee_id = e.employee_id
group by e.first_name, e.last_name
order by num_orders desc
with data

select * from mv_num_orders_by_employee;

select * from order_details;

create table example (
	id INT,
	name varchar
)

/**
 generate_series para generar datos de prueba
*/
select * from example

SELECT * FROM generate_series(1,10);

INSERT into example(id)
SELECT * FROM generate_series(1, 500000)


create materialized view mv_example as
select * from example
with data

select * from mv_example;

select * from generate_series(
	'2022-01-01 00:00'::timestamp,
	'2022-12-25 00:00',
	'6 hours'
)

/*
 EXPLAIN ANALYZE 
 permite mostrar el query planner y ver los tiempos: 
 */

EXPLAIN ANALYZE select * from order_details where unit_price < 9;
create index idx_order_details_unit_price on order_details(unit_price) where unit_price < 10;

EXPLAIN ANALYZE select * from num_orders_by_employee;
EXPLAIN ANALYZE select * from orders;

/* 
índices
Estructuras de datos que permiten optimizar las consultas en base a una columna o filtro en particular
con el fin de exitar escaneo secuencial de toda la tabla
*/
create index idx_orders_pk on orders(order_id);
EXPLAIN ANALYZE select * from orders;

EXPLAIN ANALYZE select * from example;
create index idx_example_pk on example(id);

EXPLAIN ANALYZE select * from example WHERE id = 456777;


/*
Particionamiento de tablas
Técnica que permite dividir una misma tabla en múltiples particiones con el objetivo de optimizar las consultas

Hay tres tipos:
- Rango
- Lista
- Hash
*/


-- Tabla base
CREATE TABLE users (
	id BIGSERIAL,
	birth_date DATE NOT NULL,
	first_name VARCHAR(20) NOT NULL,
	PRIMARY KEY(id, birth_date)
) PARTITION BY RANGE (birth_date);

-- particiones
CREATE TABLE users_2020 PARTITION OF users
FOR VALUES FROM ('2020-01-01') TO ('2021-01-01');

CREATE TABLE users_2021 PARTITION OF users
FOR VALUES FROM ('2021-01-01') TO ('2022-01-01');

CREATE TABLE users_2022 PARTITION OF users
FOR VALUES FROM ('2022-01-01') TO ('2023-01-01');

INSERT INTO users(birth_date, first_name) VALUES
('2020-01-15', 'User 1'),
('2020-06-15', 'User 2'),
('2021-02-15', 'User 3'),
('2021-11-15', 'User 4'),
('2022-04-15', 'User 5'),
('2022-12-15', 'User 6');

select * from users_2020;
select * from users_2021;
select * from users_2022;

EXPLAIN ANALYZE select * from users;
EXPLAIN ANALYZE select * from users where birth_date = '2020-06-15';
EXPLAIN ANALYZE select * from users where birth_date = '2021-02-15';
EXPLAIN ANALYZE select * from users where birth_date > '2021-02-14' and birth_date < '2022-12-16';
EXPLAIN ANALYZE select * from users where EXTRACT(month from birth_date) = 6 and EXTRACT(year from birth_date) = 2020



