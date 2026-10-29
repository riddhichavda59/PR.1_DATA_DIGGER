-- Project: Data Digger
-- Beginner-friendly MySQL project for an E-Commerce Store
-- Run this file in MySQL Workbench or the MySQL command line.

CREATE DATABASE IF NOT EXISTS DataDigger;
USE DataDigger;

-- Re-create the tables so this script can be run again from the beginning.
SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS OrderDetails;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Customers;
SET FOREIGN_KEY_CHECKS = 1;

-- 1. CUSTOMERS TABLE
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Address VARCHAR(200)
);

-- 2. ORDERS TABLE
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT NOT NULL,
    OrderDate DATE NOT NULL,
    TotalAmount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
        ON UPDATE CASCADE ON DELETE CASCADE
);

-- 3. PRODUCTS TABLE
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    Stock INT NOT NULL
);

-- 4. ORDER DETAILS TABLE
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    Subtotal DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
        ON UPDATE CASCADE ON DELETE RESTRICT
);

-- =========================
-- CUSTOMERS: sample records
-- =========================
INSERT INTO Customers (CustomerID, Name, Email, Address) VALUES
(1, 'Alice', 'alice@example.com', 'Surat'),
(2, 'Rahul', 'rahul@example.com', 'Ahmedabad'),
(3, 'Priya', 'priya@example.com', 'Vadodara'),
(4, 'Amit', 'amit@example.com', 'Rajkot'),
(5, 'Neha', 'neha@example.com', 'Mumbai'),
(6, 'Karan', 'karan@example.com', 'Pune');

-- View all customer details
SELECT * FROM Customers;

-- Update a customer's address
UPDATE Customers
SET Address = 'Surat, Gujarat'
WHERE CustomerID = 2;

-- Display all customers whose name is Alice
SELECT * FROM Customers
WHERE Name = 'Alice';

-- Delete a customer by CustomerID.
-- Customer 6 has no orders, so this is safe to run.
DELETE FROM Customers
WHERE CustomerID = 6;

-- ======================
-- PRODUCTS: sample data
-- ======================
INSERT INTO Products (ProductID, ProductName, Price, Stock) VALUES
(1, 'Mouse', 700.00, 50),
(2, 'Keyboard', 1200.00, 35),
(3, 'Headphones', 2500.00, 20),
(4, 'Monitor', 15000.00, 12),
(5, 'Laptop', 45000.00, 8),
(6, 'Old USB Cable', 400.00, 0);

-- View all products sorted by price, highest first
SELECT * FROM Products
ORDER BY Price DESC;

-- Update the price of a specific product
UPDATE Products
SET Price = 1300.00
WHERE ProductID = 2;

-- Retrieve products that are out of stock
SELECT * FROM Products
WHERE Stock = 0;

-- Delete out-of-stock products
-- The out-of-stock product is not used in OrderDetails.
DELETE FROM Products
WHERE Stock = 0;

-- Retrieve products with price between 500 and 25000
SELECT * FROM Products
WHERE Price BETWEEN 500 AND 25000
ORDER BY Price;

-- Most expensive and cheapest products (aggregate functions)
SELECT MAX(Price) AS HighestPrice, MIN(Price) AS LowestPrice
FROM Products;

-- ====================
-- ORDERS: sample data
-- ====================
INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount) VALUES
(101, 1, DATE_SUB(CURDATE(), INTERVAL 2 DAY), 1900.00),
(102, 2, DATE_SUB(CURDATE(), INTERVAL 8 DAY), 3700.00),
(103, 3, DATE_SUB(CURDATE(), INTERVAL 15 DAY), 16200.00),
(104, 4, DATE_SUB(CURDATE(), INTERVAL 25 DAY), 45000.00),
(105, 5, DATE_SUB(CURDATE(), INTERVAL 40 DAY), 2500.00),
(106, 1, DATE_SUB(CURDATE(), INTERVAL 1 DAY), 1200.00);

-- Retrieve all orders made by a specific customer
SELECT * FROM Orders
WHERE CustomerID = 1;

-- Update an order's total amount
UPDATE Orders
SET TotalAmount = 2000.00
WHERE OrderID = 101;

-- Retrieve orders placed in the last 30 days
SELECT * FROM Orders
WHERE OrderDate >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
  AND OrderDate <= CURDATE()
ORDER BY OrderDate DESC;

-- Highest, lowest, and average order amount
SELECT MAX(TotalAmount) AS HighestOrder,
       MIN(TotalAmount) AS LowestOrder,
       AVG(TotalAmount) AS AverageOrder
FROM Orders;

-- Delete an order using OrderID.
-- Order 106 has no OrderDetails, so this is safe to run.
DELETE FROM Orders
WHERE OrderID = 106;

-- ==========================
-- ORDER DETAILS: sample data
-- ==========================
INSERT INTO OrderDetails
    (OrderDetailID, OrderID, ProductID, Quantity, Subtotal) VALUES
(1001, 101, 1, 1, 700.00),
(1002, 101, 2, 1, 1200.00),
(1003, 102, 3, 1, 2500.00),
(1004, 102, 1, 1, 700.00),
(1005, 102, 2, 1, 500.00),
(1006, 103, 4, 1, 15000.00),
(1007, 103, 1, 1, 1200.00),
(1008, 104, 5, 1, 45000.00),
(1009, 105, 3, 1, 2500.00);

-- Retrieve all order details for a specific order
SELECT * FROM OrderDetails
WHERE OrderID = 101;

-- Calculate total revenue from all order details using SUM()
SELECT SUM(Subtotal) AS TotalRevenue
FROM OrderDetails;

-- Top 3 most ordered products
SELECT p.ProductID, p.ProductName, SUM(od.Quantity) AS TotalQuantityOrdered
FROM OrderDetails od
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY p.ProductID, p.ProductName
ORDER BY TotalQuantityOrdered DESC
LIMIT 3;

-- Count how many order-detail records contain a specific product using COUNT()
SELECT p.ProductID, p.ProductName, COUNT(od.OrderDetailID) AS TimesSold
FROM Products p
LEFT JOIN OrderDetails od ON p.ProductID = od.ProductID
WHERE p.ProductID = 1
GROUP BY p.ProductID, p.ProductName;

-- Optional: view the relationships across all four tables
SELECT c.Name, o.OrderID, o.OrderDate, p.ProductName,
       od.Quantity, od.Subtotal
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
ORDER BY o.OrderID;
