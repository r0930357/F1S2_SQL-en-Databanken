-- Tom Belmans, r0930357

-- Les 3: SELECT/WHERE
-- * Vraag 1: Geef de voor- en familienaam van alle gebruikers waar de familienaam begint met de letter "B" of eindigt met de letter “s”.

SELECT voornaam AS 'Voornaam', familienaam AS 'Familienaam'
FROM project.Gebruiker
WHERE familienaam LIKE 'B%' OR familienaam LIKE '%s';

-- * Vraag 2: Geef de naam en postcode van de gemeenten op van alle geregistreerde gebruikers in België, sorteer deze op postcode.

SELECT DISTINCT gemeente AS 'Gemeente', postcode AS 'Postcode'
FROM project.Adres
WHERE land = 'België'
ORDER BY postcode;

-- * Vraag 3: Geef de gebruikersnaam, voornaam en familienaam weer van alle gebruikers weer die zich geabonneerd hebben in kolom genaamd “Abonnee”:
-- - Indien deze zich geabonneerd hebben voor 31-12-1979 geef je deze weer als “geabonneerd voor het jaar 1980".
-- - Indien deze zich geabonneerd hebben tussen 01-01-1980 en 31-12-1999 geef je deze weer als “geabonneerd tussen 1980 en 2000”.
-- - Indien deze zich geabonneerd hebben na 01-01-2000 geef je deze weer als “geabonneerd na 2000”.
-- Sorteer deze op abonneerdatum, van recent naar langdurig.

SELECT username AS 'Gebruikersnaam', voornaam AS 'Voornaam', familienaam AS 'Familienaam',
CASE
WHEN creatieDatum <= '12-31-1979' THEN 'geabonneerd voor het jaar 1980'
WHEN creatieDatum BETWEEN '01-01-1980' AND '12-31-1999' THEN 'geabonneerd tussen 1980 en 2000'
WHEN creatieDatum >= '01-01-2000' THEN 'geabonneerd na 2000'
END AS 'Abonnee'
FROM project.Gebruiker
WHERE isVerwijderd = 0
ORDER BY creatieDatum DESC;

-- * Vraag 4: Geef de productID, fabrikant, naam en weblink van alle producten weer op leverdatum.
-- - Indien de leverdatum meer dan 5 dagen is, geef je dit weer als “de levertermijn bedraagt meer dan 1 week”.
-- - Indien de leverdatum tussen de 3 en 5 dagen is, geef je dit weer als “deze week leverbaar”.
-- - Indien de leverdatum minder dan 3 dagen betreft, geef je dit weer als “direct leverbaar”.
-- Sorteer deze producten op leverdatum, van “direct leverbaar” tot “levertermijn bedraagt meer dan 1 week”.

SELECT ID as 'ProductID', fabrikant AS 'Fabrikant', naam AS 'Naam', weblink AS 'URL',
CASE
WHEN levertijd < 3 THEN 'direct leverbaar'
WHEN levertijd BETWEEN 3 AND 5 THEN 'deze week leverbaar'
WHEN levertijd > 5 THEN 'de levertermijn bedraagt meer dan 1 week'
END AS 'Levertermijn'
FROM project.Product
ORDER BY levertijd ASC, fabrikant;

-- * Vraag 5: Geef de prijs en de productstatus van alle producten die nog geen koper hebben. Rangschik de prijs van laag naar hoog.

SELECT prijs AS 'Prijs', productStatus AS 'Productstatus'
FROM project.Aanbod
WHERE koperID IS NULL
ORDER BY prijs ASC;

-- Les 4: Scalaire functies
-- * Vraag 1: Geef van alle producten de fabrikant en naam weer in één tabel genaamd "Product", de beschrijving van elk product in de tabel "Productomscrijving" en de datum dat deze is uitgebracht in de tabel "Releasedatum".
-- Geef de datum weer volgens het Europese standaardformaat (dag/maand/jaar).
-- Rangschik de producten op datum, van meest recent uitgebracht tot langst geleden uitgebracht.

SELECT CONCAT(fabrikant,' , ',naam) AS 'Product', beschrijving AS 'Productbeschrijving', CONVERT(varchar, creatieDatum, 103) AS 'Releasedatum'
FROM project.Product
ORDER BY creatieDatum DESC;

