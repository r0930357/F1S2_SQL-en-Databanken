DROP TABLE IF EXISTS DM_Oef1.Nummer;
DROP TABLE IF EXISTS DM_Oef1.Cd;
DROP TABLE IF EXISTS DM_Oef1.Uitvoerder;
DROP TABLE IF EXISTS DM_Oef2.BestellingGerecht;
DROP TABLE IF EXISTS DM_Oef2.Gerecht;
DROP TABLE IF EXISTS DM_Oef2.Bestelling;
DROP TABLE IF EXISTS DM_Oef2.Ober;
DROP TABLE IF EXISTS DM_Oef2.Klant;
DROP TABLE IF EXISTS DM_Oef3.Behandeling;
DROP TABLE IF EXISTS DM_Oef3.BehandelingType
DROP TABLE IF EXISTS DM_Oef3.Kapper;
DROP TABLE IF EXISTS DM_Oef3.Klant;

IF OBJECT_ID('DM_Oef4.Afdeling', 'U') IS NOT NULL
ALTER TABLE DM_Oef4.Afdeling
    DROP CONSTRAINT FK_Afdeling_Medewerker;

DROP TABLE IF EXISTS DM_Oef4.WerkActiviteit;
DROP TABLE IF EXISTS DM_Oef4.Medewerker;
DROP TABLE IF EXISTS DM_Oef4.Afdeling;
DROP TABLE IF EXISTS DM_Oef4.Project;
DROP TABLE IF EXISTS DM_Oef5.PersoneelslidKwalificatie;
DROP TABLE IF EXISTS DM_Oef5.Kwalificatie;
DROP TABLE IF EXISTS DM_Oef5.Personeelslid;
DROP TABLE IF EXISTS DM_Oef5.Afdeling;
DROP TABLE IF EXISTS DM_Oef5.Locatie;
DROP TABLE IF EXISTS DM_Oef5.Gemeente;
DROP TABLE IF EXISTS DM_Oef6.OnderhoudsbeurtOnderdeel;
DROP TABLE IF EXISTS DM_Oef6.Onderdeel;
DROP TABLE IF EXISTS DM_Oef6.Onderhoudsbeurt;
DROP TABLE IF EXISTS DM_Oef6.Auto;
DROP TABLE IF EXISTS DM_Oef6.MerkType;
DROP TABLE IF EXISTS DM_Oef6.Klant;
DROP TABLE IF EXISTS DM_Oef7.WerknemerBedrijfJob;
DROP TABLE IF EXISTS DM_Oef7.Job;
DROP TABLE IF EXISTS DM_Oef7.Bedrijf;
DROP TABLE IF EXISTS DM_Oef7.Werknemer;
DROP TABLE IF EXISTS DM_Oef7.Gemeente;
DROP TABLE IF EXISTS DM_Oef7.Land;
DROP TABLE IF EXISTS DM_Oef8.Bestellijn;
DROP TABLE IF EXISTS DM_Oef8.Artikel;
DROP TABLE IF EXISTS DM_Oef8.Bestelling;
DROP TABLE IF EXISTS DM_Oef8.Leverancier;
DROP TABLE IF EXISTS DM_Oef8.Woonplaats;

DROP SCHEMA IF EXISTS DM_Oef1;
GO

DROP SCHEMA IF EXISTS DM_Oef2;
GO

DROP SCHEMA IF EXISTS DM_Oef3;
GO

DROP SCHEMA IF EXISTS DM_Oef4;
GO

DROP SCHEMA IF EXISTS DM_Oef5;
GO

DROP SCHEMA IF EXISTS DM_Oef6;
GO

DROP SCHEMA IF EXISTS DM_Oef7;
GO

DROP SCHEMA IF EXISTS DM_Oef8;
GO

CREATE SCHEMA DM_Oef1;
GO

CREATE SCHEMA DM_Oef2;
GO

CREATE SCHEMA DM_Oef3;
GO

CREATE SCHEMA DM_Oef4;
GO

CREATE SCHEMA DM_Oef5;
GO

CREATE SCHEMA DM_Oef6;
GO

CREATE SCHEMA DM_Oef7;
GO

CREATE SCHEMA DM_Oef8;
GO

--DM_Oef1
CREATE TABLE DM_Oef1.Uitvoerder
(
    id       int IDENTITY (1,1) PRIMARY KEY,
    naam     varchar(30) NOT NULL,
    voornaam varchar(30) NULL,
);

CREATE TABLE DM_Oef1.Cd
(
    id           int IDENTITY (1,1) PRIMARY KEY,
    uitvoerderId int          NULL,
    titel        varchar(100) NOT NULL,
    CONSTRAINT FK_Cd_Uitvoerder
        FOREIGN KEY (uitvoerderId)
            REFERENCES DM_Oef1.Uitvoerder (id)
);

CREATE TABLE DM_Oef1.Nummer
(
    id    int IDENTITY (1,1) PRIMARY KEY,
    cdId  int,
    titel varchar(100) NOT NULL,
    CONSTRAINT FK_Nummer_Cd
        FOREIGN KEY (cdId)
            REFERENCES DM_Oef1.Cd (id)
);


INSERT INTO DM_Oef1.Uitvoerder (naam, voornaam)
VALUES ('Klabas', 'Jef'),
       ('Peeters', 'Frank'),
       ('Claes', 'Marie-Louise'),
       ('Van den Bergh', 'Frank'),
       ('Luyten', 'Karin');

