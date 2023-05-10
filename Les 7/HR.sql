DROP TABLE IF EXISTS HR.Barema;
DROP TABLE IF EXISTS HR.JobGeschiedenis;

IF OBJECT_ID('HR.Departement', 'U') IS NOT NULL
ALTER TABLE HR.Departement
    DROP CONSTRAINT IF EXISTS FK_Departement_Locatie;

IF OBJECT_ID('HR.Departement', 'U') IS NOT NULL
ALTER TABLE HR.Departement
    DROP CONSTRAINT IF EXISTS FK_Departement_Werknemer_manager;

DROP TABLE IF EXISTS HR.Locatie;
DROP TABLE IF EXISTS HR.Land;
DROP TABLE IF EXISTS HR.Regio;
DROP TABLE IF EXISTS HR.Werknemer;
DROP TABLE IF EXISTS HR.Departement;
DROP TABLE IF EXISTS HR.Job;
DROP SCHEMA IF EXISTS HR;
GO

CREATE SCHEMA HR;
GO

CREATE TABLE HR.Regio
(
    id   int IDENTITY (1,1),
    naam varchar(25),
    CONSTRAINT PK_Regio PRIMARY KEY (id)
);

CREATE TABLE HR.Land
(
    id      int IDENTITY (1,1),
    code    char(2)     NOT NULL,
    naam    varchar(40) NULL,
    regioId int,
    CONSTRAINT PK_Land PRIMARY KEY (id),
    CONSTRAINT FK_Land_Regio FOREIGN KEY (regioId)
        REFERENCES HR.Regio (id)
);

CREATE UNIQUE INDEX AK_Land ON HR.Land (code);

CREATE TABLE HR.Locatie
(
    id          int IDENTITY (1000,100),
    straatAdres varchar(40),
    postcode    varchar(12),
    stad        varchar(30) NOT NULL,
    provincie   varchar(25),
    landId      int,
    CONSTRAINT PK_Locatie PRIMARY KEY (id),
    CONSTRAINT FK_Locatie_Land FOREIGN KEY (landId)
        REFERENCES HR.Land (id)
);

CREATE TABLE HR.Job
(
    id             int IDENTITY (1,1),
    code           varchar(10) NOT NULL,
    titel          varchar(35) NOT NULL,
    minimumSalaris money,
    maximumSalaris money
        CONSTRAINT PK_Job PRIMARY KEY (id)
);

CREATE TABLE HR.Departement
(
    id                 int IDENTITY (10,10),
    naam               varchar(30) NOT NULL,
    werknemerIdManager int,
    locatieId          int,
    CONSTRAINT PK_Departement PRIMARY KEY (id),
    CONSTRAINT FK_Departement_Locatie FOREIGN KEY (locatieId)
        REFERENCES HR.Locatie (id),
)
CREATE TABLE HR.Werknemer
(
    id                  int,
    voornaam            varchar(20) NOT NULL,
    naam                varchar(25) NOT NULL,
    email               varchar(25) NOT NULL,
    telefoonnummer      varchar(20),
    huurDatum           date        NOT NULL,
    jobId               int         NOT NULL,
    salaris             money,
    commissiePercentage numeric(2, 2),
    werknemerIdChef     int,
    departementId       int,
    CONSTRAINT CK_Werknemer_salaris CHECK (salaris > 0),
    CONSTRAINT UK_Werknemer_email UNIQUE (email),
    CONSTRAINT PK_Werknemer PRIMARY KEY (id),
    CONSTRAINT FK_Werknemer_Departement
        FOREIGN KEY (departementId) REFERENCES HR.Departement (id),
    CONSTRAINT FK_Werknemer_Job FOREIGN KEY (jobId)
        REFERENCES HR.Job (id),
    CONSTRAINT FK_Werknemer_Werknemer_chef
        FOREIGN KEY (werknemerIdChef) REFERENCES HR.Werknemer (id)
);

ALTER TABLE HR.Departement
    ADD CONSTRAINT FK_Departement_Werknemer_manager
        FOREIGN KEY (werknemerIdManager) REFERENCES HR.Werknemer (id);