-- * Vraag 2: Geef in de tabel "vOLLEDIGE nAAM" de volledige naam van alle gebruikers weer met de eerste letter van de voor- en familienaam klein gedrukt, de andere letters in hoofdletter.
-- Laat tussen de voornaam en de familienaam 5 spaties.

SELECT CONCAT(SUBSTRING(LOWER(voornaam), 1, 1), SUBSTRING((UPPER(voornaam)), 2, 100), SPACE(5), SUBSTRING(LOWER(familienaam),1,1), SUBSTRING(UPPER(familienaam),2,100)) AS 'vOLLEDIGE nAAM'
FROM project.Gebruiker
ORDER BY familienaam;

-- * Vraag 3: Geef in de tabel "Gebruikersinformatie" de voornaam, familienaam, abonneeringjaar, beschrijving en emailadres weer volgens het voorbeeld:
-- "Gebruiker [familienaam] [voornaam] is al [aantal jaar] jaar geregistreerd als gebruiker. De beschrijving luidt [beschrijving], en heeft als emailadres [email]"
-- Rangschik alle gebruikers op familienaam, beginnende vanaf de laatste in het aflabet.

SELECT 'Gebruiker ' + CONCAT(familienaam, SPACE(1), voornaam) + ' is al ' + CONVERT(varchar, DATEDIFF(YEAR, creatieDatum, GETDATE())) + ' jaar geregistreerd als gebruiker. De beschrijving luidt: ' + beschrijving + ', en heeft als emailadres ' + email AS 'Gebruikersinformatie'
FROM project.Gebruiker
ORDER BY familienaam DESC;

-- * Vraag 4: Geef de minumum prijs, maximum prijs en gemiddelde prijs weer van alle aangeboden producten met uitzondering van de defecte producten.

SELECT '€ ' + CONVERT(varchar, ROUND(MIN(prijs),2), 0) + ',-' AS 'Laagste prijs', '€ ' + CONVERT(varchar, ROUND(MAX(prijs),2) ,0)  + ',-' AS 'Hoogste prijs', '€ ' + CONVERT(varchar, ROUND(AVG(prijs),2), 0) + ',-' AS 'Gemiddelde prijs'
FROM project.Aanbod
WHERE productStatus NOT LIKE 'defect';

-- * Vraag 5:
--- a) Geef het email adres en de volledige naam van alle gebruikers weer.

SELECT email AS 'Email', CONCAT(voornaam, SPACE(1), familienaam) AS 'Volledige Naam'
FROM project.Gebruiker

-- b) Verander het email adres naar [familienaam].[voornaam]@tweakers.be.
-- Indien de voor- of familinaam spaties bevat dienen deze vervangen te worden met een punt.
UPDATE project.Gebruiker
SET email = LOWER(REPLACE(familienaam, SPACE(1), '.')) + '.' + LOWER(REPLACE(voornaam, SPACE(1), '.')) + '@tweakers.be'

-- c) Geef vervolgens het nieuwe email adres en de volledige naam van alle gebruikers weer.
-- Rangschik deze alfabetisch op voornaam.
SELECT email AS 'Email', CONCAT(voornaam, SPACE(1), familienaam) AS 'Volledige Naam'
FROM project.Gebruiker
ORDER BY voornaam;

-- Les 5: Joins
-- * Vraag 1: Geef de adresgegevens van alle geregistreerde gebruikers weer.

SELECT g.username AS 'Gebruikersnaam', CONCAT(g.voornaam, SPACE(1), g.familienaam) AS 'Naam', CONCAT(a.straat, ', ', a.huisnummer) AS 'Adres', CONCAT(a.postcode, ', ', a.gemeente) AS 'Gemeente', a.land AS 'Land',
CASE
    WHEN a.land = 'Australië' THEN 'APAC'
    ELSE 'EMEA'
END AS 'Regio'
FROM project.Gebruiker AS g
    JOIN project.Adres AS a
    ON a.ID = g.adresID
ORDER BY Naam;

