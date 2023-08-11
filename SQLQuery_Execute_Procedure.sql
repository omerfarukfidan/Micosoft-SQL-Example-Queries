exec GetList1 50

declare @sql varchar(MAX) = 'select * from Sales.Invoices'
--select @sql
exec(@sql)




