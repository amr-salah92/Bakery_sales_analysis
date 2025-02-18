/*
BAKERY SALES ANALYSIS PROJECT

This project analyzes sales data from a bakery to uncover business insights including:
- Key sales metrics and product performance
- Premium vs standard product categorization
- Sales trends by time and product categories
- Inventory turnover rates
The analysis helps optimize product offerings, pricing strategies, and operational planning.
*/

-- ###############
-- DATA PREPARATION
-- ###############

USE bakery;  -- Set database context

-- Initial data inspection
SELECT * FROM bakery LIMIT 5;

-- Disable safe update mode for data modifications
SET SQL_SAFE_UPDATES = 0;

-- Fix column name with encoding artifact
ALTER TABLE bakery
CHANGE COLUMN ï»؟ID ID INT;

-- Convert text dates to proper DATE format
UPDATE bakery 
SET DATE = STR_TO_DATE(date, '%c/%e/%Y');

-- #########################
-- BASIC SALES METRICS ANALYSIS
-- #########################

-- Quantity extremes analysis
SELECT  
    MAX(QUANTITY) AS Top_quantity,
    MIN(QUANTITY) AS Smallest_quantity
FROM bakery;

-- Price range analysis
SELECT  
    MAX(unit_price) AS Max_unit_price,
    MIN(unit_price) AS Min_unit_price
FROM bakery;

-- Transaction timeframe analysis
SELECT  
    MAX(date) AS Last_transaction,
    MIN(date) AS First_transaction
FROM bakery;

-- ########################
-- PRODUCT PERFORMANCE ANALYSIS
-- ########################

-- Top selling products analysis
SELECT 
    ITEM, 
    SUM(QUANTITY) AS Total_quantity,
    ROUND(AVG(UNIT_PRICE),2) AS Avg_price,
    ROUND(SUM(TOTAL),2) AS Total_sales
FROM bakery 
GROUP BY ITEM
ORDER BY Total_sales DESC;

-- High-demand items (Above average quantity)
WITH ItemAverages AS (
    SELECT 
        ITEM, 
        AVG(QUANTITY) AS Item_avg_qty
    FROM bakery
    GROUP BY ITEM
)
SELECT 
    ITEM, 
    Item_avg_qty AS Avg_quantity
FROM ItemAverages
WHERE Item_avg_qty > (SELECT AVG(QUANTITY) FROM bakery)
ORDER BY Avg_quantity DESC;

-- #########################
-- PREMIUM PRODUCT ANALYSIS
-- #########################

-- Premium product identification
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

-- Premium product sales contribution
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

-- ########################
-- TEMPORAL ANALYSIS
-- ########################

-- Inventory turnover rate
SELECT 
    ITEM,
    DATEDIFF(MAX(date), MIN(date)) AS Days_interval
FROM bakery
GROUP BY ITEM
ORDER BY Days_interval;

-- Hourly sales trends for top products
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
ORDER BY ITEM, Sale_hour DESC;

-- Premium items hourly trends
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

-- Monthly sales performance
SELECT 
    MONTHNAME(date) AS Sale_month,
    ROUND(SUM(Total),2) AS Monthly_sales
FROM bakery
GROUP BY Sale_month
ORDER BY Monthly_sales DESC;