-- * Vraag 2: Geef de producten weer met productnaam, categorie, subcategorie en productbeschrijving welke elke geregistreerde gebruiker in bezit heeft.

SELECT CONCAT(g.voornaam, SPACE(1), g.familienaam) AS 'Naam', CONCAT(p.fabrikant, SPACE(1), p.naam) AS 'Productnaam', pc.naam AS 'Categorie', psc.naam AS 'Subcategorie', p.beschrijving AS 'Productbeschrijving'
FROM project.Gebruiker AS g
    JOIN project.GebruikerProduct AS gp
    ON g.ID = gp.gebruikerID
    JOIN project.Product AS p
    ON gp.ProductID = p.ID
    JOIN project.ProductCategorie AS pc
    ON p.ID = pc.productID
    JOIN project.ProductSubCategorie AS psc
    ON psc.productCategorieID = pc.ID
ORDER BY Naam ASC

-- * Vraag 3: Toon welke gebruikers welke artikelen te koop aanbieden.

SELECT CONCAT(verkoper.voornaam, SPACE(1), verkoper.familienaam) AS 'Verkoper', CONCAT(p.fabrikant, SPACE(1), p.naam) AS 'Product', a.productStatus AS 'Status', ('€ ' + CONVERT(varchar, a.prijs) + ',-') AS 'Prijs',
CASE 
    WHEN a.isGereserveerd = 1 THEN 'dit product is gereserveerd'
    WHEN a.isGereserveerd = 0 THEN '-/-'
END AS 'Gereserveerd?'
FROM project.Gebruiker AS g
    JOIN project.Aanbod AS a
    ON a.verkoperID = g.ID
    JOIN project.Gebruiker AS verkoper
    ON a.verkoperID = verkoper.ID
    JOIN project.Product AS p
    ON a.productID = p.ID
ORDER BY verkoper.familienaam

-- * Vraag 4: Wie heeft over welk product een product review geschreven en wat is de inhoud van de review?

SELECT CONCAT(g.voornaam, SPACE(1), g.familienaam) AS 'Naam',CONCAT(p.fabrikant, SPACE(1), p.naam) AS 'Product', CONCAT('OORDEEL:' + CONVERT(varchar,pr.eindoordeel) + '/5', SPACE(3), 'HOOFDING: ' + pr.hoofding, SPACE(5), + 'INHOUD: ' + pr.inhoud) AS 'Product review'
FROM project.Gebruiker AS g
    LEFT JOIN project.GebruikerProduct as gp
    ON g.ID = gp.gebruikerID
    JOIN project.Product AS p
    ON gp.productID = p.ID
    JOIN project.ProductReview as pr
    ON p.ID = pr.productID
WHERE pr.inhoud IS NOT NULL
ORDER BY g.familienaam

-- * Vraag 5: Toon alle gebruikers woonachtig in België en Nederland en de adressen van deze gebruikers.
-- Geef weer of ze iets verkopen, en zoja, wat ze verkopen, binnen welke categorie het product valt dat ze verkopen en de status van het product.

SELECT CONCAT(g.voornaam, SPACE(1), g.familienaam) AS 'Naam', CONCAT(a.straat, ', ', a.huisnummer, SPACE(5), a.postcode, ', ', a.gemeente, SPACE(5), UPPER(a.land)) AS 'Adres',
CASE
    WHEN p.naam IS NULL THEN '-/-'
    WHEN p.naam IS NOT NULL THEN CONCAT(p.fabrikant, SPACE(1), p.naam)
END AS 'Product',
CASE
    WHEN c.naam IS NULL THEN '-/-'
    WHEN c.naam IS NOT NULL THEN CONCAT(c.naam, ' - ', s.naam)
END AS 'Categorie',
CASE 
    WHEN verkoper.productStatus IS NULL THEN '-/-'
    WHEN verkoper.productStatus IS NOT NULL THEN verkoper.productStatus
END AS 'Status'
FROM project.Gebruiker AS g
    JOIN project.Adres as a
    ON a.ID = g.adresID
    FULL OUTER JOIN project.Aanbod AS verkoper
    ON verkoper.verkoperID = g.ID
    FULL OUTER JOIN project.Product as p
    ON verkoper.productID = p.ID
    FULL OUTER JOIN project.ProductCategorie as c
    ON p.ID = c.productID
    FULL OUTER JOIN project.ProductSubCategorie AS s
    ON c.ID = s.productCategorieID
