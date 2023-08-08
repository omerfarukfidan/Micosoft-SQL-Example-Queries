select * from 
(select PrimaryContactPersonID, a.DeliveryMethodID, b.DeliveryMethodName, BillToCustomerID, CustomerCategoryID, CustomerID
from Sales.Customers a 
 JOIN Application.DeliveryMethods b ON b.DeliveryMethodID = a.DeliveryMethodID )X
 JOIN Sales.Invoices c ON c.DeliveryMethodID = x.DeliveryMethodID AND c.CustomerID = x.CustomerID

 select a.CityID, a.CityName, b.StateProvinceID, b.StateProvinceName from Application.Cities a FULL JOIN Application.StateProvinces b on a.StateProvinceID = b.StateProvinceID WHERE a.StateProvinceID IS NULL OR b.StateProvinceID IS NULL--RIGHT LEFT INNER HEPSÝNDE AYNI SAYIDA ROW DÖNÜYOR SEBEBÝ EÞLEMEYEN OLMAMAISI MI?


  select a.StockItemID, a.StockItemName from Warehouse.StockItems a
  select * from [Warehouse].[StockItemStockGroups]

 select a.StockItemID, a.StockItemName from Warehouse.StockItems a JOIN [Warehouse].[StockItemStockGroups] b ON a.StockItemID = b.StockItemID



 select * 
from Sales.Customers a 
 INNER JOIN Sales.Invoices b ON b.CustomerID = a.CustomerID
 where a.DeliveryMethodID!=b.DeliveryMethodID

 select sum(adet)
 from (
 select CustomerID, count(*)adet from Sales.Invoices group by CustomerID)x


  select CustomerID from Sales.Invoices
  where CustomerID>100
  group by CustomerID
  having count(*)>130

order by 2, 3 desc


 select * from Sales.Invoices where CustomerID = 1

 select *
 into Customers_04Aug23
 from Sales.Customers 

 begin transaction

 delete Sales.Customers 
 where CustomerID = 3

 rollback
 commit


select * Application.DeliveryMethods


select count(distinct TABLE_NAME) from INFORMATION_SCHEMA.COLUMNS
where COLUMN_NAME like 'customer%'

Turkish_CI_AS

select * 
into OA
from (
select distinct object_id x from sys.all_columns)a
CROSS JOIN
(
select distinct object_id y from sys.all_columns)b
order by NEWID()

select * from OA where col1 = 42
select * from OA where col2 = 42
select * from OA where idx = 42

insert OA ( col1, col2) values(1, 1)

sele