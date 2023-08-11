--update sales.Customers set CustomerName = 'Ömer' where CustomerID = 100
select * from sales.Orders
select * from sales.InvoiceLines

begin transaction
select * from sales.Invoices

update i
	set OrderTotal = OT, NrOfLines = Adet
from sales.Invoices i
INNER JOIN
(
	select i.InvoiceID, SUM(UnitPrice*Quantity)OT, count(*)Adet 
	from Sales.Invoices i
	INNER JOIN Sales.InvoiceLines il ON i.InvoiceID = il.InvoiceID
	group by i.InvoiceID
)x ON i.InvoiceID = x.InvoiceID

select * from sales.Invoices

rollback
