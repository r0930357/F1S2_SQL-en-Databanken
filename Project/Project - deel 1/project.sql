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
    creatieDatum date NOT NULL,
    abonneStart date NULL,
    aboneeVerval date NULL,
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
    fabrikant varchar(100) NOT NULL,
    naam varchar(255) NOT NULL,
    beschrijving varchar(4000) NOT NULL,
    afbeelding varchar(50) NULL,
    creatieDatum date NOT NULL,
    levertijd int NULL,
    weblink varchar(255) NULL,
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
    inhoud varchar(2000) NOT NULL,
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
    koperID int NULL,
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
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (1, 'Kleinhoefstraat', '4', 'Geel', '2440', 'België')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (2, 'Dorpstraat', '15', 'Antwerpen', '2000', 'België')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (3, 'Schoolstraat', '23', 'Gent', '9000', 'België')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (4, 'Marktplein', '8', 'Brussel', '1000', 'België')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (5, 'Kerkstraat', '11', 'Leuven', '3000', 'België')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (6, 'Hoofdstraat', '42', 'Hasselt', '3500', 'België')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (7, 'Binnenweg', '17', 'Brugge', '8000', 'België')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (8, 'Korte Kerkstraat', '3', 'Veurne', '8630', 'België')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (9, 'Groenstraat', '21', 'Lier', '2500', 'België')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (10, 'Grote Markt', '7', 'Oostende', '8400', 'België')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (11, 'Spoorwegstraat', '32', 'Dendermonde', '9200', 'België')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (12, 'Kapellestraat', '13', 'Turnhout', '2300', 'België')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (13, 'Parkstraat', '14', 'Den Haag', '2514', 'Nederland')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (14, 'Rue du Midi', '22', 'Brussel', '1000', 'België')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (15, 'Via Roma', '7', 'Milaan', '20121', 'Italë')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (16, 'Friedrichstraße', '43', 'Berlijn', '10969', 'Duitsland')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (17, 'Gran Vía', '25', 'Madrid', '28013', 'Spanje')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (18, 'Moulin de la Rousselière', '5', 'Nantes', '44300', 'Frankrijk')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (19, 'Strøget', '15', 'København', '1160', 'Denemarken')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (20, 'Rua do Ouro', '49', 'Lissabon', '1100-064', 'Portugal')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (21, 'Kungsgatan', '8', 'Stockholm', '111 43', 'Zweden')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (22, 'Flinders Street', '100', 'Melbourne', '3000', 'Australië')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (23, 'Mohrenstraße', '37', 'Wenen', '1010', 'Oostenrijk')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (24, 'Karl Johans gate', '23', 'Oslo', '0159', 'Noorwegen')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (25, 'Passeig de Gràcia', '92', 'Barcelona', '08008', 'Spanje')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (26, 'Náměstí Republiky', '5', 'Praag', '110 00', 'Tsjechische Republiek')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (27, 'Corso Buenos Aires', '33', 'Milaan', '20124', 'Italië')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (28, 'Park Lane', '12', 'Londen', 'W1K 7AF', 'Verenigd Koninkrijk')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (29, 'Champs-Élysées', '15', 'Parijs', '75008', 'Frankrijk')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (30, 'Nørrebrogade', '16', 'Kopenhagen', '2200', 'Denemarken')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (31, 'Gran Vía', '34', 'Madrid', N'28013', 'Spanje')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (32, 'Kreuzbergstraße', '23', 'Berlijn', '10965', 'Duitsland')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (33, 'Hoofdstraat', '15', 'Amsterdam', '1012 BX', 'Nederland')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (34, 'Rue du Faubourg Saint-Honoré', '120', 'Parijs', '75008', 'Frankrijk')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (35, 'Oxford Street', '235', 'Londen', 'W1D 2JD', 'Engeland')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (36, 'Unter den Linden', '1', 'Berlijn', '10117', 'Duitsland')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (37, 'Passeig de Gràcia', '92', 'Barcelona', '08008', 'Spanje')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (38, 'Via dei Condotti', '1', 'Rome', '00187', 'Italië')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (39, 'Neuer Wall', '35', 'Hamburg', '20354', 'Duitsland')
INSERT [project].[Adres] ([ID], [straat], [huisnummer], [gemeente], [postcode], [land]) VALUES (40, 'Meir', '45 bus 2', 'Antwerpen', '2000', 'België')
SET IDENTITY_INSERT [project].[Adres] OFF
GO