CREATE TABLE HR.JobGeschiedenis
(
    werknemerId   int  NOT NULL,
    startdatum    date NOT NULL,
    einddatum     date NOT NULL,
    jobId         int  NOT NULL,
    departementId int,
    CONSTRAINT PK_JobGeschiedenis PRIMARY KEY (werknemerId, startdatum),
    CONSTRAINT CH_JobGeschiedenis_datums
        CHECK (einddatum > startdatum),
    CONSTRAINT FK_JobGeschiedenis_Werknemer
        FOREIGN KEY (werknemerId) REFERENCES HR.Werknemer (id),
    CONSTRAINT FK_JobGeschiedenis_Job FOREIGN KEY (jobId)
        REFERENCES HR.Job (id),
    CONSTRAINT FK_JobGeschiedenis_Departement
        FOREIGN KEY (departementId) REFERENCES HR.Departement (id)
);

CREATE TABLE HR.Barema
(
    id             int IDENTITY (1,1),
    niveau         varchar(3),
    minimumSalaris money,
    maximumSalaris money,
    CONSTRAINT PK_Barema PRIMARY KEY (id)
)

-- gegevens toevoegen aan HR tabellen --
-- Barema --
INSERT INTO HR.Barema
VALUES ('A', 1000, 2999),
       ('B', 3000, 5999),
       ('C', 6000, 9999),
       ('D', 10000, 14999),
       ('E', 15000, 24999),
       ('F', 25000, 40000)
;

-- regio --
INSERT INTO HR.Regio
VALUES ('Europa'),
       ('Amerika'),
       (N'Azië'),
       ('Midden Oosten en Afrika')
;

-- land --
INSERT INTO HR.Land
VALUES ('IT', N'Italië', 1),
       ('JP', 'Japan', 3),
       ('US', 'United States of Amerika', 2),
       ('CA', 'Canada', 2),
       ('CN', 'China', 3),
       ('IN', 'India', 3),
       ('AU', N'Australië', 3),
       ('ZW', 'Zimbabwe', 4),
       ('SG', 'Singapore', 3),
       ('UK', 'United Kingdom', 1),
       ('FR', 'Frankrijk', 1),
       ('DE', 'Duitsland', 1),
       ('ZM', 'Zambia', 4),
       ('EG', 'Egypte', 4),
       ('BR', N'Brazilië', 2),
       ('CH', 'Zwitserland', 1),
       ('NL', 'Nederland', 1),
       ('MX', 'Mexico', 2),
       ('KW', 'Koeweit', 4),
       ('IL', N'Israël', 4),
       ('DK', 'Denemarken', 1),
       ('HK', 'HongKong', 3),
       ('NG', 'Nigeria', 4),
       ('AR', N'Argentinië', 2),
       ('BE', N'België', 1);

INSERT INTO HR.Locatie
VALUES ('1297 Via Cola di Rie', '00989', 'Rome', NULL, 1),
       ('93091 Calle della Testa', '10934', N'Venetië', NULL, 1),
       ('2017 Shinjuku-ku', '1689', 'Tokyo', 'Tokyo Prefecture', 2),
       ('9450 Kamiya-cho', '6823', 'Hiroshima', NULL, 2),
       ('2014 Jabberwocky Rd', '26192', 'Southlake', 'Texas', 3),
       ('2011 Interiors Blvd', '99236', 'South San Francisco', 'California', 3),
       ('2007 Zagora St', '50090', 'South Brunswick', 'New Jersey', 3),
       ('2004 Charade Rd', '98199', 'Seattle', 'Washington', 3),
       ('147 Spadina Ave', 'M5V 2L7', 'Toronto', 'Ontario', 4),
       ('6092 Boxwood St', 'YSW 9T2', 'Whitehorse', 'Yukon', 4),
       ('40-5-12 Laogianggen', '190518', 'Beijing', NULL, 5),
       ('1298 Vileparle (E)', '490231', 'Bombay', 'Maharashtra', 6),
       ('12-98 Victoria Street', '2901', 'Sydney', 'New South Wales', 7),
       ('198 Clementi North', '540198', 'Singapore', NULL, 9),
       ('8204 Arthur St', NULL, 'London', NULL, 10),
       ('Magdalen Centre, The Oxford Science Park', 'OX9 9ZB', 'Oxford', 'Oxford', 10),
       ('9702 Chester Road', '09629850293', 'Stretford', 'Manchester', 10),
       ('Schwanthalerstr. 7031', '80925', 'Munich', 'Bavaria', 12),
       ('Rua Frei Caneca 1360 ', '01307-002', 'Sao Paulo', 'Sao Paulo', 15),
       ('20 Rue des Corps-Saints', '1730', 'Geneva', 'Geneve', 16),
       ('Murtenstrasse 921', '3095', 'Bern', 'BE', 16),
       ('Pieter Breughelstraat 837', '3029SK', 'Utrecht', 'Utrecht', 17),
       ('Mariano Escobedo 9991', '11932', 'Mexico City', 'Distrito Federal', 18);

