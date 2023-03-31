-- Oefening 2 - V1
SELECT naam                                 AS 'Product (onbewerkt)',
       UPPER(SUBSTRING(naam, 1, 1)) +
       LOWER(SUBSTRING(naam, 2, LEN(naam))) AS 'Product (bewerkt)'
FROM HnS.Product;

-- Oefening 2 - V2
SELECT naam  AS 'Product (onbewerkt)',
       CONCAT(UPPER(LEFT(naam, 1)),
              LOWER(RIGHT(naam, LEN(naam) - 1))
           ) AS 'Product (bewerkt)'
FROM HnS.Product;

-- Oefening 2 - V3
SELECT naam  AS 'Product (onbewerkt)',
       CONCAT_WS(SPACE(0),
                 UPPER(SUBSTRING(naam, 1, 1)),
                 LOWER(SUBSTRING(naam, 2, LEN(naam)))
           ) AS 'Product (bewerkt)'
FROM HnS.Product;

-- Oefening 3 - V1
SELECT id,
       TRIM(familienaam) + SPACE(1) + TRIM(voornaam) AS 'Klantnaam'
FROM HnS.Klant
WHERE gsm IS NULL
ORDER BY 'Klantnaam';

-- Oefening 3 - V2
SELECT id,
       CONCAT(TRIM(familienaam), SPACE(1), TRIM(voornaam)) AS 'Klantnaam'
FROM HnS.Klant
WHERE gsm IS NULL
ORDER BY TRIM(familienaam),
         TRIM(voornaam);

-- Oefening 3 - V3
SELECT id,
       CONCAT_WS(SPACE(1), TRIM(familienaam), TRIM(voornaam)) AS 'Klantnaam'
FROM HnS.Klant
WHERE gsm IS NULL
ORDER BY CONCAT_WS(SPACE(1), TRIM(familienaam), TRIM(voornaam));

-- Oefening 4 - V1
SELECT naam                       AS 'Productnaam',
       CONVERT(int, inkoopprijs)  AS 'Inkoopprijs',
       CONVERT(int, verkoopprijs) AS 'Verkoopprijs'
FROM HnS.Product
WHERE categorieId = 6
ORDER BY inkoopprijs,
         verkoopprijs;

-- Oefening 4 - V2
SELECT naam                      AS 'Productnaam',
       CAST(inkoopprijs AS int)  AS 'Inkoopprijs',
       CAST(verkoopprijs AS int) AS 'Verkoopprijs'
FROM HnS.Product
WHERE categorieId = 6
ORDER BY inkoopprijs,
         verkoopprijs;

-- Oefening 5
SELECT id,
       CONVERT(varchar, orderdatum, 103) AS 'Orderdatum',
       ISNULL(
               CONVERT(varchar, leveringsdatum, 103),
               'nog geen leveringsdatum'
           )                             AS 'Leveringsdatum'
FROM HnS.[Order]
ORDER BY HnS.[Order].orderdatum;

-- Oefening 6
SELECT id                                    AS 'Ordernummer',
       CONVERT(varchar, leveringsdatum, 103) AS 'Leveringsdatum'
FROM HnS.[Order]
WHERE leveringsdatum IS NOT NULL;

-- Oefening 7
SELECT id                                                  AS 'Ordernummer',
       CONVERT(varchar, orderdatum, 103)                   AS 'Orderdatum',
       CONVERT(varchar, DATEADD(DAY, 14, orderdatum), 103) AS 'Vermoedelijke leveringsdatum'
FROM HnS.[Order]
WHERE leveringsdatum IS NULL;

-- Oefening 8 -- V1
SELECT 'Product ' +
       UPPER(TRIM(naam)) + ' (productnummer = ' + CONVERT(varchar, id, 1) + ') ' +
       ' heeft een inkoopprijs van ' + CONVERT(varchar, inkoopprijs) +
       N' € en verkoopprijs van ' + CONVERT(varchar, verkoopprijs) +
       N' €' AS Product
FROM HnS.Product
ORDER BY inCatalogus DESC;

-- Oefening 8 -- V2
SELECT CONCAT('Product ',
              UPPER(TRIM(naam)), ' (productnummer = ', id, ') ',
              ' heeft een inkoopprijs van ',
              inkoopprijs,
              N' € en verkoopprijs van ',
              verkoopprijs,
              N' €'
           ) AS Product
FROM HnS.Product
ORDER BY inCatalogus DESC;

-- Oefening 8 -- V3
SELECT CONCAT_WS(SPACE(1),
                 'Product',
                 UPPER(TRIM(naam)),
                 '(productnummer =', id, ')',
                 'heeft een inkoopprijs van',
                 inkoopprijs,
                 N'€ en verkoopprijs van',
                 verkoopprijs,
                 N'€'
           ) AS Product
FROM HnS.Product
ORDER BY inCatalogus DESC;

-- Oefening 9 - V1
SELECT TRIM(naam) AS 'productnaam'
FROM HnS.Product
WHERE DATENAME(WEEKDAY, inCatalogus) = 'Thursday'
ORDER BY TRIM(naam) DESC;

-- Oefening 9 - V2
SELECT TRIM(naam) AS 'productnaam'
FROM HnS.Product
WHERE DATEPART(WEEKDAY, inCatalogus) = 5
ORDER BY TRIM(naam) DESC;

-- Oefening 10
SELECT TRIM(naam)                  AS 'Productnaam',
       CONCAT(inkoopprijs, N' €')  AS 'Inkoopprijs (€)',
       CONCAT(verkoopprijs, N' €') AS 'Verkoopprijs (€)',
       eenhedenInVoorraad          AS 'Eenheden in voorraad'
FROM HnS.Product
WHERE eenhedenInVoorraad IN (3, 10)
ORDER BY inkoopprijs DESC,
         TRIM(naam) DESC;

-- Oefening 11
SELECT TRIM(naam)                                 AS 'Productnaam',
       inkoopprijs                                AS 'Inkoopprijs',
       verkoopprijs                               AS 'Verkoopprijs',
       NULLIF(verkoopprijs - inkoopprijs, 249.35) AS 'Verschil van 249,35 € ?'
FROM HnS.Product
WHERE inkoopprijs BETWEEN 750 AND 2000
ORDER BY verkoopprijs - inkoopprijs;

-- Oefening 12
SELECT id                                    AS Klantnummer,
       REPLACE(telefoon, SPACE(1), SPACE(0)) AS Telefoon
FROM HnS.Klant
WHERE telefoon IS NOT NULL;

-- Oefening 13

-- Deel 1
SELECT email                                                  AS Email,
       TRIM(gemeente)                                         AS Gemeente,
       CONCAT_WS(SPACE(1), TRIM(voornaam), TRIM(familienaam)) AS Naam
FROM HnS.Klant
WHERE email IS NULL
  AND LOWER(gemeente) = 'geel';

-- Deel 2
UPDATE HnS.Klant
SET email         = LOWER(REPLACE(voornaam, SPACE(1), SPACE(0))) + '.' +
                    LOWER(REPLACE(familienaam, SPACE(1), SPACE(0))) + '@hns.be',
    volledigeNaam = CONCAT_WS(SPACE(1), TRIM(voornaam), TRIM(familienaam))
WHERE email IS NULL
  AND LOWER(gemeente) = 'geel';

-- Deel 3
SELECT email          AS Email,
       TRIM(gemeente) AS Gemeente,
       volledigeNaam  AS 'Volledige Naam'
FROM HnS.Klant
WHERE LOWER(gemeente) = 'geel';

