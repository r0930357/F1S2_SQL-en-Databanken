SELECT COUNT(*)
FROM party.Customers

SELECT MIN(PartySize) AS 'Min', MAX(PartySize) AS 'Max', AVG(PartySize) AS 'Gemiddelde', SUM(PartySize) AS 'Totaal'
FROM party.Reservations

SELECT SUM(PartySize) AS 'Totaal'
FROM party.Reservations
WHERE CustomerID = (SELECT ID
FROM party.Customers
WHERE FirstName = 'Amby' AND LastName = 'Harber')

-- Toon de favoriete schotels van alle klanten waarvan de familinaam beting met de letter "D"
-- Mogelijkheid 1: met een subquerry
SELECT Name, [Description]
FROM party.Dishes
WHERE ID IN (
    SELECT ID
    FROM party.Customers
    WHERE LastName LIKE 'D%'
)

-- Mogelijkheid 2: Met een join

SELECT Name, [Description]
FROM party.Customers AS c
    JOIN party.Dishes AS d
    ON d.ID = c.FavoriteDish
WHERE LastName LIKE 'T%'

-- Toon alle schotels die de klant 'Amby Harber' ooit heeft besteld
-- Mogelijkheid 1: met een subquerry

SELECT Name, [Description], Price
FROM party.Dishes
WHERE ID IN (
    SELECT DishID
    FROM party.OrdersDishes
    WHERE OrderID IN (
        SELECT ID
        FROM party.Orders
        WHERE CustomerID IN (
            SELECT ID
            FROM party.Customers
            WHERE FirstName = 'Amby'
            AND LastName = 'Harber'
        )
    )
)
ORDER BY Name

-- Mogelijkheid 2: Met een join

SELECT DISTINCT d.Name, d.[Description], d.Price
FROM party.Customers AS c
    JOIN party.Orders as o
    ON c.ID = o.CustomerID
    JOIN party.OrdersDishes od
    ON o.ID = od.OrderID
    JOIN party.Dishes as d
    ON od.DishID = d.ID
WHERE c.FirstName = 'Amby' AND c.LastName = 'Harber'
ORDER BY Name