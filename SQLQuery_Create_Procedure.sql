USE [WideWorldImporters]
GO
/****** Object:  StoredProcedure [dbo].[GetList1]    Script Date: 9.08.2023 14:52:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[GetList1]
@sql varchar(MAX) = 'select * from Sales.Invoices where InvoiceId = 50'
--@TableName varchar(100) = 'Sales.Invoices',
--@Cndt varchar(100) = 'InvoiceId = 50'
AS

--declare @sql varchar(MAX) = 'select * from '+@TableName+' where '+@Cndt
print @sql
exec(@sql)