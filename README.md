DataDigger --- SQL Database Project
Project Overview
DataDigger is a beginner-friendly SQL database project designed to
manage customer information, products, orders, and order details. It
demonstrates common database operations using MySQL.

Note: This project does not use SQL JOIN queries.
Objectives
- Create and manage a database with related tables.
- Store and retrieve customer, product, order, and order-detail
  records.
- Practice inserting, viewing, updating, and deleting records.
- Filter and sort data using conditions and ordering.
- Use aggregate functions to summarize information.
Database Name
DataDigger
Tables
1. Customers
Stores customer information: - Customer ID - Name - Email - Address
2. Products
Stores product information: - Product ID - Product Name - Price - Stock
Quantity
3. Orders
Stores order information: - Order ID - Customer ID - Order Date - Total
Amount
4. OrderDetails
Stores individual items included in orders: - Order Detail ID - Order
ID - Product ID - Quantity - Subtotal
Features
- Create the DataDigger database and its tables.
- Add sample customer, product, order, and order-detail records.
- View records from each table.
- Search customers and orders using conditions.
- Update customer addresses, product prices, and order amounts.
- Delete selected records.
- Sort products by price.
- Find products within a price range.
- Identify products that are out of stock.
- Calculate total revenue and total quantities.
- Find highest, lowest, and average values.
- Count records and summarize quantities by product ID.
- Filter recent orders by date.
- Run the script again to recreate the tables and sample data.
SQL Concepts Used
- Database and table creation
- Primary keys and foreign keys
- INSERT, SELECT, UPDATE, and DELETE
- WHERE and BETWEEN
- ORDER BY and GROUP BY
- COUNT, SUM, MAX, MIN, and AVG
- Date functions and date conditions
- Foreign-key constraints
Software Requirements
- MySQL Server
- MySQL Workbench or another MySQL-compatible SQL editor
How to Run the Project
1. Install MySQL Server and open MySQL Workbench.
2. Open a new SQL editor tab.
3. Open the DataDigger SQL project file and copy its contents into the
   editor.
4. Execute the script.
5. Review the result grids for the table queries and summaries.
Important Note
The script drops and recreates the four project tables when it is run
from the beginning. Any existing data in those tables will be deleted.
Keep a backup if you need to preserve existing records.
Project Outcome
DataDigger provides practical experience with MySQL database management
and common SQL operations without using JOIN queries

--Explaintion Video  :https://drive.google.com/file/d/12tKvtCjw9xiV-BWKsd41L4_SDQ_XI8RF/view?usp=sharing
