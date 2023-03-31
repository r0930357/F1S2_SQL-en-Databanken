-- r0930357 - Tom Belmans

-- Oefening 1
SELECT UPPER(naam)
FROM Tennis.Speler
ORDER BY naam

-- Oefening 2
SELECT naam, LEN(naam) As 'Karakters'
FROM Tennis.Speler

-- Oefening 3
SELECT LOWER(voornaam) + '. ' + UPPER(naam) AS 'naam', bondsnummer
FROM Tennis.Speler
WHERE plaats = 'Den Haag'

-- Oefening 4
SELECT id, LEFT(UPPER(voornaam), 1) + '. ' + naam AS 'naam'
FROM Tennis.Speler
WHERE naam LIKE 'B%'

-- Oefening 5
SELECT Id
FROM Tennis.Boete
WHERE YEAR(datum) = 2000

-- Oefening 6
SELECT id, YEAR(datum) as 'jaar'
FROM Tennis.Boete
WHERE YEAR(datum) > 2000

-- Oefening 7
SELECT voornaam + ' ' + naam AS 'naam', ISNULL(bondsnummer, 'geen') AS 'bondsnr'
FROM Tennis.Speler
WHERE plaats = 'Den Haag'

-- Oefening 8
SELECT id, geboortedatum, DATENAME(WEEKDAY, geboortedatum) As 'weekdag', DATENAME(MONTH, geboortedatum) AS 'maand'
FROM Tennis.Speler
WHERE id < 10

-- Oefening 9
SELECT 'Speler ' + naam + ' is geboren op ' + CONVERT(varchar, geboortedatum, 103) +  ' woont in ' + UPPER(plaats) + ' en heeft als bondsnr ' + bondsnummer AS 'Wedstrijdspeler'
FROM Tennis.Speler

-- Oefening 10

SELECT 'Speler ' + CONVERT(varchar, spelerId) + ' heeft de volgende boete gehad: ' + CONVERT(varchar,bedrag) AS 'speler met boetes'
FROM Tennis.Boete

-- Oefening 11
SELECT id, spelerId, DATEADD(MONTH, 3, datum) AS 'bestuursdag' 
FROM Tennis.Boete