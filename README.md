
-- ==========================================
-- PROJECT NAME: DataDigger
-- SQL Project Without JOIN
-- ==========================================

CREATE DATABASE IF NOT EXISTS DataDigger;
USE DataDigger;

-- Remove old tables
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS OrderDetails;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Customers;

SET FOREIGN_KEY_CHECKS = 1;

-- ==========================================
-- 1. CUSTOMERS TABLE
-- ==========================================

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Address VARCHAR(200)
);

INSERT INTO Customers
(CustomerID, Name, Email, Address)
VALUES
(1, 'Alice', 'alice@example.com', 'Surat'),
(2, 'Rahul', 'rahul@example.com', 'Ahmedabad'),
(3, 'Priya', 'priya@example.com', 'Vadodara'),
(4, 'Amit', 'amit@example.com', 'Rajkot'),
(5, 'Neha', 'neha@example.com', 'Mumbai'),
(6, 'Karan', 'karan@example.com', 'Pune');

-- Display all customers
SELECT * FROM Customers;

-- Update customer address
UPDATE Customers
SET Address = 'Surat, Gujarat'
WHERE CustomerID = 2;

-- Search customer by name
SELECT * FROM Customers
WHERE Name = 'Alice';

-- Count total customers
SELECT COUNT(*) AS TotalCustomers
FROM Customers;

-- Delete one customer
DELETE FROM Customers
WHERE CustomerID = 6;


-- ==========================================
-- 2. PRODUCTS TABLE
-- ==========================================

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    Stock INT NOT NULL
);

INSERT INTO Products
(ProductID, ProductName, Price, Stock)
VALUES
(1, 'Mouse', 700.00, 50),
(2, 'Keyboard', 1200.00, 35),
(3, 'Headphones', 2500.00, 20),
(4, 'Monitor', 15000.00, 12),
(5, 'Laptop', 45000.00, 8),
(6, 'Old USB Cable', 400.00, 0);

-- Display all products
SELECT * FROM Products;

-- Display products by highest price
SELECT * FROM Products
ORDER BY Price DESC;

-- Update product price
UPDATE Products
SET Price = 1300.00
WHERE ProductID = 2;

-- Find out-of-stock products
SELECT * FROM Products
WHERE Stock = 0;

-- Delete out-of-stock products
DELETE FROM Products
WHERE Stock = 0;

-- Find products between 500 and 25000
SELECT * FROM Products
WHERE Price BETWEEN 500 AND 25000
ORDER BY Price;

-- Highest and lowest product price
SELECT MAX(Price) AS HighestPrice,
       MIN(Price) AS LowestPrice
FROM Products;

-- Count total products
SELECT COUNT(*) AS TotalProducts
FROM Products;

-- Average product price
SELECT AVG(Price) AS AveragePrice
FROM Products;


-- ==========================================
-- 3. ORDERS TABLE
-- ==========================================

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT NOT NULL,
    OrderDate DATE NOT NULL,
    TotalAmount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (CustomerID)
        REFERENCES Customers(CustomerID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

INSERT INTO Orders
(OrderID, CustomerID, OrderDate, TotalAmount)
VALUES
(101, 1, DATE_SUB(CURDATE(), INTERVAL 2 DAY), 1900.00),
(102, 2, DATE_SUB(CURDATE(), INTERVAL 8 DAY), 3700.00),
(103, 3, DATE_SUB(CURDATE(), INTERVAL 15 DAY), 16200.00),
(104, 4, DATE_SUB(CURDATE(), INTERVAL 25 DAY), 45000.00),
(105, 5, DATE_SUB(CURDATE(), INTERVAL 40 DAY), 2500.00),
(106, 1, DATE_SUB(CURDATE(), INTERVAL 1 DAY), 1200.00);

-- Display all orders
SELECT * FROM Orders;

-- Find orders of customer 1
SELECT * FROM Orders
WHERE CustomerID = 1;

-- Update order amount
UPDATE Orders
SET TotalAmount = 2000.00
WHERE OrderID = 101;

-- Orders from the last 30 days
SELECT * FROM Orders
WHERE OrderDate >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
  AND OrderDate <= CURDATE()
ORDER BY OrderDate DESC;

-- Highest, lowest and average order amount
SELECT MAX(TotalAmount) AS HighestOrder,
       MIN(TotalAmount) AS LowestOrder,
       AVG(TotalAmount) AS AverageOrder
FROM Orders;

-- Total order amount
SELECT SUM(TotalAmount) AS TotalOrderAmount
FROM Orders;

-- Count total orders
SELECT COUNT(*) AS TotalOrders
FROM Orders;

-- Delete one order
DELETE FROM Orders
WHERE OrderID = 106;


-- ==========================================
-- 4. ORDER DETAILS TABLE
-- ==========================================

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    Subtotal DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (OrderID)
        REFERENCES Orders(OrderID)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    FOREIGN KEY (ProductID)
        REFERENCES Products(ProductID)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

INSERT INTO OrderDetails
(OrderDetailID, OrderID, ProductID, Quantity, Subtotal)
VALUES
(1001, 101, 1, 1, 700.00),
(1002, 101, 2, 1, 1200.00),
(1003, 102, 3, 1, 2500.00),
(1004, 102, 1, 1, 700.00),
(1005, 102, 2, 1, 500.00),
(1006, 103, 4, 1, 15000.00),
(1007, 103, 1, 1, 1200.00),
(1008, 104, 5, 1, 45000.00),
(1009, 105, 3, 1, 2500.00);

-- Display all order details
SELECT * FROM OrderDetails;

-- Find details for order 101
SELECT * FROM OrderDetails
WHERE OrderID = 101;

-- Calculate total revenue from order details
SELECT SUM(Subtotal) AS TotalRevenue
FROM OrderDetails;

-- Count order-detail records
SELECT COUNT(*) AS TotalOrderDetails
FROM OrderDetails;

-- Calculate total quantity ordered
SELECT SUM(Quantity) AS TotalQuantityOrdered
FROM OrderDetails;

-- Find highest and lowest subtotal
SELECT MAX(Subtotal) AS HighestSubtotal,
       MIN(Subtotal) AS LowestSubtotal
FROM OrderDetails;

-- Find average subtotal
SELECT AVG(Subtotal) AS AverageSubtotal
FROM OrderDetails;

-- Find total quantity for each product
-- No JOIN used
SELECT ProductID,
       SUM(Quantity) AS TotalQuantityOrdered
FROM OrderDetails
GROUP BY ProductID
ORDER BY TotalQuantityOrdered DESC
LIMIT 3;

-- Count how many order-detail records contain product 1
-- No JOIN used
SELECT ProductID,
       COUNT(*) AS TimesSold
FROM OrderDetails
WHERE ProductID = 1
GROUP BY ProductID;

-- ==========================================
-- END OF DATADIGGER PROJECT
-- NO JOIN USED
-- ==========================================
