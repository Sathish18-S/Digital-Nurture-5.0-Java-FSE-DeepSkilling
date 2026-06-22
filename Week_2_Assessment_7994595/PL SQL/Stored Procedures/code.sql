-- =====================================
-- CREATE DATABASE
-- =====================================

CREATE DATABASE IF NOT EXISTS bank_db;
USE bank_db;


-- =====================================
-- CREATE TABLES
-- =====================================

CREATE TABLE savings_accounts (
    account_id INT PRIMARY KEY,
    customer_id INT,
    balance DECIMAL(12,2)
);

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(100),
    department_id INT,
    salary DECIMAL(10,2)
);

CREATE TABLE accounts (
    account_id INT PRIMARY KEY,
    customer_id INT,
    balance DECIMAL(12,2)
);

-- =====================================
-- INSERT DATA
-- =====================================

INSERT INTO savings_accounts VALUES
(201,1,10000.00),
(202,2,5000.00),
(203,3,20000.00);

INSERT INTO employees VALUES
(301,'Sathish',101,50000.00),
(302,'rajesh',102,45000.00),
(303,'viswas',101,55000.00),
(304,'hemanath',103,60000.00);

INSERT INTO accounts VALUES
(401,1,12000.00),
(402,2,8000.00),
(403,3,500.00);

-- =====================================
-- SCENARIO 1
-- Process Monthly Interest
-- Add 1% Interest
-- =====================================

SET SQL_SAFE_UPDATES = 0;

UPDATE savings_accounts
SET balance = balance + (balance * 0.01);

SELECT
    account_id,
    customer_id,
    balance
FROM savings_accounts;

-- =====================================
-- SCENARIO 2
-- Update Employee Bonus
-- Department 101 gets 10% bonus
-- =====================================

UPDATE employees
SET salary = salary + (salary * 0.10)
WHERE department_id = 101;

SELECT
    emp_id,
    name,
    department_id,
    salary
FROM employees;

-- =====================================
-- SCENARIO 3
-- Transfer Funds
-- Transfer 2000 from 401 to 402
-- =====================================

START TRANSACTION;

UPDATE accounts
SET balance = balance - 2000
WHERE account_id = 401;

UPDATE accounts
SET balance = balance + 2000
WHERE account_id = 402;

COMMIT;

SELECT * FROM accounts;

-- =====================================
-- FAILED TRANSFER EXAMPLE
-- Account 403 has only 500
-- Cannot transfer 1000
-- =====================================

SELECT
CASE
    WHEN balance >= 1000
    THEN 'Transfer Allowed'
    ELSE 'Transfer Failed - Insufficient Funds'
END AS Transfer_Status
FROM accounts
WHERE account_id = 403;

-- =====================================
-- FINAL OUTPUT
-- =====================================

SELECT * FROM savings_accounts;
SELECT * FROM employees;
SELECT * FROM accounts;