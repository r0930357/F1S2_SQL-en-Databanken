-- Les 3: Tennis
-- Oefening 1
SELECT id
FROM Tennis.Speler
WHERE lidSinds BETWEEN 2000 AND 2003

-- Oefening 2
SELECT id
FROM Tennis.Boete
WHERE bedrag BETWEEN 50 AND 100

-- Oefening 3
SELECT id
FROM Tennis.Boete
WHERE bedrag NOT BETWEEN 50 AND 100

-- Oefening 4
SELECT id
FROM Tennis.Speler
WHERE plaats <> 'Den Haag' AND plaats <> 'Voorburg'

-- Oefening 5
SELECT id, naam
FROM Tennis.Speler
WHERE naam LIKE '%en%'

-- Oefening 6
SELECT naam, id
FROM Tennis.Speler
WHERE naam LIKE '%a_'

-- Oefening 7
SELECT id, voornaam, naam
FROM Tennis.Speler
WHERE naam LIKE '_e%'
AND naam LIKE '%e_'

-- Oefening 8
SELECT id, bedrag,
    CASE
        WHEN bedrag < 40 THEN 'Laag'
        WHEN bedrag < 80 THEN 'Middelmatig'
        ELSE 'Hoog'
    END AS 'Categorie'
FROM Tennis.Boete

-- Oefening 9
SELECT id,
    CASE
        WHEN divisie = 'ere' THEN 'eredivisie'
        WHEN divisie = 'tweede' THEN 'tweede divisie'
    END AS 'divisie'
FROM Tennis.Team

-- Oefening 10
SELECT DISTINCT spelerid
FROM Tennis.Boete
WHERE bedrag IS NOT NULL

-- Oefening 11
SELECT DISTINCT lidSinds
FROM Tennis.Speler
WHERE lidSinds >= 2000

-- Oefening 12
SELECT DISTINCT spelerid
FROM Tennis.Bestuurslid
WHERE functie = 'Penningmeester'