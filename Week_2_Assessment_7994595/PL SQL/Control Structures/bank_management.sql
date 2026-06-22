
-- Create Database
CREATE DATABASE IF NOT EXISTS bank_db;
USE bank_db;

-- ==========================================
-- Create Customers Table
-- ==========================================

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    loan_interest_rate DECIMAL(5,2),
    balance DECIMAL(12,2),
    IsVIP CHAR(1) DEFAULT 'N'
);

-- ==========================================
-- Create Loans Table
-- ==========================================

CREATE TABLE loans (
    loan_id INT PRIMARY KEY,
    customer_id INT,
    due_date DATE,
    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);

-- ==========================================
-- Insert Sample Customer Data
-- ==========================================

INSERT INTO customers VALUES
(1, 'Harish', 65, 8.5, 45000, 'N');
(2, 'Gopi', 45, 9.0, 9000, 'N');
(3, 'Sharon', 70, 7.8, 20000, 'N');
(4,'Deepak',30,10.20,5000,'N');
(5,'Sathish',65,8.50,45000,'N'),
(6,'Rajesh',45,9.00,9000,'N'),
(7,'Hari',70,7.80,20000,'N'),


-- ==========================================
-- Insert Sample Loan Data
-- ==========================================

INSERT INTO loans VALUES

(101,1,DATE_ADD(CURDATE(), INTERVAL 15 DAY)),
(102,2,DATE_ADD(CURDATE(), INTERVAL 45 DAY)),
(103,3,DATE_ADD(CURDATE(), INTERVAL 10 DAY)),
(104,4,DATE_ADD(CURDATE(), INTERVAL 5 DAY));

-- ==========================================
-- Scenario 1:
-- Apply 1% Interest Discount
-- for Customers Above 60
-- ==========================================

SET SQL_SAFE_UPDATES = 0;

UPDATE customers
SET loan_interest_rate =
    loan_interest_rate - (loan_interest_rate * 0.01)
WHERE age > 60;

SELECT
    customer_id,
    name,
    age,
    loan_interest_rate
FROM customers;

-- ==========================================
-- Scenario 2:
-- Promote Customers to VIP
-- if Balance > 10000
-- ==========================================

UPDATE customers
SET IsVIP = 'Y'
WHERE balance > 10000;

SELECT
    customer_id,
    name,
    balance,
    IsVIP
FROM customers;

-- ==========================================
-- Scenario 3:
-- Loans Due Within Next 30 Days
-- ==========================================

SELECT
    l.loan_id,
    c.name,
    l.due_date
FROM loans l
JOIN customers c
ON l.customer_id = c.customer_id
WHERE l.due_date BETWEEN CURDATE()
AND DATE_ADD(CURDATE(), INTERVAL 30 DAY);

-- ==========================================
-- Display Final Data
-- ==========================================

SELECT * FROM customers;
SELECT * FROM loans;