-- Oefening 1
SELECT id
FROM tennis.speler
WHERE lidSinds BETWEEN 2000 AND 2003
ORDER BY id;

-- Oefening 2
SELECT id
FROM tennis.boete
WHERE bedrag BETWEEN 50 AND 100;

-- Oefening 3
SELECT id
FROM tennis.boete
WHERE NOT (bedrag BETWEEN 50 AND 100);

-- Oefening 4
SELECT id
FROM tennis.speler
WHERE plaats NOT IN ('Den Haag', 'Voorburg');

SELECT id
FROM tennis.speler
WHERE NOT (plaats = 'Den Haag')
  AND NOT (plaats = 'Voorburg');

SELECT id
FROM tennis.speler
WHERE plaats <> 'Den Haag'
  AND plaats <> 'Voorburg';

-- Oefening 5
SELECT id, naam
FROM tennis.speler
WHERE naam LIKE '%en%';

-- Oefening 6
SELECT naam, id
FROM tennis.speler
WHERE naam LIKE '%a_'
ORDER BY naam;

-- Oefening 7
SELECT id, naam, voornaam
FROM tennis.speler
WHERE naam LIKE '_e%e_';

-- Oefening 8 - v1
SELECT id,
       bedrag,
       CASE
           WHEN bedrag <= 40 THEN 'laag'
           WHEN bedrag BETWEEN 41 AND 80 THEN 'middelmatig'
           ELSE 'hoog' END AS categorie
FROM tennis.boete;

-- Oefening 8 - v2
SELECT id,
       bedrag,
       CASE
           WHEN bedrag >= 0 AND bedrag <= 40 THEN 'laag'
           WHEN bedrag >= 41 AND bedrag <= 80 THEN 'middelmatig'
           WHEN bedrag >= 81 THEN 'hoog'
           ELSE 'fout'
           END AS categorie
FROM tennis.boete;

-- Oefening 9
SELECT id,
       CASE
           WHEN divisie = 'ere' THEN 'eredivisie'
           ELSE 'tweede divisie'
           END AS divisie
FROM tennis.team;

SELECT id,
       CASE divisie
           WHEN 'ere' THEN 'eredivisie'
           WHEN 'tweede' THEN 'tweede divisie'
           ELSE 'onbekend'
           END AS divisie
FROM Tennis.Team;

-- Oefening 10
SELECT DISTINCT spelerId
FROM tennis.boete
ORDER BY spelerId;

-- Oefening 11
SELECT DISTINCT lidSinds
FROM tennis.speler
WHERE lidSinds>=2000
ORDER BY lidSinds;

-- Oefening 12
SELECT distinct spelerId
FROM tennis.bestuurslid
WHERE functie='Penningmeester'
ORDER BY spelerId;

