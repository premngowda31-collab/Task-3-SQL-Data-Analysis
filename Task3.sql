CREATE DATABASE IF NOT EXISTS ecommerce;
USE ecommerce;

DROP TABLE IF EXISTS order_details;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10,2)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_details (
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

INSERT INTO customers VALUES
(1, 'Prem', 'Bangalore'),
(2, 'Rahul', 'Delhi'),
(3, 'Ankit', 'Mumbai');

INSERT INTO products VALUES
(101, 'Laptop', 50000),
(102, 'Phone', 20000),
(103, 'Headphones', 2000);

INSERT INTO orders VALUES
(1, 1, '2024-01-10', 52000),
(2, 2, '2024-01-11', 20000),
(3, 1, '2024-01-15', 50000);

INSERT INTO order_details VALUES
(1, 101, 1),
(1, 103, 1),
(2, 102, 1),
(3, 101, 1);

SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM order_details;

SELECT c.name, o.order_id, o.amount
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id;

SELECT customer_id, SUM(amount) AS total_spent
FROM orders
GROUP BY customer_id;


SELECT * FROM orders
ORDER BY amount DESC;

SELECT name
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
    WHERE amount > 30000
);

CREATE OR REPLACE VIEW customer_spending AS
SELECT customer_id, SUM(amount) AS total_spent
FROM orders
GROUP BY customer_id;

SELECT * FROM customer_spending;

CREATE INDEX idx_customer ON orders(customer_id);