SELECT *
FROM party.Dishes

SELECT id, Name, Type
FROM party.Dishes
WHERE type = 'Main'

SELECT id, Name, Type
FROM party.Dishes
WHERE Name LIKE 'C%'
    OR Name LIKE 'P%'

SELECT id, Name, Price
FROM party.Dishes
WHERE Price < 90
ORDER BY Price DESC, Name

SELECT *
FROM party.Customers
WHERE id IN (1,5,10,15)

SELECT id, FirstName, LastName, Birthday
FROM party.Customers
WHERE Birthday BETWEEN '1985-01-01' AND '1995-12-31'
ORDER BY Birthday

SELECT id, FirstName, LastName, Birthday
FROM party.Customers
WHERE id BETWEEN 10 AND 20

SELECT id, FirstName, LastName, Birthday
FROM party.Customers
WHERE LastName LIKE 'B%'

SELECT id, FirstName, LastName, Birthday
FROM party.Customers
WHERE LastName LIKE 'S%n'

SELECT id, FirstName, LastName, Birthday
FROM party.Customers
WHERE LastName LIKE '____'

SELECT Name, Price
FROM party.Dishes
WHERE Price IS NOT NULL
ORDER BY Price

SELECT DISTINCT Price
FROM party.Dishes
ORDER BY Price

SELECT Name As 'Naam', Price As 'Prijs',
    CASE 
        WHEN Price < 75 THEN 'Laag'
        WHEN Price < 90 THEN 'Gemiddeld'
        ELSE 'Hoog'
    END As 'Prijsindex'
FROM party.Dishes
WHERE Price IS NOT NULL
ORDER BY Price