INSERT INTO HR.Departement
VALUES ('Administration', NULL, 1700),
       ('Marketing', NULL, 1800),
       ('Purchasing', NULL, 1700),
       ('Human Resources', NULL, 2400),
       ('Shipping', NULL, 1500),
       ('IT', NULL, 1400),
       ('Public Relations', NULL, 2700),
       ('Sales', NULL, 2500),
       ('Executive', NULL, 1700),
       ('Finance', NULL, 1700),
       ('Accounting', NULL, 1700),
       ('Treasury', NULL, 1700),
       ('Corporate Tax', NULL, 1700),
       ('Control And Credit', NULL, 1700),
       ('Shareholder Services', NULL, 1700),
       ('Benefits', NULL, 1700),
       ('Manufacturing', NULL, 1700),
       ('Construction', NULL, 1700),
       ('Contracting', NULL, 1700),
       ('Operations', NULL, 1700),
       ('IT Support', NULL, 1700),
       ('NOC', NULL, 1700),
       ('IT Helpdesk', NULL, 1700),
       ('Government Sales', NULL, 1700),
       ('Retail Sales', NULL, 1700),
       ('Recruiting', NULL, 1700),
       ('Payroll', NULL, 1700);

INSERT INTO HR.Job
VALUES ('AD_PRES', 'President', 20000, 40000),
       ('AD_VP', 'Administration Vice President', 15000, 30000),
       ('AD_ASST', 'Administration Assistant', 3000, 6000),
       ('FI_MGR', 'Finance Manager', 8200, 16000),
       ('FI_ACCOUNT', 'Accountant', 4200, 9000),
       ('AC_MGR', 'Accounting Manager', 8200, 16000),
       ('AC_ACCOUNT', 'Public Accountant', 4200, 9000),
       ('SA_MAN', 'Sales Manager', 10000, 20000),
       ('SA_REP', 'Sales Representative', 6000, 12000),
       ('PU_MAN', 'Purchasing Manager', 8000, 15000),
       ('PU_CLERK', 'Purchasing Clerk', 2500, 5500),
       ('ST_MAN', 'Stock Manager', 5500, 8500),
       ('ST_CLERK', 'Stock Clerk', 2000, 5000),
       ('SH_CLERK', 'Shipping Clerk', 2500, 5500),
       ('IT_PROG', 'Programmer', 4000, 10000),
       ('MK_MAN', 'Marketing Manager', 9000, 15000),
       ('MK_REP', 'Marketing Representative', 4000, 9000),
       ('HR_REP', 'Human Resources Representative', 4000, 9000),
       ('PR_REP', 'Public Relations Representative', 4500, 10500);