SET IDENTITY_INSERT [project].[Gebruiker] ON
GO
INSERT [project].[Gebruiker] ([ID], [username], [voornaam], [familienaam], [email], [telefoonnummer], [creatieDatum], [abonneStart], [aboneeVerval], [beschrijving], [afbeelding], [isVerwijderd], [adresID]) VALUES (1, 'r0930357', 'Tom', 'Belmans', 'r0930357@student.thomasmore.be', '', '1980-11-20', '2023-01-01', '2024-01-01', 'Niet jong, wel gek', 'selfie.jpg', 0, 1);
INSERT [project].[Gebruiker] ([ID], [username], [voornaam], [familienaam], [email], [telefoonnummer], [creatieDatum], [abonneStart], [aboneeVerval], [beschrijving], [afbeelding], [isVerwijderd], [adresID]) VALUES (2, 'reduf55', 'Reinhout', 'Dufour', 'rdufour55@pandora.be', '0498238244', '1993-04-08', '', '', 'Waarom zijn de bananen krom?', 'rd_me.jpg', 0, 1);
INSERT [project].[Gebruiker] ([ID], [username], [voornaam], [familienaam], [email], [telefoonnummer], [creatieDatum], [abonneStart], [aboneeVerval], [beschrijving], [afbeelding], [isVerwijderd], [adresID]) VALUES (3, 'juliahn', 'Julia', 'Michaels', 'juliahnmusic@gmail.com', '310-691-4489', '2015-01-01', '', '', 'I have no issues, or do I?', 'juliahn.jpg', 0, 2);
INSERT [project].[Gebruiker] ([ID], [username], [voornaam], [familienaam], [email], [telefoonnummer], [creatieDatum], [abonneStart], [aboneeVerval], [beschrijving], [afbeelding], [isVerwijderd], [adresID]) VALUES (4, 'taylorswift', 'Taylor', 'Swift', 'tswift@taylorswift.com', '615-555-5555', '2006-01-01', '', '', 'Folklore', 'taylorswift.jpg', 0, 3);
INSERT [project].[Gebruiker] ([ID], [username], [voornaam], [familienaam], [email], [telefoonnummer], [creatieDatum], [abonneStart], [aboneeVerval], [beschrijving], [afbeelding], [isVerwijderd], [adresID]) VALUES (5, 'queen', 'Freddie', 'Mercury', 'freddie@queen.com.uk', '020-7734-8932', '1956-08-01', '', '', 'Beelzebub has a devil put aside for me', 'freddie.jpg', 1, 4);
INSERT [project].[Gebruiker] ([ID], [username], [voornaam], [familienaam], [email], [telefoonnummer], [creatieDatum], [abonneStart], [aboneeVerval], [beschrijving], [afbeelding], [isVerwijderd], [adresID]) VALUES (6, 'theKing', 'Elvis', 'Presley', 'elvis@elvismusic.com', '901-332-3329', '1954-01-01', '', '', 'I love music and hamburgers', 'elvis.jpg', 1, 5);
INSERT [project].[Gebruiker] ([ID], [username], [voornaam], [familienaam], [email], [telefoonnummer], [creatieDatum], [abonneStart], [aboneeVerval], [beschrijving], [afbeelding], [isVerwijderd], [adresID]) VALUES (7, 'theking2', 'Michael', 'Jackson', 'mjackson@neverland.com', '310-859-7500', '1964-01-01', '', '', 'Thriller', 'michaeljackson.jpg', 1, 6);
INSERT [project].[Gebruiker] ([ID], [username], [voornaam], [familienaam], [email], [telefoonnummer], [creatieDatum], [abonneStart], [aboneeVerval], [beschrijving], [afbeelding], [isVerwijderd], [adresID]) VALUES (8, 'TheQueenOfPop', 'Madonna', 'Ciccone', 'madonna@lmcvrecords.com', '612-764-0850', '1958-08-16', '', '', 'I sing like a virgin, I look like Billy the puppet (Saw)', 'madonna.jpg', 1, 7);
INSERT [project].[Gebruiker] ([ID], [username], [voornaam], [familienaam], [email], [telefoonnummer], [creatieDatum], [abonneStart], [aboneeVerval], [beschrijving], [afbeelding], [isVerwijderd], [adresID]) VALUES (9, 'INSERT_SYMBOL', 'Prince', 'Nelson', 'prince@paisley.com', '612-764-0850', '1978-01-01', '1978-02-01', '2016-04-21', 'Purple Rain Like its 1999', 'prince.jpg', 1, 7);
INSERT [project].[Gebruiker] ([ID], [username], [voornaam], [familienaam], [email], [telefoonnummer], [creatieDatum], [abonneStart], [aboneeVerval], [beschrijving], [afbeelding], [isVerwijderd], [adresID]) VALUES (10, 'yokos_beatle', 'John', 'Lennon', 'johnlennon@thebeatles.com', '020-7361-7676', '1960-01-01', '', '', 'Sergant Peppers trooper', 'johnlennon.jpg', 1, 8);
INSERT [project].[Gebruiker] ([ID], [username], [voornaam], [familienaam], [email], [telefoonnummer], [creatieDatum], [abonneStart], [aboneeVerval], [beschrijving], [afbeelding], [isVerwijderd], [adresID]) VALUES (11, 'nirvana', 'Kurt', 'Cobain', 'kcobain@nirvana.com', '206-302-6957', '1987-01-01', '', '', 'I made some mind-blowing music', 'kurdtcobain.jpg', 1, 9);
SET IDENTITY_INSERT [project].[Gebruiker] OFF
GO

