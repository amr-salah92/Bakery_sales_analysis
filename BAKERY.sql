/*
==========================
BAKERY SALES ANALYSIS PROJECT
==========================

Objective:
Analyze bakery sales data to extract business insights on:
- Sales performance and trends
- Product categorization (premium vs standard)
- Time-based patterns (hourly, monthly)
- Inventory dynamics

Outcome:
Optimize pricing, inventory management, and marketing strategies.
*/

-- ========================
-- SECTION 1: DATA PREPARATION
-- ========================

-- Set the working database context
USE bakery;

-- Preview the first 5 rows of data
SELECT * FROM bakery LIMIT 5;

-- Disable safe update mode to allow unrestricted updates
SET SQL_SAFE_UPDATES = 0;

-- Fix improperly encoded column name
ALTER TABLE bakery
CHANGE COLUMN ï»؟ID ID INT;

-- Convert date strings to proper DATE format
UPDATE bakery 
SET DATE = STR_TO_DATE(date, '%c/%e/%Y');


-- ==================================
-- SECTION 2: BASIC SALES METRICS ANALYSIS
-- ==================================

-- Find the maximum and minimum quantity sold in a single transaction
SELECT  
    MAX(QUANTITY) AS Top_quantity,
    MIN(QUANTITY) AS Smallest_quantity
FROM bakery;

-- Identify the highest and lowest unit prices
SELECT  
    MAX(unit_price) AS Max_unit_price,
    MIN(unit_price) AS Min_unit_price
FROM bakery;

-- Determine the earliest and latest transaction dates
SELECT  
    MAX(date) AS Last_transaction,
    MIN(date) AS First_transaction
FROM bakery;

-- Calculate order frequency and quantity sold per transaction
SELECT 
    ticket_number,
    COUNT(Quantity) AS Order_count,
    SUM(Quantity) AS Total_quantity_sold
FROM bakery
GROUP BY ticket_number 
ORDER BY Total_quantity_sold DESC;


-- ==================================
-- SECTION 3: PRODUCT PERFORMANCE ANALYSIS
-- ==================================

-- List top-selling products by total sales, with quantity and average price
SELECT 
    ITEM, 
    COUNT(Quantity) AS Order_count,
    SUM(QUANTITY) AS Total_quantity,
    ROUND(AVG(UNIT_PRICE),2) AS Avg_price,
    ROUND(SUM(TOTAL),2) AS Total_sales
FROM bakery 
GROUP BY ITEM
ORDER BY Total_sales DESC;

-- Identify high-demand products whose average quantity exceeds overall average
WITH ItemAverages AS (
    SELECT 
        ITEM, 
        AVG(QUANTITY) AS Item_avg_qty
    FROM bakery
    GROUP BY ITEM
)
SELECT 
    b.ITEM, 
    COUNT(b.QUANTITY) AS Order_count,
    SUM(b.QUANTITY) AS Total_quantity,
    ia.Item_avg_qty AS Avg_quantity
FROM bakery b
JOIN ItemAverages ia ON b.ITEM = ia.ITEM
WHERE ia.Item_avg_qty > (SELECT AVG(QUANTITY) FROM bakery)
GROUP BY b.ITEM, ia.Item_avg_qty
ORDER BY Avg_quantity DESC;


-- ==================================
-- SECTION 4: PREMIUM PRODUCT ANALYSIS
-- ==================================

-- Categorize products as Premium or Standard based on unit price > 4x average
WITH AveragePrice AS (
    SELECT AVG(UNIT_PRICE) AS Avg_price FROM bakery
),
ThresholdPrice AS (
    SELECT Avg_price * 4 AS Premium_threshold 
    FROM AveragePrice
)
SELECT 
    b.ITEM, 
    ROUND(AVG(b.UNIT_PRICE),2) AS Avg_price,
    CASE 
        WHEN AVG(b.UNIT_PRICE) > t.Premium_threshold THEN 'Premium'
        ELSE 'Standard'
    END AS Price_category
FROM bakery b
CROSS JOIN ThresholdPrice t
GROUP BY b.ITEM
ORDER BY Avg_price DESC;

-- Calculate sales and contribution % of selected premium items
WITH TotalSales AS (
    SELECT SUM(TOTAL) AS All_sales FROM bakery
)
SELECT 
    b.ITEM,
    ROUND(SUM(b.TOTAL),2) AS Item_sales,
    ROUND((SUM(b.TOTAL)/ts.All_sales)*100, 2) AS Sales_percentage
FROM bakery b, TotalSales ts
WHERE b.ITEM IN ('ROYAL 6P', 'TARTE FRAISE 6P', 'TARTE FRAISE 4PER', 'TRAITEUR', 'TARTE FRUITS 4P')
GROUP BY b.ITEM
ORDER BY Item_sales DESC;


-- ==============================
-- SECTION 5: TEMPORAL ANALYSIS
-- ==============================

-- Measure inventory turnover interval for each product
SELECT 
    ITEM,
    DATEDIFF(MAX(date), MIN(date)) AS Days_available
FROM bakery
GROUP BY ITEM
ORDER BY Days_available DESC;

-- Analyze hourly sales trends for top products
WITH HourlySales AS (
    SELECT 
        ITEM,
        DATE_FORMAT(STR_TO_DATE(TIME, '%r'), '%H:00:00') AS Sale_hour,
        SUM(QUANTITY) AS Total_sold
    FROM bakery
    WHERE ITEM IN ('TRADITIONAL BAGUETTE', 'FORMULE SANDWICH')
    GROUP BY Sale_hour, ITEM
)
SELECT 
    ITEM,
    Sale_hour,
    Total_sold
FROM HourlySales
ORDER BY Total_sold DESC;

-- Analyze hourly sales trends for premium products
WITH HourlySales AS (
    SELECT 
        ITEM,
        DATE_FORMAT(STR_TO_DATE(TIME, '%r'), '%H:00:00') AS Sale_hour,
        SUM(QUANTITY) AS Total_sold
    FROM bakery
    WHERE ITEM IN ('ROYAL 6P', 'TARTE FRAISE 6P', 'TARTE FRAISE 4PER', 'TRAITEUR', 'TARTE FRUITS 4P')
    GROUP BY Sale_hour, ITEM
)
SELECT 
    ITEM,
    Sale_hour,
    Total_sold
FROM HourlySales
ORDER BY ITEM, Sale_hour DESC;

-- Get monthly sales totals
SELECT 
    MONTHNAME(date) AS Sale_month,
    ROUND(SUM(Total),2) AS Monthly_sales
FROM bakery
GROUP BY Sale_month
ORDER BY Monthly_sales DESC;

-- Calculate Month-over-Month (MoM) percentage change in monthly sales
WITH MonthlySales AS (
    SELECT 
        DATE_FORMAT(date, '%Y-%m') AS Sale_month,
        ROUND(SUM(Total), 2) AS Monthly_sales
    FROM bakery
    GROUP BY Sale_month
),
SalesWithChange AS (
    SELECT 
        Sale_month,
        Monthly_sales,
        LAG(Monthly_sales) OVER (ORDER BY Sale_month) AS Previous_month_sales,
        ROUND(
            (Monthly_sales - LAG(Monthly_sales) OVER (ORDER BY Sale_month)) / 
            LAG(Monthly_sales) OVER (ORDER BY Sale_month) * 100, 
            2
        ) AS MoM_change_percentage
    FROM MonthlySales
)
SELECT * FROM SalesWithChange
ORDER BY Sale_month;
