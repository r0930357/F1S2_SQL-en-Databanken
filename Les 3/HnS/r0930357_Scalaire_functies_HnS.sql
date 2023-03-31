-- Oefening 1 -> HnS_Extra_records.sql uitvoeren

-- Oefening 2

SELECT naam AS 'onbewerkt',
        CONCAT(SUBSTRING(naam, 1, 1), SUBSTRING((LOWER(naam)), 2, 100)) AS 'bewerkt'
FROM HnS.Product

-- Oefening 3

SELECT id, CONCAT(TRIM(voornaam), ' ', TRIM(familienaam)) AS 'Klantnaam'
FROM HnS.Klant
WHERE gsm IS NULL
ORDER BY familienaam

-- Oefening 4

SELECT naam, ROUND(inkoopprijs, 0), ROUND(verkoopprijs, 0)
FROM HnS.Product
WHERE categorieId = 6
ORDER BY inkoopprijs, verkoopprijs

-- Oefening 5
SELECT orderdatum AS 'Orderdatum', (ISNULL(CONVERT(varchar,leveringsdatum,103), 'nog geen leveringsdatum')) AS 'Leveringsdatum'
FROM HnS.[Order]

-- Oefening 6
SELECT id AS 'Ordernummer', CONVERT(varchar,leveringsdatum,103)
FROM HnS.[Order]
WHERE leveringsdatum IS NOT NULL
ORDER BY Leveringsdatum

-- Oefening 7
SELECT id as 'Ordernummer', CONVERT(varchar, orderdatum, 103) AS 'Orderdatum', CONVERT(varchar, DATEADD(DAY, 14, orderdatum), 103) 'Vermoedelijke leveringsdatum'
FROM HnS.[Order]
WHERE leveringsdatum IS NULL


-- Oefening 8
SELECT 'Product ' + (UPPER(TRIM(naam)) + '(productnummer = ' + CONVERT(varchar, id, 1) + ') ' + 'heeft een inkoopprijs van ' + CONVERT(varchar, inkoopprijs) + N'€ en een verkoopprijs van ' + CONVERT(varchar, verkoopprijs) + N' €') as 'Product'
FROM HnS.Product
ORDER BY inCatalogus DESC

-- Oefening 9
SELECT naam AS 'Productnaam'
FROM Hns.Product
WHERE DATENAME(WEEKDAY, inCatalogus) = 'Thursday'
ORDER BY TRIM(naam) DESC

-- Oefening 10
SELECT TRIM(naam) AS 'Productnaam', CONCAT(inkoopprijs, ' €') AS 'Inkoopprijs (€)', CONCAT(verkoopprijs, ' €') AS 'Verkoopprijs (€)', eenhedenInVoorraad AS 'Eenheden in voorraad'
FROM Hns.Product
WHERE eenhedenInVoorraad IN(3, 10)
ORDER BY inkoopprijs DESC, TRIM(naam) DESC

-- Oefening 11
SELECT TRIM(naam) AS 'Productnaam', inkoopprijs AS 'Inkoopprijs', verkoopprijs AS 'Verkoopprijs (€)', NULLIF(verkoopprijs - inkoopprijs, 249.35) AS 'Verschil van 249,35 € ?'
FROM HnS.Product
WHERE inkoopprijs BETWEEN 750 AND 2000
ORDER BY verkoopprijs - inkoopprijs;

-- Oefening 12
SELECT id AS 'Klantnummer', REPLACE(telefoon, SPACE(1), SPACE(0)) As 'Telefoon'
FROM HnS.Klant
WHERE telefoon IS NOT NULL

-- Oefening 13
SELECT email AS 'Email', TRIM(LOWER(gemeente)) As 'Gemeente', CONCAT(voornaam, ' ', familienaam) AS 'Volledige Naam'
FROM HnS.Klant

UPDATE Hns.Klant
SET email = LOWER(REPLACE(voornaam, SPACE(1), SPACE(0))) + '.' +LOWER(REPLACE(familienaam, SPACE(1), SPACE(0))) + '@hns.be', volledigeNaam = CONCAT_WS(SPACE(1), TRIM(voornaam), TRIM(familienaam))
WHERE email IS NULL AND LOWER(gemeente) = 'geel';

SELECT email AS 'Email', TRIM(gemeente) AS 'Gemeente', volledigeNaam AS 'Volledige Naam'
FROM HnS.Klant
WHERE LOWER(gemeente) = 'geel';