


 CREATE PROC GetFark
 AS

 select si.StockItemID, si.StockItemName, GirenMiktar, ��kanMiktar, GirenMiktar-��kanMiktar Fark, QuantityOnHand 
 from [Warehouse].[StockItems] si
 LEFT JOIN (select StockItemID, SUM(ReceivedOuters)GirenMiktar from [Purchasing].[PurchaseOrderLines] group by StockItemID)g ON g.StockItemID = si.StockItemID
 LEFT JOIN (select StockItemID, SUM(PickedQuantity)��kanMiktar from [Sales].[OrderLines] group by StockItemID)� ON �.StockItemID = si.StockItemID
 LEFT JOIN [Warehouse].[StockItemHoldings] sih ON sih.StockItemID = si.StockItemID
 




