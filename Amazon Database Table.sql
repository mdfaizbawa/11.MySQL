CREATE DATABASE AmazonDB;

USE AmazonDB;

CREATE TABLE users(
user_id INT PRIMARY KEY AUTO_INCREMENT,
firstname VARCHAR(100) NOT NULL,
email VARCHAR(150) UNIQUE NOT NULL,
registered_date DATE NOT NULL,
membership ENUM('Basic','Prime') DEFAULT 'Basic');

CREATE TABLE Products(
product_id INT PRIMARY KEY AUTO_INCREMENT,
firstname VARCHAR(200) NOT NULL,
price DECIMAL(10,2) NOT NULL,
category VARCHAR(100) NOT NULL,
stock INT NOT NULL);

ALTER TABLE products
CHANGE firstname productname VARCHAR(200) NOT NULL;

CREATE TABLE orders(
order_id INT PRIMARY KEY AUTO_INCREMENT,
user_id INT,
order_date DATE NOT NULL,
total_amount DECIMAL(10,2) NOT NULL,
FOREIGN KEY (user_id) REFERENCES users(user_id));

CREATE TABLE OrderDetails(
order_details INT PRIMARY KEY AUTO_INCREMENT, 
order_id INT,
product_id INT,
quantity INT NOT NULL,
FOREIGN KEY (order_id) REFERENCES orders(order_id),
FOREIGN KEY (product_id) REFERENCES Products(product_id));

SELECT* FROM products;

INSERT INTO users(firstname, email, registered_date, membership)
VALUES('Alice Johnson', 'alice.j@example.com', '2024-01-15', 'Prime'),
('Bob Smith', 'bob.s@example.com', '2024-02-01', 'Basic'),
('Charlie Brown', 'charlie.b@example.com', '2024-03-10', 'Prime'),
('Daisy Ridley', 'daisy.r@example.com', '2024-04-12', 'Basic');

INSERT INTO Products(firstname, price, category, stock) 
VALUES
('Echo Dot', 49.99, 'Electronics', 120),
('Kindle Paperwhite', 129.99, 'Books', 50),
('Fire Stick', 39.99, 'Electronics', 80),
('Yoga Mat', 19.99, 'Fitness', 200),
('Wireless Mouse', 24.99, 'Electronics', 150);

INSERT INTO orders (user_id, order_date, total_amount)
VALUES
(1, '2024-05-01', 79.98),
(2, '2024-05-03', 129.99),
(1, '2024-05-04', 49.99),
(3, '2024-05-05', 24.99);

INSERT INTO OrderDetails (order_id, product_id, quantity) 
VALUES
(1, 1, 2),
(2, 2, 1),
(3, 1, 1),
(4, 5, 1);



