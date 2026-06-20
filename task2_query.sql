USE Join_task;
GO

-- KPI Dashboard Summary
SELECT
    ROUND(SUM(Sales), 2) AS Total_Sales,
    ROUND(SUM(Profit), 2) AS Total_Profit,
    COUNT(Order_ID) AS Total_Orders,
    ROUND(SUM(Sales) / COUNT(Order_ID), 2) AS Avg_Order_Value,
    ROUND((SUM(Profit) * 100.0 / SUM(Sales)), 2) AS Profit_Margin_Percentage
FROM Orders;
GO

-- 1. Total Sales by Region
SELECT
    c.Region,
    SUM(o.Sales) AS Total_Sales
FROM Orders o
INNER JOIN Customers c
ON o.Customer_ID = c.Customer_ID
GROUP BY c.Region
ORDER BY Total_Sales DESC;
GO

--2. Profit Margin by Category
SELECT
    Product_Category,
    ROUND((SUM(Profit) * 100.0 / SUM(Sales)), 2) AS Profit_Margin
FROM Orders
GROUP BY Product_Category
ORDER BY Profit_Margin DESC;
GO

--   3. Monthly Sales Trend
SELECT
    DATENAME(MONTH, Order_Date) AS Month_Name,
    SUM(Sales) AS Monthly_Sales
FROM Orders
GROUP BY DATENAME(MONTH, Order_Date), MONTH(Order_Date)
ORDER BY MONTH(Order_Date);
GO

--   4. Top 5 Customers by Revenue
SELECT TOP 5
    c.Customer_Name,
    SUM(o.Sales) AS Revenue
FROM Orders o
INNER JOIN Customers c
ON o.Customer_ID = c.Customer_ID
GROUP BY c.Customer_Name
ORDER BY Revenue DESC;
GO

-- 5. Sales by Customer Segment
SELECT
    c.Segment,
    SUM(o.Sales) AS Total_Sales
FROM Orders o
INNER JOIN Customers c
ON o.Customer_ID = c.Customer_ID
GROUP BY c.Segment
ORDER BY Total_Sales DESC;
GO

-- 6. Top 5 Customers by Profit
SELECT TOP 5
    c.Customer_Name,
    SUM(o.Profit) AS Total_Profit
FROM Orders o
INNER JOIN Customers c
ON o.Customer_ID = c.Customer_ID
GROUP BY c.Customer_Name
ORDER BY Total_Profit DESC;
GO

-- 7. Category-wise Sales
SELECT
    Product_Category,
    SUM(Sales) AS Total_Sales
FROM Orders
GROUP BY Product_Category
ORDER BY Total_Sales DESC;
GO

-- 8. Discount Impact on Profitability
SELECT
    CASE
        WHEN Discount = 0 THEN 'No Discount'
        WHEN Discount <= 0.10 THEN 'Low Discount'
        WHEN Discount <= 0.20 THEN 'Medium Discount'
        ELSE 'High Discount'
    END AS Discount_Level,
    SUM(Profit) AS Total_Profit
FROM Orders
GROUP BY
    CASE
        WHEN Discount = 0 THEN 'No Discount'
        WHEN Discount <= 0.10 THEN 'Low Discount'
        WHEN Discount <= 0.20 THEN 'Medium Discount'
        ELSE 'High Discount'
    END
ORDER BY Total_Profit DESC;
GO

-- Summary Table: Sales and Profit by Category
SELECT
    Product_Category,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM Orders
GROUP BY Product_Category
ORDER BY Total_Sales DESC;
GO