CREATE TABLE locations (
    location_id SERIAL PRIMARY KEY,
    street_code VARCHAR(25),
    city VARCHAR(30),
    state_province VARCHAR(12)
);

CREATE TABLE departments (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(50) UNIQUE,
    budget INTEGER,
    location_id INTEGER REFERENCES locations(location_id)
);

CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(50),
    phone_number VARCHAR(20),
    salary INTEGER,
    department_id INTEGER REFERENCES departments(department_id)
);


SELECT
    employees.first_name,
    employees.last_name,
    employees.department_id,
    departments.department_name
FROM
    employees
JOIN
    departments ON employees.department_id = departments.department_id;


SELECT
    employees.first_name,
    employees.last_name,
    employees.department_id,
    departments.department_name
FROM
    employees
JOIN
    departments ON employees.department_id = departments.department_id
WHERE
    employees.department_id IN (80, 40);


SELECT
    employees.first_name,
    employees.last_name,
    departments.department_name,
    locations.city,
    locations.state_province
FROM
    employees
JOIN
    departments ON employees.department_id = departments.department_id
JOIN
    locations ON departments.location_id = locations.location_id;


SELECT
    departments.department_id,
    departments.department_name,
    employees.employee_id,
    employees.first_name,
    employees.last_name
FROM
    departments
LEFT JOIN
    employees ON departments.department_id = employees.department_id;


SELECT
    employees.first_name,
    employees.last_name,
    employees.department_id,
    departments.department_name
FROM
    employees
LEFT JOIN
    departments ON employees.department_id = departments.department_id;