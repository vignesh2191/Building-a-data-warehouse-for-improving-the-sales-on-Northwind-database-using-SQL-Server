-- creating the order dimension table
CREATE TABLE Northwind_DW.dbo.order_dimension (
	OrderID INT NOT NULL,
	OrderDate datetime NOT NULL,

-- setting the primary key
PRIMARY KEY CLUSTERED 
(
	OrderID ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

-- selecting the northwind database
USE Northwind
GO

-- populating the order dimension table
INSERT INTO NorthWind_DW.[dbo].order_dimension
        (OrderID,
		OrderDate)

SELECT DISTINCT
	o.OrderID,
	o.OrderDate

FROM [dbo].Orders AS o

-- checking if the table is populated correctly
SELECT * FROM NorthWind_DW.dbo.order_dimension;