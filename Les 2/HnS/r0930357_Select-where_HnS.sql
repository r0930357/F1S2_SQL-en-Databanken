-- r0930357 - Tom Belmans

-- Oefening 1
SELECT naam AS 'Productnaam'
FROM HnS.Product
WHERE naam LIKE 'HP%'

-- Oefening 2
SELECT naam
FROM HnS.Categorie
WHERE naam LIKE '%en'

-- Oefening 3
SELECT naam, verkoopprijs
FROM HnS.Product
WHERE verkoopprijs BETWEEN 80 AND 100
ORDER BY verkoopprijs

-- Oefening 4
SELECT id as 'Klantnummer', CONCAT(familienaam, ' ', voornaam) as 'Klantnaam', email 
FROM HnS.Klant
WHERE email NOT LIKE '%@hs.be' OR email IS NULL
ORDER BY familienaam, voornaam

-- Oefening 5
SELECT DISTINCT gemeente
FROM HnS.Klant
ORDER BY gemeente

-- Oefening 6
SELECT productId AS Productnummer
FROM HnS.Orderlijn
WHERE hoeveelheid BETWEEN 1 AND 2
ORDER BY productId

-- Oefening 7
SELECT id, familienaam AS 'Familienaam van de klant', voornaam AS 'Voornaam van de klant'
FROM HnS.Klant
WHERE familienaam LIKE '% %'
ORDER BY familienaam, voornaam, id DESC

-- Oefening 8
SELECT id AS 'Productnummer', naam AS 'Productnaam',
       CASE
           WHEN eenhedenInVoorraad + eenhedenInBestelling <= bestellingsniveau
               THEN 'Bestellen'
           ELSE 'Niet bestellen'
           END AS 'Bestellen of niet?'
FROM HnS.Product
WHERE categorieId = 1
ORDER BY id

-- Oefening 9
SELECT DISTINCT productId AS 'Productnummer',  korting AS 'Korting %'
FROM Hns.Orderlijn
WHERE korting BETWEEN 5 AND 10
ORDER BY productId

-- Oefening 10
SELECT naam AS 'Productnaam', inkoopprijs AS 'Inkoopprijs'
FROM HnS.Product
WHERE inkoopprijs IN(80, 100)

-- Oefening 11
SELECT naam AS 'Productnaam', inkoopprijs AS 'Inkoopprijs', verkoopprijs AS 'Verkoopprijs',
CASE
WHEN (verkoopprijs - inkoopprijs) / verkoopprijs <= 0.1 THEN '10% of Minder'
WHEN (verkoopprijs - inkoopprijs) / verkoopprijs <= 0.15 THEN '15% of Minder'
WHEN (verkoopprijs - inkoopprijs) / verkoopprijs <= 0.2 THEN '20% of Minder'
ELSE 'Meer dan 20%'
END AS 'Winst'
FROM HnS.Product
WHERE stopgezet = 0 AND categorieId = 1
ORDER BY Winst

-- Oefening 12
SELECT id AS 'Productnummer', naam AS 'Productnaam', (eenhedenInVoorraad + eenhedenInBestelling) * inkoopprijs AS 'Totale inkoopprijs'
FROM HnS.Product
WHERE stopgezet = -1 AND (eenhedenInVoorraad + eenhedenInBestelling) * inkoopprijs > 0
ORDER BY id DESC