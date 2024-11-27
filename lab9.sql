--1
CREATE OR REPLACE FUNCTION increase_value(param INTEGER)
RETURNS INTEGER AS $$
BEGIN
    RETURN param + 10;
END; $$
LANGUAGE plpgsql;

-- 2.
CREATE OR REPLACE FUNCTION compare_numbers(num1 INTEGER, num2 INTEGER)
RETURNS TEXT AS $$
BEGIN
    IF num1 > num2 THEN
        RETURN 'Greater';
    ELSIF num1 = num2 THEN
        RETURN 'Equal';
    ELSE
        RETURN 'Lesser';
    END IF;
END; $$
LANGUAGE plpgsql;

-- 3.
CREATE OR REPLACE FUNCTION number_series(n INTEGER)
RETURNS TEXT AS $$
DECLARE
    result TEXT := '';
    i INTEGER := 1;
BEGIN
    WHILE i <= n LOOP
        result := result || i || ' ';
        i := i + 1;
    END LOOP;
    RETURN result;
END; $$
LANGUAGE plpgsql;

-- 4.
CREATE OR REPLACE FUNCTION find_employee(emp_name TEXT)
RETURNS TABLE (id INTEGER, name TEXT, salary NUMERIC) AS $$
BEGIN RETURN QUERY SELECT id, name, salary FROM employees WHERE name = emp_name;
END; $$
LANGUAGE plpgsql;

-- 5.
CREATE OR REPLACE FUNCTION list_products(category_name TEXT)
RETURNS TABLE (product_id INTEGER, product_name TEXT, price NUMERIC) AS $$
BEGIN
    RETURN QUERY SELECT id, name, price FROM products WHERE category = category_name;
END; $$
LANGUAGE plpgsql;

-- 6.
CREATE OR REPLACE FUNCTION calculate_bonus(salary NUMERIC)
RETURNS NUMERIC AS $$
BEGIN
    RETURN salary * 0.1;
END; $$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION update_salary(emp_id INTEGER)
RETURNS VOID AS $$
DECLARE
    current_salary NUMERIC;
    bonus NUMERIC;
BEGIN
    SELECT salary INTO current_salary FROM employees WHERE id = emp_id;
    bonus := calculate_bonus(current_salary);
    UPDATE employees SET salary = salary + bonus WHERE id = emp_id;
END; $$
LANGUAGE plpgsql;

-- 7.
CREATE OR REPLACE FUNCTION complex_calculation(
    num1 INTEGER, num2 INTEGER, str1 TEXT
)
RETURNS TEXT AS $$
DECLARE
    numeric_result INTEGER;
    string_result TEXT;
BEGIN
    numeric_result := num1 * num2;

    string_result := CONCAT('Processed: ', str1);

    RETURN CONCAT(string_result, ', Numeric Result: ', numeric_result);
END; $$
LANGUAGE plpgsql;