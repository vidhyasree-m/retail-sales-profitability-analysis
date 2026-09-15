import pandas as pd
df = pd.read_excel("superstore_cleaned_data.xlsx",sheet_name="superstore_cleaned")
print(df.head())
# checking number of rows and columns
print("\nShape")
print(df.shape)
# checking column names 
print("\nColumns")
print(df.columns.tolist())
# checking data type of the columns
print("\nData Types:")
print(df.dtypes)

# Data Quality Validation
print("\nMissing Values:")
print(df.isnull().sum())

print("\nDuplicate Rows:")
print(df.duplicated().sum())

print("\nDate Range:")
print("Earliest Order Date:", df["Order Date"].min())
print("Latest Order Date:", df["Order Date"].max())

invalid_dates = (df["Ship Date"] < df["Order Date"]).sum()
print("\nInvalid Shipping Dates:", invalid_dates)

# ============================================
# 1. OVERALL BUSINESS KPIs
# ============================================

total_sales = df["Sales"].sum()
total_profit = df["Profit"].sum()
total_orders = df["Order ID"].nunique()
total_quantity = df["Quantity"].sum()
avg_discount = df["Discount"].mean() * 100
profit_margin = (total_profit / total_sales) * 100

print("\nOverall Business KPIs")
print("---------------------")
print("Total Sales:", round(total_sales, 2))
print("Total Profit:", round(total_profit, 2))
print("Total Orders:", total_orders)
print("Total Quantity:", total_quantity)
print("Average Discount:", round(avg_discount, 2), "%")
print("Profit Margin:", round(profit_margin, 2), "%")

# ============================================
# 2. Category Sales & Profit
# ============================================

category_analysis = (
    df.groupby("Category")
      .agg(
          total_sales=("Sales", "sum"),
          total_profit=("Profit", "sum"),
          total_quantity=("Quantity", "sum")
      )
      .reset_index()
)
category_analysis["profit_margin"] = (
    category_analysis["total_profit"]
    / category_analysis["total_sales"] * 100
).round(2)

print("\nCategory Analysis")
print(category_analysis)

# Visualization For Category Sales

import matplotlib.pyplot as plt
# Category Sales

plt.figure(figsize=(8, 5))

plt.bar(
    category_analysis["Category"],
    category_analysis["total_sales"]
)

plt.title("Sales by Category")
plt.xlabel("Category")
plt.ylabel("Total Sales")

plt.tight_layout()
plt.show()

# ============================================
# 3. Monthly Sales Trend
# ============================================

monthly_sales = (
    df.groupby(pd.Grouper(key="Order Date", freq="MS"))
      .agg(total_sales=("Sales", "sum"))
      .reset_index()
)

# Creating 3-month rolling average
monthly_sales["rolling_3m_sales"] = (
    monthly_sales["total_sales"]
    .rolling(window=3)
    .mean()
)

print("\nMonthly Sales with 3-Month Rolling Average")
print(monthly_sales.head(6))


# # Visualization for Monthly sales with 3-month rolling average
plt.figure(figsize=(10, 5))

plt.plot(
    monthly_sales["Order Date"],
    monthly_sales["total_sales"],
    label="Monthly Sales"
)

plt.plot(
    monthly_sales["Order Date"],
    monthly_sales["rolling_3m_sales"],
    label="3-Month Rolling Average"
)

plt.title("Monthly Sales Trend with 3-Month Rolling Average")
plt.xlabel("Month")
plt.ylabel("Sales")
plt.legend()

plt.xticks(rotation=45)
plt.tight_layout()
plt.show()

# ============================================
# 4. Discount vs Profitability
# ============================================

# visualization for discount vs profit

plt.figure(figsize=(8, 5))

plt.scatter(
    df["Discount"] * 100,
    df["Profit"],
    alpha=0.4
)

plt.title("Discount vs Profit")
plt.xlabel("Discount (%)")
plt.ylabel("Profit")

plt.tight_layout()
plt.show()

# ============================================
# 5. Sub_Category Profitability
# ============================================

subcategory_analysis = (
    df.groupby("Sub-Category")
      .agg(
          total_sales=("Sales", "sum"),
          total_profit=("Profit", "sum")
      )
      .reset_index()
)

subcategory_analysis["profit_margin"] = (
    subcategory_analysis["total_profit"]
    / subcategory_analysis["total_sales"] * 100
).round(2)

subcategory_analysis = subcategory_analysis.sort_values(
    "total_profit",
    ascending=False
)

print("\nSub-Category Profitability")
print(subcategory_analysis)

# Visualization for Sub_Category Profitability

profit_extremes = pd.concat([
    subcategory_analysis.head(5),
    subcategory_analysis.tail(5)
])

plt.figure(figsize=(10, 6))

plt.barh(
    profit_extremes["Sub-Category"],
    profit_extremes["total_profit"]
)

plt.title("Top and Bottom Sub-Categories by Profit")
plt.xlabel("Total Profit")
plt.ylabel("Sub-Category")

plt.tight_layout()
plt.show()