INSERT INTO DM_Oef1.Cd (uitvoerderId, titel)
VALUES (1, 'Why'),
       (2, 'Anoniem'),
       (5, 'Houden van'),
       (1, 'Noot'),
       (1, 'Olliebol');

INSERT INTO DM_Oef1.Nummer (cdId, titel)
VALUES (1, 'lied 1'),
       (1, 'lied 5'),
       (2, 'lied 3'),
       (3, 'lied 15'),
       (3, 'lied 2'),
       (4, 'lied 4'),
       (5, 'lied 8'),
       (3, 'lied 25');

--DM_Oef2

CREATE TABLE DM_Oef2.Ober
(
    id       int IDENTITY (1,1) PRIMARY KEY,
    naam     varchar(30) NOT NULL,
    voornaam varchar(30) NOT NULL
);

CREATE TABLE DM_Oef2.Klant
(
    id       int IDENTITY (1,1) PRIMARY KEY,
    naam     varchar(30) NOT NULL,
    voornaam varchar(30)
);

CREATE TABLE DM_Oef2.Gerecht
(
    id    int IDENTITY (1,1) PRIMARY KEY,
    naam  varchar(30) NOT NULL,
    prijs money       NOT NULL
);

CREATE TABLE DM_Oef2.Bestelling
(
    id              int IDENTITY (1,1) PRIMARY KEY,
    oberId          int      NOT NULL,
    klantId         int      NOT NULL,
    bestelDatumTijd datetime NOT NULL
        CONSTRAINT FK_Bestelling_Ober
            FOREIGN KEY (oberId)
                REFERENCES DM_Oef2.Ober (id),
    CONSTRAINT FK_Bestelling_Klant
        FOREIGN KEY (klantId)
            REFERENCES DM_Oef2.Klant (id),
);

CREATE UNIQUE INDEX AK_Bestelling_oberId_klantId_bestelDatumTijd
    ON DM_Oef2.Bestelling (oberId, klantId, bestelDatumTijd);

CREATE TABLE DM_Oef2.BestellingGerecht
(
    id           int IDENTITY (1,1) PRIMARY KEY,
    bestellingId int NOT NULL,
    gerechtId    int NOT NULL,
    aantal       int NOT NULL
        CONSTRAINT FK_BestellingGerecht_Bestelling
            FOREIGN KEY (bestellingId)
                REFERENCES DM_Oef2.Bestelling (id),
    CONSTRAINT FK_BestellingGerecht_Gerecht
        FOREIGN KEY (gerechtId)
            REFERENCES DM_Oef2.Gerecht (id),
);
CREATE UNIQUE INDEX AK_BestellingGerecht_bestellingId_gerechtId
    ON DM_Oef2.BestellingGerecht (bestellingId, gerechtId);

INSERT INTO DM_Oef2.Ober (naam, voornaam)
VALUES ('Peetermans   ', '   Louise'),
       ('   Aerts   ', 'Luc    '),
       ('Bertels   ', 'Frits'),
       ('Bertels', 'Antoon'),
       ('Zimmermans', 'Antoon');

-- Klant
INSERT INTO DM_Oef2.Klant (naam, voornaam)
VALUES ('Beerten', 'Marjan'),
       ('Beerten', 'Mark'),
       ('Bertels', 'Louise'),
       ('Put', 'Marjan'),
       ('Oeyen', 'Marcel'),
       ('Timmermans', 'Piet');

-- Gerecht
INSERT INTO DM_Oef2.Gerecht (naam, prijs)
VALUES ('Dame Blanche', 7.20),
       ('Banasplit', 6.15),
       ('Boerenomelet', 18.00),
       ('Spaghetti van de chef', 11.95),
       ('Garnalenkroket', 15.95);

-- Bestelling
INSERT INTO DM_Oef2.Bestelling (klantId, oberId, bestelDatumTijd)
VALUES (1, 1, '2019/02/05 15:18:00'),
       (2, 1, '2019/02/05 15:20:15'),
       (3, 1, '2019/02/06 15:25:00'),
       (1, 2, '2019/02/05 16:15:00'),
       (2, 3, '2019/02/15 15:18:00'),
       (5, 2, '2019/02/16 16:25:25'),
       (1, 1, '2018/04/15'),
       (1, 2, '2018/04/15'),
       (1, 3, '2018/04/16'),
       (1, 2, '2018/04/25'),
       (3, 3, '2018/04/26'),
       (5, 1, '2018/04/04'),
       (4, 1, '2018/04/14'),
       (4, 2, '2018/04/14'),
       (4, 3, '2018/04/14'),
       (4, 4, '2018/04/14'),
       (5, 1, '2018/04/14'),
       (5, 2, '2018/04/14');

-- BestellingGerecht
INSERT INTO DM_Oef2.BestellingGerecht
VALUES (1, 1, 2),
       (1, 2, 2),
       (2, 3, 5),
       (3, 4, 3),
       (3, 3, 2),
       (4, 3, 2),
       (5, 1, 3);

--DM_Oef3
CREATE TABLE DM_Oef3.Kapper
(
    id       int IDENTITY (1,1) PRIMARY KEY,
    naam     varchar(30) NOT NULL,
    voornaam varchar(30)
);

CREATE TABLE DM_Oef3.Klant
(
    id       int IDENTITY (1,1) PRIMARY KEY,
    naam     varchar(30) NOT NULL,
    voornaam varchar(30) NOT NULL
);

