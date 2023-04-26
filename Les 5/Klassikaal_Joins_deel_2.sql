-- OUTER JOIN met 2 tabellen
-- Geeft het resultaat met alle klanten, ongeacht deze een favoriete schotel hebben of niet.
SELECT FirstName, LastName, Name, Description
FROM party.Customers C
    LEFT OUTER JOIN party.Dishes d
    ON c.FavoriteDish = d.ID

-- het woord OUTER mag ook weggelaten worden
-- Geeft het resultaat met alle schotels (Name), ongeacht deze een klant hebben of niet.
SELECT FirstName, LastName, Name, Description
FROM party.Customers C
    RIGHT OUTER JOIN party.Dishes d
    ON c.FavoriteDish = d.ID

SELECT FirstName, LastName, Name, Description
FROM party.Customers C
    FULL OUTER JOIN party.Dishes d
    ON c.FavoriteDish = d.ID

-- OUTER JOIN met 3 tabellen

SELECT c.ID as 'Customer ID', LastName, FirstName, Name, Description
FROM party.Customers c
    FULL JOIN party.CustomersEvents ce
    ON c.ID = ce.CustomerID
    FULL JOIN party.Events e
    ON e.ID = ce.EventID
ORDER BY LastName, FirstName

-- SELF JOIN (JOIN binnen dezelfde tabel)

SELECT c2.FirstName, c2.LastName, c2.FavoriteDish
FROM party.Customers c1
    JOIN party.Customers c2
    ON c1.FavoriteDish = c2.FavoriteDish
WHERE c1.ID = 3
AND c2.ID != 3
