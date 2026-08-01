create database ecommerce;
use ecommerce;

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    city VARCHAR(50),
    state VARCHAR(50),
    join_date DATE
);

show tables;

CREATE TABLE Categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100) NOT NULL,
    category_id INT,
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT NOT NULL,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE NOT NULL,
    total_amount DECIMAL(10,2) NOT NULL,
    order_status VARCHAR(30),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Order_Items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT NOT NULL,
    item_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

CREATE TABLE Payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    payment_method VARCHAR(50) NOT NULL,
    payment_status VARCHAR(30) NOT NULL,
    payment_date DATE,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

INSERT INTO Categories (category_name) VALUES
('Electronics'),
('Clothing'),
('Books'),
('Home & Kitchen'),
('Sports');
SELECT*FROM Categories;

INSERT INTO Customers (customer_name, email, phone, city, state, join_date) VALUES
('Vaishu','vaishu@gmail.com','9876543210','Coimbatore','Tamil Nadu','2025-01-10'),
('Sudhi','sudhi@gmail.com','9876543211','Chennai','Tamil Nadu','2025-01-12'),
('Rahul','rahul@gmail.com','9876543212','Bangalore','Karnataka','2025-01-15'),
('Arun','arun@gmail.com','9876543213','Hyderabad','Telangana','2025-01-18'),
('Sruthi','sruthi@gmail.com','9876543214','Kochi','Kerala','2025-01-20');
SELECT*FROM Customers;

INSERT INTO Products (product_name, category_id, price, stock_quantity) VALUES
('iPhone 15', 1, 79999.00, 25),
('Samsung Galaxy S24', 1, 69999.00, 30),
('Men T-Shirt', 2, 799.00, 100),
('Women Jeans', 2, 1499.00, 80),
('Harry Potter', 3, 599.00, 40),
('The Secret', 3, 349.00, 50),
('Mixer Grinder', 4, 3499.00, 20),
('Rice Cooker', 4, 2499.00, 35),
('Cricket Bat', 5, 1999.00, 40),
('Football', 5, 899.00, 70);
SELECT*FROM Products;

INSERT INTO Orders (customer_id, order_date, total_amount, order_status)
VALUES
(1, '2025-02-01', 79999.00, 'Delivered'),
(2, '2025-02-03', 1499.00, 'Delivered'),
(3, '2025-02-05', 599.00, 'Shipped'),
(4, '2025-02-08', 3499.00, 'Delivered'),
(5, '2025-02-10', 1999.00, 'Processing');
SELECT*FROM Orders;

INSERT INTO Order_Items (order_id, product_id, quantity, item_price)
VALUES
(1, 1, 1, 79999.00),
(2, 4, 1, 1499.00),
(3, 5, 1, 599.00),
(4, 7, 1, 3499.00),
(5, 9, 1, 1999.00);
SELECT*FROM Order_Items;

INSERT INTO Payments (order_id, payment_method, payment_status, payment_date)
VALUES
(1, 'Credit Card', 'Paid', '2025-02-01'),
(2, 'UPI', 'Paid', '2025-02-03'),
(3, 'Debit Card', 'Paid', '2025-02-05'),
(4, 'Net Banking', 'Paid', '2025-02-08'),
(5, 'Cash on Delivery', 'Pending', '2025-02-10');
SELECT*FROM Payments;

/*==========================================================
                    BASIC QUERIES
==========================================================*/

-- Show all customers
SELECT *
FROM Customers;

-- Show all products
SELECT *
FROM Products;

-- Show product name and price
SELECT product_name, price
FROM Products;

-- Products above 1000
SELECT *
FROM Products
WHERE price > 1000;

-- Customers from Chennai
SELECT *
FROM Customers
WHERE city = 'Chennai';

-- Delivered orders
SELECT *
FROM Orders
WHERE order_status = 'Delivered';

-- Stock less than 50
SELECT *
FROM Products
WHERE stock_quantity < 50;

-- Customers in alphabetical order
SELECT *
FROM Customers
ORDER BY customer_name;

-- Total customers
SELECT COUNT(*) AS Total_Customers
FROM Customers;

-- Total products
SELECT COUNT(*) AS Total_Products
FROM Products;

/*==========================================================
                AGGREGATE FUNCTIONS
==========================================================*/

-- Highest price
SELECT MAX(price) AS Highest_Price
FROM Products;

-- Lowest price
SELECT MIN(price) AS Lowest_Price
FROM Products;