CREATE TABLE DM_Oef3.BehandelingType
(
    id           int IDENTITY (1,1) PRIMARY KEY,
    naam         varchar(100) NOT NULL,
    omschrijving varchar(100) NULL,
    prijs        money        NOT NULL
);

CREATE TABLE DM_Oef3.Behandeling
(
    id                int IDENTITY (1,1) PRIMARY KEY,
    kapperId          int  NOT NULL,
    klantId           int  NOT NULL,
    datum             date NOT NULL,
    tijdstip          time NOT NULL,
    behandelingTypeId int  NOT NULL
        CONSTRAINT FK_Behandeling_Kapper
            FOREIGN KEY (kapperId)
                REFERENCES DM_Oef3.Kapper (id),
    CONSTRAINT FK_Behandeling_Klant
        FOREIGN KEY (klantId)
            REFERENCES DM_Oef3.Klant (id),
    CONSTRAINT FK_Behandeling_BehandelingType
        FOREIGN KEY (behandelingTypeId)
            REFERENCES DM_Oef3.BehandelingType (id)
);
CREATE UNIQUE INDEX AK_Behandeling_kapperId_klantId_datum_tijdstip_behandelingTypeId
    ON DM_Oef3.Behandeling (kapperId, klantId, datum, tijdstip, behandelingTypeId);

-- BehandelingType
INSERT INTO DM_Oef3.BehandelingType (naam, omschrijving, prijs)
VALUES ('pagekop', ' haar dat steil, als dikke laag en recht afgeknipt als een muts of helm over het hoofd ligt',
        25.50),
       ('bobkapsel', 'haar tot ongeveer aan de kin en met een rechte pony', 20.50),
       ('stekelhaar', 'kort haar dat overeind staat', 15);

INSERT INTO DM_Oef3.BehandelingType (naam, prijs)
VALUES ('haarmasker', 5.00),
       ('haarlak', 2.00);

-- Kapper
INSERT INTO DM_Oef3.Kapper (naam, voornaam)
VALUES ('Klabas', 'Jef'),
       ('Klabas', 'Karin'),
       ('Brusselmans', 'Bert'),
       ('aerts', 'Louise'),
       ('  de kapper van      ', '     stad     '),
       ('the', 'HAIRCORNER');

INSERT INTO DM_Oef3.Kapper (naam)
VALUES ('Kreatos');

-- Klant --
INSERT INTO DM_Oef3.Klant (voornaam, naam)
VALUES ('Petra', 'Franken'),
       ('Peeters', 'Ludovicus'),
       ('Huysmans', 'Philip'),
       ('Peeters', 'Maria'),
       ('Klaesens', 'Olga');

-- Behandeling --
INSERT INTO DM_Oef3.Behandeling
VALUES (2, 3, '2019/02/15', '9:00', 3),
       (2, 3, '2019/02/16', '12:30', 5),
       (3, 4, '2019/02/15', '9:50', 3),
       (3, 3, '2019/02/15', '9:00', 1),
       (4, 5, '2019/02/26', '12:30', 4),
       (5, 4, '2019/02/25', '9:50', 2),
       (1, 4, '2019/02/25', '9:50', 3);

--DM_Oef4
CREATE TABLE DM_Oef4.Afdeling
(
    id               int IDENTITY (1,1) PRIMARY KEY,
    naam             varchar(30) NOT NULL,
    medewerkerIdChef int         NULL
);

CREATE TABLE DM_Oef4.Medewerker
(
    id         int IDENTITY (1,1) PRIMARY KEY,
    afdelingId int NOT NULL,
    naam       varchar(30),
    voornaam   varchar(30)
);

CREATE TABLE DM_Oef4.Project
(
    id     int IDENTITY (1,1) PRIMARY KEY,
    naam   varchar(30) NOT NULL,
    budget money
);

CREATE TABLE DM_Oef4.WerkActiviteit
(
    id           int IDENTITY (1,1) PRIMARY KEY,
    projectId    int   NOT NULL,
    medewerkerId int   NOT NULL,
    uren         float NOT NULL
        CONSTRAINT FK_WerkActiviteit_Project
            FOREIGN KEY (projectId)
                REFERENCES DM_Oef4.Project (id),
    CONSTRAINT FK_WerkActiviteit_Medewerker
        FOREIGN KEY (medewerkerId)
            REFERENCES DM_Oef4.Medewerker (id),
    CONSTRAINT UK_WerkActiviteit
        UNIQUE (projectId, medewerkerId)
);

-- Foreign key opgeven --
ALTER TABLE DM_Oef4.Afdeling
    ADD CONSTRAINT FK_Afdeling_Medewerker
        FOREIGN KEY (medewerkerIdChef)
            REFERENCES DM_Oef4.Medewerker (id);

ALTER TABLE DM_Oef4.Medewerker
    ADD CONSTRAINT FK_Medewerker_Afdeling
        FOREIGN KEY (afdelingId)
            REFERENCES DM_Oef4.Afdeling (id);

INSERT INTO DM_Oef4.Afdeling (naam)
VALUES ('Analyse'),
       ('Programmering'),
       ('Inkoop'),
       ('Productie Plant A'),
       ('Productie Plant B'),
       ('Verkoop');

