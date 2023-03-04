--Controleren of de tabel "Planten" bestaad, indien ja -> schema weg
IF EXISTS(
    SELECT *
        FROM sys.tables AS t
        JOIN sys.schemas AS s
            ON t.schema_id = s.schema_id
    WHERE s.name = 'Planten'
    AND t.name ='Planten'
) DROP TABLE Planten.Planten;


IF EXISTS(
    SELECT *
        FROM sys.tables AS t
        JOIN sys.schemas AS s
            ON t.schema_id = s.schema_id
    WHERE s.name = 'Planten'
    AND t.name ='Soort'
) DROP TABLE Planten.Soort;


IF EXISTS(
    SELECT *
        FROM sys.schemas
    WHERE name = 'Planten'
) DROP SCHEMA Planten;

--Creëer het schema "Planten"
EXEC  ('CREATE SCHEMA Planten;');

--Creëer de tabel "Planten" in het schema "Planten"
CREATE TABLE Planten.Planten(
    id int NOT NULL IDENTITY(1,1) CONSTRAINT PK_Planten PRIMARY KEY (id),
    naam varchar(20) NOT NULL,
    soort int NOT NULL,
    kleur varchar(10) NULL,
    hoogte float NULL,
    prijs float NOT NULL,
    CONSTRAINT CK_Planten_kleur
        CHECK(kleur IN('wit', 'rood', 'geel', 'gemengd'))
);

--Creëer de tabel "Soort" in het schema "Planten"
CREATE TABLE Planten.Soort(
    id int NOT NULL IDENTITY(1,1),
    naam varchar(10),
    CONSTRAINT PK_Soort PRIMARY KEY (id)
);

--Pas de tabel "Planten" in het schema "Planten" aan, voeg een foreign key toe
ALTER TABLE Planten.Planten
    ADD CONSTRAINT FK_Planten_Soort
        FOREIGN KEY (Soort)
        REFERENCES Planten.Soort(id);

--Voeg 2 kolommen "bloeibegin" en "bloeieinde" toe aan de tabel "Planten"
ALTER TABLE Planten.Planten
    ADD bloeibegin date, bloeieinde date;

--Verwijder de kolom "hoogte" in de tabel "Planten"
ALTER TABLE Planten.Planten
    DROP COLUMN hoogte;

--Schakel de autonummering in de tabel "Soort" tijdelijk uit (!!!Op het einde de autonummering terug aan zetten!!!)
GO
SET IDENTITY_INSERT Planten.Soort ON
GO

INSERT Planten.Soort(id, naam)
VALUES (1, '1-jarig'), (2, 'vast'), (3, 'bol'), (4, 'boom');

--Schakel de autonummering in de tabel "Soort" terug aan
GO
SET IDENTITY_INSERT Planten.Soort OFF
GO

--Data toevoegen in de velden van de tabel "Planten" -> De LANGE methode
INSERT Planten.Planten(naam, soort, kleur, prijs, bloeibegin, bloeieinde)
VALUES ('Aster', 1, 'gemengd', 0.5, '1990-05-01', NULL);

--Data toevoegen in de velden van de tabel "Planten" -> De KORTE methode (!!!Kolemmen met NOT NULL moeten ingevuld worden!!!)
INSERT Planten.Planten(naam, soort, prijs)
VALUES ('Anjer', 2, 1.5);

--Data toevoegen in de velden van de tabel "Planten" -> De alternatieve KORTE methode
INSERT Planten.Planten
VALUES ('Tulp', 3, NULL, 2.5, NULL, NULL);

--Data toevoegen in de velden van de tabel "Planten" -> De alternatieve KORTE methode
INSERT Planten.Planten
VALUES ('Den', 4, NULL, 100, NULL, NULL);

--Data verwijderen in de velden van de tabel "Planten" aan de hand van een conditie (waar naam = Den)
DELETE FROM Planten.Planten
WHERE naam = 'Den';

--Update -> pas de kleur "wit" aan in de kolom "kleur" van de tabel "Planten"
UPDATE Planten.Planten
SET kleur = 'wit'
WHERE id = 2

--Tabel Planten weergeeven
SELECT * 
FROM Planten.Planten;

--Data verwijderen in de velden van de tabel "Soort" aan de hand van een conditie (waar id = 4 (boom))
DELETE FROM Planten.Soort
WHERE id = 4;

--Tabel Soort weergeeven
SELECT *
FROM Planten.Soort;