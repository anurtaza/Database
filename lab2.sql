--LAB2


--2.1
CREATE DATABASE lab2;


--2.2
CREATE TABLE countries(
    country_id   SERIAL PRIMARY KEY,
    country_name VARCHAR(50),
    region_id    INT,
    population   INT
);



--2.3
INSERT INTO countries(country_name, region_id, population)
VALUES ('China', 1, 1419321278);



--2.4
INSERT INTO countries(country_name)
VALUES ('Germany');


--2.5
INSERT INTO countries(country_name, region_id, population)
VALUES ('India', NULL, 1453980647);



--2.6
INSERT INTO countries(country_name, region_id, population)
VALUES
    ('Australia', 2, 26713205 ),
    ('US', 3, 345426571),
    ('Pakistan', 4, 252197089);


--2.7
ALTER TABLE countries
ALTER COLUMN country_name SET DEFAULT 'Kazakstan';


--2.8
INSERT INTO countries(population,region_id)
VALUES (19000000, 1);


--2.9
INSERT INTO countries DEFAULT VALUES;


--2.10
CREATE TABLE countries_new (LIKE countries INCLUDING ALL);


--2.11
INSERT INTO countries_new (country_id, country_name, region_id, population)
SELECT country_id, country_name, region_id, population FROM countries;


--2.12
UPDATE countries
SET region_id=1
WHERE region_id IS NULL;


--2.13
UPDATE countries
SET population = population * 1.1
RETURNING country_name, population  AS "New Population";



--2.14
DELETE FROM countries
WHERE population < 100000;


--2.15
DELETE FROM countries_new
WHERE country_id IN (SELECT country_id FROM countries)


--2.16
DELETE FROM countries
RETURNING *;