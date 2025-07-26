# Table of Contents

- [Project Name](#project-name)
- [Project Background](#project-background)
- [Project Goals](#project-goals)
- [Data Structure & Initial Checks](#data-structure--initial-checks)
- [Executive Summary](#executive-summary)
- [Insights Deep Dive](#insights-deep-dive)
  - [Sales Trends](#sales-trends)
  - [Product Performance](#product-performance)
  - [Peak Sales Hours](#peak-sales-hours)
  - [Customer Purchasing Patterns](#customer-purchasing-patterns)
- [Recommendations](#recommendations)
- [Technical Details](#technical-details)
- [Assumptions and Caveats](#assumptions-and-caveats)

## Project Name

**Bakery Sales Analysis**

## Project Background

This project analyzes sales transactions for a bakery, covering 1,295 transactions in January 2021. The bakery operates in the food retail industry, offering a variety of baked goods and beverages. The business model is direct-to-consumer sales via a storefront.

Key business metrics:
- Sales Volume: 1,295 transactions recorded
- Total Unique Items Sold: 81 different products
- Transaction Frequency: Sales occur throughout the day, with peak activity around mid-morning to noon.

## Project Goals

As a data analyst at the bakery, the objective of this analysis is to:
- Identify high-performing products that drive revenue.
- Determine peak sales hours to optimize staffing and inventory.
- Analyze customer purchasing behavior to create targeted promotions.
- Provide actionable recommendations to improve overall sales and efficiency.

## Data Structure & Initial Checks

The dataset consists of four key columns describing each transaction:
- Date & Time: Timestamp of each purchase.
- Item & Quantity: Products sold per transaction.
- Pricing Information: Unit price and total transaction cost.
- Transaction ID: Unique identifier for each purchase.

Initial Observations:
- No missing data in the dataset.
- Sales are recorded from January 3, 2021, onward.
- Some transactions include bulk purchases (up to 200 units in a single transaction).

## Executive Summary

**Overview of Findings**
- Traditional Baguettes dominate sales, with "Traditional Baguette" being the best-seller (630 units).
- Peak sales occur from 10 AM , with €201 in revenue.
- Coffee and croissants are popular breakfast items, indicating strong morning demand.

  
![Screenshot_26-7-2025_213433_chat deepseek com](https://github.com/user-attachments/assets/b8bce037-19b2-4327-934c-9c9928d19bfc)

## Insights Deep Dive

### Sales Trends
- Sales are highest on weekends, with a sharp increase on Fridays and Saturdays.
- Some weekdays see lower sales volume, indicating possible off-peak periods.

### Product Performance
Top 3 best-selling products:
1. Traditional Baguette (630 units)

![Screenshot_13-2-2025_21218_chatgpt com](https://github.com/user-attachments/assets/8181122d-6096-4717-865f-fbb3cb361abb)

2. Coffee (211 units)

![Screenshot_13-2-2025_21436_chatgpt com](https://github.com/user-attachments/assets/c356edec-34ab-43b8-921b-61f54a0b08bd)

3. Croissant (168 units)

![Screenshot_13-2-2025_2165_chatgpt com](https://github.com/user-attachments/assets/b7489a65-c578-4533-b189-47f610222ddf)

Least-selling items include specialty bread varieties and limited-time pastries.

### Peak Sales Hours
- Noon (10 AM) is the busiest hour (€201 in revenue).
- Mid-morning (9 AM - 11 AM) sees consistent high sales, suggesting strong breakfast demand.
- Evening sales are lower, indicating reduced foot traffic after work hours.

### Customer Purchasing Patterns
- Most customers buy one to two items per transaction.
- Certain items (e.g., coffee) are commonly purchased together with pastries.
- Large bulk orders (100+ units) are rare but contribute significantly to daily revenue.

## Recommendations
- Stock high-demand items before peak hours: Ensure sufficient inventory of baguettes, coffee, and croissants before 9 AM - 12 PM.
- Offer breakfast promotions: Bundling coffee with pastries could increase morning sales.
- Target slow periods with discounts & new products: Afternoon and evening discounts may attract more customers.
- Optimize staffing based on peak times: Increase staff availability between 9 AM - 12 PM.
- Purchase ingredients for top-selling products, such as baguettes and croissants, at better profit margins by negotiating bulk supplier discounts.

## Technical Details
- **SQL**: Used for data cleaning and sales aggregation, ensuring accurate transaction analysis.
- **Excel (Power Query Editor)**: Utilized for initial data cleaning and transformation, handling duplicates and formatting issues.
- **Power BI**: Developed an interactive dashboard to visualize key trends and insights, making it easier for stakeholders to explore sales data dynamically.
- **Figma**: Designed custom visual elements for the dashboard to enhance usability and presentation.

## Assumptions and Caveats
- Missing sales data for some early January dates may slightly impact trend analysis.
- The dataset does not include customer demographics, limiting insights into buyer segmentation.
- Refunds and returns are not documented, potentially affecting revenue calculations.

Links to Resources:
- **SQL Queries**: [https://github.com/amr-salah92/Bakery_sales_analysis/blob/main/BAKERY.sql]

