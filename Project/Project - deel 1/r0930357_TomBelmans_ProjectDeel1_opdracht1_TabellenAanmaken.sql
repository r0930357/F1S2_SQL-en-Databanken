-- Tom Belmans, r0930357

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
    datum date NOT NULL,
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