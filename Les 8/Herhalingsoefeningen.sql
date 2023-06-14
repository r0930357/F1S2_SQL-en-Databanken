-- HERHANINGSOEFENINGEN - OEFENING 1
-- Geef per uitvoerder zijn eventueel uitgegeven albums en de titels van deze nummers.
-- Het resultaat wordt gesorteerd in dalende volgorde van de albumitels.

SELECT CONCAT(U.voornaam, SPACE(1), U.naam) as 'Uitvoerder', C.titel as 'Album', N.titel AS 'Titel'
FROM DM_OEF1.Uitvoerder AS U
    LEFT OUTER JOIN DM_Oef1.Cd as C
    ON U.id = C.uitvoerderId
    LEFT OUTER JOIN DM_Oef1.Nummer as N
    ON C.id = N.cdId
ORDER BY C.titel DESC

-- HERHALINGOEFENINGEN - OEFENING 2
-- Geef per ober weer welke bestelling hij/zij heeft opgenomen bij welke klant. 
-- Het gebruikte SQL-commando mag geen JOINS bevatten.
SELECT (
    -- Eerste kolom: "Ober"
    SELECT CONCAT_WS(SPACE(1), TRIM(o.naam), TRIM(o.voornaam))
    FROM DM_Oef2.Ober as o
    WHERE o.id IN (
        SELECT DISTINCT b.oberId
        FROM DM_Oef2.Bestelling as b
        WHERE bestellingId = id)
    ) AS 'Ober',
    -- Tweede kolom: "Bestelnummer"
    ( SELECT b.id
    FROM DM_Oef2.Bestelling as b
    WHERE bestellingId = id
    ) AS 'Bestenummer',
    -- Derde kolom: "Besteldatum"
    ( SELECT CONVERT(varchar, b.bestelDatumTijd, 103)
    FROM DM_Oef2.Bestelling as b
    WHERE bestellingId = id
    ) AS 'Besteldatum',
    -- Vierde kolom: "Klant"
    ( SELECT CONCAT_WS(SPACE(1), TRIM(k.voornaam), TRIM(k.naam))
    FROM DM_Oef2.Klant as k
    WHERE k.id IN
        (SELECT b.klantId
        FROM DM_Oef2.Bestelling as b
        WHERE bestellingId = id)
    ) AS 'Klant',
    -- Vijfde kolom: "Bestelling"
    CONCAT_WS(SPACE(1), bg.aantal ,'x', (
        SELECT g.naam
        FROM DM_Oef2.Gerecht as g
        WHERE gerechtId = id)
    ) AS "Bestelling"
FROM DM_Oef2.BestellingGerecht as bg
ORDER BY Ober ASC

