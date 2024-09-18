--1
CREATE DATABASE lab1;

--CREATE DATABASE IF NOT EXISTS lab1;

--2
CREATE TABLE users (
    id SERIAL PRIMARY KEY,  -- Автоинкрементирующийся id
    firstname VARCHAR(50),  -- Поле firstname с максимальной длиной 50 символов
    lastname VARCHAR(50)    -- Поле lastname с максимальной длиной 50 символов
);

--3
ALTER TABLE users ADD COLUMN isadmin INT;

--4
ALTER TABLE users
ALTER COLUMN isadmin TYPE BOOLEAN
USING isadmin::boolean;


--5
ALTER TABLE users ALTER COLUMN isadmin SET DEFAULT FALSE;

--6
-- Первичный ключ для поля id был уже добавлен в шаге 2 (через PRIMARY KEY)

--7
CREATE TABLE tasks (
    id SERIAL PRIMARY KEY,  -- Автоинкрементирующийся id
    name VARCHAR(50),       -- Поле name с максимальной длиной 50 символов
    user_id INT,            -- Поле user_id для связывания с таблицей users
    FOREIGN KEY (user_id) REFERENCES users(id)  -- Внешний ключ для связи с таблицей users
);

--8
DROP TABLE tasks;


--9
DROP DATABASE IF EXISTS lab1;





---пример

-- Создание таблицы users
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    firstname VARCHAR(50),
    lastname VARCHAR(50),
    isadmin BOOLEAN DEFAULT FALSE
);

-- Создание таблицы tasks
CREATE TABLE IF NOT EXISTS tasks (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    user_id INT,
    FOREIGN KEY (user_id) REFERENCES users(id)
);
-- Добавление данных в таблицу users
INSERT INTO users (firstname, lastname, isadmin)
VALUES ('John', 'Doe', TRUE), ('Jane', 'Smith', FALSE);

-- Добавление данных в таблицу tasks
INSERT INTO tasks (name, user_id)
VALUES ('Complete Lab', 1), ('Prepare for Exam', 2);

-- Просмотр данных
SELECT * FROM users;
SELECT * FROM tasks;