INSERT INTO DM_Oef4.Medewerker (afdelingId, naam, voornaam)
VALUES ('1', 'Peeters', 'Johan'),
       ('2', 'Claes', 'Ron'),
       ('1', 'Puttemans', 'Peter'),
       ('1', 'Franken', 'Tony'),
       ('2', 'Jorissen', 'Fred'),
       ('2', 'Maesens', 'Bertha'),
       ('3', 'Put', 'Karel'),
       ('3', 'Claessens', 'Robert'),
       ('4', 'Put', 'Pieter'),
       ('4', 'Frederickx', 'Hubert'),
       ('4', 'Ulenaers', 'Fred'),
       ('5', 'Mentens', 'Maarten');

-- Chefs toekennen aan afdeling
UPDATE DM_Oef4.Afdeling
SET medewerkerIdChef = 1
WHERE naam = 'Analyse';

UPDATE DM_Oef4.Afdeling
SET medewerkerIdChef = 2
WHERE id = 2;

UPDATE DM_Oef4.Afdeling
SET medewerkerIdChef = 8
WHERE naam = 'Inkoop';

UPDATE DM_Oef4.Afdeling
SET medewerkerIdChef = 10
WHERE naam = 'Verkoop';

INSERT INTO DM_Oef4.Project (naam, budget)
VALUES ('VDU', 1000),
       ('CRT', 800);

INSERT INTO DM_Oef4.Project (naam)
VALUES ('TTV');

INSERT INTO DM_Oef4.Project (naam, budget)
VALUES ('Project 45', 4500),
       ('Project 7', 12500);

INSERT INTO DM_Oef4.WerkActiviteit (projectId, medewerkerId, uren)
VALUES (1, 4, 5.00),
       (1, 5, 2.50),
       (2, 3, 8.50),
       (2, 5, 7.50),
       (3, 8, 27.50);

--DM_Oef5
CREATE TABLE DM_Oef5.Locatie
(
    id               int IDENTITY (1,1) PRIMARY KEY,
    code             varchar(2),
    naam             varchar(30),
    omschrijving     varchar(100),
    straatHuisnummer varchar(30),
    gemeenteId       int
);

CREATE TABLE DM_Oef5.Afdeling
(
    id        int IDENTITY (1,1) PRIMARY KEY,
    naam      varchar(30) NOT NULL,
    locatieId int         NOT NULL,
    CONSTRAINT FK_Afdeling_Locatie
        FOREIGN KEY (locatieId)
            REFERENCES DM_Oef5.Locatie (id)
);

CREATE TABLE DM_Oef5.Kwalificatie
(
    id   int IDENTITY (1,1) PRIMARY KEY,
    naam varchar(30) NOT NULL
);

CREATE TABLE DM_Oef5.Personeelslid
(
    id               int IDENTITY (1,1) PRIMARY KEY,
    personeelsnummer varchar(30) NOT NULL,
    naam             varchar(30),
    voornaam         varchar(30),
    afdelingId       int,
    CONSTRAINT FK_Personeelslid_Afdeling
        FOREIGN KEY (afdelingId)
            REFERENCES DM_Oef5.Afdeling (id),
    CONSTRAINT UK_Personeelslid_personeelsnummer
        UNIQUE (personeelsnummer)
);

CREATE TABLE DM_Oef5.PersoneelslidKwalificatie
(
    id              int IDENTITY (1,1) PRIMARY KEY,
    personeelslidId int NOT NULL,
    kwalificatieId  int NOT NULL,
    jaar            int,
    CONSTRAINT FK_PersoneelslidKwalificatie_Personeelslid
        FOREIGN KEY (personeelslidId)
            REFERENCES DM_Oef5.Personeelslid (id)
            ON DELETE CASCADE,
    CONSTRAINT FK_PersoneelslidKwalificatie_Kwalificatie
        FOREIGN KEY (kwalificatieId)
            REFERENCES DM_Oef5.Kwalificatie (id),
    CONSTRAINT UK_PersoneelslidKwalificatie
        UNIQUE (personeelslidId, kwalificatieId)
);

CREATE TABLE DM_Oef5.Gemeente
(
    id       int IDENTITY (1,1) PRIMARY KEY,
    postcode varchar(4)  NOT NULL,
    plaats   varchar(30) NOT NULL,
);

ALTER TABLE DM_Oef5.Locatie
    ADD CONSTRAINT FK_Locatie_Gemeente
        FOREIGN KEY (gemeenteId)
            REFERENCES DM_Oef5.Gemeente (id);

INSERT INTO DM_Oef5.Locatie (code, naam, omschrijving, straatHuisnummer)
VALUES ('BR', 'Bureau Research', 'Hoofdgebouw via ingang 2', 'Peperstraat 24A');

INSERT INTO DM_Oef5.Locatie (code, naam, straatHuisnummer)
VALUES ('P1', 'Plant 1', 'Peperstraat 38'),
       ('P2', 'Plant 2', 'Nieuwstraat 15');

INSERT INTO DM_Oef5.Locatie (code, naam, omschrijving, straatHuisnummer)
VALUES ('B1', 'Blok A1', 'Hoofdgebouw via ingang 1', 'Peperstraat 24B'),
       ('PR', 'Public Relation', 'Blok C', 'Peperstraat 24B');

INSERT INTO DM_Oef5.Afdeling (naam, locatieId)
VALUES ('Distributie', 1),
       ('Personeelsdienst', 5);

