create database super_store;
use super_store;

CREATE TABLE store_sales 
(
Order_ID        VARCHAR(255),
Order_Date      DATE,
Ship_Date       DATE,
Ship_Mode       VARCHAR(255),
Customer_ID     VARCHAR(255),
Customer_Name   VARCHAR(255),
Segment         VARCHAR(255),
Country         VARCHAR(255),
City            VARCHAR(255),
State           VARCHAR(255),
Postal_Code     VARCHAR(255),
Region          VARCHAR(255),
Product_ID      VARCHAR(255),
Category        VARCHAR(255),
Sub_Category    VARCHAR(255),
Product_Name    VARCHAR(500),
Sales           DECIMAL(10,4),
Quantity        INT,
Discount        DECIMAL(4,2),
Profit          DECIMAL(10,4)
);


SET global local_infile = ON;

LOAD DATA LOCAL INFILE 'N:/MY_SQL/Project/cleaned_sales_dataset.csv'
into table store_sales
fields terminated by ','
OPTIONALLY ENCLOSED BY '"'
lines terminated by '\r\n'
ignore 1 rows;

select * from store_sales;



-- Here are SQL-based analytics questions for both Part 1 and Part 2

# PART 1 – SQL Analytics Questions (Basic)

# Total Sales by Region
# 1   -- What is the total sales value contributed by each region?
select region, sum(Sales) from store_sales
group by region ;

# Profit Margin by Category
#  2  -- What is the profit margin (profit ÷ sales) for each product category?
select  category, sum(profit)/ sum(sales) as profit_margin from store_sales
group by category;

# Monthly Sales Over Time
#  3  -- How do total sales vary month by month throughout the year?
select year(order_date) as Year, monthname(order_date) as Month, round(sum(sales), 2) from store_sales
group by year, month
order by year, month;


# Distribution of Discounts
#  4  -- What is the frequency distribution of different discount levels across all orders?
select
	case
		when discount< 0.1 then "Low Discount"
        when discount between 0.1 and 0.3 then "moderate discount"
        else 
			"High Discount"
		end 
			as Discount_Distribution,
	count(discount) as Total_discount_freq
from store_sales 
group by Discount_Distribution
order by Total_discount_freq desc;

select * from store_sales;

# Sales by Category and Subcategory
#  5  -- How much revenue is generated from each subcategory within every category?
select category, sub_category, sum(sales) from store_sales
group by sub_category, category;


# Profit vs. Sales by Category
#  6  -- For each product category, what are the total sales and corresponding total profit?
select category, sub_category, sum(sales) , sum(profit) from store_sales
group by category, sub_category;

# Total Quantity Sold by State
#  7  -- What is the total number of items sold in each state?
select state, sum(quantity)from store_sales
group by state;
 
# Average Profit Margin by Region
#  8  -- What is the average profit margin for each region?
select region, sum(profit) / sum(sales) as profit_margin from store_sales
group by region;

# Top 10 Products by Sales
#  9  -- Which 10 products have the highest total sales value?
select product_name, sum(sales) as total_sales from store_sales
group by product_name
order by total_sales desc
limit 10;


# PART 2 – SQL Analytics Questions (Advanced)

# Top Regions by Profitability
#  10  -- Which regions contribute the highest total profit?
select region, sum(profit) from store_sales
group by region
order by sum(profit) desc ;

# Customer Lifetime Value (CLTV)
#  11  -- What is the total sales contributed by each customer across all their orders?
select customer_id, customer_name, round(sum(sales)) as total_sales 
from store_sales
group by customer_name, customer_id
order by total_sales desc ;


# Average Order Value (AOV)
#  12  -- What is the average revenue per order?
select sum(sales) / count(distinct order_id) as average_order_value from store_sales;


