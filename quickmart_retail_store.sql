-- ============================================================
-- QUICKMART RETAIL STORE DATABASE PROJECT
-- ============================================================

-- ============================================================
-- CREATE DATABASE TABLES
-- ============================================================

DROP TABLE IF EXISTS sales;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(150),
    city VARCHAR(50) NOT NULL,
    phone_number VARCHAR(20)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    unit_price DECIMAL(12, 2) NOT NULL CHECK (unit_price >= 0),
    quantity_in_stock INT NOT NULL CHECK (quantity_in_stock >= 0)
);

CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    sale_date DATE NOT NULL,
    CONSTRAINT fk_sales_customer
        FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    CONSTRAINT fk_sales_product
        FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- ============================================================
-- INSERT CUSTOMER DATA
-- ============================================================

INSERT INTO customers (customer_id, customer_name, email, city, phone_number) VALUES
(1, 'Amina Bello', 'amina.bello@gmail.com', 'Lagos', '08031234567'),
(2, 'Chinedu Okafor', 'chinedu.okafor@gmail.com', 'Abuja', '08029876543'),
(3, 'Fatima Musa', 'fatima.musa@yahoo.com', 'Kano', '08134567890'),
(4, 'David Johnson', 'david.johnson@gmail.com', 'Port Harcourt', '07045678901'),
(5, 'Grace Adeyemi', NULL, 'Ibadan', '09051234567'),
(6, 'Ahmed Ibrahim', 'ahmed.ibrahim@gmail.com', 'Lagos', '08127894561'),
(7, 'Blessing Eze', 'blessing.eze@gmail.com', 'Abuja', '08066778899'),
(8, 'Esther Okoro', 'esther.okoro@gmail.com', 'Port Harcourt', '09012345678');

-- ============================================================
-- INSERT PRODUCT DATA
-- ============================================================

INSERT INTO products (product_id, product_name, category, unit_price, quantity_in_stock) VALUES
(1, 'Laptop', 'Electronics', 450000.00, 15),
(2, 'Phone', 'Electronics', 280000.00, 25),
(3, 'Tablet', 'Electronics', 180000.00, 18),
(4, 'Office Chair', 'Furniture', 85000.00, 35),
(5, 'Monitor', 'Electronics', 150000.00, 12),
(6, 'Keyboard', 'Accessories', 25000.00, 60),
(7, 'Mouse', 'Accessories', 15000.00, 75),
(8, 'Air Conditioner', 'Appliances', 320000.00, 10),
(9, 'Desk', 'Furniture', 120000.00, 22),
(10, 'Headphones', 'Accessories', 55000.00, 28);

-- ============================================================
-- INSERT SALES DATA
-- Customer 8 intentionally has no sales so the DELETE exercise
-- can be demonstrated safely with the existing foreign key.
-- ============================================================

INSERT INTO sales (sale_id, customer_id, product_id, quantity, sale_date) VALUES
(1, 1, 2, 1, '2026-01-05'),
(2, 2, 1, 1, '2026-01-10'),
(3, 3, 6, 2, '2026-01-15'),
(4, 4, 8, 1, '2026-02-02'),
(5, 5, 4, 2, '2026-02-10'),
(6, 6, 3, 1, '2026-02-18'),
(7, 1, 10, 3, '2026-03-01'),
(8, 7, 5, 1, '2026-03-08'),
(9, 2, 7, 4, '2026-03-15'),
(10, 3, 9, 1, '2026-03-20'),
(11, 4, 2, 2, '2026-04-05'),
(12, 6, 1, 1, '2026-04-12'),
(13, 5, 6, 3, '2026-04-20'),
(14, 1, 3, 2, '2026-05-03'),
(15, 7, 10, 1, '2026-05-18');

-- ============================================================
-- BASIC SELECT
-- ============================================================

SELECT * FROM customers;
SELECT * FROM products;
SELECT product_name, unit_price FROM products;
SELECT customer_name, city FROM customers;

-- ============================================================
-- WHERE
-- ============================================================

SELECT * FROM customers
WHERE city = 'Lagos';

SELECT * FROM products
WHERE category = 'Electronics';

SELECT * FROM products
WHERE unit_price > 100000;

SELECT * FROM products
WHERE quantity_in_stock < 20;

-- ============================================================
-- AND, OR, NOT
-- ============================================================

SELECT * FROM products
WHERE category = 'Electronics'
  AND unit_price > 200000;

SELECT * FROM customers
WHERE city = 'Lagos'
   OR city = 'Abuja';

SELECT * FROM customers
WHERE NOT city = 'Lagos';

-- ============================================================
-- IN
-- ============================================================

SELECT * FROM customers
WHERE city IN ('Lagos', 'Abuja', 'Port Harcourt');

-- ============================================================
-- BETWEEN
-- ============================================================

SELECT * FROM products
WHERE unit_price BETWEEN 50000 AND 300000;

SELECT * FROM sales
WHERE sale_date BETWEEN '2026-02-01' AND '2026-03-31';

-- ============================================================
-- LIKE
-- ============================================================

SELECT * FROM customers
WHERE customer_name LIKE 'A%';

SELECT * FROM customers
WHERE customer_name LIKE '%a';

SELECT * FROM customers
WHERE email LIKE '%@gmail.com';

-- ============================================================
-- NULL VALUES
-- ============================================================

SELECT * FROM customers
WHERE email IS NULL;

SELECT * FROM customers
WHERE email IS NOT NULL;

-- ============================================================
-- DISTINCT
-- ============================================================

SELECT DISTINCT city
FROM customers
ORDER BY city;