INSERT INTO DM_Oef5.Afdeling (naam, locatieId)
VALUES ('Verkoop', 5),
       ('Aankoop', 4),
       ('Productie A', 2);

INSERT INTO DM_Oef5.Kwalificatie (naam)
VALUES ('Kandidaat Pedagogie'),
       ('Licentie Pedagogie'),
       ('Doctoraat Pedagogie'),
       ('Kandidaat Informatica'),
       ('Licentie Informatica'),
       ('Bachelor Informatica');

INSERT INTO DM_Oef5.Personeelslid (personeelsnummer, naam, voornaam, afdelingId)
VALUES ('1302', 'De Coninck', 'Johan', 1),
       ('1308', 'Maes', 'Frederik', 1),
       ('1304', 'Peeters', 'Jan', 2);

INSERT INTO DM_Oef5.Personeelslid (personeelsnummer, naam)
VALUES ('1306', 'Claessen');

INSERT INTO DM_Oef5.Personeelslid (personeelsnummer, naam, voornaam)
VALUES ('1317', 'Put', 'Jan');

INSERT INTO DM_Oef5.PersoneelslidKwalificatie (personeelslidId, kwalificatieId, jaar)
VALUES (1, 1, 1970),
       (1, 2, 1973),
       (1, 3, 1977),
       (2, 4, 1980),
       (2, 5, 1982),
       (3, 6, 2007);

INSERT INTO DM_Oef5.Gemeente
VALUES ('2440', 'Geel'),
       ('2400', 'Mol'),
       ('2260', 'Oevel'),
       ('2260', 'Westerlo'),
       ('2260', 'Zoerle-Parwijs');

UPDATE DM_Oef5.Locatie
SET gemeenteId =
        (
            SELECT id
            FROM DM_Oef5.Gemeente
            WHERE postcode = 2440
        )
WHERE code = 'BR';

UPDATE DM_Oef5.Locatie
SET gemeenteId =
        (
            SELECT id
            FROM DM_Oef5.Gemeente
            WHERE plaats = 'Westerlo'
        )
WHERE naam = 'Plant 1';

UPDATE DM_Oef5.Locatie
SET gemeenteId =
        (
            SELECT id
            FROM DM_Oef5.Gemeente
            WHERE plaats = 'Oevel'
        )
WHERE code = 'P2';

UPDATE DM_Oef5.Locatie
SET gemeenteId =
        (
            SELECT id
            FROM DM_Oef5.Gemeente
            WHERE plaats = 'Geel'
        )
WHERE id = 4
   OR id = 5;

--DM_Oef6
CREATE TABLE DM_Oef6.Onderdeel
(
    id            int IDENTITY (1,1) PRIMARY KEY,
    omschrijving  varchar(100) NOT NULL,
    eenheidsprijs money        NOT NULL,
    nummer        varchar(20)  NOT NULL
);

CREATE UNIQUE INDEX AK_Onderdeel_nummer ON DM_Oef6.Onderdeel (nummer);

CREATE TABLE DM_Oef6.Klant
(
    id       int IDENTITY (1,1) PRIMARY KEY,
    naam     varchar(30) NOT NULL,
    voornaam varchar(30)
);

CREATE TABLE DM_Oef6.Auto
(
    id          int IDENTITY (1,1) PRIMARY KEY,
    merkTypeId  int,
    klantId     int,
    nummerplaat varchar(30) NOT NULL,
    CONSTRAINT FK_Auto_Klant
        FOREIGN KEY (klantId)
            REFERENCES DM_Oef6.Klant (id)
            ON DELETE SET NULL,
    CONSTRAINT UK_Auto
        UNIQUE (nummerplaat)
);

CREATE TABLE DM_Oef6.Onderhoudsbeurt
(
    id      int IDENTITY (1,1) PRIMARY KEY,
    datum   date  NOT NULL,
    autoId  int,
    kmStand float NOT NULL,
    CONSTRAINT FK_Onderhoudsbeurt_Auto
        FOREIGN KEY (autoId)
            REFERENCES DM_Oef6.Auto (id)
);

CREATE TABLE DM_Oef6.OnderhoudsbeurtOnderdeel
(
    id                int IDENTITY (1,1) PRIMARY KEY,
    onderhoudsbeurtId int,
    onderdeelId       int NOT NULL,
    aantal            int NOT NULL,
    CONSTRAINT FK_OnderhoudsbeurtOnderdeel_Onderhoudsbeurt
        FOREIGN KEY (onderhoudsbeurtId)
            REFERENCES DM_Oef6.Onderhoudsbeurt (id)
            ON DELETE SET NULL,
    CONSTRAINT FK_OnderhoudsbeurtOnderdeel_Onderdeel
        FOREIGN KEY (onderdeelId)
            REFERENCES DM_Oef6.Onderdeel (id),
    CONSTRAINT UK_OnderhoudsbeurtOnderdeel
        UNIQUE (onderhoudsbeurtId, onderdeelId)
);

CREATE TABLE DM_Oef6.MerkType
(
    id   int IDENTITY (1,1) PRIMARY KEY,
    merk varchar(100),
    type varchar(100)
);

ALTER TABLE DM_Oef6.Auto
    ADD CONSTRAINT FK_Auto_MerkType
        FOREIGN KEY (merkTypeId)
            REFERENCES DM_Oef6.MerkType (id);