# Sales Growth Rate
#  13  -- What is the percentage change in total monthly sales compared to the previous month?
select 
monthname(order_date) as Month_name, 
month(order_date) as month_num,
round(sum(sales),2) as Monthly_Sales,
lag(sum(sales),1) over (order by month(Order_Date)) as previous_month_sales,

round((sum(sales) - lag(sum(sales),1) over (order by month(Order_Date)))
/
(lag(sum(sales),1) over (order by month(Order_Date)))*100, 2) as Monthly_Sales_percent
from store_sales
group by Month_name, month_num;


# High-Discount Sales Analysis
#  14  -- How does sales and profit vary across different discount brackets (e.g., 0–10%, 10–20%, --20%)?
select
	case
		when discount between 0.0 and 0.1 then "0-10%"
        when discount between 0.1 and 0.2 then "10-20%"
        else
			"--20%"
		end
			as Discount_Brackets,
            sum(sales) as Totalsales,
            sum(profit) as Totalprofit
from store_sales
group by discount_brackets;

# Top Cities by Quantity Sold
#  15  -- Which cities have the highest quantity of items sold?
select city, sum(sales), sum(quantity) from store_sales
group by city
order by sum(quantity) desc;


# Repeat Purchase Rate by Customer					### ask to sir
#  16  -- How many customers have placed more than one order?
select count(*) as Reapeat_Customer_Count
from (
		select customer_id from store_sales
        group by customer_id 
        having count(distinct order_id ) > 1
        ) as RepeatCustomers;


# Seasonal Sales Patterns
#  17  -- Are there particular months or seasons with consistently higher sales?
#  spring (mar-may), summer(jun-aug), autum(sept-nov), winters(dec-feb)
select
	case
		when month(order_date) between 3 and 5 then "Spring"
        when month(order_date) between 6 and 8 then "Summer"
        when month(order_date) between 9 and 11 then "Autum"
	else
        "Winter"
	end as Seasons,
    sum(sales) as Seasonal_sales
from store_sales
group by Seasons
order by field(Seasons, "Spring", "Summer", "Autum", "Winters");        

# Profit Contribution by Product Category
#  18  -- How much profit does each product category contribute to the overall total profit?



# Top 5 Most Profitable Products
#  19  -- Which products have generated the most total profit?
select product_name, sum(profit) as total_profit
from store_sales
group by product_name
order by total_profit desc
;


# Impact of Shipping Mode on Profitability
#  20  -- How does profit margin differ across various shipping modes?
select ship_mode, (sum(profit) / sum(sales) ) * 100  as Total_Profit_Margin from store_sales
group by ship_mode
order by Total_Profit_Margin desc ;


# Sales and Profitability by Segment
#  21  -- What are the total sales and total profit for each customer segment?
select segment, sum(sales) as total_sales, sum(profit) as total_profit from store_sales
group by segment
order by total_sales desc;


# Highest-Selling Products with Low Profit Margins					#### ask to sir
#  22  -- Which high-revenue products have below-average profit margins?
select product_name, sum(sales) as total_revenue, (sum(profit) / sum(sales)) * 100 as profit_margins		#gemini
from store_sales
group by product_name
having (sum(profit) / sum(sales)) * 100 < 12.47
order by total_revenue desc ;

select									# by sir
		product_name,
        sum(sales) as Total_sales,
        (sum(profit) / sum(sales)) as ProfitMargin
from store_sales
group by Product_name
having ProfitMargin < (select avg(profit / sales) as average_profit_margins from store_sales)
order by Total_sales desc;

# Average Time from Order to Ship
#  23  -- What is the average number of days taken to ship an order after it was placed?
select avg(datediff(ship_date, order_date)) as avg_no_of_days_taken from store_sales;

# Average Time from Order to Ship for each ship mode 
#  23  -- What is the average number of days taken to ship an order after it was placed?
select ship_mode, 
round(avg(datediff(ship_date, order_date))) as avg_no_of_days_taken 
from store_sales
group by ship_mode
order by avg_no_of_days_taken;