SELECT party.Customers.ID, LastName, FirstName, Name
FROM party.Customers
    INNER JOIN party.Dishes
    ON party.Customers.FavoriteDish = party.Dishes.ID

-- Vereenvouwdigde methode:
SELECT c.ID, LastName, FirstName, Name
FROM party.Customers AS c
    JOIN party.Dishes AS d
    ON c.FavoriteDish = d.ID

SELECT Date, PartySize, FirstName, LastName
FROM party.Customers
    JOIN party.Reservations
    ON party.Customers.ID = party.Reservations.CustomerID
ORDER BY party.Reservations.Date DESC, party.Customers.LastName

SELECT Name As 'Event', LastName As 'Famnaam'
FROM party.Customers c
    JOIN party.CustomersEvents ce
    ON c.ID = ce.CustomerID
    JOIN party.Events e
    ON e.ID = ce.EventID
where LastName Like '%t'
ORDER BY date

SELECT o.ID, OrderDate AS 'Datum', Name AS 'Gerecht'
FROM party.Orders o
    JOIN party.OrdersDishes od
    ON o.ID = od.OrderID
    JOIN party.Dishes d
    ON d.ID = od.DishID
WHERE o.ID IN (1, 3, 5)
ORDER BY OrderDate