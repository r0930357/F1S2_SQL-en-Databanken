SELECT LEFT(LastName, 1) AS 'Beginletter', COUNT(*) AS 'Aantal'
FROM party.Customers AS c
GROUP BY LEFT(LastName, 1)

SELECT d.Name AS 'Gerecht', COUNT(*) AS 'Aantal'
FROM party.Customers AS c
    JOIN party.Dishes AS d
    ON d.ID = c.FavoriteDish
WHERE FavoriteDish > 4
GROUP BY d.Name
HAVING COUNT(*) >= 6
ORDER BY 'Aantal' DESC

-- Toon achternaam en voornaam van alle klanten die 2 events hebben geörgainseerd.
-- Sorteer op achternaam.

SELECT CONCAT(c.LastName, SPACE(1), c.FirstName) AS 'Naam', COUNT(EventID) AS 'Event'
FROM party.Customers AS c
    JOIN party.CustomersEvents AS ce
    ON c.ID = ce.CustomerID
    JOIN party.Events AS e
    ON ce.EventID = e.ID
GROUP BY c.LastName, c.FirstName
HAVING COUNT(*) = 2
ORDER BY c.LastName