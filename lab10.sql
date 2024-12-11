-- Создание таблиц

-- Таблица Books
CREATE TABLE Books (
    book_id SERIAL PRIMARY KEY,   -- Уникальный идентификатор книги
    title VARCHAR(255),           -- Название книги
    author VARCHAR(255),          -- Автор книги
    price DECIMAL(10, 2),         -- Цена книги
    quantity INT                  -- Количество книг в наличии
);

-- Таблица Customers
CREATE TABLE Customers (
    customer_id SERIAL PRIMARY KEY, -- Уникальный идентификатор клиента
    customer_name VARCHAR(255),     -- Имя клиента (изменил с name на customer_name для избежания конфликтов)
    email VARCHAR(255)              -- Электронная почта клиента
);

-- Таблица Orders
CREATE TABLE Orders (
    order_id SERIAL PRIMARY KEY,       -- Уникальный идентификатор заказа
    book_id INT,                       -- Идентификатор книги
    customer_id INT,                   -- Идентификатор клиента
    order_date DATE,                   -- Дата заказа
    quantity INT,                      -- Количество заказанных книг
    FOREIGN KEY (book_id) REFERENCES Books(book_id),    -- Внешний ключ на таблицу Books
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)  -- Внешний ключ на таблицу Customers
);

-- Вставка тестовых данных в таблицу Books
INSERT INTO Books (title, author, price, quantity)
VALUES
('Database 101', 'A. Smith', 40.00, 10),
('Learn SQL', 'B. Johnson', 35.00, 15),
('Advanced DB', 'C. Lee', 50.00, 5);

-- Вставка тестовых данных в таблицу Customers
INSERT INTO Customers (customer_name, email)
VALUES
('John Doe', 'johndoe@example.com'),
('Jane Doe', 'janedoe@example.com');

-- Задача 1: Транзакция для оформления заказа
BEGIN ;

-- Вставка нового заказа в таблицу Orders
INSERT INTO Orders (book_id, customer_id, order_date, quantity)
VALUES (1, 101, CURRENT_DATE, 2);

-- Обновление таблицы Books для уменьшения количества книги с book_id = 1
UPDATE Books
SET quantity = quantity - 2
WHERE book_id = 1;

-- Завершение транзакции
COMMIT;

-- Задача 2: Транзакция с откатом (Rollback)
START TRANSACTION;

-- Попытка вставки нового заказа для customer_id = 102, который хочет заказать 10 книг с book_id = 3
-- Проверяем, достаточно ли книг в наличии (в наличии только 5 книг)
SELECT quantity FROM Books WHERE book_id = 3;

-- Поскольку количество книг меньше 10, откатываем транзакцию
ROLLBACK;

-- Задача 3: Демонстрация уровня изоляции
-- Сессия 1: начинаем транзакцию с уровнем изоляции READ COMMITTED
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
START TRANSACTION;

-- Обновляем цену книги с book_id = 1
UPDATE Books
SET price = 45.00
WHERE book_id = 1;

-- Завершаем транзакцию
COMMIT;

-- Сессия 2: начинаем другую транзакцию с тем же уровнем изоляции
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
START TRANSACTION;

-- Читаем обновленную цену для книги с book_id = 1
SELECT price FROM Books WHERE book_id = 1;

-- Завершаем транзакцию
COMMIT;

-- Задача 4: Проверка долговечности изменений
START TRANSACTION;

-- Обновляем email клиента с customer_id = 101
UPDATE Customers
SET email = 'newemail@example.com'
WHERE customer_id = 101;

-- Завершаем транзакцию
COMMIT;

-- Перезагружаем сервер базы данных
-- (Это делается вручную в вашей СУБД)

-- После перезагрузки проверяем, что изменения сохранились
SELECT email FROM Customers WHERE customer_id = 101;