WHERE a.land = 'België' OR a.land = 'Nederland'
ORDER BY g.voornaam DESC

-- Les 6: Subqueries
-- * Vraag 1: Toon de volledige naam van alle geregistreerde gebruikers uit België.

SELECT CONCAT(g.voornaam, SPACE(1), g.familienaam) AS 'Naam'
FROM project.Gebruiker AS g
WHERE g.adresID IN (
    SELECT a.ID
    FROM project.Adres AS a
    WHERE a.land = 'België'
    )

-- * Vraag 2: Toon de producten van alle actieve geregistreerde gebruikers.

SELECT CONCAT(p.fabrikant, SPACE(1), p.naam) AS 'Product'
FROM project.Product AS p
WHERE p.ID IN (
    SELECT gp.productID
    FROM project.GebruikerProduct AS gp
    WHERE gp.gebruikerID IN (
        SELECT g.ID
        FROM project.Gebruiker AS g
        WHERE g.isVerwijderd = 0
    )
)

-- * Vraag 3: Toon de prijs van alle gereserveerde producten van de fabrikanten "Apple" en "Samsung" die aangeboden worden.

SELECT '€ ' + CONVERT(varchar, a.prijs) + ',-' AS 'Prijs'
FROM project.Aanbod AS a
WHERE a.isGereserveerd = 1 AND a.productID IN (
    SELECT p.ID
    FROM project.Product AS p
    WHERE p.fabrikant LIKE '%Apple' OR p.fabrikant LIKE '%Samsung'
)
ORDER BY prijs DESC

-- * Vraag 4: Geef de prijs, de naam van de afbeelding en de status van alle producten aangeboden door verkopers uit België of Nederland

SELECT '€ ' + CONVERT(varchar, a.prijs) + ',-' AS 'Prijs', a.productAfbeelding AS 'Afbeelding', a.productStatus AS 'Status'
FROM project.Aanbod AS a
WHERE a.verkoperID IN (
    SELECT g.ID
    FROM project.Gebruiker AS g
    WHERE g.adresID IN (
        SELECT adres.ID
        FROM project.Adres AS adres
        WHERE adres.land LIKE 'België' OR adres.land LIKE 'Nederland'
    )
)
ORDER BY prijs

-- * Vraag 5: Geef de reviews weer van alle actieve gebruikers waarvan het land eindigd op "ië" (België, Italië, Australië, ...)

SELECT CONCAT(CONVERT(varchar, pr.eindoordeel) + '/5', SPACE(3), 'TITEL: ' +  pr.hoofding) AS 'Review'
FROM project.ProductReview AS pr
WHERE pr.gebruikerID IN (
    SELECT g.ID
    FROM project.Gebruiker AS g
    WHERE g.isVerwijderd IS NOT NULL AND g.adresID IN (
        SELECT a.ID
        FROM project.Adres AS a
        WHERE a.land LIKE '%ië'
    )
)

-- Les 6: SET-functies
-- * Vraag 1: Toon hoeveel nieuwe producten of producten in nieuwstaat er worden aangeboden.
-- Toon de hoogste prijs, de laagste prijs en gemiddelde prijs van deze producten.

SELECT COUNT(a.ID) AS 'Aantal aangeboden producten', MAX(a.prijs) AS 'Hoogte prijs', MIN(a.prijs) AS 'Laagste prijs', AVG(a.prijs) AS 'Gemiddelde prijs'
FROM project.Aanbod AS a
WHERE a.productStatus LIKE 'nieuw' OR a.productStatus LIKE 'nieuwstaat'

-- *Vraag 2: Toon het aantal actief geregistreerde gebruikers uit België en Nederland

SELECT DISTINCT COUNT(a.ID) AS 'Geregistreerde Belgische gebruikers'
FROM project.Adres AS a
WHERE a.land = 'België' AND  a.ID IN
    (SELECT g.adresID
    FROM project.Gebruiker AS g
    WHERE g.isVerwijderd = 0
)

