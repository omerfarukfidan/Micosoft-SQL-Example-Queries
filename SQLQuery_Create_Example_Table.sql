drop table #tbl
create table #tbl (ProductId int, OrderDate datetime, Quantity int)

declare @i int = 0, @ProductId int, @od datetime, @Quantity int
while @i<20000
begin
	select @ProductId = RAND()*10+1,
		@od = DATEADD(MINUTE, RAND()*400000, '2023-01-01'),
		@Quantity = RAND()*10+2,
		@i = @i + 1

	insert into #tbl values(@ProductId, @od, @Quantity)
    
end


/*
select * from #tbl
order by 2
*/

/*select ProductId, SUM(Quantity)ToplamAdet
from #tbl
group by ProductId
order by 1
*/

--select case when 21=1 then 'OK' else 'x' end
--select case 21 when 1 then 'OK' when 2 then 'iki' when 3 then 'üç' end



/*select ProductId, 
	SUM(case when DATEPART(MONTH,OrderDate) = 01 then Quantity end)Qty01,
	SUM(case when DATEPART(MONTH,OrderDate) = 02 then Quantity end)Qty02,
	SUM(case when DATEPART(MONTH,OrderDate) = 03 then Quantity end)Qty03,
	SUM(case when DATEPART(MONTH,OrderDate) = 04 then Quantity end)Qty04,
	SUM(case when DATEPART(MONTH,OrderDate) = 05 then Quantity end)Qty05,
	SUM(case when DATEPART(MONTH,OrderDate) = 06 then Quantity end)Qty06,
	SUM(case when DATEPART(MONTH,OrderDate) = 07 then Quantity end)Qty07,
	SUM(case when DATEPART(MONTH,OrderDate) = 08 then Quantity end)Qty08,
	SUM(case when DATEPART(MONTH,OrderDate) = 09 then Quantity end)Qty09,
	SUM(case when DATEPART(MONTH,OrderDate) = 10 then Quantity end)Qty10,
	SUM(case when DATEPART(MONTH,OrderDate) = 11 then Quantity end)Qty11,
	SUM(case when DATEPART(MONTH,OrderDate) = 12 then Quantity end)Qty12
from #tbl
group by ProductId  
order by 1
*/

/*select DATEPART(MONTH,OrderDate), SUM(Quantity)
from #tbl
where ProductId = 3
group by DATEPART(MONTH,OrderDate)
order by 1  */


select case 
	when ProductId in (1,2,9,10) then 'A' 
	when ProductId in (3) then 'B' 
	else 'C' 
	end GrupNo,
SUM(case when DATEPART(QUARTER,OrderDate) = 1 then Quantity end) AS Q1,
SUM(case when DATEPART(QUARTER,OrderDate) = 2 then Quantity end) AS Q2,
SUM(case when DATEPART(QUARTER,OrderDate) = 3 then Quantity end) AS Q3,
SUM(case when DATEPART(QUARTER,OrderDate) = 4 then Quantity end) AS Q4,
SUM(Quantity)Toplam,
COUNT(*)ToplamSipariþAdedi
from #tbl
group by case 
	when ProductId in (1,2,9,10) then 'A' 
	when ProductId in (3) then 'B' 
	else 'C' 
	end
order by 1






