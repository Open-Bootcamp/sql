/* Sentencias DML: Data Manipulation Language
	CRUD: 
	
	Create (INSERT INTO)
	Read (SELECT FROM), 
	Update (UPDATE SET)
	Delete (DELETE FROM)
*/

-- 1. Consultas o recuperación de datos

SELECT * FROM employees;

SELECT id FROM employees;

SELECT id, email FROM employees;

SELECT email, id FROM employees;

SELECT id, email, salary FROM employees;

-- Filtrar filas
SELECT * FROM employees WHERE id = 1;

SELECT * FROM employees WHERE name = 'Employee1';

SELECT * FROM employees WHERE married = 'true';

SELECT * FROM employees WHERE married = TRUE;

SELECT * FROM employees WHERE birth_date = '1990-12-25';

SELECT * FROM employees WHERE married = TRUE AND salary > 10000;


-- 2. Inserción de datos

INSERT INTO employees(name, email) VALUES ('Juan', 'juan@company.com');

INSERT INTO employees(name, email, married, genre, salary) 
VALUES ('antonio4', 'antonio4@company.com', TRUE, 'M', 23566.43);

INSERT INTO employees(name, email, married, genre, salary, birth_date, start_at) 
VALUES ('francisco', 'francisco@company.com', TRUE, 'M', 23566.43, '1987-5-29', '10:00:00');

INSERT INTO employees(name, email, married, genre, salary, birth_date, start_at) 
VALUES ('Rosa', 'rosa@company.com', FALSE, 'F', 34543.43, '1990-5-29', '10:00:00');

INSERT INTO employees(name, email, married, genre, salary, birth_date, start_at) 
VALUES ('Alberto', 'alberto@company.com', FALSE, 'M', 32421.43, '1988-5-29', '10:00:00');

INSERT INTO employees
VALUES (9, TRUE, 'francisco3', 'francisco3@company.com', 'M', 23566.43, '1987-5-29', '10:00:00');


-- 3. Actualizar o editar

UPDATE employees SET birth_date = '2000-03-12';

UPDATE employees SET birth_date = '2000-03-12' WHERE id = 5;

UPDATE employees SET salary = 45000 WHERE email = 'juan@company.com';

UPDATE employees SET genre = 'M', start_at = '08:30:00' WHERE email = 'juan@company.com';

UPDATE employees SET genre = 'M', start_at = '08:30:00' WHERE email = 'noexiste@company.com';

UPDATE employees SET genre = 'M', start_at = '08:30:00' WHERE email = 'juan@company.com' RETURNING *;

UPDATE employees SET genre = NULL WHERE id = 14;

-- 4. Borrar
SELECT * FROM employees;

DELETE FROM employees;

DELETE FROM employees WHERE married = TRUE;

DELETE FROM employees WHERE salary < 33000;

DELETE FROM employees WHERE salary IS NULL;






