
select * from #log order by tarih 
select * from #log where Tip='P' order by tarih 
select * from #log where Tip='C' order by tarih 


-- select MIN(Tarih) from #log WHERE Quantity <> 0 --Sipariş sayısı 0 olmayan ilk tarihi bulan komut

--fifo
declare @i int = 1, @partNo int, @transfer int, @siparisAdedi int, @geciciTarih date, @iterator int = 1, @tipi char, @eldekiUrunAdedi int = 0, @geciciUrunAdedi int = 0, @quantity int, @kalan int = 0, @fromParties varchar(500), @new_idx int, @geciciSiparisAdedi int = 0, @eksikSiparisAdedi int = 0

--select @siparisAdedi = count(*) from #log where Tip='C' --Customerden gelen siparişlerin adedini  @siparisAdedi değişkenine atayan komut

--create table #temp_log (new_idx int IDENTITY(1,1), geciciTarih datetime, tipi varchar(1), partNo int, quantity int, kalan int, fromParties varchar(500))

--idx e göre döncem tipine bak sonra sonra adede bak karşılıyor mu karşılamıyor mu 
while @i <= 1000
begin
	
	select @partNo = PartiNO, @iterator = idx,  @tipi = Tip from #log where idx = @i
	if  @tipi = 'P'
		begin
		select @geciciUrunAdedi = Kalan from #log where idx = @i
		set @eldekiUrunAdedi = @eldekiUrunAdedi + @geciciUrunAdedi
		if @siparisAdedi >  @eldekiUrunAdedi
				begin 
				 set @geciciSiparisAd
				 edi = @siparisAdedi
				 update #log set Kalan = 0 where idx = @i
				 set @eksikSiparisAdedi = @eldekiUrunAdedi - @geciciSiparisAdedi
				end	
	

		end 
	else if @tipi = 'C'
		begin
			select @siparisAdedi = Quantity from #log where idx = @i
			if @siparisAdedi >  @eldekiUrunAdedi
				begin 
				 set @geciciSiparisAdedi = @siparisAdedi
				end
			else if @siparisAdedi <= @eldekiUrunAdedi
				begin
				update #log set Kalan = @eldekiUrunAdedi where idx = @i
				end
		end
		

/*
	select @geciciTarih = MIN(Tarih) from #log WHERE Quantity <> 0
	update #log   set Kalan = (/*Tipi P olanlardan gelecek*/) AND set Quantity = 0  WHERE Tarih = @geciciTarih
*/

	set @i = @i +1
end

