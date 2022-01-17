## Sentencias DML
Data Manipulation Language

Operaciones **CRUD**:

* ==C==: Create --> ``INSERT INTO``
* ==R==: Retrieve o Read --> ``SELECT FROM`` 
* ==U==: Update -->  ``UPDATE``
* ==D==: Delete -->  ``DELETE FROM``


### 1. Recuperar datos (SELECT)

Recuperar todos los empleados:

```sql
SELECT * FROM employees;
```


### 2. Insertar nuevos datos (INSERT)

Insertar un nuevo empleado:

```sql
INSERT INTO employees (married, name, email, genre, salary, birth_date, start_at) VALUES (TRUE, 'Employee2', 'employee1@company.com', 'M', 29567.23, '1990-12-25', '08:30:00');
```

### 3. Actualizar datos (UPDATE)


### 4. Borrar datos (DELETE)