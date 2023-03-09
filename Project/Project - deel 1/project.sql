DROP TABLE IF EXISTS project.ProductCategorie;
DROP TABLE IF EXISTS project.ProductSubCategorie;
DROP TABLE IF EXISTS project.Product;
DROP TABLE IF EXISTS project.ProductReview;
DROP TABLE IF EXISTS project.Aanbod;
DROP TABLE IF EXISTS project.ProductReview;
DROP TABLE IF EXISTS project.GebruikerProduct;
DROP TABLE IF EXISTS project.Gebruiker;
DROP TABLE IF EXISTS project.Adres;


DROP SCHEMA IF EXISTS project; 

EXEC('CREATE SCHEMA project');
GO

CREATE TABLE project.Adres(
	ID int IDENTITY(1,1) NOT NULL,
	straat varchar(40) NOT NULL,
	huisnummer varchar(50) NOT NULL,
    gemeente varchar (50) NOT NULL,
    postcode varchar (12) NULL,
    land varchar (30) NOT NULL,
 CONSTRAINT PK_Adres PRIMARY KEY (ID),
)

CREATE TABLE project.Gebruiker(
	ID int IDENTITY(1,1) NOT NULL,
	username varchar(50) NOT NULL,
	voornaam varchar(80) NOT NULL,
    familienaam varchar(50) NOT NULL,
    email varchar(50) NULL,
    telefoonnummer varchar(30) NULL,
    creatieDatum smalldatetime NOT NULL,
    abonneStart smalldatetime NULL,
    aboneeVerval smalldatetime NULL,
    beschrijving varchar(255) NULL,
    afbeelding varchar(50) NULL,
    isVerwijderd bit NULL,
    adresID int NOT NULL,
 CONSTRAINT PK_Gebruiker PRIMARY KEY (ID),
 CONSTRAINT FK_GebruikerAdres
	FOREIGN KEY (adresID)
	REFERENCES project.Adres(ID),
 )

CREATE TABLE project.Product(
    ID int IDENTITY(1,1) NOT NULL,
    naam varchar(255) NOT NULL,
    beschrijving varchar(255) NOT NULL,
    afbeelding varchar(50) NULL,
    creatieDatum smalldatetime NOT NULL,
    levertijd int NULL,
    weblink varchar NULL,
    serienummer varchar(255) NOT NULL,
    isBeschikbaar bit NOT NULL,
 CONSTRAINT PK_Product PRIMARY KEY (ID),
)

CREATE TABLE project.GebruikerProduct(
    ID int IDENTITY(1,1) NOT NULL,
    gebruikerID int NOT NULL,
	productID int NOT NULL,
 CONSTRAINT PK_GebruikerProduct PRIMARY KEY (ID),
 CONSTRAINT FK_GebruikerProductGebruiker
		FOREIGN KEY (gebruikerID)
		REFERENCES project.Gebruiker(ID),
 CONSTRAINT FK_GebruikerProductProduct
		FOREIGN KEY (productID)
		REFERENCES project.Product(ID),
)

CREATE TABLE project.ProductReview(
    ID int IDENTITY(1,1) NOT NULL,
    datum smalldatetime NOT NULL,
    hoofding varchar(80) NOT NULL,
    inhoud varchar(4000) NOT NULL,
    eindoordeel int NOT NULL,
    productID int NOT NULL,
    gebruikerID int NOT NULL,
 CONSTRAINT PK_ProductReview PRIMARY KEY (ID),
 CONSTRAINT FK_ProductReviewGebruiker
		FOREIGN KEY (gebruikerID)
		REFERENCES project.Gebruiker(ID),
 CONSTRAINT FK_ProductReviewProduct
		FOREIGN KEY (productID)
		REFERENCES project.Product(ID),
)

CREATE TABLE project.Aanbod(
    ID int IDENTITY(1,1) NOT NULL,
    prijs FLOAT NOT NULL,
    productAfbeelding varchar(50) NULL,
    productStatus varchar(15) NULL,
    isGereserveerd bit NULL,
    productID int NOT NULL,
    koperID int NOT NULL,
    verkoperID int NOT NULL,
 CONSTRAINT PK_Aanbod PRIMARY KEY (ID),
 CONSTRAINT FK_AanbodProduct
    FOREIGN KEY (productID)
    REFERENCES project.Product(ID),
 CONSTRAINT FK_AanbodGebruiker_Koper
    FOREIGN KEY (koperID)
    REFERENCES project.Gebruiker(ID),
 CONSTRAINT FK_AanbodGebruiker_Verkoper
    FOREIGN KEY (verkoperID)
    REFERENCES project.Gebruiker(ID),
)

CREATE TABLE project.ProductCategorie(
    ID int IDENTITY(1,1) NOT NULL,
    naam varchar(50) NOT NULL,
    productID int NOT NULL,
 CONSTRAINT PK_ProductCategorie PRIMARY KEY (ID),
 CONSTRAINT FK_ProductCategorieProduct
    FOREIGN KEY (productID)
    REFERENCES project.Product(ID),
)

CREATE TABLE project.ProductSubCategorie(
    ID int IDENTITY(1,1) NOT NULL,
    naam varchar(50) NOT NULL,
    productCategorieID int NOT NULL,
 CONSTRAINT PK_ProductSubCategorie PRIMARY KEY (ID),
 CONSTRAINT FK_ProductSubCategorieProductCategorie
    FOREIGN KEY (productCategorieID)
    REFERENCES project.ProductCategorie(ID),
)

GO

