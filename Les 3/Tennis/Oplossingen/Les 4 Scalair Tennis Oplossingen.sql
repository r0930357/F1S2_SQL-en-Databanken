-- Oefening 1
SELECT upper(naam) as naam
FROM tennis.speler
ORDER BY naam;

-- Oefening 2
SELECT naam, LEN(naam) as karakters
FROM tennis.speler;

-- Oefening 3
SELECT TRIM(LOWER(voornaam)) + '. ' + UPPER(naam) as naam,
       bondsnummer
FROM tennis.speler
WHERE plaats = 'den haag';

-- Oefening 4
SELECT id,
       SUBSTRING(voornaam, 1, 1) + '. ' + naam as naam
FROM tennis.speler
WHERE SUBSTRING(naam, 1, 1) = 'B';

-- Oefening 5
SELECT id
FROM tennis.boete
WHERE YEAR(datum) = 2000;

-- Oefening 6
SELECT id, YEAR(datum) as jaar
FROM tennis.boete
WHERE YEAR(datum) > 2000;

-- Oefening 7
SELECT TRIM(voornaam) + ' ' + naam as naam,
       ISNULL(bondsnummer, 'geen') as bondsnr
FROM tennis.speler
WHERE plaats = 'den haag';

-- Oefening 8
SELECT id,
       geboortedatum,
       DATENAME(WEEKDAY, geboortedatum) as weekdag,
       DATENAME(MONTH, geboortedatum)   as maand
FROM tennis.speler
WHERE id < 10;

-- Oefening 9
SELECT 'Speler ''' +
       rtrim(NAAM) +
       ''' is geboren op ' +
       CONVERT(varchar, geboortedatum, 103) +
       ', woont in ' + upper(plaats) +
       ' en heeft als bondsnr ' +
       bondsnummer as wedstrijdspeler
FROM tennis.speler
WHERE bondsnummer IS NOT NULL;

-- Oefening 10
SELECT 'Speler ' +
       CONVERT(varchar, spelerId) + ' heeft volgende boete gehad: ' +
       CONVERT(varchar, bedrag, 0) as 'speler met boetes'
FROM tennis.boete;

-- Oefening 11
SELECT NAAM,
       DATEDIFF(MONTH, geboortedatum, GETDATE()) as maanden_geleefd
FROM tennis.speler
ORDER BY maanden_geleefd;

-- Oefening 12
SELECT id,
       spelerId,
       DATEADD(MONTH, 3, datum) as bestuursdag
FROM tennis.Boete;



