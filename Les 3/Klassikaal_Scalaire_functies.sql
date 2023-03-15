SELECT CONCAT_WS(' ', id, LastName, FirstName,) AS 'Naam'
FROM party.Customers

SELECT CONCAT_WS(' ', id, UPPER(LastName), FirstName,) AS 'Naam'
FROM party.Customers

SELECT CONCAT(id, LEFT(UPPER(LastName), 3), SUBSTRING(FirstName, 2, 2)) AS 'Code'
From party.Customers

SELECT LastName, CHARINDEX('a', LastName, CHARINDEX('a', LastName) + 1) AS 'Positie'
FROM party.Customers
WHERE CHARINDEX('a', LastName, CHARINDEX('a', LastName) + 1) != 0

SELECT LastName, REPLACE(LastName, 'a', '*')
FROM party.Customers
WHERE LastName LIKE '%a'

SELECT LastName, STUFF(LastName, 2, 4, '****') AS Code
FROM party.Customers
WHERE LEN(LAstName) >= 6

SELECT MIN(Price) AS Min,
       MAX(Price) AS Max,
       AVG(Price) AS Gemiddelde,
       SUM(Price) AS Som,
       COUNT(*) As Aantal
FROM party.Dishes

-- Datum en tijd opvragen van de server
SET DATEFIRST 1; -- 1e weekdag = maandag ipv zondag
SELECT GETDATE(),
       DAY(GETDATE()),
       MONTH(GETDATE()),
       DATENAME(wk ,GETDATE()),
       DATEPART(WEEKDAY ,GETDATE())

SELECT DATEDIFF(DAY, '1980-11-20', GETDATE()),
    DATEADD(DAY, 30, GETDATE()) -- Zet een dag in de toekomst -> handig voor facturatiedatum

SELECT CAST(id AS varchar(4)) + ' ' + LastName + ' ' + FirstName AS 'Naam'
FROM party.Customers

SELECT CONVERT(varchar(4)), id) + + ' ' + LastName + ' ' + FirstName AS 'Naam'
FROM party.Customers

-- Datumnotatie : dd/mm/yyyy
SELECT CONVERT(varchar, GETDATE(), 103)
-- Datumnotatie : yyyy.mm.dd
SELECT CONVERT(varchar, GETDATE(), 102)
-- Datumnotatie : mm.dd.yyyy
SELECT CONVERT(varchar, GETDATE(), 101)
-- Datumnotatie : mmm dd yyyy
SELECT CONVERT(varchar, GETDATE(), 100)

-- Vervang een NULL door 0 -> kan enkel binnen hetzelfde datatype (prijs = int, 0 = int)
SELECT Name, ISNULL(Price, 0)
FROM party.Dishes

-- Vervange prijs door een stringwaarde -> prijs omzetten naar string door CAST
SELECT Name, ISNULL(CAST(Price As varchar(14), 'prijs onbekend'))
FROM party.Dishes
