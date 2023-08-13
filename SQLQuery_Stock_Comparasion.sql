


 CREATE PROC GetFark
 AS

 select si.StockItemID, si.StockItemName, GirenMiktar, ÇýkanMiktar, GirenMiktar-ÇýkanMiktar Fark, QuantityOnHand 
 from [Warehouse].[StockItems] si
 LEFT JOIN (select StockItemID, SUM(ReceivedOuters)GirenMiktar from [Purchasing].[PurchaseOrderLines] group by StockItemID)g ON g.StockItemID = si.StockItemID
 LEFT JOIN (select StockItemID, SUM(PickedQuantity)ÇýkanMiktar from [Sales].[OrderLines] group by StockItemID)ç ON ç.StockItemID = si.StockItemID
 LEFT JOIN [Warehouse].[StockItemHoldings] sih ON sih.StockItemID = si.StockItemID
 




