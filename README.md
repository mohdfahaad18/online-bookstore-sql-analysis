# Online Book Store SQL Analysis

## 📌 Project Overview

This project focuses on analyzing an Online Book Store dataset using **PostgreSQL**. The project demonstrates relational database design, data importing, SQL querying, and extracting useful insights from books, customers, and orders data.

The database contains three main tables:

* **Books** — information about books, authors, genres, prices, publication years, and stock.
* **Customers** — customer details including name, email, phone, city, and country.
* **Orders** — order information including customers, books, order dates, quantities, and total amounts.

## 🎯 Objectives

* Design a relational database using PostgreSQL.
* Import and manage structured CSV datasets.
* Analyze customer, book, and order data.
* Use SQL to answer business-related questions.
* Practice joins, aggregations, filtering, subqueries, and window functions.
* Generate insights related to sales, customers, inventory, and orders.

## 🗄️ Database Structure

### Books

| Column           | Description            |
| ---------------- | ---------------------- |
| `book_id`        | Unique book identifier |
| `title`          | Book title             |
| `author`         | Author name            |
| `genre`          | Book genre             |
| `published_year` | Year of publication    |
| `price`          | Book price             |
| `stock`          | Available stock        |

### Customers

| Column        | Description                |
| ------------- | -------------------------- |
| `customer_id` | Unique customer identifier |
| `name`        | Customer name              |
| `email`       | Customer email             |
| `phone`       | Customer phone number      |
| `city`        | Customer city              |
| `country`     | Customer country           |

### Orders

| Column         | Description                   |
| -------------- | ----------------------------- |
| `order_id`     | Unique order identifier       |
| `customer_id`  | Customer who placed the order |
| `book_id`      | Book that was ordered         |
| `order_date`   | Date of the order             |
| `quantity`     | Number of books ordered       |
| `total_amount` | Total order amount            |

## 📊 Dataset

The project uses three CSV files:

* `Books.csv` — 500 book records
* `Customers.csv` — 500 customer records
* `Orders.csv` — 500 order records

## 🛠️ Technologies Used

* **PostgreSQL**
* **SQL**
* **pgAdmin 4**
* **CSV**

## 🔍 SQL Concepts Used

The project includes practical examples of:

* `SELECT`
* `WHERE`
* `ORDER BY`
* `GROUP BY`
* `HAVING`
* Aggregate functions
* `INNER JOIN`
* `LEFT JOIN`
* Subqueries
* Date filtering
* `CASE` statements
* Primary keys
* Foreign keys

## 💡 Example Analysis Questions

Some of the analysis performed includes:

1. List customers from a specific country.
2. Find orders placed during a particular month.
3. Calculate total available book stock.
4. Analyze orders and customer information using joins.
5. Identify sales and order patterns.
6. Analyze book genres and pricing.
7. Calculate aggregated sales metrics.
8. Examine customer ordering behavior.

## ▶️ How to Run the Project

### 1. Create the database

Create a PostgreSQL database named:

```sql
CREATE DATABASE OnlineBookStore_Project;
```

### 2. Run the SQL file

Open the provided:

`Online_BookStore_Project.sql`

in **pgAdmin 4 Query Tool** and execute the table creation queries.

### 3. Import the CSV files

Import the following datasets into their respective tables:

* `Books.csv` → `Books`
* `Customers.csv` → `Customers`
* `Orders.csv` → `Orders`

### 4. Run the analysis queries

Execute the analysis queries included in:

`Online_BookStore_Project.sql`

to reproduce the results.

## 📁 Project Structure

```text
online-bookstore-sql-analysis/
│
├── Books.csv
├── Customers.csv
├── Orders.csv
├── Online_BookStore_Project.sql
└── README.md
```

## 👨‍💻 Author

**Mohd Fahaad**

Computer Science Engineering – Data Science

Skills demonstrated in this project: **PostgreSQL, SQL, Data Analysis, Relational Database Design**

