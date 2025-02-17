USE bakery;

SELECT * FROM bakery 
LIMIT 5 ;

SET SQL_SAFE_UPDATES = 0;

ALTER TABLE bakery
CHANGE COLUMN ï»؟ID ID INT;

UPDATE bakery 
SET DATE = STR_TO_DATE(date, '%c/%e/%Y');

-- BIGGEST & SMALL QUANTITY 
SELECT  
MAX(QUANTITY) AS Top_quantity,
MIN(QUANTITY) AS SMALLEST_QUANTITY
 FROM bakery ;
-- TOP & BOTTOM UNIT_PRICE
SELECT  
MAX(unit_price) AS Top_UNIT_PRICE,
MIN(unit_price) AS SMALLEST_UNIT_PRICE
 FROM bakery ;
-- START & END OF TRANSACTIONS
 SELECT  
MAX(date) AS END_DATE,
MIN(date) AS START_DATE
 FROM bakery ;
 
 
-- BEST SELLING ITEM 
SELECT ITEM, 
SUM(QUANTITY) AS TOTAL_QTY,
ROUND(AVG(UNIT_PRICE),2) AS AVG_UPRICE,
ROUND(SUM(TOTAL),2) AS TOTAL_SALES
 FROM bakery 
 GROUP BY ITEM
 ORDER BY TOTAL_SALES DESC;
 
 
 -- ABOVE AVG SELLING ITEM
-- Common Table Expression (CTE) to calculate the average quantity per item
WITH ALL_AVG_QTY AS (
  SELECT 
    ITEM, 
    AVG(QUANTITY) AS ITEM_AVG_QTY
  FROM 
    bakery
  GROUP BY 
    ITEM
)
-- Main query to select items with average quantity above the overall average
SELECT 
  ITEM, 
  ITEM_AVG_QTY AS AVG_QTY
FROM 
  ALL_AVG_QTY
WHERE 
  ITEM_AVG_QTY > (
    SELECT 
      AVG(QUANTITY) 
    FROM 
      bakery 
    WHERE 
      bakery.ITEM = ALL_AVG_QTY.ITEM
  )
ORDER BY 
  AVG_QTY DESC;

-- Premium products
-- Step 1: Calculate the average unit price
WITH AveragePrice AS (
  SELECT AVG(UNIT_PRICE) AS AVG_PRICE
  FROM bakery
)

-- Step 2: Define a threshold (e.g., 4 times the average price)
, ThresholdPrice AS (
  SELECT AVG_PRICE * 4 AS PREMIUM_THRESHOLD
  FROM AveragePrice
)

-- Step 3: Categorize items and calculate average unit price
SELECT 
  b.ITEM, 
  AVG(b.UNIT_PRICE) AS AVG_UNIT,
  CASE 
    WHEN AVG(b.UNIT_PRICE) > t.PREMIUM_THRESHOLD THEN 'Premium'
    ELSE 'Standard'
  END AS ITEM_CATEGORY
FROM 
  bakery b
CROSS JOIN 
  ThresholdPrice t
GROUP BY 
  b.ITEM, t.PREMIUM_THRESHOLD
ORDER BY 
  AVG_UNIT DESC;

-- Premium Sales share
WITH TOTAL_SALES AS (
  SELECT SUM(TOTAL) AS ALL_SALES
  FROM bakery
)
SELECT 
  b.ITEM,
  SUM(b.TOTAL) AS TOTAL_SALES,
  (SUM(b.TOTAL) / ts.ALL_SALES)*100 AS PERCENT
FROM 
  bakery b, TOTAL_SALES ts
WHERE 
  b.ITEM IN ('ROYAL 6P', 'TARTE FRAISE 6P', 'TARTE FRAISE 4PER', 'TRAITEUR', 'TARTE FRUITS 4P')
GROUP BY 
  b.ITEM, ts.ALL_SALES
ORDER BY 
  TOTAL_SALES DESC;

-- fast and slow selling ITEM according to days interval 
SELECT ITEM,
  DATEDIFF(MAX((date)), MIN((date))) AS Days_interval
FROM bakery
GROUP BY ITEM
ORDER BY Days_interval;

-- percent of fast selling items 
WITH TotalSales AS (
  SELECT SUM(TOTAL) AS AllSales
  FROM bakery
),
ItemSales AS (
  SELECT ITEM, SUM(TOTAL) AS ItemTotal
  FROM bakery
  WHERE ITEM IN (
    'PLAT 6.50E', 'DIVERS PATISSERIE', 'GACHE', 'DEMI BAGUETTE', 
    'GAL FRANGIPANE 4P', 'PAILLE', 'TULIPE', 'SABLE F  P', 
    'MACARON', 'ROYAL 6P', 'ROYAL', 'TARTELETTE CHOC', 
    'TARTE FINE', 'PLAT 8.30E', 'BROWNIES', 'DIVERS BOISSONS', 
    'FINANCIER', 'PALET BRETON', 'TRIANGLES'
  )
  GROUP BY ITEM
)
SELECT 
  i.ITEM, 
  i.ItemTotal AS TotalSales, 
  (i.ItemTotal / t.AllSales) * 100 AS PercentSales
FROM 
  ItemSales i, 
  TotalSales t
ORDER BY 
  PercentSales DESC;
  
  
  -- best selling item by percent 
 WITH TotalSales AS (
  SELECT SUM(TOTAL) AS AllSales
  FROM bakery
)
SELECT 
  b.ITEM, 
 ROUND(SUM(b.TOTAL),2) AS TotalSales, 
  ROUND((SUM(b.TOTAL) / t.AllSales),2) * 100 AS PercentSales
FROM 
  bakery b,
  TotalSales t
GROUP BY 
  b.ITEM, 
  t.AllSales
ORDER BY 
  PercentSales DESC;

-- sales trend for best 2 items ('TRADITIONAL BAGUETTE', 'FORMULE SANDWICH')
WITH HourlySales AS (
  SELECT 
    ITEM,
    DATE_FORMAT(STR_TO_DATE(TIME, '%r'), '%H:00:00') AS SaleHour,
    SUM(QUANTITY) AS TotalSold
  FROM bakery
  WHERE ITEM IN ('TRADITIONAL BAGUETTE', 'FORMULE SANDWICH')
  GROUP BY SaleHour, ITEM
)
SELECT 
  ITEM,
  SaleHour,
  TotalSold
FROM 
  HourlySales
ORDER BY 
  ITEM, SaleHour DESC;
  
  
  -- sales trend for premium items ('ROYAL 6P', 'TARTE FRAISE 6P', 'TARTE FRAISE 4PER', 'TRAITEUR', 'TARTE FRUITS 4P')
WITH HourlySales AS (
  SELECT 
    ITEM,
    DATE_FORMAT(STR_TO_DATE(TIME, '%r'), '%H:00:00') AS SaleHour,
    SUM(QUANTITY) AS TotalSold
  FROM bakery
  WHERE ITEM IN ('ROYAL 6P', 'TARTE FRAISE 6P', 'TARTE FRAISE 4PER', 'TRAITEUR', 'TARTE FRUITS 4P')
  GROUP BY SaleHour, ITEM
)
SELECT 
  ITEM,
  SaleHour,
  TotalSold
FROM 
  HourlySales
ORDER BY 
  ITEM, SaleHour DESC;


-- best month in sales
SELECT 
  MONTHNAME(date) AS SaleMonth,
  SUM(Total) AS TotalSold
FROM bakery
GROUP BY SaleMonth
ORDER BY TotalSold DESC;
