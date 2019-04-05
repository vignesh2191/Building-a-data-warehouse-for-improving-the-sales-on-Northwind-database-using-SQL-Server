-- selecting my datawarehouse
USE NorthWind_DW
GO

-- creating the sales fact table
CREATE TABLE [dbo].[sales_fact](
	[OrderDate] [datetime] NOT NULL,
	[ProductID] [int] NOT NULL,
	OrderID INT NOT NULL,
	UnitsInStock INT NULL,
	UnitsSold INT NULL,
	[Quantity] [smallint] NULL,
	[Discount] [real] NULL,
	[SalesRevenue] [money] NULL,
	[UnitPrice] [money] NULL,
	[RevenueAfterDiscount] [money] NULL,

-- setting the primary keys
 CONSTRAINT [IX_sales_fact] UNIQUE NONCLUSTERED 
(
	[OrderDate] ASC,
	[ProductID] ASC,
	OrderID ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

-- selecting the northwind database for populating
USE Northwind
GO

-- populating the table
INSERT INTO NorthWind_DW.[dbo].sales_fact -- Change 89514_dw to YOUR data warehouse name!
        (OrderDate,
		ProductID,
		OrderID,
		UnitsInStock,
		UnitsSold,
		Quantity,
		SalesRevenue,
		UnitPrice,
		RevenueAfterDiscount
		)

SELECT 
	o.OrderDate,
	od.ProductID,
	od.OrderID,
	p.UnitsInStock,
	COUNT(od.OrderID) AS UnitsSold,
	SUM(od.Quantity) AS Quantity,
	SUM(od.UnitPrice * od.Quantity) AS SalesRevenue,
	SUM(od.UnitPrice * od.Quantity) / SUM(od.Quantity) AS UnitPrice,
	SUM(CONVERT(money,
		(od.UnitPrice*od.Quantity*(1-od.Discount)/100))*100)
		AS RevenueAfterDiscount

FROM [dbo].[Order Details] AS od
JOIN [dbo].[Orders] AS o
	ON od.OrderID = o.OrderID
JOIN [Northwind].[dbo].[Products] AS p
	ON od.ProductID = p.ProductID
GROUP BY o.OrderDate, od.ProductID, od.OrderID, p.UnitsInStock;

-- checking if the table is populated correctly
SELECT * FROM [NorthWind_DW].[dbo].sales_fact;