INSERT INTO HR.Werknemer
VALUES (100, 'Steven', 'King', 'SKING', '515.123.4567', '1987-06-17', 1, 24000, NULL, NULL, 90),
       (101, 'Neena', 'Kochhar', 'NKOCHHAR', '515.123.4568', '1989-09-21', 2, 17000, NULL, 100, 90),
       (102, 'Lex', 'De Haan', 'LDEHAAN', '515.123.4569', '1993-01-13', 2, 17000, NULL, 100, 90),
       (103, 'Alexander', 'Hunold', 'AHUNOLD', '590.423.4567', '1990-01-03', 15, 9000, NULL, 102, 60),
       (104, 'Bruce', 'Ernst', 'BERNST', '590.423.4568', '1991-05-21', 15, 6000, NULL, 103, 60),
       (105, 'David', 'Austin', 'DAUSTIN', '590.423.4569', '1997-06-25', 15, 4800, NULL, 103, 60),
       (106, 'Valli', 'Pataballa', 'VPATABAL', '590.423.4560', '1998-02-05', 15, 4800, NULL, 103, 60),
       (107, 'Diana', 'Lorentz', 'DLORENTZ', '590.423.5567', '1999-02-07', 15, 4200, NULL, 103, 60),
       (108, 'Nancy', 'Greenberg', 'NGREENBE', '515.124.4569', '1994-08-17', 4, 12000, NULL, 101, 100),
       (109, 'Daniel', 'Faviet', 'DFAVIET', '515.124.4169', '1994-08-16', 5, 9000, NULL, 108, 100),
       (110, 'John', 'Chen', 'JCHEN', '515.124.4269', '1997-09-28', 5, 8200, NULL, 108, 100),
       (111, 'Ismael', 'Sciarra', 'ISCIARRA', '515.124.4369', '1997-09-30', 5, 7700, NULL, 108, 100),
       (112, 'Jose Manuel', 'Urman', 'JMURMAN', '515.124.4469', '1998-03-07', 5, 7800, NULL, 108, 100),
       (113, 'Luis', 'Popp', 'LPOPP', '515.124.4567', '1999-12-07', 5, 6900, NULL, 108, 100),
       (114, 'Den', 'Raphaely', 'DRAPHEAL', '515.127.4561', '1994-12-07', 10, 11000, NULL, 100, 30),
       (115, 'Alexander', 'Khoo', 'AKHOO', '515.127.4562', '1995-05-18', 11, 3100, NULL, 114, 30),
       (116, 'Shelli', 'Baida', 'SBAIDA', '515.127.4563', '1997-12-24', 11, 2900, NULL, 114, 30),
       (117, 'Sigal', 'Tobias', 'STOBIAS', '515.127.4564', '1997-07-24', 11, 2800, NULL, 114, 30),
       (118, 'Guy', 'Himuro', 'GHIMURO', '515.127.4565', '1998-11-15', 11, 2600, NULL, 114, 30),
       (119, 'Karen', 'Colmenares', 'KCOLMENA', '515.127.4566', '1999-08-10', 11, 2500, NULL, 114, 30),
       (120, 'Matthew', 'Weiss', 'MWEISS', '650.123.1234', '1996-07-18', 12, 8000, NULL, 100, 50),
       (121, 'Adam', 'Fripp', 'AFRIPP', '650.123.2234', '1997-04-10', 12, 8200, NULL, 100, 50),
       (122, 'Payam', 'Kaufling', 'PKAUFLIN', '650.123.3234', '1995-05-01', 12, 7900, NULL, 100, 50),
       (123, 'Shanta', 'Vollman', 'SVOLLMAN', '650.123.4234', '1997-10-10', 12, 6500, NULL, 100, 50),
       (124, 'Kevin', 'Mour , s', 'KMOUR , S', '650.123.5234', '1999-11-16', 12, 5800, NULL, 100, 50),
       (125, 'Julia', 'Nayer', 'JNAYER', '650.124.1214', '1997-07-16', 13, 3200, NULL, 120, 50),
       (126, 'Irene', 'Mikkilineni', 'IMIKKILI', '650.124.1224', '1998-09-28', 13, 2700, NULL, 120, 50),
       (127, 'James', 'Landry', 'JLANDRY', '650.124.1334', '1999-01-14', 13, 2400, NULL, 120, 50),
       (128, 'Steven', 'Markle', 'SMARKLE', '650.124.1434', '2000-03-08', 13, 2200, NULL, 120, 50),
       (129, 'Laura', 'Bissot', 'LBISSOT', '650.124.5234', '1997-08-20', 13, 3300, NULL, 121, 50),
       (130, 'Mozhe', 'Atkinson', 'MATKINSO', '650.124.6234', '1997-10-30', 13, 2800, NULL, 121, 50),
       (131, 'James', 'Marlow', 'JAMRLOW', '650.124.7234', '1997-02-16', 13, 2500, NULL, 121, 50),
       (132, 'TJ', 'Olson', 'TJOLSON', '650.124.8234', '1999-04-10', 13, 2100, NULL, 121, 50),
       (133, 'Jason', 'Mallin', 'JMALLIN', '650.127.1934', '1996-06-14', 13, 3300, NULL, 122, 50),
       (134, 'Michael', 'Rogers', 'MROGERS', '650.127.1834', '1998-08-26', 13, 2900, NULL, 122, 50),
       (135, 'Ki', 'Gee', 'KGEE', '650.127.1734', '1999-12-12', 13, 2400, NULL, 122, 50),
       (136, 'Hazel', 'Philtanker', 'HPHILTAN', '650.127.1634', '2000-02-06', 13, 2200, NULL, 122, 50),
       (137, 'Renske', 'Ladwig', 'RLADWIG', '650.121.1234', '1995-07-14', 13, 3600, NULL, 123, 50),
       (138, 'Stephen', 'Stiles', 'SSTILES', '650.121.2034', '1997-10-26', 13, 3200, NULL, 123, 50),
       (139, 'John', 'Seo', 'JSEO', '650.121.2019', '1998-02-12', 13, 2700, NULL, 123, 50),
       (140, 'Joshua', 'Patel', 'JPATEL', '650.121.1834', '1998-04-06', 13, 2500, NULL, 123, 50),
       (141, 'Trenna', 'Rajs', 'TRAJS', '650.121.8009', '1995-10-17', 13, 3500, NULL, 124, 50),
       (142, 'Curtis', 'Davies', 'CDAVIES', '650.121.2994', '1997-01-29', 13, 3100, NULL, 124, 50),
       (143, 'Randall', 'Matos', 'RMATOS', '650.121.2874', '1998-03-15', 13, 2600, NULL, 124, 50),
       (144, 'Peter', 'Vargas', 'PVARGAS', '650.121.2004', '1998-07-09', 13, 2500, NULL, 124, 50),
       (145, 'John', 'Russell', 'JRUSSEL', '011.44.1344.429268', '1996-10-01', 8, 14000, .4, 100, 80),
       (146, 'Karen', 'Partners', 'KPARTNER', '011.44.1344.467268', '1997-01-05', 8, 13500, .3, 100, 80),
       (147, 'Alberto', 'Errazuriz', 'AERRAZUR', '011.44.1344.429278', '1997-03-10', 8, 12000, .3, 100, 80),
       (148, 'Gerald', 'Cambrault', 'GCAMBRAU', '011.44.1344.619268', '1999-10-15', 8, 11000, .3, 100, 80),
       (149, 'Eleni', 'Zlotkey', 'EZLOTKEY', '011.44.1344.429018', '2000-01-29', 8, 10500, .2, 100, 80),
       (150, 'Peter', 'Tucker', 'PTUCKER', '011.44.1344.129268', '1997-01-30', 9, 10000, .3, 145, 80),
       (151, 'David', 'Bernstein', 'DBERNSTE', '011.44.1344.345268', '1997-03-24', 9, 9500, .25, 145, 80),
       (152, 'Peter', 'Hall', 'PHALL', '011.44.1344.478968', '1997-08-20', 9, 9000, .25, 145, 80),
       (153, 'Christopher', 'Olsen', 'COLSEN', '011.44.1344.498718', '1998-03-30', 9, 8000, .2, 145, 80),
       (154, 'Nanette', 'Cambrault', 'NCAMBRAU', '011.44.1344.987668', '1998-12-09', 9, 7500, .2, 145, 80),
       (155, 'Oliver', 'Tuvault', 'OTUVAULT', '011.44.1344.486508', '1999-11-23', 9, 7000, .15, 145, 80),
       (156, 'Janette', 'King', 'JKING', '011.44.1345.429268', '1996-01-30', 9, 10000, .35, 146, 80),
       (157, 'Patrick', 'Sully', 'PSULLY', '011.44.1345.929268', '1996-03-04', 9, 9500, .35, 146, 80),
       (158, 'Allan', 'McEwen', 'AMCEWEN', '011.44.1345.829268', '1996-08-01', 9, 9000, .35, 146, 80),
       (159, 'Lindsey', 'Smith', 'LSMITH', '011.44.1345.729268', '1997-03-10', 9, 8000, .3, 146, 80),
       (160, 'Louise', 'Doran', 'LDORAN', '011.44.1345.629268', '1997-12-15', 9, 7500, .3, 146, 80),
       (161, 'Sarath', 'Sewall', 'SSEWALL', '011.44.1345.529268', '1998-11-03', 9, 7000, .25, 146, 80),
       (162, 'Clara', 'Vishney', 'CVISHNEY', '011.44.1346.129268', '1997-11-11', 9, 10500, .25, 147, 80),
       (163, 'Danielle', 'Greene', 'DGREENE', '011.44.1346.229268', '1999-03-19', 9, 9500, .15, 147, 80),
       (164, 'Mattea', 'Marvins', 'MMARVINS', '011.44.1346.329268', '2000-01-24', 9, 7200, .10, 147, 80),
       (165, 'David', 'Lee', 'DLEE', '011.44.1346.529268', '2000-02-23', 9, 6800, .1, 147, 80),
       (166, 'Sundar', 'Ande', 'SANDE', '011.44.1346.629268', '2000-03-24', 9, 6400, .10, 147, 80),
       (167, 'Amit', 'Banda', 'ABANDA', '011.44.1346.729268', '2000-04-21', 9, 6200, .10, 147, 80),
       (168, 'Lisa', 'Ozer', 'LOZER', '011.44.1343.929268', '1997-03-11', 9, 11500, .25, 148, 80),
       (169, 'Harrison', 'Bloom', 'HBLOOM', '011.44.1343.829268', '1998-03-23', 9, 10000, .20, 148, 80),
       (170, 'Tayler', 'Fox', 'TFOX', '011.44.1343.729268', '1998-01-24', 9, 9600, .20, 148, 80),
       (171, 'William', 'Smith', 'WSMITH', '011.44.1343.629268', '1999-02-23', 9, 7400, .15, 148, 80),
       (172, 'Elizabeth', 'Bates', 'EBATES', '011.44.1343.529268', '1999-03-24', 9, 7300, .15, 148, 80),
       (173, 'Sundita', 'Kumar', 'SKUMAR', '011.44.1343.329268', '2000-04-21', 9, 6100, .10, 148, 80),
       (174, 'Ellen', 'Abel', 'EABEL', '011.44.1644.429267', '1996-05-11', 9, 11000, .30, 149, 80),
       (175, 'Alyssa', 'Hutton', 'AHUTTON', '011.44.1644.429266', '1997-03-19', 9, 8800, .25, 149, 80),
       (176, 'Jonathon', 'Taylor', 'JTAYLOR', '011.44.1644.429265', '1998-03-24', 9, 8600, .20, 149, 80),
       (177, 'Jack', 'Livingston', 'JLIVINGS', '011.44.1644.429264', '1998-04-23', 9, 8400, .20, 149, 80),
       (178, 'Kimberely', 'Grant', 'KGRANT', '011.44.1644.429263', '1999-05-24', 9, 7000, .15, 149, NULL),
       (179, 'Charles', 'Johnson', 'CJOHNSON', '011.44.1644.429262', '2000-01-04', 9, 6200, .10, 149, 80),
       (180, 'Winston', 'Taylor', 'WTAYLOR', '650.507.9876', '1998-01-24', 14, 3200, NULL, 120, 50),
       (181, 'Jean', 'Fleaur', 'JFLEAUR', '650.507.9877', '1998-02-23', 14, 3100, NULL, 120, 50),
       (182, 'Martha', 'Sullivan', 'MSULLIVA', '650.507.9878', '1999-06-21', 14, 2500, NULL, 120, 50),
       (183, 'Girard', 'Geoni', 'GGEONI', '650.507.9879', '2000-02-03', 14, 2800, NULL, 120, 50),
       (184, 'Nandita', 'Sarchand', 'NSARCHAN', '650.509.1876', '1996-01-27', 14, 4200, NULL, 121, 50),
       (185, 'Alexis', 'Bull', 'ABULL', '650.509.2876', '1997-02-20', 14, 4100, NULL, 121, 50),
       (186, 'Julia', 'Dellinger', 'JDELLING', '650.509.3876', '1998-06-24', 14, 3400, NULL, 121, 50),
       (187, 'Anthony', 'Cabrio', 'ACABRIO', '650.509.4876', '1999-02-07', 14, 3000, NULL, 121, 50),
       (188, 'Kelly', 'Chung', 'KCHUNG', '650.505.1876', '1997-06-14', 14, 3800, NULL, 122, 50),
       (189, 'Jennifer', 'Dilly', 'JDILLY', '650.505.2876', '1997-08-13', 14, 3600, NULL, 122, 50),
       (190, 'Timothy', 'Gates', 'TGATES', '650.505.3876', '1998-07-11', 14, 2900, NULL, 122, 50),
       (191, 'Randall', 'Perkins', 'RPERKINS', '650.505.4876', '1999-12-19', 14, 2500, NULL, 122, 50),
       (192, 'Sarah', 'Bell', 'SBELL', '650.501.1876', '1996-02-04', 14, 4000, NULL, 123, 50),
       (193, 'Britney', 'Everett', 'BEVERETT', '650.501.2876', '1997-03-03', 14, 3900, NULL, 123, 50),
       (194, 'Samuel', 'McCain', 'SMCCAIN', '650.501.3876', '1998-07-01', 14, 3200, NULL, 123, 50),
       (195, 'Vance', 'Jones', 'VJONES', '650.501.4876', '1999-03-17', 14, 2800, NULL, 123, 50),
       (196, 'Alana', 'Walsh', 'AWALSH', '650.507.9811', '1998-04-24', 14, 3100, NULL, 124, 50),
       (197, 'Kevin', 'Feeney', 'KFEENEY', '650.507.9822', '1998-05-23', 14, 3000, NULL, 124, 50),
       (198, 'Donald', 'OConnell', 'DOCONNEL', '650.507.9833', '1999-06-21', 14, 2600, NULL, 124, 50),
       (199, 'Douglas', 'Grant', 'DGRANT', '650.507.9844', '2000-01-13', 14, 2600, NULL, 124, 50),
       (200, 'Jennifer', 'Whalen', 'JWHALEN', '515.123.4444', '1987-09-17', 3, 4400, NULL, 101, 10),
       (201, 'Michael', 'Hartstein', 'MHARTSTE', '515.123.5555', '1996-02-17', 16, 13000, NULL, 100, 20),
       (202, 'Pat', 'Fay', 'PFAY', '603.123.6666', '1997-08-17', 17, 6000, NULL, 201, 20),
       (203, 'Susan', 'Mavris', 'SMAVRIS', '515.123.7777', '1994-06-07', 18, 6500, NULL, 101, 40),
       (204, 'Hermann', 'Baer', 'HBAER', '515.123.8888', '1994-06-07', 19, 10000, NULL, 101, 70),
       (205, 'Shelley', 'Higgins', 'SHIGGINS', '515.123.8080', '1994-06-07', 6, 12000, NULL, 101, 110),
       (206, 'William', 'Gietz', 'WGIETZ', '515.123.8181', '1994-06-07', 7, 8300, NULL, 205, 110);

