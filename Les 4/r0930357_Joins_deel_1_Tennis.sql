-- r0930357 - Tom Belmans

-- Oefening 1
SELECT t.id AS 'teamnr', naam, voornaam
FROM Tennis.Team AS t
JOIN Tennis.Speler AS s
ON s.ID = t.spelerId

-- Oefening 2
SELECT w.id AS 'wedstrijdnr', s.naam AS 'naam', s.voornaam AS 'voornaam', w.teamId AS 'teamId'
FROM Tennis.Wedstrijd AS w
JOIN Tennis.Speler AS s
ON s.id = w.spelerId
ORDER BY wedstrijdnr

-- Oefening 3
SELECT w.id AS 'wedstrijdnr', s.naam AS 'naam', s.voornaam AS 'voornaam', t.divisie AS 'divisie'
FROM Tennis.Wedstrijd AS w
JOIN Tennis.Speler AS s
ON s.id = w.spelerId
JOIN Tennis.Team AS t
ON w.teamId = t.id

-- Oefening 4
SELECT DISTINCT b.id as 'betalingsnr', s.naam as 'naam'
FROM Tennis.Speler as s
JOIN Tennis.Boete as b
ON s.id = b.spelerId
JOIN Tennis.Bestuurslid as bl
ON s.id = bl.spelerId
WHERE bl.functie = 'Penningmeester'