-- HERHALINGOEFENINGEN - OEFENING 3
-- Geef een overzicht van alle werknemers met hun chef.
-- Elk antwoord gebruikt een verschillende JOIN (left, right, inner)
-- met een INNER JOIN
SELECT 'De chef van ''' + CONCAT(werknemer.voornaam,SPACE(1), werknemer.naam) + ''' is ''' + CONCAT(chef.voornaam,SPACE(1), chef.naam) + '''' AS 'Personeelslid - Chef'
FROM DM_Oef7.Werknemer as werknemer
    JOIN DM_Oef7.Werknemer as chef
    ON werknemer.werknemerIdChef = chef.id

-- met een LEFT OUTER JOIN
SELECT 'De chef van ''' + CONCAT(werknemer.voornaam,SPACE(1), werknemer.naam) + ''' is ''' + CONCAT(chef.voornaam,SPACE(1), chef.naam) + '''' AS 'Personeelslid - Chef'
FROM DM_Oef7.Werknemer as werknemer
    LEFT OUTER JOIN DM_Oef7.Werknemer as chef
    ON werknemer.werknemerIdChef = chef.id
WHERE chef.naam IS NOT NULL

-- met een RIGHT OUTER JOIN
SELECT 'De chef van ''' + CONCAT(werknemer.voornaam,SPACE(1), werknemer.naam) + ''' is ''' + CONCAT(chef.voornaam,SPACE(1), chef.naam) + '''' AS 'Personeelslid - Chef'
FROM DM_Oef7.Werknemer as werknemer
    RIGHT OUTER JOIN DM_Oef7.Werknemer as chef
    ON werknemer.werknemerIdChef = chef.id
WHERE werknemer.naam IS NOT NULL

-- HERHALINGOEFENINGEN - OEFENING 4
-- Geef de naam en het aantal bestellingen van de chef ober (= ober met de meeste bestellingen).
SELECT TOP (1) TRIM(voornaam) + ' ' + TRIM(naam) AS 'Chef ober', COUNT(*) AS 'Aantal bestellingen'
FROM DM_Oef2.Ober AS o
    JOIN DM_Oef2.Bestelling as b
    ON b.oberId = o.id
GROUP BY TRIM(voornaam) + ' ' + TRIM(naam)
ORDER BY COUNT(*) DESC

-- HERHALINGOEFENINGEN - OEFENING 5
-- Geef de kapperszaken in dalende volgorde.
SELECT CONCAT_WS(SPACE(1), UPPER(SUBSTRING(TRIM(k.naam),1 ,1)) + LOWER(SUBSTRING(TRIM(k.naam),2, 100)) ,UPPER(SUBSTRING(TRIM(k.voornaam),1 ,1)) + LOWER(SUBSTRING(TRIM(k.voornaam),2, 100))) AS 'Kapperszaak'
FROM DM_Oef3.Kapper as k
ORDER BY Kapperszaak DESC

-- HERHALINGOEFENINGEN - OEFENING 6
-- Geef de namen van de kapperszaken en het aantal uitgevoerde behandelingen.
-- Hou er rekening mee dat toekomstige kapperszaken niet altijd correct worden toegevoegd.
-- Zo kan het zijn dat de naam en/of voornaam bestaat uit alleen kleine of alleen hoofdletters.
-- Ook dan worden de namen van de kapperszaken op dezelfde manier getoond als in onderstaand voorbeeld.
-- Sorteer het resultaat oplopend op het aantal behandelingen en bij een gelijk aantal behandelingen op de naam van de kapperszaak.
SELECT CONCAT_WS(SPACE(1), UPPER(SUBSTRING(TRIM(k.naam),1 ,1)) + LOWER(SUBSTRING(TRIM(k.naam),2, 100)) ,UPPER(SUBSTRING(TRIM(k.voornaam),1 ,1)) + LOWER(SUBSTRING(TRIM(k.voornaam),2, 100))) AS 'Kapperszaak', COUNT(*) AS 'Aantal Behandelingen'
FROM DM_Oef3.Kapper as k
    JOIN DM_Oef3.Behandeling as b
    ON b.kapperId = k.id
GROUP BY CONCAT_WS(SPACE(1), UPPER(SUBSTRING(TRIM(k.naam),1 ,1)) + LOWER(SUBSTRING(TRIM(k.naam),2, 100)) ,UPPER(SUBSTRING(TRIM(k.voornaam),1 ,1)) + LOWER(SUBSTRING(TRIM(k.voornaam),2, 100)))
ORDER BY [Aantal Behandelingen]

-- HERHALINGOEFENINGEN - OEFENING 7
-- Kapper met id 7 heeft vandaag (in onderstaand voorbeeld = 06/02/2022) om 10u een nieuwe behandeling uitgevoerd bij klant met id 2.
-- De klant heeft een ‘pagekop’ laten knippen.
-- Je mag behandelingTypeId 1 niet hard gecodeerd toevoegen.
INSERT INTO DM_Oef3.Behandeling (kapperId, klantId, datum, tijdstip, behandelingTypeId)
VALUES (7,2,GETDATE(),'10:00:00', (
    SELECT id
    FROM DM_Oef3.BehandelingType as bt
    WHERE bt.naam = 'pagekop'
))

-- EXTRA -> Verwijder het record uit de tabel "Behandeling"
DELETE FROM DM_Oef3.Behandeling WHERE id = 8

-- HERHALINGOEFENINGEN - OEFENING 8
-- Geef alle kapperszaken die minstens een snitbeurt hebben uitgevoerd.
-- Een snitbeurt kan je herkennen wanneer de omschrijving van het behandelingstype is ingevuld.
-- Het resultaat wordt gesorteerd volgens kappersnaam en -voornaam.
SELECT CONCAT_WS(SPACE(1), UPPER(SUBSTRING(TRIM(k.naam),1 ,1)) + LOWER(SUBSTRING(TRIM(k.naam),2, 100)) ,UPPER(SUBSTRING(TRIM(k.voornaam),1 ,1)) + LOWER(SUBSTRING(TRIM(k.voornaam),2, 100))) AS 'Kapperszaak'
FROM DM_Oef3.Kapper as k
WHERE k.id IN (
    SELECT b.kapperId
    FROM DM_Oef3.Behandeling as b
    WHERE b.behandelingTypeId IN (
        SELECT bt.id
        FROM DM_Oef3.BehandelingType as bt
        WHERE bt.omschrijving IS NOT NULL
    )
)
ORDER BY k.naam, k.voornaam

-- HERHALINGOEFENINGEN - OEFENING 9
-- Geef een overzicht van alle personeelsleden met hun kwalificaties en de afdelingen waarin ze werken.
-- Sorteer het resultaat op personeelsnummer.
SELECT pl.personeelsnummer AS 'Personeelsnummer', CONCAT_WS(SPACE(1), pl.naam, pl.voornaam), a.naam AS 'Afdeling', l.naam as 'Locatie Afdeling', k.naam as 'Kwalificatie', plk.jaar AS 'Behaald'
FROM DM_Oef5.PersoneelslidKwalificatie as plk
    JOIN DM_Oef5.Kwalificatie as k
    ON k.id = plk.kwalificatieId
    JOIN DM_Oef5.Personeelslid as pl
    ON pl.id = plk.personeelslidId
    JOIN DM_Oef5.Afdeling as a
    ON a.id = pl.afdelingId
    JOIN DM_Oef5.Locatie as l
    ON l.id = a.locatieId
ORDER BY pl.personeelsnummer

-- HERHALINGOEFENINGEN - OEFENING 10
-- Geef per personeelslid weer hoeveel kwalificaties hij/zij in zijn of haar bezit heeft.
SELECT CONCAT_WS(SPACE(1), pl.naam, pl.voornaam, 'heeft', COUNT(k.id), 'kwalificaties')
FROM DM_Oef5.PersoneelslidKwalificatie as plk
    JOIN DM_Oef5.Kwalificatie as k
    ON k.id = plk.kwalificatieId
    JOIN DM_Oef5.Personeelslid as pl
    ON pl.id = plk.personeelslidId
GROUP BY pl.naam, pl.voornaam, pl.personeelsnummer
ORDER BY pl.personeelsnummer

-- HERHALINGOEFENINGEN - OEFENING 11
-- Geef de personeelsleden op die tussen 1975 en 1985 een kwalificatie hebben behaald.
-- Sorteer op personeelsnummer.
SELECT pl.personeelsnummer AS 'Personeelsnummer', CONCAT_WS(SPACE(1), pl.naam, pl.voornaam) AS 'Personeel'
FROM DM_Oef5.Personeelslid as pl
    JOIN DM_Oef5.PersoneelslidKwalificatie as plk
    ON pl.id = plk.personeelslidId
WHERE plk.jaar BETWEEN 1975 AND 1985

-- HERHALINGOEFENINGEN - OEFENING 12
-- Geef onderstaand overzicht per onderhoudsbeurt. Bekijk aandachtig het gewenst resultaat.
-- Het onderhoudsnummer wordt als volgt samengesteld:
-- •	het huidig jaar gevolgd door een slash en de id.
-- De kilometerstand wordt in volgende groepen weergegeven:
-- •	minder dan 20.000 km
-- •	tussen 20.000 en 50.000 km
-- •	meer dan 50.000 km

SELECT CONCAT(YEAR(GETDATE()),'/',ob.id) AS 'Onderhoudsnummer', a.nummerplaat AS 'Nummerplaat', mt.merk AS 'Merk', mt.[type] AS 'Type', 
CASE
    WHEN ob.kmStand < 20000 THEN 'Minder dan 20.000km'
    WHEN ob.kmStand < 50000 THEN 'Tussen 20.000 en 50.000 km'
    ELSE 'Meer dan 50.000km'
END AS 'Kilomterstand', CONVERT(varchar, ob.datum, 103) AS 'Datum'
FROM DM_Oef6.Onderhoudsbeurt as ob
    JOIN DM_Oef6.Auto as a
    ON a.id = ob.autoId
    JOIN DM_Oef6.MerkType as mt
    ON mt.id = a.merkTypeId
    JOIN DM_Oef6.Klant as k
    ON k.id = a.klantId

-- HERHALINGOEFENINGEN - OEFENING 13
-- Geef per auto weer welke en hoeveel onderdelen gebruikt werden tijdens de onderhoudsbeurten.
-- Alleen de resultaten waarvoor het aantal onderdelen groter is dan 1 worden getoond in het overzicht.
-- Sorteer het resultaat op nummerplaat.
SELECT a.nummerplaat as 'Nummerplaat', o.omschrijving as 'Onderdelen', COUNT(o.id) as 'Aantal onderdelen'
FROM DM_Oef6.Onderdeel as o
    JOIN DM_Oef6.OnderhoudsbeurtOnderdeel as oho
    ON o.id = oho.onderdeelId
    JOIN DM_Oef6.Onderhoudsbeurt as oh
    ON oh.id = oho.onderhoudsbeurtId
    JOIN DM_Oef6.[Auto] as a
    ON a.id = oh.autoId
GROUP BY a.nummerplaat, o.omschrijving, o.id
HAVING COUNT(o.id) > 1
ORDER BY a.nummerplaat

-- HERHALINGOEFENINGEN - OEFENING 14
-- Geef een overzicht van alle afdeling, met eventueel de vermelding wie het afdelingshoofd is.
-- Voor een afdeling zonder afdelingshoofd, drukken we ‘Open vacature’ in de 2de kolom.
SELECT a.naam AS 'Afdeling',
CASE
    WHEN chef.naam IS NULL THEN 'Open vacature'
    ELSE CONCAT_WS(SPACE(1), chef.naam, chef.voornaam)
END AS 'Afdelingshoofd'
FROM DM_Oef4.Afdeling as a
    LEFT OUTER JOIN DM_Oef4.Medewerker as chef
    ON a.medewerkerIdChef = chef.id

-- HERHALINGOEFENINGEN - OEFENING 15
-- Karel Put wordt afdelingshoofd van de afdeling ‘Productie Plant A’ en interim afdelingshoofd van alle andere afdelingen zonder afdelingshoofd. 
-- Doe het nodige zodat deze informatie in de juiste tabellen wordt aangepast.
UPDATE DM_Oef4.Afdeling
SET medewerkerIdChef = (
    SELECT TOP 1 m.id
    FROM DM_Oef4.Medewerker as m
    WHERE voornaam = 'Karel'
      AND naam = 'Put'
)
WHERE medewerkerIdChef IS NULL;

-- HERHALINGOEFENINGEN - OEFENING 16
-- Voorzie in tabel ‘Woonplaats’ een extra attribuut ‘provincie’. Dit attribuut is 100 karakters groot.
-- Vul ‘Antwerpen’ in het nieuwe attribuut ‘provincie’ voor de woonplaatsen met als postcode 2300, 2400, 2440 en 2000.

-- Tabel "Woonplaats" aanpassen -> voeg kolom 'provincie' toe
ALTER TABLE DM_Oef8.Woonplaats
ADD provincie varchar(100) NULL;

-- Voeg in de kolom 'provincie' de naam 'Antwerpen' toe waar de postcodes gelijk zijn aan 2300, 2400, 2440 en 2000
UPDATE DM_Oef8.Woonplaats
SET provincie = 'Antwerpen'
WHERE postcode IN (2300, 2400, 2440, 2000);

-- Geef de tabel "Woonplaats" weer
SELECT * FROM DM_Oef8.Woonplaats

-- EXTRA -> De kolom terug verwijderen
ALTER TABLE DM_Oef8.Woonplaats
DROP COLUMN provincie