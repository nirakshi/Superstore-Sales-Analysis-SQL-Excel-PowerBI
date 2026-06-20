CREATE TABLE Orders (
    Order_ID NVARCHAR(50),
    Order_Date DATE,
    Customer_ID NVARCHAR(50),
    Product_Category NVARCHAR(50),
    Sales FLOAT,
    Quantity TINYINT,
    Discount FLOAT,
    Profit FLOAT
);
GO

INSERT INTO Orders (
    Order_ID,
    Order_Date,
    Customer_ID,
    Product_Category,
    Sales,
    Quantity,
    Discount,
    Profit
)
SELECT
    Order_ID,
    Order_Date,
    Customer_ID,
    Category,
    Sales,
    Quantity,
    Discount,
    Profit
FROM [dbo].[Sample - Superstore];
GO

CREATE TABLE Customers (
    Customer_ID NVARCHAR(50),
    Customer_Name NVARCHAR(50),
    Region NVARCHAR(50),
    Segment NVARCHAR(50)
);
GO

INSERT INTO Customers (
    Customer_ID,
    Customer_Name,
    Region,
    Segment
)
SELECT DISTINCT
    Customer_ID,
    Customer_Name,
    Region,
    Segment
FROM [dbo].[Sample - Superstore];
GO

SELECT
    o.Order_ID,
    c.Customer_Name,
    c.Region,
    c.Segment,
    o.Product_Category,
    o.Sales,
    o.Profit
FROM Orders o
INNER JOIN Customers c
ON o.Customer_ID = c.Customer_ID;
GO
