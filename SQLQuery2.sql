--select count(distinct StateProvinceID) from [Application].Cities
--order by LatestRecordedPopulation desc

--select CountryID, CountryName, FormalName, IsoAlpha3Code, IsoNumericCode, CountryType, LatestRecordedPopulation, Continent, Region, Subregion, Border
--from Application.Countries
--where LatestRecordedPopulation not between 100e6 and 500e6
--	AND Continent not in ( 'Asia', 'Europe')
--order by Continent, CountryName, LatestRecordedPopulation desc

select x.*, c.LatestRecordedPopulation as EyaletNüfusu,
ISNULL(HesaplananNüfus,0)-c.LatestRecordedPopulation as Fark
from (
	select a.StateProvinceID, b.[StateProvinceName], count(*)Adet, SUM(a.LatestRecordedPopulation)HesaplananNüfus
	from Application.Cities a
	INNER JOIN Application.StateProvinces b ON a.StateProvinceID = b.StateProvinceID
	group by a.StateProvinceID, b.[StateProvinceName]
)x
INNER JOIN Application.StateProvinces c ON c.StateProvinceID = x.StateProvinceID
order by Fark

--select * from Application.Cities  where StateProvinceID = 48

--ornek
select a.SupplierCategoryID, SupplierCategoryName, SupplierName from Purchasing.SupplierCategories a INNER JOIN Purchasing.Suppliers b ON b.SupplierCategoryID = a.SupplierCategoryID