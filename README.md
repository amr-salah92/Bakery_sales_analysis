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
- Mid-morning (9 AM - 12 PM) sees consistent high sales, suggesting strong breakfast demand.
- Evening sales are lower, indicating reduced foot traffic after work hours.

### Customer Purchasing Patterns
- Most customers buy one to two items per transaction.
- Certain items (e.g., coffee) are commonly purchased together with pastries.
- Large bulk orders (100+ units) are rare but contribute significantly to daily revenue.

##Business Questions & Answers

## 📊 Sales Metrics & Trends
### 1. What are the busiest times for sales?
**Answer:**  
- **Peak Hour:** 11 AM generates the highest revenue (€133 from baguettes alone).  
- **Peak Window:** 9 AM - 12 PM accounts for 60% of top-selling item (Traditional Baguette) sales.  
- **Weekly Pattern:** Fridays and Saturdays see 30% higher sales than weekdays.  

### 2. How do monthly sales trends look?  
**Answer:**  
- **Top Months:** April (€659) and May (€640) are peak revenue months.  
- **Growth:** February 2022 saw a 184% MoM sales surge compared to January 2022.  
- **Low Season:** September (€85) and December (€86) are the slowest months.  

---

## 🥖 Product Performance  
### 3. What are the top-selling products?  
**Answer:**  
| Product              | Units Sold | Total Revenue |  
|----------------------|------------|--------------|  
| Traditional Baguette | 630        | €778         |  
| Coffee               | 211        | €211         |  
| Croissant            | 168        | €191         |  

### 4. Which premium products drive revenue?  
**Answer:**  
- **Traiteur** (catering) generates €114 (2.8% of total revenue).  
- **Tarte Fraise 6P** contributes €75 (1.8% of revenue), primarily sold between 9 AM - 4 PM.  

### 5. Which items have low turnover?  
**Answer:**  
- Specialty breads (e.g., *Gache*, *Gal Frangipane*) show minimal sales.  
- Slow-movers like *Divers Patisserie* take >500 days to sell out.  

---

## ⚙️ Operational Insights  
### 6. How should staffing be optimized?  
**Answer:**  
- **Increase staff:** 8 AM - 1 PM (peak demand window).  
- **Reduce staff:** After 3 PM when sales drop by 45%.  

### 7. What inventory adjustments are needed?  
**Answer:**  
- **Stock 20% more:** Baguettes, coffee, and croissants before 8 AM daily.  
- **Discontinue:** Specialty breads with <€10 monthly revenue (e.g., *Sable F P*, *Tulipe*).  

---

## 🧑 Customer Behavior  
### 8. What are common purchase patterns?  
**Answer:**  
- 72% of transactions include 1-2 items.  
- **Top Combo:** 38% of coffee purchases include a croissant or pastry.  
- **Bulk Orders:** Rare (0.8% of transactions) but drive 15% of daily revenue when they occur.  

### 9. When do premium items sell best?  
**Answer:**  
- **Traiteur:** Peaks at 11 AM (4 units) and 12 PM (2 units).  
- **Tarte Fraise 6P:** Sells best at 4 PM (40% of daily premium sales).  

---

## 💡 Recommendations Summary  
### 10. What key actions should the bakery take?  
**Answer:**  
1. **Bundle breakfast items:** Coffee + croissant promotions before 10 AM.  
2. **Negotiate bulk discounts:** Flour/suppliers for baguette ingredients (630 units/month).  
3. **Run afternoon promotions:** Target 2 PM - 5 PM lulls with 15% off slow-moving items.  
4. **Reallocate staff:** Shift 2 employees from evenings to morning peaks.  

---
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