SET IDENTITY_INSERT [project].[Adres] ON 
GO
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (1, N'Kleinhoefstraat', N'4', N'Geel', N'2440', N'België')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (2, N'Dorpstraat', N'15', N'Antwerpen', N'2000', N'België')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (3, N'Schoolstraat', N'23', N'Gent', N'9000', N'België')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (4, N'Marktplein', N'8', N'Brussel', N'1000', N'België')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (5, N'Kerkstraat', N'11', N'Leuven', N'3000', N'België')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (6, N'Hoofdstraat', N'42', N'Hasselt', N'3500', N'België')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (7, N'Binnenweg', N'17', N'Brugge', N'8000', N'België')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (8, N'Korte Kerkstraat', N'3', N'Veurne', N'8630', N'België')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (9, N'Groenstraat', N'21', N'Lier', N'2500', N'België')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (10, N'Grote Markt', N'7', N'Oostende', N'8400', N'België')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (11, N'Spoorwegstraat', N'32', N'Dendermonde', N'9200', N'België')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (12, N'Kapellestraat', N'13', N'Turnhout', N'2300', N'België')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (13, N'Parkstraat', N'14', N'Den Haag', N'2514', N'Nederland')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (14, N'Rue du Midi', N'22', N'Brussel', N'1000', N'België')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (15, N'Via Roma', N'7', N'Milaan', N'20121', N'Italë')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (16, N'Friedrichstraße', N'43', N'Berlijn', N'10969', N'Duitsland')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (17, N'Gran Vía', N'25', N'Madrid', N'28013', N'Spanje')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (18, N'Moulin de la Rousselière', N'5', N'Nantes', N'44300', N'Frankrijk')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (19, N'Strøget', N'15', N'København', N'1160', N'Denemarken')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (20, N'Wall Street', N'15', N'New York', N'10005', N'Verenigde Staten')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (21, N'Queens Road Central', N'1', N'Hong Kong', N'', N'Hong Kong')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (22, N'Rua do Ouro', N'49', N'Lissabon', N'1100-064', N'Portugal')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (23, N'Kungsgatan', N'8', N'Stockholm', N'111 43', N'Zweden')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (24, N'Flinders Street', N'100', N'Melbourne', N'3000', N'Australië')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (25, N'Avenida Paulista', N'1234', N'São Paulo', N'01310-100', N'Brazilië')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (26, N'Mohrenstraße', N'37', N'Wenen', N'1010', N'Oostenrijk')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (27, N'Karl Johans gate', N'23', N'Oslo', N'0159', N'Noorwegen')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (28, N'Passeig de Gràcia', N'92', N'Barcelona', N'08008', N'Spanje')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (29, N'Náměstí Republiky', N'5', N'Praag', N'110 00', N'Tsjechische Republiek')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (30, N'Corso Buenos Aires', N'33', N'Milaan', N'20124', N'Italië')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (31, N'Park Lane', N'12', N'Londen', N'W1K 7AF', N'Verenigd Koninkrijk')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (32, N'Rua Augusta', N'1575', N'São Paulo', N'01305-001', N'Brazilië')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (33, N'Fifth Avenue', N'725', N'New York', N'10022', N'Verenigde Staten')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (34, N'Champs-Élysées', N'15', N'Parijs', N'75008', N'Frankrijk')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (35, N'Av. Paulista', N'854', N'São Paulo', N'01310-100', N'Brazilië')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (36, N'Nørrebrogade', N'16', N'Kopenhagen', N'2200', N'Denemarken')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (37, N'Gran Vía', N'34', N'Madrid', N'28013', N'Spanje')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (38, N'Kreuzbergstraße', N'23', N'Berlijn', N'10965', N'Duitsland')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (39, N'Nanluoguxiang', N'5', N'Beijing', N'100009', N'China')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (40, N'Tverskaya Street', N'6', N'Moskow', N'125009', N'Rusland')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (41, N'Hoofdstraat', N'15', N'Amsterdam', N'1012 BX', N'Nederland')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (42, N'Rue du Faubourg Saint-Honoré', N'120', N'Parijs', N'75008', N'Frankrijk')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (43, N'Oxford Street', N'235', N'Londen', N'W1D 2JD', N'Engeland')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (44, N'Unter den Linden', N'1', N'Berlijn', N'10117', N'Duitsland')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (45, N'Passeig de Gràcia', N'92', N'Barcelona', N'08008', N'Spanje')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (46, N'Via dei Condotti', N'1', N'Rome', N'00187', N'Italië')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (47, N'Neuer Wall', N'35', N'Hamburg', N'20354', N'Duitsland')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (48, N'Madison Avenue', N'667', N'New York', N'10065', N'Verenigde Staten')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (49, N'Rue de la Paix', N'12', N'Parijs', N'75002', N'Frankrijk')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (50, N'Rua Oscar Freire', N'999', N'São Paulo', N'01426-001', N'Brazilië')
SET IDENTITY_INSERT [project].[Adres] OFF
GO

SET IDENTITY_INSERT [project].[Gebruiker] ON
GO
INSERT [project].[Gebruiker] ([ID], [username], [voornaam], [familienaam], [email], [telefoonnummer], [creatieDatum], [abonneStart], [aboneeVerval], [beschrijving], [afbeelding], [isVerwijderd], [adresID]) VALUES (1, N'TomBelmans', N'Tom', N'Belmans', N'r0930357@student.thomasmore.be', N'', CAST(N'1980-11-20T00:00:00' AS SmallDateTime), CAST(N'2023-01-01T00:00:00' AS SmallDateTime), CAST(N'2024-01-01T00:00:00' AS SmallDateTime), N'Niet jong, wel gek', N'selfie.jpg', 0, 1)
