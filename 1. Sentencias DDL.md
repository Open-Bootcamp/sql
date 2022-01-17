## Sentencias DDL
Data Definition Language


Operaciones con **Bases de datos**:

* Crear base de datos: ``CREATE DATABASE employees2;``
* Borrar una base de datos: ``DROP DATABASE employees2;``


Operaciones con **Tablas**:

* Crear tablas: ``CREATE TABLE IF NOT EXISTS employees (...);``
* Borrar tablas: ``DROP TABLE IF EXISTS employees;``
* Cambiar el nombre de una tabla:
	*  ``ALTER TABLE IF EXISTS employees RENAME TO employees_2021;``
* Agregar columnas a una tabla:
	* ``ALTER TABLE employees ADD COLUMN email VARCHAR(100);``
* Borrar columnas de una tabla:
	* ``ALTER TABLE employees DROP COLUMN IF EXISTS salary;``


**Tipos de datos** en tablas:

* ``INT``
* ``BOOLEAN``
* ``CHAR``, ``VARCHAR``, ``TEXT``
* ``NUMERIC``
* ``DATE``
* ``TIME``
* ``SERIAL``

**Restricciones** en las columnas de las tablas:

* ``PRIMARY KEY``
* ``NOT NULL``
* ``UNIQUE``
* ``CHECK``