UPDATE HR.Departement
SET werknemerIdManager = 200
WHERE id = 10;

UPDATE HR.Departement
SET werknemerIdManager = 201
WHERE id = 20;

UPDATE HR.Departement
SET werknemerIdManager = 114
WHERE id = 30;

UPDATE HR.Departement
SET werknemerIdManager = 203
WHERE id = 40;

UPDATE HR.Departement
SET werknemerIdManager = 121
WHERE naam = 'Shipping';

UPDATE HR.Departement
SET werknemerIdManager = 103
WHERE naam = 'IT';

UPDATE HR.Departement
SET werknemerIdManager = 204
WHERE naam = 'Public Relations';

UPDATE HR.Departement
SET werknemerIdManager = 145
WHERE naam = 'Sales';

UPDATE HR.Departement
SET werknemerIdManager = 100
WHERE naam = 'Executive';

UPDATE HR.Departement
SET werknemerIdManager = 108
WHERE naam = 'Finance';

UPDATE HR.Departement
SET werknemerIdManager = 205
WHERE naam = 'Accounting';

INSERT INTO HR.JobGeschiedenis
VALUES (102, '1993-01-13', '1998-07-24', 15, 60),
       (101, '1989-09-21', '1993-10-27', 7, 110),
       (101, '1993-10-28', '1997-03-15', 6, 110),
       (201, '1996-02-17', '1999-12-19', 17, 20),
       (114, '1998-03-24', '1999-12-31', 13, 50),
       (122, '1999-01-01', '1999-12-31', 13, 50),
       (200, '1987-09-17', '1993-06-17', 3, 90),
       (176, '1998-03-24', '1998-12-31', 9, 80),
       (176, '1999-01-01', '1999-12-31', 8, 80),
       (200, '1994-07-01', '1998-12-31', 7, 90);
