

--alias = AS--

select * from Sales.OrderLines
--Müþterilerin þipariþlerinin vergilendirilmiþtoplam fiyatý
select SUM(Quantity * (UnitPrice * (1 + (TaxRate/100)))) as TotalPrice from Sales.OrderLines


select * from Purchasing.PurchaseOrderLines
--Firmanýn sipariþlerinin beklenen fiyatý
select SUM(OrderedOuters * ExpectedUnitPricePerOuter) from Purchasing.PurchaseOrderLines


--ORDERS ÝÇÝN aylýk ve yýllýk olarak miktarlarýn kýrýlýmýný gör x bu iþlemi yapan bir subquery

select SUM(X.TotalPriceOfOrders) AS TotalPrice from (select DATEPART(yy,a.OrderDate) AS Year,DATEPART(mm,a.OrderDate) AS Month, SUM(Quantity * (UnitPrice * (1 + (TaxRate/100)))) as TotalPriceOfOrders from Sales.OrderLines b JOIN Sales.Orders a ON b.OrderID=a.OrderID  GROUP BY DATEPART(yy,a.OrderDate), DATEPART(mm,a.OrderDate))X 


--PURCHASE ÝÇÝN aylýk ve yýllýk olarak miktarlarýn kýrýlýmýný gör
select DATEPART(yy,b.OrderDate) AS Year, DATEPART(mm,b.OrderDate) as Month, SUM(OrderedOuters * ExpectedUnitPricePerOuter) as TotalPriceOfPurchase from Purchasing.PurchaseOrderLines a JOIN Purchasing.PurchaseOrders b ON a.PurchaseOrderID=b.PurchaseOrderID GROUP BY DATEPART(yy,b.OrderDate), DATEPART(mm,b.OrderDate) ORDER BY 1,2

--ÝKÝ TABLONUN BÝRLEÞÝMÝ
select * FROM 
(select DATEPART(yy,a.OrderDate) AS Year,DATEPART(mm,a.OrderDate) AS Month, SUM(Quantity * (UnitPrice * (1 + (TaxRate/100)))) as TotalPriceOfOrders from Sales.OrderLines b JOIN Sales.Orders a ON b.OrderID=a.OrderID  GROUP BY DATEPART(yy,a.OrderDate), DATEPART(mm,a.OrderDate))X 
FULL OUTER JOIN (select DATEPART(yy,b.OrderDate) AS Year, DATEPART(mm,b.OrderDate) as Month, SUM(OrderedOuters * ExpectedUnitPricePerOuter) as TotalPriceOfPurchase from Purchasing.PurchaseOrderLines a JOIN Purchasing.PurchaseOrders b ON a.PurchaseOrderID=b.PurchaseOrderID GROUP BY DATEPART(yy,b.OrderDate), DATEPART(mm,b.OrderDate))Y ON X.Year = Y.Year AND X.Month=Y.Month

select X.Year, X.Month, (SUM(X.TotalPriceOfOrders)/SUM(Y.TotalPriceOfPurchase)) AS RATE FROM 
(select DATEPART(yy,a.OrderDate) AS Year,DATEPART(mm,a.OrderDate) AS Month, SUM(Quantity * (UnitPrice * (1 + (TaxRate/100)))) as TotalPriceOfOrders from Sales.OrderLines b JOIN Sales.Orders a ON b.OrderID=a.OrderID  GROUP BY DATEPART(yy,a.OrderDate), DATEPART(mm,a.OrderDate))X 
FULL OUTER JOIN (select DATEPART(yy,b.OrderDate) AS Year, DATEPART(mm,b.OrderDate) as Month, SUM(OrderedOuters * ExpectedUnitPricePerOuter) as TotalPriceOfPurchase from Purchasing.PurchaseOrderLines a JOIN Purchasing.PurchaseOrders b ON a.PurchaseOrderID=b.PurchaseOrderID GROUP BY DATEPART(yy,b.OrderDate), DATEPART(mm,b.OrderDate))Y ON X.Year = Y.Year AND X.Month=Y.Month GROUP BY X.Year, X.Month