-- Onderdeel
INSERT INTO DM_Oef6.Onderdeel (omschrijving, eenheidsprijs, nummer)
VALUES ('Koelvloeistof', 3.81, '9979918LOS'),
       ('Steeklamp 5 Watt', 1.25, '621632'),
       ('Bollamp Amber', 2.95, 'BNL51240198'),
       ('Oliefilter', 12.98, '1109N3'),
       ('Remblokjes', 2.18, '45A45Z'),
       ('Remblokjes special', 3.00, '45A45ZA');

-- Klant
INSERT INTO DM_Oef6.Klant (naam, voornaam)
VALUES ('De Coninck', 'Johan'),
       ('Maes', 'Frederik'),
       ('Peeters', 'Karel'),
       ('Claessen', 'Frans'),
       ('Put', 'Jan');

INSERT INTO DM_Oef6.Klant (naam)
VALUES ('Bakkerij Bolletje');

-- Auto
INSERT INTO DM_Oef6.Auto (klantId, nummerplaat)
VALUES (4, '1-POU-183'),
       (3, 'CAX-263'),
       (1, '1-ETM-273'),
       (3, 'A10'),
       (2, '1-ZET-123'),
       (6, '1-MIN-800');

INSERT INTO DM_Oef6.MerkType (merk, type)
VALUES ('Renault', 'Megane'),
       (N'Citroën', 'C6'),
       ('Audi', 'A4'),
       ('Porsche', 'Cayenne'),
       ('Renault', 'Megane');

UPDATE DM_Oef6.Auto
SET merkTypeId = 1
WHERE id = 1;

UPDATE DM_Oef6.Auto
SET merkTypeId = 3
WHERE id = 2;

UPDATE DM_Oef6.Auto
SET merkTypeId = 2
WHERE id = 3;

UPDATE DM_Oef6.Auto
SET merkTypeId = 1
WHERE id = 4;

UPDATE DM_Oef6.Auto
SET merkTypeId = 5
WHERE id = 5;

UPDATE DM_Oef6.Auto
SET merkTypeId = 3
WHERE id = 6;

-- Onderhoudsbeurt
INSERT INTO DM_Oef6.Onderhoudsbeurt (datum, autoId, kmStand)
VALUES ('2018-02-17', 2, 47320),
       ('2018-12-17', 3, 14800),
       ('2019-02-17', 1, 100800),
       ('2019-02-17', 2, 180800),
       ('2019-02-17', 3, 314800),
       ('2019-02-18', 6, 78800);

-- OnderhoudsbeurtOnderdeel
INSERT INTO DM_Oef6.OnderhoudsbeurtOnderdeel (onderhoudsbeurtId, onderdeelId, aantal)
VALUES (1, 1, 1),
       (1, 2, 1),
       (1, 3, 4),
       (1, 4, 1),
       (2, 1, 1),
       (2, 2, 1),
       (2, 3, 4),
       (2, 5, 2),
       (3, 1, 1),
       (3, 2, 1),
       (3, 3, 4),
       (4, 4, 1),
       (4, 1, 1),
       (4, 2, 1),
       (5, 3, 4),
       (5, 5, 2),
       (6, 2, 1),
       (6, 3, 4),
       (6, 5, 2);

DELETE DM_Oef6.Klant
WHERE naam = 'Bakkerij Bolletje';

--DM_Oef7
-- aanmaken van de tabellen horend bij oefening 7
CREATE TABLE DM_Oef7.Land
(
    id   int IDENTITY (1,1) PRIMARY KEY,
    naam varchar(100) NOT NULL
);

CREATE TABLE DM_Oef7.Gemeente
(
    id       int IDENTITY (1,1) PRIMARY KEY,
    postcode varchar(6)   NOT NULL,
    naam     varchar(100) NOT NULL,
    landId   int DEFAULT 1,
    CONSTRAINT FK_Gemeente_Land
        FOREIGN KEY (landId)
            REFERENCES DM_Oef7.Land (id)
);

CREATE TABLE DM_Oef7.Werknemer
(
    id               int IDENTITY (1,1) PRIMARY KEY,
    inschrijfnummer  int          NOT NULL,
    naam             varchar(30)  NOT NULL,
    voornaam         varchar(30)  NOT NULL,
    straatHuisnummer varchar(100) NOT NULL,
    gemeenteId       int          NOT NULL,
    telefoon         varchar(100) NOT NULL,
    werknemerIdChef  int,
    CONSTRAINT UK_Werknemer
        UNIQUE (inschrijfnummer),
    CONSTRAINT FK_Werknemer_Gemeente
        FOREIGN KEY (gemeenteId)
            REFERENCES DM_Oef7.Gemeente (id),
    CONSTRAINT FK_Werknemer_WerknemerChef
        FOREIGN KEY (werknemerIdChef)
            REFERENCES DM_Oef7.Werknemer (id)
);

CREATE TABLE DM_Oef7.Job
(
    id           int IDENTITY (1,1) PRIMARY KEY,
    afkorting    varchar(4),
    omschrijving varchar(100) NOT NULL UNIQUE
);

CREATE TABLE DM_Oef7.Bedrijf
(
    id               int IDENTITY (1,1) PRIMARY KEY,
    naam             varchar(100) NOT NULL,
    straatHuisnummer varchar(100) NOT NULL,
    gemeenteId       int          NOT NULL,
    CONSTRAINT FK_Bedrijf_Gemeente
        FOREIGN KEY (gemeenteId)
            REFERENCES DM_Oef7.Gemeente (id)
);