-- ============================================================
-- ORDER BY
-- ============================================================

SELECT * FROM products
ORDER BY unit_price ASC;

SELECT * FROM products
ORDER BY unit_price DESC;

SELECT * FROM customers
ORDER BY customer_name ASC;

-- ============================================================
-- LIMIT
-- ============================================================

SELECT * FROM products
ORDER BY unit_price DESC
LIMIT 5;

-- ============================================================
-- CUSTOMER UPDATE
-- Confirm first, then update, then verify.
-- ============================================================

SELECT * FROM customers
WHERE customer_id = 1;

UPDATE customers
SET city = 'Abuja'
WHERE customer_id = 1;

SELECT * FROM customers
WHERE customer_id = 1;

-- ============================================================
-- PRODUCT PRICE UPDATE
-- ============================================================

SELECT * FROM products
WHERE product_id = 4;

UPDATE products
SET unit_price = 90000.00
WHERE product_id = 4;

SELECT * FROM products
WHERE product_id = 4;

-- ============================================================
-- STOCK UPDATE
-- ============================================================

SELECT * FROM products
WHERE product_id = 7;

UPDATE products
SET quantity_in_stock = 68
WHERE product_id = 7;

SELECT * FROM products
WHERE product_id = 7;

-- ============================================================
-- DELETE A CUSTOMER
-- Customer 8 has no sales, so this demonstrates a safe delete.
-- ============================================================

SELECT * FROM customers
WHERE customer_id = 8;

DELETE FROM customers
WHERE customer_id = 8;

SELECT * FROM customers
WHERE customer_id = 8;

-- ============================================================
-- ALTER TABLE: REGISTRATION DATE
-- ============================================================

ALTER TABLE customers
ADD COLUMN registration_date DATE;

UPDATE customers SET registration_date = '2025-11-15' WHERE customer_id = 1;
UPDATE customers SET registration_date = '2025-11-20' WHERE customer_id = 2;
UPDATE customers SET registration_date = '2025-12-02' WHERE customer_id = 3;
UPDATE customers SET registration_date = '2025-12-10' WHERE customer_id = 4;
UPDATE customers SET registration_date = '2026-01-03' WHERE customer_id = 5;
UPDATE customers SET registration_date = '2026-01-08' WHERE customer_id = 6;
UPDATE customers SET registration_date = '2026-01-12' WHERE customer_id = 7;

SELECT * FROM customers;

-- ============================================================
-- ALTER TABLE: PRODUCT BRAND
-- ============================================================

ALTER TABLE products
ADD COLUMN brand VARCHAR(50);

UPDATE products SET brand = 'Dell' WHERE product_id = 1;
UPDATE products SET brand = 'Samsung' WHERE product_id = 2;
UPDATE products SET brand = 'Apple' WHERE product_id = 3;
UPDATE products SET brand = 'IKEA' WHERE product_id = 4;
UPDATE products SET brand = 'LG' WHERE product_id = 5;
UPDATE products SET brand = 'Logitech' WHERE product_id = 6;
UPDATE products SET brand = 'Logitech' WHERE product_id = 7;
UPDATE products SET brand = 'Hisense' WHERE product_id = 8;
UPDATE products SET brand = 'IKEA' WHERE product_id = 9;
UPDATE products SET brand = 'Sony' WHERE product_id = 10;

SELECT * FROM products;

-- ============================================================
-- UPSERT
-- PostgreSQL: insert product 10 if it does not exist;
-- otherwise update its price and stock.
-- ============================================================

INSERT INTO products
    (product_id, product_name, category, unit_price, quantity_in_stock, brand)
VALUES
    (10, 'Headphones', 'Accessories', 60000.00, 35, 'Sony')
ON CONFLICT (product_id)
DO UPDATE SET
    unit_price = EXCLUDED.unit_price,
    quantity_in_stock = EXCLUDED.quantity_in_stock;

SELECT * FROM products
WHERE product_id = 10;

-- ============================================================
-- FINAL CHALLENGE 1
-- 3 most expensive Electronics products
-- ============================================================

SELECT *
FROM products
WHERE category = 'Electronics'
ORDER BY unit_price DESC
LIMIT 3;

-- ============================================================
-- FINAL CHALLENGE 2
-- Customers from Lagos, Abuja or Port Harcourt with email
-- ============================================================

SELECT customer_id, customer_name, email, city
FROM customers
WHERE city IN ('Lagos', 'Abuja', 'Port Harcourt')
  AND email IS NOT NULL;

-- ============================================================
-- FINAL CHALLENGE 3
-- Products over ₦50,000 with fewer than 30 in stock
-- Lowest stock first
-- ============================================================

SELECT product_id, product_name, unit_price, quantity_in_stock
FROM products
WHERE unit_price > 50000
  AND quantity_in_stock < 30
ORDER BY quantity_in_stock ASC;

-- ============================================================
-- FINAL CHALLENGE 4
-- Sales between two dates present in the data
-- ============================================================

SELECT *
FROM sales
WHERE sale_date BETWEEN '2026-03-01' AND '2026-04-30'
ORDER BY sale_date;

-- ============================================================
-- FINAL CHALLENGE 5
-- Update phone number and city in one statement
-- ============================================================

SELECT * FROM customers
WHERE customer_id = 2;

UPDATE customers
SET phone_number = '08115554433',
    city = 'Lagos'
WHERE customer_id = 2;

SELECT * FROM customers
WHERE customer_id = 2;

-- ============================================================
-- END OF QUICKMART RETAIL STORE PROJECT
-- ============================================================




