SET IDENTITY_INSERT [project].[Product] ON
GO
INSERT [project].[Product] ([ID], [fabrikant], [naam], [beschrijving], [afbeelding], [creatieDatum], [levertijd], [weblink], [serienummer], [isBeschikbaar]) VALUES (1, 'Samsung', 'Galaxy S23', 'Een premium design met een duurzame touch, dat is wat je krijgt met de Galaxy S23. Deze nieuwste Samsung Galaxy smartphone is helemaal afgestemd op jouw stijl en wat jij belangrijk vindt. Het design is geïnspireerd op de natuur en deels ontworpen met eco-vriendelijke materialen en het besturingssysteem is precies naar jouw wens te personaliseren dankzij de nieuwe One UI 5 update.', 'SamsungGalaxyS23.jpg', '2023-03-01', 7, 'https://www.samsung.com/be/smartphones/galaxy-s23/', 'R3CNA0DA7MM', 1)
INSERT [project].[Product] ([ID], [fabrikant], [naam], [beschrijving], [afbeelding], [creatieDatum], [levertijd], [weblink], [serienummer], [isBeschikbaar]) VALUES (2, 'Apple', 'iPhone 14', 'De nieuwe iPhone 14 is het meest geavanceerde toestel ooit gemaakt door Apple. Met een strak design, razendsnelle processor en een prachtig OLED-scherm is dit de perfecte smartphone voor de veeleisende gebruiker. De camera is voorzien van de nieuwste technologieën en maakt de mooiste fotos en videos. Dankzij de lange batterijduur hoef je je geen zorgen te maken over lege accus.', 'iPhone14.jpg', '2023-03-08', 5, 'https://www.apple.com/nl/iphone-14/', '9TGBNHY67UJ', 1)
INSERT [project].[Product] ([ID], [fabrikant], [naam], [beschrijving], [afbeelding], [creatieDatum], [levertijd], [weblink], [serienummer], [isBeschikbaar]) VALUES (3, 'Apple', 'iPhone 14 Pro', 'De iPhone 14 Pro is de nieuwste smartphone van Apple en beschikt over een schitterend OLED-scherm en de krachtige A18-processor. Met de nieuwe ProMotion-technologie wordt het scherm automatisch aangepast op de inhoud en geniet je van soepele beelden. Dankzij de nieuwe iOS 16-update is de iPhone 14 Pro nog sneller en efficiënter in gebruik.', 'iPhone14Pro.jpg', '2023-03-05', 10, 'https://www.apple.com/nl/iphone-14-pro/', 'T6YHD2A92ZT', 1)
INSERT [project].[Product] ([ID], [fabrikant], [naam], [beschrijving], [afbeelding], [creatieDatum], [levertijd], [weblink], [serienummer], [isBeschikbaar]) VALUES (4, 'Sony', 'Xperia Z10', 'De Xperia Z10 is de ideale smartphone voor de echte multimedia-liefhebber. Dankzij de 4K HDR OLED-schermtechnologie geniet je van de beste beeldkwaliteit en met de 3D Surround Sound-speakers ben je verzekerd van de beste geluidskwaliteit. Daarnaast is de Xperia Z10 ook nog eens stof- en waterdicht en beschikt het over een lange batterijduur.', 'XperiaZ10.jpg', '2023-02-28', 5, 'https://www.sony.nl/electronics/smartphones/xperia-z10', 'K9DJB3F8XLW', 0);
INSERT [project].[Product] ([ID], [fabrikant], [naam], [beschrijving], [afbeelding], [creatieDatum], [levertijd], [weblink], [serienummer], [isBeschikbaar]) VALUES (5, 'Dell', 'XPS 15', 'De XPS 15 is een krachtige en stijlvolle laptop van Dell. Het 15,6-inch 4K OLED-scherm zorgt voor haarscherpe beelden en de nieuwste Intel Core i9-processor zorgt voor ongekende prestaties. Dankzij de lange batterijduur en het lichtgewicht design is de XPS 15 perfect voor onderweg.', 'XPS15.jpg', '2023-03-08', '3', 'https://www.dell.com/nl-nl/shop/laptops/nieuwe-xps-15-laptop/spd/xps-15-9720-laptop', 'F1HJU6B4KTY', 1);
INSERT [project].[Product] ([ID], [fabrikant], [naam], [beschrijving], [afbeelding], [creatieDatum], [levertijd], [weblink], [serienummer], [isBeschikbaar]) VALUES (6, 'Lenovo', 'ThinkPad X1 Carbon', 'De ThinkPad X1 Carbon is de ideale laptop voor zakelijke gebruikers. De laptop is uitgerust met een krachtige Intel Core i7-processor, heeft een lange batterijduur en is extreem licht en dun. Daarnaast beschikt de laptop over verschillende beveiligingsfuncties en is het toetsenbord spatwaterdicht.', 'ThinkPadX1Carbon.jpg', '2023-03-06', 5, 'https://www.lenovo.com/nl/nl/laptops/thinkpad/x1-series/X1-Carbon-Gen-10/p/22TP2X1X1C0', 'S7VLA9P2CQF', 1);
INSERT [project].[Product] ([ID], [fabrikant], [naam], [beschrijving], [afbeelding], [creatieDatum], [levertijd], [weblink], [serienummer], [isBeschikbaar]) VALUES (7, 'Dell', 'UltraSharp U3219Q', 'De Dell UltraSharp U3219Q is een 32-inch monitor met 4K-resolutie en HDR-ondersteuning voor een geweldige beeldkwaliteit. Het scherm biedt 99% sRGB-kleurdekking en ondersteunt meerdere kleurruimten, waardoor het ideaal is voor creatieve professionals. Daarnaast heeft de monitor een USB-C-poort voor eenvoudige aansluiting op laptops en andere apparaten.', 'UltraSharpU3219Q.jpg', '2023-03-07', 3, 'https://www.dell.com/nl-nl/shop/dell-ultrasharp-32-4k-usb-c-monitor-u3219q/apd/210-arni/monitoren-monitor-accessoires', 'G5HNF3B6YHT', 0);
INSERT [project].[Product] ([ID], [fabrikant], [naam], [beschrijving], [afbeelding], [creatieDatum], [levertijd], [weblink], [serienummer], [isBeschikbaar]) VALUES (8, 'HP', 'Z34c', 'De HP Z34c is een prachtige curved monitor die je volledig onderdompelt in je werk en entertainment. Met een diagonaal van 34 inch en een resolutie van 3440 x 1440 pixels geniet je van haarscherpe beelden en dankzij de gebogen vormgeving heb je een breder gezichtsveld. De monitor beschikt over diverse aansluitmogelijkheden, waaronder HDMI, DisplayPort en USB-C.', 'HPZ34c.jpg', '2023-03-07', 3, 'https://store.hp.com/NetherlandsStore/Merch/Product.aspx?id=3JU92AA&opt=ABB&sel=DEF', 'Q2ZGR7A15D9', 0);
INSERT [project].[Product] ([ID], [fabrikant], [naam], [beschrijving], [afbeelding], [creatieDatum], [levertijd], [weblink], [serienummer], [isBeschikbaar]) VALUES (9, 'ASUS', 'ROG Strix G15 Advantage Edition', 'De ROG Strix G15 Advantage Edition is een krachtige gaming desktop computer met een AMD Ryzen 9 5900HX processor en een AMD Radeon RX 6800M grafische kaart. Hierdoor is de computer geschikt voor de nieuwste games en videobewerking. Met de Aura Sync RGB-verlichting creëer je een unieke sfeer en dankzij de ROG audio-technologie ervaar je het beste geluid tijdens het gamen.', 'ROGStrixG15AdvantageEdition.jpg', '2023-03-08', 10, 'https://www.asus.com/nl/Desktops/ROG-Strix-G15-Advantage-Edition/', 'F5HBC1E6ZAD', 1);
INSERT [project].[Product] ([ID], [fabrikant], [naam], [beschrijving], [afbeelding], [creatieDatum], [levertijd], [weblink], [serienummer], [isBeschikbaar]) VALUES (10, 'LG', 'OLED55C14LB', '55 inch LG OLED TV met 4K resolutie en HDR', 'LG55C14LB.jpg', '2022-02-15', 7, 'https://www.example.com/lg-oled-tv', 'TV123456', 0);
INSERT [project].[Product] ([ID], [fabrikant], [naam], [beschrijving], [afbeelding], [creatieDatum], [levertijd], [weblink], [serienummer], [isBeschikbaar]) VALUES (11, 'Samsung', 'QLED 4K Smart TV Q65C', 'Een ultramoderne televisie met een verbluffend 4K QLED-scherm en geavanceerde functies zoals Quantum HDR en Adaptive Sound+', 'Samsung_Q65C.jpg', '2023-03-09', 3, 'https://www.example.com/samsung-tv', 'TV987654', 1);
INSERT [project].[Product] ([ID], [fabrikant], [naam], [beschrijving], [afbeelding], [creatieDatum], [levertijd], [weblink], [serienummer], [isBeschikbaar]) VALUES (12, 'Samsung', 'QLED 8K Smart TV Q800A', 'Een ultramoderne televisie met een verbluffend 8K QLED-scherm en geavanceerde functies zoals Quantum HDR en Adaptive Sound+', 'Samsung_Q800A.jpg', '2023-03-09', 5, 'https://www.example.com/samsung-tv-q800a', 'TV123456', 1);
INSERT [project].[Product] ([ID], [fabrikant], [naam], [beschrijving], [afbeelding], [creatieDatum], [levertijd], [weblink], [serienummer], [isBeschikbaar]) VALUES (13, 'Apple', 'iPad Air', 'Een krachtige tablet met een 10,9 inch Liquid Retina-display, A14 Bionic-chip en ondersteuning voor Apple Pencil en Magic Keyboard.', 'Apple_iPad_Air.jpg', '2023-03-09', 2, 'https://www.example.com/ipad-air', 'IPAD789012', 1);
INSERT [project].[Product] ([ID], [fabrikant], [naam], [beschrijving], [afbeelding], [creatieDatum], [levertijd], [weblink], [serienummer], [isBeschikbaar]) VALUES (14, 'Apple', 'iPad Pro 12.9-inch', 'Een krachtige en veelzijdige tablet met een 12,9-inch Retina-display en een A14 Bionic-chip.', 'Apple_iPad_Pro_12.9-inch.jpg', '2023-03-09', 2, 'https://www.example.com/ipad-pro-12-9-inch', 'TAB234567', 1);
INSERT [project].[Product] ([ID], [fabrikant], [naam], [beschrijving], [afbeelding], [creatieDatum], [levertijd], [weblink], [serienummer], [isBeschikbaar]) VALUES (15, 'Samsung', 'Galaxy Tab S7', 'Een krachtige tablet met een groot 11 inch scherm en een snelle Snapdragon 865 Plus processor', 'Samsung_Tab_S7.jpg', '2023-03-09', 2, 'https://www.example.com/samsung-tablet-s7', 'TAB654321', 1);
INSERT [project].[Product] ([ID], [fabrikant], [naam], [beschrijving], [afbeelding], [creatieDatum], [levertijd], [weblink], [serienummer], [isBeschikbaar]) VALUES (16, 'Sennheiser', 'Momentum True Wireless 2', 'Premium draadloze oordopjes met Active Noise Cancellation en kristalhelder geluid', 'Sennheiser_Momentum_True_Wireless_2.jpg', '2023-03-09', 2, 'https://www.example.com/sennheiser-earbuds', 'SE789012', 1);
INSERT [project].[Product] ([ID], [fabrikant], [naam], [beschrijving], [afbeelding], [creatieDatum], [levertijd], [weblink], [serienummer], [isBeschikbaar]) VALUES (17, 'Apple', 'AirPods Pro', 'Volledig draadloze oortjes met actieve ruisonderdrukking en transparantie-modus. Werkt perfect samen met alle Apple-devices.', 'AirPods_Pro.jpg', '2023-03-09', 2, 'https://www.example.com/airpods-pro', 'AP987654', 0);
INSERT [project].[Product] ([ID], [fabrikant], [naam], [beschrijving], [afbeelding], [creatieDatum], [levertijd], [weblink], [serienummer], [isBeschikbaar]) VALUES (18, 'Bose', 'QuietComfort 45 Wireless Headphones', 'Een premium set van noise-cancelling draadloze hoofdtelefoons met een indrukwekkende geluidskwaliteit en een comfortabel ontwerp', 'Bose_QC45.jpg', '2023-03-09', 2, 'https://www.example.com/bose-qc45', 'BH654321', 1);
INSERT [project].[Product] ([ID], [fabrikant], [naam], [beschrijving], [afbeelding], [creatieDatum], [levertijd], [weblink], [serienummer], [isBeschikbaar]) VALUES (19, 'Sony', 'PlayStation 5', 'Een krachtige gaming console met geavanceerde hardware en high-performance games', 'Sony_PS5.jpg', '2023-03-09', 2, 'https://www.example.com/sony-ps5', 'PS512345', 1);
INSERT [project].[Product] ([ID], [fabrikant], [naam], [beschrijving], [afbeelding], [creatieDatum], [levertijd], [weblink], [serienummer], [isBeschikbaar]) VALUES (20, 'Sony', 'PlayStation 4', 'Een krachtige spelcomputer met uitstekende grafische prestaties en een breed scala aan games en entertainmentopties.', 'Sony_PS4.jpg', '2023-03-09', 2, 'https://www.example.com/ps4', 'PS4123456', 0);
INSERT [project].[Product] ([ID], [fabrikant], [naam], [beschrijving], [afbeelding], [creatieDatum], [levertijd], [weblink], [serienummer], [isBeschikbaar]) VALUES (21, 'Dell', 'Optiplex 7070', 'Veelzijdig en flexibel: De OptiPlex 7070 heeft een compact ontwerp dat gemakkelijk in uw werkruimte past, zich aanpast aan uw werkstijl en uw desktopomgeving maximaliseert. Voeg de optionele Small Form Factor All-in-One Stand met een kabelafdekking toe voor een opgeruimde werkomgeving. Verantwoord gebouwd: de OptiPlex 7070 Tower is gebouwd met maximaal 39%1 van post-consumer gerecycleerde kunststoffen.', 'DellOptiplex7070.jpg', '2022-01-01', 14, 'https://www.example.com/desktop', 'PC123456', 1);
INSERT [project].[Product] ([ID], [fabrikant], [naam], [beschrijving], [afbeelding], [creatieDatum], [levertijd], [weblink], [serienummer], [isBeschikbaar]) VALUES (22, 'Samsung', '870 EVO SSD', 'Een krachtige en betrouwbare solid state drive (SSD) met een opslagcapaciteit van 1TB en lees- en schrijfsnelheden van respectievelijk 560MB/s en 530MB/s.', 'Samsung_870_EVO.jpg', '2023-03-09', 2, 'https://www.example.com/samsung-ssd-870-evo', 'SSD987654', 1);
INSERT [project].[Product] ([ID], [fabrikant], [naam], [beschrijving], [afbeelding], [creatieDatum], [levertijd], [weblink], [serienummer], [isBeschikbaar]) VALUES (23, 'Kingston', 'A2000 M.2 NVMe SSD', 'Een snelle en betrouwbare solid-state drive in een compacte M.2-vormfactor, met een hoge lees- en schrijfsnelheid van respectievelijk 2200MB/s en 2000MB/s.', 'kingston-a2000-m2.jpg', '2023-03-09', 2, 'https://www.example.com/kingston-a2000-m2', 'SSD789012', 1);
INSERT [project].[Product] ([ID], [fabrikant], [naam], [beschrijving], [afbeelding], [creatieDatum], [levertijd], [weblink], [serienummer], [isBeschikbaar]) VALUES (24, 'Intel', 'Core i9 Gen 12 Processor', 'Een krachtige processor van Intel, ontworpen voor ultieme prestaties in de meest veeleisende toepassingen en workflows', 'intel_i9_gen12.jpg', '2023-03-09', 1, 'https://www.example.com/intel-i9-gen12', 'PR987654', 0);
INSERT [project].[Product] ([ID], [fabrikant], [naam], [beschrijving], [afbeelding], [creatieDatum], [levertijd], [weblink], [serienummer], [isBeschikbaar]) VALUES (25, 'AMD', 'Ryzen 9 6990X', 'De nieuwste generatie Ryzen-processor met 32 cores en 64 threads, waardoor hij perfect is voor multitasking en veeleisende toepassingen zoals videobewerking en gaming.', 'AMD_Ryzen_9_6990X.jpg', '2022-10-09', 2, 'https://www.example.com/amd-ryzen-9-6990x', 'RYZ123456', 1);
INSERT [project].[Product] ([ID], [fabrikant], [naam], [beschrijving], [afbeelding], [creatieDatum], [levertijd], [weblink], [serienummer], [isBeschikbaar]) VALUES (26, 'Nvidia', 'GeForce RTX 4080', 'Een high-end videokaart met de nieuwste Ampere-architectuur en 48 GB GDDR6-geheugen, geschikt voor de meest veeleisende toepassingen en games.', 'nvidia-rtx-4080.jpg', '2023-01-02', 2, 'https://www.example.com/nvidia-rtx-4080', 'GPU987654', 1);
INSERT [project].[Product] ([ID], [fabrikant], [naam], [beschrijving], [afbeelding], [creatieDatum], [levertijd], [weblink], [serienummer], [isBeschikbaar]) VALUES (27, 'AMD', 'Radeon RX 6900 XT', 'De nieuwste generatie AMD grafische kaart met 80 Compute Units, 16GB GDDR6-geheugen en PCIe 4.0-ondersteuning', 'AMD_Radeon_RX_6900_XT.jpg', '2022-09-01', 2, 'https://www.example.com/amd-rx-6900-xt', 'VC987654', 0);
INSERT [project].[Product] ([ID], [fabrikant], [naam], [beschrijving], [afbeelding], [creatieDatum], [levertijd], [weblink], [serienummer], [isBeschikbaar]) VALUES (28, 'Nvidia', 'Quadro RTX 6000', 'Een krachtige en geavanceerde videokaart van de nieuwste generatie, speciaal ontworpen voor professionele workflows zoals 3D-modellering, animatie en rendering', 'nvidia_quadro_rtx_6000.jpg', '2023-01-01', 7, 'https://www.example.com/nvidia-quadro-rtx-6000', 'QGC237654A', 0);
INSERT [project].[Product] ([ID], [fabrikant], [naam], [beschrijving], [afbeelding], [creatieDatum], [levertijd], [weblink], [serienummer], [isBeschikbaar]) VALUES (29, 'ASUS', 'ROG Maximus XIV Extreme', 'Een hoogwaardig moederbord van de nieuwste generatie met ondersteuning voor de nieuwste Intel Core-processors en DDR4-geheugen, met geavanceerde overklokmogelijkheden en uitgebreide connectiviteitsopties.', 'ASUS_ROG_Maximus_XIV_Extreme.jpg', '2022-10-10', 2, 'https://www.example.com/asus-moederbord', 'MB45DD89', 1);
INSERT [project].[Product] ([ID], [fabrikant], [naam], [beschrijving], [afbeelding], [creatieDatum], [levertijd], [weblink], [serienummer], [isBeschikbaar]) VALUES (30, 'MSI', 'MPG B560I GAMING EDGE WIFI', 'Een high-performance Mini-ITX-moederbord met de nieuwste Intel B560 chipset en ondersteuning voor PCIe 4.0.', 'msi-b560i-gaming-edge-wifi.jpg', '2022-11-09', 2, 'https://www.example.com/msi-motherboard-b560i', 'MB789012', 1);
SET IDENTITY_INSERT [project].[Product] OFF
GO

SET IDENTITY_INSERT [project].[Aanbod] ON
GO

-- productStatus: nieuw in verpakking, nieuwstaat, gebruikt, defect
INSERT [project].[Aanbod] ([ID], [prijs], [productAfbeelding], [productStatus], [isGereserveerd], [productID], [koperID], [verkoperID]) VALUES (1, 1000, 'afbeelding1.jpg', 'nieuwstaat', 0, 3, 1, 10);

SET IDENTITY_INSERT [project].[Aanbod] OFF
GO