CREATE TABLE DM_Oef7.WerknemerBedrijfJob
(
    id          int IDENTITY (1,1) PRIMARY KEY,
    werknemerId int  NOT NULL,
    bedrijfId   int  NOT NULL,
    vanDatum    date NOT NULL,
    totDatum    date,
    jobId       int  NOT NULL,
    CONSTRAINT FK_WerknemerBedrijfJob_Werknemer
        FOREIGN KEY (werknemerId)
            REFERENCES DM_Oef7.Werknemer (id)
            ON DELETE CASCADE,
    CONSTRAINT FK_WerknemerBedrijfJob_Bedrijf
        FOREIGN KEY (bedrijfId)
            REFERENCES DM_Oef7.Bedrijf (id),
    CONSTRAINT FK_WerknemerBedrijfJob_Job
        FOREIGN KEY (jobId)
            REFERENCES DM_Oef7.Job (id),
);

-- Land
INSERT INTO DM_Oef7.Land
VALUES (N'België'),
       ('Nederland'),
       ('Duitsland'),
       ('Frankrijk'),
       ('Luxemburg'),
       (N'Groot Britannië'),
       ('Oostenrijk'),
       ('USA');

-- Gemeente
INSERT INTO DM_Oef7.Gemeente (postcode, naam)
VALUES ('2440', 'Geel'),
       ('2400', 'Mol'),
       ('3550', 'Heusden-Zolder'),
       ('3500', 'Hasselt'),
       ('2000', 'Antwerpen');

INSERT INTO DM_Oef7.Gemeente (postcode, naam, landId)
VALUES ('3045AN', 'Rotterdam', 2),
       ('2032PN', 'Haarlem', 2),
       ('2910', 'Essen', 1),
       ('45127', 'Essen', 3);

-- Bedrijf
INSERT INTO DM_Oef7.Bedrijf
VALUES ('Gemert B.V.', 'Peperstraat 15A', 2),
       ('Shell', 'Shellstraat', 3),
       ('Ladage', 'Pastoor Neylenlaan 45', 5),
       ('Pol Makelaardij', 'Bruglaan 78A-78C', 8),
       ('Jef Klabas', 'Watermolenstraat 45', 7);

-- Job
INSERT INTO DM_Oef7.Job (afkorting, omschrijving)
VALUES ('ANA', 'Analist'),
       ('ANPR', 'Analist-programmeur'),
       ('PROG', 'Programmeur'),
       ('VERK', 'Verkoper'),
       ('BOEK', 'Boekhouder');

INSERT INTO DM_Oef7.Job (omschrijving)
VALUES ('Projectleider');

INSERT INTO DM_Oef7.Job (afkorting, omschrijving)
VALUES ('Db', 'Databank verantwoordelijke');

-- Werknemer
INSERT INTO DM_Oef7.Werknemer (inschrijfnummer, naam, voornaam, straatHuisnummer, gemeenteId, telefoon)
VALUES ('744', 'Peeters', 'Peter', 'Peperstraat 15A', 5, '02/15487541');

INSERT INTO DM_Oef7.Werknemer (inschrijfnummer, naam, voornaam, straatHuisnummer, gemeenteId, telefoon, werknemerIdChef)
VALUES ('74493', 'Maes', 'Patrick', 'Korte kerkweg 3', 1, '014/596323', 1);

INSERT INTO DM_Oef7.Werknemer (inschrijfnummer, naam, voornaam, straatHuisnummer, gemeenteId, telefoon)
VALUES ('892', 'Daems', 'Mark', 'Nieuwstraat 78 bus 5', 2, '018/457812');

INSERT INTO DM_Oef7.Werknemer (inschrijfnummer, naam, voornaam, straatHuisnummer, gemeenteId, telefoon, werknemerIdChef)
VALUES ('74494', 'Mertens', 'Johan', 'Turnhoutsebaan 38', 1, '014/596323', 3),
       ('74495', 'Maes', 'Pieter', 'Tulpenlaan 45', 1, '014/584678', 3);

-- WerknemerBedrijfJob
INSERT INTO DM_Oef7.WerknemerBedrijfJob (werknemerId, bedrijfId, vanDatum, totDatum, jobId)
VALUES (1, 3, '2016-12-01', NULL, 4),
       (2, 1, '2017-01-01', '2017-03-12', 1),
       (4, 1, '2017-03-01', '2017-08-11', 2),
       (2, 2, '2017-04-01', '2017-07-31', 1),
       (2, 3, '2017-08-14', '2017-09-17', 2),
       (4, 3, '2017-08-24', '2017-09-24', 1),
       (2, 3, '2017-10-01', NULL, 5),
       (4, 4, '2017-10-01', '2018-01-15', 3),
       (5, 2, '2017-01-02', '2017-04-01', 2),
       (5, 3, '2017-05-02', '2017-09-24', 3),
       (5, 5, '2017-09-25', '2018-01-24', 3),
       (5, 3, '2018-01-25', NULL, 3),
       (4, 5, '2018-02-01', NULL, 3);


DELETE DM_Oef7.Werknemer
WHERE voornaam = 'Pieter'
  AND naam = 'Maes';

--DM_Oef8
CREATE TABLE DM_Oef8.Woonplaats
(
    id       int IDENTITY (1,1) PRIMARY KEY,
    postcode varchar(6)   NOT NULL,
    gemeente varchar(100) NOT NULL
);

