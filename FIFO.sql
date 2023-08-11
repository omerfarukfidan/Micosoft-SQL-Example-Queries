declare @i int = 1, @Quantity int, @CQuantity int, @t int = 0, @PartiNo int = 0, @runningtotal int = 0, @Kalan int = 0

drop table #log
create table #log (idx int IDENTITY(1,1), Tarih datetime, Tip varchar(1), PartiNo int, Quantity int, Kalan int, FromParties varchar(500))


set nocount on
while @i<=1000
begin
set @Quantity = floor(rand()*100)
set @t = @t + @Quantity

if @Quantity % 2 = 0 OR @Quantity % 2 = 1 AND @runningtotal < @Quantity 
begin

	set @PartiNo = @PartiNo + 1
	insert into #log (Tarih, tip, PartiNo, Quantity)
		values (DATEADD(HOUR, @t, '2022-01-01'),
		'P',
		@PartiNo,
		@Quantity)

	set @runningtotal = @runningtotal + @Quantity
end
else
begin
insert into #log (Tarih, tip, Quantity)
	values (DATEADD(HOUR, @t, '2022-01-01'),
	'C',
	@Quantity)

	set @runningtotal = @runningtotal - @Quantity
end
set @i = @i +1
end

update #log set Kalan = Quantity where PartiNo > 0

set @i = 1
while @i<=1000
begin

	select @PartiNo = PartiNo, @CQuantity = Quantity
	from #log
	where idx = @i

	if @PartiNo is null
	begin
		while exists(select 1 from #log where Kalan > 0 AND idx between 1 and @i) AND @CQuantity > 0
		begin
			--set @Quantity = 0
			select @PartiNo = MIN(PartiNo) from #log where Kalan > 0 AND idx between 1 and @i	--MAX LIFO, MIN FIFO için!
			select @Kalan = Kalan from #log where PartiNo = @PartiNo
			
			if(@Kalan > @CQuantity)
			begin
				update #log set Kalan = Kalan - @CQuantity where PartiNo = @PartiNo
				update #log set FromParties = ISNULL(FromParties,'')+CONVERT(varchar, @PartiNo)+'->'+CONVERT(varchar, @CQuantity)+'  ' where idx = @i
				set @CQuantity = 0
			end
			else
			begin
				update #log set Kalan = 0 where PartiNo = @PartiNo
				update #log set FromParties = ISNULL(FromParties,'')+CONVERT(varchar, @PartiNo)+'->'+CONVERT(varchar, @Kalan)+'  ' where idx = @i
				set @CQuantity = @CQuantity - @Kalan
			end
			


		end
	end


	set @i = @i + 1

end
select * from #log

--select * from #x2