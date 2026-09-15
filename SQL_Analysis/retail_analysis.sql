-- creating database retail_analysis
create database retail_analysis;
use retail_analysis;
-- creating a table named superstore
CREATE TABLE superstore (
    row_id INT,
    order_id VARCHAR(20),
    order_date DATE,
    ship_date DATE,
    ship_mode VARCHAR(30),
    customer_id VARCHAR(20),
    customer_name VARCHAR(100),
    segment VARCHAR(30),
    country VARCHAR(50),
    city VARCHAR(50),
    state VARCHAR(50),
    postal_code VARCHAR(20),
    region VARCHAR(20),
    product_id VARCHAR(30),
    category VARCHAR(30),
    sub_category VARCHAR(30),
    product_name VARCHAR(200),
    sales DECIMAL(12,2),
    quantity INT,
    discount DECIMAL(4,2),
    profit DECIMAL(12,2)
);
show tables;
select count(*) as total_rows from superstore;
------------------------------------------
-- 1 Overall Business KPIs
------------------------------------------
-- ============================================
-- 1. OVERALL BUSINESS KPIs
-- ============================================
use retail_analysis;
SELECT
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    COUNT(DISTINCT order_id) AS total_orders,
    SUM(quantity) AS total_quantity,
    round(AVG(discount)*100.0,2) AS avg_discount,
    round((SUM(profit) / SUM(sales))*100.0,2) AS profit_margin
FROM superstore;
-----------------------------------------------------------------
-- Yearly total sales and total profit, sorted from 2014 to 2017
-----------------------------------------------------------------
select year(order_date) as year,
round(sum(sales),2) as total_sales, round(sum(profit),2) as total_profit from superstore
group by year(order_date)
order by year(order_date);
--------------------------------
-- year over year sales growth
--------------------------------
-- YoY Growth = (Current Year Sales − Previous Year Sales) / Previous Year Sales × 100
select 
    year(order_date) as year,
    round(sum(sales),2) as total_sales,
    lag(sum(sales)) over(order by year(order_date)) as previous_year_sales,
    round(
        (sum(sales) - lag(sum(sales)) over(order by year(order_date)))
        / lag(sum(sales)) over(order by year(order_date)) * 100,2) as yoy_sales_growth 
from superstore
group by year(order_date)
order by year(order_date);
-----------------------------------
-- year over year profit growth
-----------------------------------
select
	year(order_date) as year,
    round(sum(profit),2) as total_profit,
    lag(sum(profit)) over(order by year(order_date)) as previous_year_profit,
    round(
		(sum(profit) - lag(sum(profit)) over(order by year(order_date)))
        / lag(sum(profit)) over(order by year(order_date)) * 100,2) as yoy_profit_growth
from superstore
group by year(order_date)
order by year(order_date);
-------------------------------------------
-- Monthly Sales Trend
-------------------------------------------
select
	date_format(order_date,'%Y-%m') as year_m,
    sum(sales) as total_sales,
    sum(profit) as total_profit from superstore
group by date_format(order_date,'%Y-%m')
order by date_format(order_date,'%Y-%m');
---------------------------------------------
-- Monthly Sales - Year Over Year Growth
---------------------------------------------
select
	date_format(order_date,'%Y-%m') as year_m,
    sum(sales) as total_sales,
    lag(sum(sales),12) over(order by date_format(order_date,'%Y-%m')) as previous_y_m_sales,
    round(
		(sum(sales) - lag(sum(sales),12) over(order by date_format(order_date,'%Y-%m')))
        / lag(sum(sales),12) over(order by date_format(order_date,'%Y-%m'))*100,2) as yoy_sales_growth
from superstore
group by date_format(order_date,'%Y-%m')
order by date_format(order_date,'%Y-%m');
--------------------------------------------
-- Category Sales & Profitability
--------------------------------------------
select category, sum(sales) as total_sales, sum(profit) as total_profit, sum(quantity) as total_qty,
round(sum(profit) / sum(sales) * 100,2) as profit_margin from superstore
group by category
order by profit_margin desc;
------------------------------------------
-- Sub-Category Profitability
------------------------------------------
select 
	sub_category, sum(sales) as total_sales, sum(profit) as total_profit, sum(quantity) as total_qty,
	round(sum(profit)/sum(sales)*100,2) as profit_margin 
from superstore
group by sub_category
order by total_profit desc;
-----------------------------------------
-- Discount vs Profitability
-----------------------------------------
select 
	round(discount*100,0) as discount, sum(sales) as total_sales, sum(profit) as total_profit,
	round(sum(profit)/sum(sales)*100,2) as profit_margin 
from superstore
group by discount
order by discount;
------------------------------------------
-- Regional Performance
------------------------------------------
select
	region, sum(sales) as total_sales, sum(profit) as total_profit, sum(quantity) as total_qty,
    round(sum(profit)/sum(sales)*100,2) as profit_margin
from superstore
group by region
order by total_sales desc;
-----------------------------------------
-- Segment Performance
-----------------------------------------
select
	segment, sum(sales) as total_sales, sum(profit) as total_profit, sum(quantity) as total_qty,
    round(sum(profit)/sum(sales)*100,2) as profit_margin
from superstore
group by segment
order by total_sales desc;
--------------------------------------------
-- Ranking the Sub-Categories
--------------------------------------------
select
	sub_category, sum(sales) as total_sales, sum(profit) as total_profit, sum(quantity) as total_qty,
    round(sum(profit)/sum(sales)*100,2) as profit_margin,
    rank() over(order by sum(profit) desc) as profit_rank
from superstore
group by sub_category
order by total_profit desc;
-----------------------------------------------
-- Identifying the loss making sub-categories
-----------------------------------------------
with subcategory_profit as (
	select
		sub_category,
		sum(sales) as total_sales,
        sum(profit) as total_profit
	from superstore
	group by sub_category
) 
select * from subcategory_profit
where total_profit < 0
order by total_profit;


    



