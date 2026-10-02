-- Retail Business Performance & Profitability Analysis
-- Dataset: SuperStoreOrders.csv

-- 1. Check total records
SELECT COUNT(*) AS total_records
FROM orders;

-- 2. Check missing values in important columns
SELECT
    SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) AS missing_order_id,
    SUM(CASE WHEN order_date IS NULL THEN 1 ELSE 0 END) AS missing_order_date,
    SUM(CASE WHEN ship_date IS NULL THEN 1 ELSE 0 END) AS missing_ship_date,
    SUM(CASE WHEN sales IS NULL THEN 1 ELSE 0 END) AS missing_sales,
    SUM(CASE WHEN profit IS NULL THEN 1 ELSE 0 END) AS missing_profit
FROM orders;

-- 3. Profit margin by category
SELECT
    category,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    ROUND(SUM(profit) * 100.0 / SUM(sales), 2) AS profit_margin
FROM orders
GROUP BY category
ORDER BY profit_margin DESC;

-- 4. Profit margin by sub-category
SELECT
    sub_category,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit,
    ROUND(SUM(profit) * 100.0 / SUM(sales), 2) AS profit_margin
FROM orders
GROUP BY sub_category
ORDER BY profit_margin DESC;

-- 5. Slow-moving products
SELECT
    product_name,
    SUM(quantity) AS total_quantity_sold,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM orders
GROUP BY product_name
ORDER BY total_quantity_sold ASC
LIMIT 10;

-- 6. Region-wise performance
SELECT
    region,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM orders
GROUP BY region
ORDER BY total_profit DESC;

-- 7. Monthly sales and profit
SELECT
    strftime('%Y-%m', order_date) AS month,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM orders
GROUP BY month
ORDER BY month;

-- 8. Customer segment performance
SELECT
    segment,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM orders
GROUP BY segment
ORDER BY total_profit DESC;

-- 9. Category and sub-category performance
SELECT
    category,
    sub_category,
    SUM(sales) AS total_sales,
    SUM(profit) AS total_profit
FROM orders
GROUP BY category, sub_category
ORDER BY total_profit DESC;