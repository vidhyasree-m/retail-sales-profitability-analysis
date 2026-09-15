# Retail Sales, Profitability & Business Performance Analysis

## Project Overview

This project analyzes retail sales data from 2014 to 2017 to evaluate
sales performance, profitability, customer segments, product categories,
discount impact, and regional performance.

The analysis was performed using Excel, SQL, and Python to demonstrate
an end-to-end data analysis workflow.

## Business Objectives

- Analyze overall sales and profitability
- Identify sales and profit trends over time
- Compare category and sub-category performance
- Evaluate the relationship between discounts and profitability
- Analyze regional and customer segment performance
- Identify loss-making sub-categories and areas requiring attention

## Tools & Technologies

- Excel — Data cleaning, analysis, PivotTables, dashboard
- MySQL — Data querying and business analysis
- Python — Pandas and Matplotlib for analysis and visualization

## Dataset

The dataset contains retail transaction-level information including:

- Order and shipping dates
- Customer and product information
- Region and customer segment
- Category and sub-category
- Sales
- Quantity
- Discount
- Profit

After data cleaning and validation, the final dataset contained
8,286 records.

## Analysis Performed

### Excel

- Data cleaning and validation
- KPI analysis
- Yearly sales and profit analysis
- Monthly sales trends
- Category and sub-category analysis
- Discount analysis
- Regional analysis
- Customer segment analysis
- Interactive Excel dashboard using PivotTables and slicers

### SQL

- Overall business KPIs
- Yearly sales and profit
- Year-over-year growth using window functions
- Monthly sales analysis
- Category and sub-category profitability
- Discount and profitability analysis
- Regional and segment analysis
- Sub-category ranking using `RANK()`
- Loss-making sub-category analysis using CTEs

### Python

- Data loading and validation using Pandas
- Overall KPI calculation
- Category profitability analysis
- Monthly sales trend analysis
- 3-month rolling average
- Discount vs profit analysis
- Sub-category profitability analysis
- Top and bottom performing sub-categories
- Data visualization using Matplotlib

## Key Findings

- Sales increased by 23.49% in 2017, while profit increased by only
  0.52%, indicating that revenue growth was not translating
  proportionally into profit growth.
- Technology generated the highest sales and profit, with an
  approximately 18.33% profit margin.
- Furniture generated approximately $614.7K in sales but only
  $16.5K in profit, resulting in a much lower 2.69% margin.
- Tables was the largest loss-making sub-category, followed by
  Bookcases and Supplies.
- Discount levels of 30% and above were associated with negative
  profitability in the dataset.
- Central had the lowest regional profit margin at approximately 7.72%.
- Home Office had the highest customer-segment profit margin at
  approximately 14.53%.

## Business Recommendations

- Review heavily discounted transactions, particularly those with
  discounts of 30% or higher.
- Investigate pricing and discounting strategies for loss-making
  sub-categories such as Tables.
- Investigate the factors contributing to Furniture losses in the
  Central region.
- Protect and expand high-margin categories such as Technology.
- Monitor profitability alongside sales growth when evaluating
  business performance.

## Project Outcome

This project demonstrates an end-to-end data analysis workflow:

Data Cleaning → Excel Analysis → SQL Analysis → Python Analysis →
Business Insights → Recommendations