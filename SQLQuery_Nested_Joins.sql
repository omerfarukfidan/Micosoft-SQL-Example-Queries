SELECT sp.StateProvinceID,
       sp.StateProvinceName,
	   c.LatestRecordedPopulation,
       c.CityName AS MostPopularCity
FROM Application.StateProvinces sp
JOIN (
    select StateProvinceID, MAX(LatestRecordedPopulation) AS MaxPopulation
	from Application.Cities 
	Group by StateProvinceID
	) as maxCities  
	on sp.StateProvinceID = maxCities.StateProvinceID
	Join Application.Cities c on maxCities.StateProvinceID = c.StateProvinceID AND maxCities.MaxPopulation = c.LatestRecordedPopulation; 
	
	
	/*(SELECT TOP 1 CityName
        FROM Application.Cities c
        WHERE c.StateProvinceID = sp.StateProvinceID
        ORDER BY Population DESC) AS MostPopulousCity
FROM Application.StateProvinces sp;*/

/*SELECT sp.StateProvinceID,
       sp.StateProvinceName,
	   c.LatestRecordedPopulation,
       c.CityName AS MostPopulousCity
	   
FROM Application.StateProvinces sp
JOIN (
    SELECT StateProvinceID, MAX(LatestRecordedPopulation) AS MaxPopulation
    FROM Application.Cities
    GROUP BY StateProvinceID
) AS maxCities ON sp.StateProvinceID = maxCities.StateProvinceID
JOIN Application.Cities c ON maxCities.StateProvinceID = c.StateProvinceID AND maxCities.MaxPopulation = c.LatestRecordedPopulation;*/

