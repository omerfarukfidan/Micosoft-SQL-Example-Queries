ALTER VIEW V_Invoices
AS

select c.CustomerName, i.*
from sales.Invoices i
INNER JOIN sales.Customers c ON c.CustomerID = i.CustomerID

-- SELECT * from V_Invoices --exec view