-- Average price
SELECT AVG(price) AS Average_Price
FROM Products;

-- Total stock
SELECT SUM(stock_quantity) AS Total_Stock
FROM Products;

-- Count products in each category
SELECT category_id, COUNT(*) AS Total_Products
FROM Products
GROUP BY category_id;

/*==========================================================
                    JOIN QUERIES
==========================================================*/
-- INNER JOIN : Customer with orders
SELECT c.customer_name, o.order_date, o.total_amount
FROM Customers c
INNER JOIN Orders o
ON c.customer_id = o.customer_id;

-- LEFT JOIN : Show all customers and their orders
SELECT c.customer_name, o.order_date
FROM Customers c
LEFT JOIN Orders o
ON c.customer_id = o.customer_id;

-- RIGHT JOIN : Show all orders with customer names
SELECT c.customer_name, o.order_date
FROM Customers c
RIGHT JOIN Orders o
ON c.customer_id = o.customer_id;

-- INNER JOIN : Product with category
SELECT p.product_name, c.category_name
FROM Products p
INNER JOIN Categories c
ON p.category_id = c.category_id;

-- INNER JOIN : Order with payment details
SELECT o.order_id, p.payment_method, p.payment_status
FROM Orders o
INNER JOIN Payments p
ON o.order_id = p.order_id;

/*==========================================================
                    GROUP BY QUERIES
==========================================================*/

-- Total orders by customer
SELECT customer_id, COUNT(*) AS Total_Orders
FROM Orders
GROUP BY customer_id;

-- Total amount by customer
SELECT customer_id, SUM(total_amount) AS Total_Spent
FROM Orders
GROUP BY customer_id;

-- Products in each category
SELECT category_id, COUNT(*) AS Total_Products
FROM Products
GROUP BY category_id;

-- Average product price by category
SELECT category_id, AVG(price) AS Average_Price
FROM Products
GROUP BY category_id;

-- Total stock by category
SELECT category_id, SUM(stock_quantity) AS Total_Stock
FROM Products
GROUP BY category_id;

/*==========================================================
                    SUBQUERY
==========================================================*/
-- Product with highest price
SELECT *
FROM Products
WHERE price = (SELECT MAX(price) FROM Products);

-- Product with lowest price
SELECT *
FROM Products
WHERE price = (SELECT MIN(price) FROM Products);

-- Customers who placed orders
SELECT *
FROM Customers
WHERE customer_id IN
(SELECT customer_id FROM Orders);

-- Products with price above average
SELECT *
FROM Products
WHERE price >
(SELECT AVG(price) FROM Products);

/*==========================================================
                 WINDOW FUNCTION
==========================================================*/

-- Rank products by price
SELECT product_name, price,
RANK() OVER(ORDER BY price DESC) AS Price_Rank
FROM Products;

-- Row number for customers
SELECT customer_name,
ROW_NUMBER() OVER(ORDER BY customer_name) AS Row_Num
FROM Customers;

-- Dense rank by total amount
SELECT order_id, total_amount,
DENSE_RANK() OVER(ORDER BY total_amount DESC) AS Amount_Rank
FROM Orders;

/*=========================================================
                    HAVING QUERIES
=========================================================*/
-- Customers with at least 1 order
SELECT customer_id, COUNT(*) AS Total_Orders
FROM Orders
GROUP BY customer_id
HAVING COUNT(*) >=1;

-- Customers who spent more than 5000
SELECT customer_id, SUM(total_amount) AS Total_Spent
FROM Orders
GROUP BY customer_id
HAVING SUM(total_amount) > 5000;

-- Categories with average price above 1000
SELECT category_id, AVG(price) AS Average_Price
FROM Products
GROUP BY category_id
HAVING AVG(price) > 1000;

/*=========================================================
                  DATE FUNCTION QUERIES
=========================================================*/
-- Order year
SELECT order_id, YEAR(order_date) AS Order_Year
FROM Orders;

-- Order month
SELECT order_id, MONTH(order_date) AS Order_Month
FROM Orders;

/*=========================================================
                  CASE STATEMENT QUERIES
=========================================================*/
-- Stock status
SELECT product_name, stock_quantity,
CASE
WHEN stock_quantity < 50 THEN 'Low Stock'
ELSE 'In Stock'
END AS Stock_Status
FROM Products;

-- Product availability
SELECT product_name,
CASE
WHEN stock_quantity = 0 THEN 'Out of Stock'
ELSE 'Available'
END AS Availability
FROM Products;