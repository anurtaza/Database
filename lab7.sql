CREATE DATABASE lab7;
CREATE TABLE countries (
    country_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    population INTEGER,
    region VARCHAR(50)
);
CREATE TABLE departments (
    department_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    budget DECIMAL(15, 2),
    location VARCHAR(50)
);
CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    surname VARCHAR(50) NOT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    department_id INTEGER,
    hire_date DATE,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

INSERT INTO countries (name, population, region)
VALUES
('Kazakhstan', 18754440, 'Central Asia'),
('Canada', 38005238, 'North America'),
('Germany', 83166711, 'Europe');

INSERT INTO departments (name, budget, location)
VALUES
('IT', 100000.00, 'Almaty'),
('HR', 50000.00, 'Astana'),
('Finance', 200000.00, 'Almaty');

INSERT INTO employees (name, surname, salary, department_id, hire_date)
VALUES
('Johnathan', 'Doe', 60000, 1, '2020-01-15'),
('Arsen', 'Raiymbek', 75000, 2, '2019-08-01'),
('Anara', 'Armankyzy', 50000, 3, '2021-06-12');


-- Task 1
CREATE INDEX country_name_idx ON countries (name);
SELECT * FROM countries WHERE name = 'Kazakhstan';

-- Task 2
CREATE INDEX employee_full_name_idx ON employees (name, surname);
SELECT * FROM employees WHERE name = 'John' AND surname = 'Doe';

-- Task 3
CREATE UNIQUE INDEX employee_salary_idx ON employees (salary);
SELECT * FROM employees WHERE salary > 30000 AND salary < 80000;

-- Task 4
CREATE INDEX employee_name_prefix_idx ON employees ((substring(name from 1 for 4)));
SELECT * FROM employees WHERE substring(name from 1 for 4) = 'John';

-- Task 5
CREATE INDEX employee_dept_salary_idx ON employees (department_id, salary);
CREATE INDEX department_budget_idx ON departments (department_id, budget);
