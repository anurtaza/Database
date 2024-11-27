-- stored_procedures.sql
-- SQL Script for Stored Procedures

-- Task 1: Stored Procedure to Increase Value
DELIMITER //
CREATE PROCEDURE increase_value(IN input_value INT, OUT result_value INT)
BEGIN
    SET result_value = input_value + 10;
END //
DELIMITER ;

-- Task 2: Stored Procedure to Compare Numbers
DELIMITER //
CREATE PROCEDURE compare_numbers(IN num1 INT, IN num2 INT, OUT result VARCHAR(10))
BEGIN
    IF num1 > num2 THEN
        SET result = 'Greater';
    ELSEIF num1 = num2 THEN
        SET result = 'Equal';
    ELSE
        SET result = 'Lesser';
    END IF;
END //
DELIMITER ;

-- Task 3: Stored Procedure for Number Series
DELIMITER //
CREATE PROCEDURE number_series(IN n INT, OUT series TEXT)
BEGIN
    DECLARE i INT DEFAULT 1;
    SET series = '';
    WHILE i <= n DO
        SET series = CONCAT(series, i, ' ');
        SET i = i + 1;
    END WHILE;
END //
DELIMITER ;

-- Task 4: Stored Procedure to Find Employee
DELIMITER //
CREATE PROCEDURE find_employee(IN emp_name VARCHAR(50), OUT emp_details TEXT)
BEGIN
    SELECT CONCAT('Name: ', name, ', Position: ', position, ', Salary: ', salary) 
    INTO emp_details
    FROM employees
    WHERE name = emp_name;
END //
DELIMITER ;

-- Task 5: Stored Procedure to List Products by Category
DELIMITER //
CREATE PROCEDURE list_products(IN category_name VARCHAR(50))
BEGIN
    SELECT * FROM products WHERE category = category_name;
END //
DELIMITER ;

-- Task 6: Nested Stored Procedures for Bonus Calculation and Salary Update
DELIMITER //
CREATE PROCEDURE calculate_bonus(IN emp_id INT, OUT bonus_amount DECIMAL(10, 2))
BEGIN
    SELECT salary * 0.1 INTO bonus_amount FROM employees WHERE id = emp_id;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE update_salary(IN emp_id INT)
BEGIN
    DECLARE bonus DECIMAL(10, 2);
    CALL calculate_bonus(emp_id, bonus);
    UPDATE employees SET salary = salary + bonus WHERE id = emp_id;
END //
DELIMITER ;

-- Task 7: Complex Calculation with Nested Subblocks
DELIMITER //
CREATE PROCEDURE complex_calculation(
    IN num_param INT,
    IN str_param VARCHAR(50),
    OUT final_result VARCHAR(100)
)
BEGIN
    DECLARE numeric_result INT;
    DECLARE string_result VARCHAR(50);
    
    main_block: BEGIN
        subblock_1: BEGIN
            SET numeric_result = num_param * 2;
        END subblock_1;

        subblock_2: BEGIN
            SET string_result = CONCAT('Processed-', str_param);
        END subblock_2;

        SET final_result = CONCAT(string_result, ', Value: ', numeric_result);
    END main_block;
END //
DELIMITER ;