CREATE TABLE DM_Oef8.Artikel
(
    id                    int IDENTITY (1,1) PRIMARY KEY,
    bestelcodeLeverancier varchar(4),
    omschrijving          varchar(100) NOT NULL,
    prijs                 money        NOT NULL
);

CREATE TABLE DM_Oef8.Leverancier
(
    id           int IDENTITY (1,1) PRIMARY KEY,
    code         varchar(10),
    naam         varchar(100) NOT NULL,
    adres        varchar(100) NOT NULL,
    woonplaatsId int,
    korting      decimal(5, 2) DEFAULT 0.00,
    CONSTRAINT FK_Leverancier_Woonplaats
        FOREIGN KEY (woonplaatsId)
            REFERENCES DM_Oef8.Woonplaats (id)
);

CREATE TABLE DM_Oef8.Bestelling
(
    id             int IDENTITY (1,1) PRIMARY KEY,
    bonnummer      int  NOT NULL,
    besteldatum    date NOT NULL,
    leveringsdatum date,
    korting        decimal(5, 2)
        CONSTRAINT DF_Bestelling_korting DEFAULT 0.00,
    leverancierId  int,
    CONSTRAINT UK_Bestelling
        UNIQUE (bonnummer),
    CONSTRAINT FK_Bestelling_Leverancier
        FOREIGN KEY (leverancierId)
            REFERENCES DM_Oef8.Leverancier (id)
);

CREATE TABLE DM_Oef8.Bestellijn
(
    id           int IDENTITY (1,1) PRIMARY KEY,
    bestellingId int NOT NULL,
    artikelId    int NOT NULL,
    aantal       int NOT NULL DEFAULT 0,
    CONSTRAINT FK_Bestellijn_Bestelling
        FOREIGN KEY (bestellingId)
            REFERENCES DM_Oef8.Bestelling (id)
            ON DELETE CASCADE,
    CONSTRAINT FK_Bestellijn_Artikel
        FOREIGN KEY (artikelId)
            REFERENCES DM_Oef8.Artikel (id)
);

---- Artikel
INSERT INTO DM_Oef8.Artikel (bestelcodeLeverancier, omschrijving, prijs)
VALUES ('A154', 'Beuk (boom rood)', 250),
       ('B007', 'Fabaceae Brimerus', 90),
       ('A092', 'Berk (moeras)', 150),
       ('C019', 'Appelboom', 50.00),
       ('D719', 'Perenboom', 59.45);

---- Woonplaats
INSERT INTO DM_Oef8.Woonplaats (postcode, gemeente)
VALUES ('2300', 'Turnhout'),
       ('3680', 'Erps-Kwerps'),
       ('2400', 'Mol'),
       ('2440', 'Geel'),
       ('3500', 'Hasselt'),
       ('2000', 'Antwerpen');

-- Leverancier
INSERT INTO DM_Oef8.Leverancier (naam, adres, woonplaatsId, code)
VALUES ('Flora nv', 'De Voslei 124', 2, 'KL014');

INSERT INTO DM_Oef8.Leverancier (code, naam, adres, woonplaatsId, korting)
VALUES ('KL022', 'Het meibloempje', 'Groenstraat 1 ', 1, 0.05);

INSERT INTO DM_Oef8.Leverancier (naam, adres, woonplaatsId)
VALUES ('Flora nv', 'Meirodelei 45A', 5);

INSERT INTO DM_Oef8.Leverancier (code, naam, adres, woonplaatsId, korting)
VALUES ('KL045', 'Lotusbloem', 'Groenstraat 45 ', 4, 0.025);

INSERT INTO DM_Oef8.Leverancier (naam, adres)
VALUES ('Florarium bvba', 'Peperstraat');

INSERT INTO DM_Oef8.Leverancier (code, naam, adres, woonplaatsId)
VALUES ('MZ022', 'Lelie der dalen', 'Koolmijnlaan 45A bus 1 ', 4);

-- Bestelling
INSERT INTO DM_Oef8.Bestelling (bonnummer, besteldatum, leveringsdatum, korting, leverancierId)
VALUES (121, '2017-04-01', '2017-04-22', 0.05, 1);

INSERT INTO DM_Oef8.Bestelling (bonnummer, besteldatum, leveringsdatum, leverancierId)
VALUES (122, '2017-04-11', '2017-05-02', 2);

INSERT INTO DM_Oef8.Bestelling (bonnummer, besteldatum, korting, leverancierId)
VALUES (124, '2018-03-07', 0.07, 3);

INSERT INTO DM_Oef8.Bestelling (bonnummer, besteldatum, leverancierId)
VALUES (132, '2018-03-11', 4);

INSERT INTO DM_Oef8.Bestelling (bonnummer, besteldatum, leveringsdatum, leverancierId)
VALUES (133, '2018-03-01', '2018-03-12', 5);

-- Bestellijn
INSERT INTO DM_Oef8.Bestellijn (bestellingId, artikelId, aantal)
VALUES (1, 1, 100),
       (1, 2, 90),
       (1, 3, 150),
       (2, 1, 10),
       (2, 4, 20),
       (2, 3, 10),
       (3, 4, 100),
       (3, 5, 90),
       (3, 3, 750),
       (4, 5, 190),
       (4, 3, 75),
       (4, 1, 190),
       (4, 4, 75),
       (5, 5, 190),
       (5, 3, 5),
       (5, 2, 10),
       (5, 4, 5);