-- * Vraag 3: Toon het aantal gebruikers, de hoogste score, de laagste score en de gemiddelde score van alle actieve gebruikers die niet geregistreerd zijn in België

SELECT COUNT(pr.ID) AS 'Aantal gebruikers', CONVERT(varchar,MAX(pr.eindoordeel)) + '/5' AS 'Hoogste score', CONVERT(varchar,MIN(pr.eindoordeel)) + '/5' AS 'Laagste score', CONVERT(varchar,AVG(pr.eindoordeel)) + '/5' AS 'Gemiddelde score'
FROM project.ProductReview AS pr
WHERE pr.gebruikerID IN (
    SELECT g.ID
    FROM project.Gebruiker AS g
    WHERE g.isVerwijderd IS NOT NULL AND g.adresID IN (
        SELECT a.ID
        FROM project.Adres AS a
        WHERE a.land NOT LIKE 'België'
    )
)

-- Les 7: Group By
-- * Vraag 1 : Toon de naam, jaartal en maand van alle gebruikers die een account aangemaakt hebben vanaf het jaartal 1975.
-- Toon hoeveel accounts er op dezelfde maand, en in hetzelfde jaartal gecreëerd zijn.

SELECT CONCAT(g.voornaam, SPACE(1), g.familienaam) AS 'Naam', YEAR(g.creatieDatum) AS 'Jaartal', DATENAME(MONTH, g.creatieDatum) AS 'Maand',  COUNT(*) AS 'Accounts gecreëerd'
FROM project.Gebruiker AS g
WHERE YEAR(g.creatieDatum) >= 1975
GROUP BY g.voornaam, g.familienaam, g.creatieDatum
ORDER BY Jaartal

-- * Vraag 2: Toon het aantal geregistreerde gebruikers per land waar minstens 2 gebruikers geregistreerd zijn.

SELECT a.land AS 'Land', a.gemeente AS 'Gemeente', COUNT(*) AS 'Aantal gebruikers'
FROM project.Gebruiker AS g
    JOIN project.Adres AS a
    ON a.ID = g.adresID
GROUP BY a.land, a.gemeente
HAVING COUNT(*) > 1
ORDER BY [Aantal gebruikers] DESC

-- * Vraag 3: 3.	Toon het aantal artikelen dat elke geregistreerde verkoper aanbiedt.

SELECT CONCAT(g.voornaam, SPACE (1), g.familienaam) AS 'Naam', COUNT(*) AS 'Aantal artikelen te koop'
FROM project.Gebruiker AS g
    JOIN project.Aanbod AS a
    ON g.ID = a.verkoperID
WHERE g.isVerwijderd = 0
GROUP BY g.voornaam, g.familienaam
HAVING COUNT(*) > 0
ORDER BY [Aantal artikelen te koop] DESC

-- * Vraag 4: Toon het aantal producten per categorie en subcategorie.

SELECT pc.naam AS 'Product categorie naam', psc.naam AS 'Product subcategorie naam', COUNT(*) AS 'Aantal producten'
FROM project.Product as p
    JOIN project.ProductCategorie AS pc
    ON p.ID = pc.productID
    JOIN project.ProductSubCategorie AS psc
    ON pc.ID = psc.productCategorieID
GROUP BY pc.naam, psc.naam
HAVING COUNT(*) IS NOT NULL
ORDER BY [Aantal producten] DESC

-- * Vraag 5: Toon het aantal gereserveerde producten en de verkopers.

SELECT CONCAT(g.voornaam, SPACE(1), g.familienaam) AS 'Naam', COUNT(*) 'Aantal gereserveerde producten'
FROM project.Gebruiker AS g
WHERE g.isVerwijderd = 0 AND g.ID IN (
    SELECT gp.gebruikerID
    FROM project.GebruikerProduct AS gp
    WHERE gp.productID IN (
        SELECT p.ID
        FROM project.Product AS p
        WHERE p.ID IN (
            SELECT a.productID
            FROM project.Aanbod AS a
            WHERE a.isGereserveerd = 1
        )
    )
)
GROUP BY g.voornaam, g.familienaam
ORDER BY g.familienaam