-- creating the product dimension table
CREATE TABLE Northwind_DW.dbo.product_dimension (
	ProductID INT NOT NULL,
	ProductName NVARCHAR(40) NOT NULL,
	SupplierCompanyName NVARCHAR(40) NOT NULL,
	CategoryName NVARCHAR(15) NOT NULL,

-- setting the primary key
PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF,
IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON,
ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

-- selecting the northwind database for populating
USE Northwind
GO

-- populating the product_dimension table
INSERT INTO NorthWind_DW.[dbo].product_dimension
        (ProductID,
		ProductName,
		SupplierCompanyName,
		CategoryName
		)
SELECT DISTINCT
	p.ProductID,
	p.ProductName,
	s.CompanyName AS SupplierCompanyName,
	c.CategoryName
FROM [dbo].[Products] AS p
LEFT JOIN [dbo].[Suppliers] AS s
	ON p.SupplierID = s.SupplierID
LEFT JOIN [dbo].[Categories] AS c
	ON p.CategoryID = c.CategoryID;

-- checking if the table is populated correctly
SELECT * FROM NorthWind_DW.dbo.product_dimension;