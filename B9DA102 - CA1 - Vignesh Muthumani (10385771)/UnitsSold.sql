
SELECT
 ProductID,
 COUNT(OrderID) AS UnitsSold

FROM [Northwind].[dbo].[Order Details]
GROUP BY ProductID 
