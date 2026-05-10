# 🛒 Super Store Retail Analytics — Advanced SQL

> **MySQL · 23 Queries · Window Functions · CTEs · Subqueries**

A end-to-end SQL analytics project built on a US retail dataset covering **sales, profit, customers, and shipping** across all product categories and regions. Demonstrates both foundational and advanced SQL techniques used in real-world data analysis.

---

## 📁 Repository Structure

```
superstore-sql-analytics/
├── superstore_analytics.sql   # All 23 queries with section comments
├── superstore.csv             # Raw dataset (9,994 rows)
└── README.md
```

---

## ⚙️ Setup Instructions

### Prerequisites
- MySQL 8.0+
- MySQL Workbench (or any MySQL client)

### Steps

**1. Create the database**
```sql
CREATE DATABASE super_store;
USE super_store;
```

**2. Run the CREATE TABLE block** from `superstore_analytics.sql`

**3. Enable local file import**
```sql
SET GLOBAL local_infile = ON;
```

**4. Update the file path** in the `LOAD DATA LOCAL INFILE` line to your local path:
```sql
LOAD DATA LOCAL INFILE '/your/local/path/superstore.csv'
INTO TABLE store_sales
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS;
```

**5. Run all queries** in order from the SQL file.

---

## 📊 Queries Overview

### Part 1 — Basic Analytics (Q1–Q9)

| # | Question |
|---|----------|
| Q1 | Total Sales by Region |
| Q2 | Profit Margin by Category |
| Q3 | Monthly Sales Trends (Year + Month) |
| Q4 | Discount Distribution (Low / Moderate / High) |
| Q5 | Sales by Category and Subcategory |
| Q6 | Profit vs Sales by Category |
| Q7 | Total Quantity Sold by State |
| Q8 | Average Profit Margin by Region |
| Q9 | Top 10 Products by Sales |

### Part 2 — Advanced Analytics (Q10–Q23)

| # | Question | Concepts Used |
|---|----------|---------------|
| Q10 | Top Regions by Profitability | GROUP BY, ORDER BY |
| Q11 | Customer Lifetime Value (CLV) | Aggregation, GROUP BY |
| Q12 | Average Order Value (AOV) | COUNT DISTINCT |
| Q13 | Month-over-Month Sales Growth Rate | `LAG()` Window Function |
| Q14 | Sales & Profit by Discount Bracket | CASE WHEN |
| Q15 | Top Cities by Quantity Sold | GROUP BY, ORDER BY |
| Q16 | Repeat Purchase Rate | Subquery, HAVING |
| Q17 | Seasonal Sales Patterns | CASE WHEN, FIELD() |
| Q18 | Profit Contribution % by Category | Subquery, ROUND() |
| Q19 | Top 5 Most Profitable Products | ORDER BY, LIMIT |
| Q20 | Shipping Mode Impact on Profit Margin | GROUP BY |
| Q21 | Sales & Profit by Customer Segment | GROUP BY |
| Q22 | High-Revenue, Low-Margin Products | HAVING with Subquery |
| Q23 | Average Shipping Time (Overall + By Mode) | `DATEDIFF()` |

---

## 🧠 Key SQL Concepts Demonstrated

- **Window Functions** — `LAG()` for month-over-month growth
- **Subqueries** — Dynamic average benchmarks in HAVING clause
- **CASE WHEN** — Custom bucketing (seasons, discount brackets)
- **Date Functions** — `DATEDIFF()`, `MONTHNAME()`, `YEAR()`, `MONTH()`
- **Aggregate Functions** — `SUM()`, `AVG()`, `COUNT()`, `ROUND()`
- **GROUP BY + HAVING** — Filtered aggregations
- **ORDER BY + LIMIT** — Top-N rankings

---

## 📌 Dataset

- **Source:** Sample Superstore (US Retail)
- **Rows:** 9,994 orders
- **Columns:** Order ID, Dates, Customer, Region, Category, Sales, Profit, Discount, Quantity, Ship Mode

---

## 🙋 Author

**Nikhilesh** · [GitHub Profile](https://github.com/nikhileshh02)
