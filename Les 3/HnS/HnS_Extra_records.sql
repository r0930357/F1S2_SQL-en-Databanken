-- extra klanten
INSERT INTO [HnS].Klant VALUES (17, '  Klabas  ', '  Jef  ', '  Peperstraat  ', '2440', 'Geel', '014 98 78 77', NULL, NULL);
INSERT INTO [HnS].Klant VALUES (18, '  Driesen', '  Antoinette  ', '  Nieuwstraat 15  ', '2400', 'Mol', '014 78 11 77', NULL, NULL);

-- extra producten
INSERT INTO [HnS].[Product] VALUES (217, 1, '   V82D krachtig audiosysteem met BLUETOOTH-technologie   ', 1795.65, 2045.00, 21.00, 0, 0, 0, 0, '2019-06-20');
INSERT INTO [HnS].[Product] VALUES (218, 1, ' V82E krachtig audiosysteem met BLUETOOTH-technologie', 1795.65, 2145.00, 21.00, 10, 50, 0, 0, '2019-06-20');

-- extra kolom
ALTER TABLE HnS.Klant
	ADD volledigeNaam VARCHAR(100) NULL;
GO

INSERT INTO [HnS].[Klant] VALUES (27,'   peeters','jef','peperstraat 15   ','2440','  geel',NULL,NULL,'   jef.peeters@hns.be',NULL);
INSERT INTO [HnS].[Klant] VALUES (28,'klAbas   ','jEF','   nieuwstraat 45A','2440','GEEL   ',NULL,NULL,'jef.klabas@hns.be   ',NULL);
INSERT INTO [HnS].[Klant] VALUES (29,'   peeters   ','karla  ','peperstraat 15','2440','  geel  ',NULL,NULL,NULL,NULL);
INSERT INTO [HnS].[Klant] VALUES (30,'  klAbas  ','  marjan  ','nieuwstraat 45A','2440','GEEL',NULL,NULL,NULL,NULL);
