USE [WideWorldImporters]
GO
/****** Object:  StoredProcedure [dbo].[EnKalabalıkŞehirler]    Script Date: 11.08.2023 16:39:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROC [dbo].[EnKalabalıkŞehirler]
@StartsWith varchar(1)= '0'
AS

select RN, StateProvinceID, StateProvinceName, CityID, CityName, LatestRecordedPopulation
from (
	select ROW_NUMBER() OVER(PARTITION BY s.StateProvinceID ORDER BY c.[LatestRecordedPopulation] desc)RN,
		s.StateProvinceID, s.StateProvinceName, c.CityID, c.CityName, c.LatestRecordedPopulation
	from [Application].[Cities] c
	INNER JOIN [Application].[StateProvinces] s ON s.StateProvinceID = c.StateProvinceID
)x
where RN = 1 AND (StateProvinceName like @StartsWith+'%' OR @StartsWith = '0')