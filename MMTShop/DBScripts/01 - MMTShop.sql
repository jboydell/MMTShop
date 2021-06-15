CREATE TABLE dbo.Product (
	ProductSKU varchar(50) NOT NULL,
	ProductCategoryID int NOT NULL,
	ProductName varchar(100) NOT NULL,
	ProductDescription varchar(1000) NOT NULL,
	ProductUnitPrice money NOT NULL
)

CREATE TABLE dbo.ProductCategory (
	ProductCategoryID int NOT NULL, -- This field is not an IDENTITY column so you rely on it's value and use it like an Enum.
	CategoryName varchar(100) NOT NULL
)

ALTER TABLE dbo.ProductCategory ADD CONSTRAINT
	PK_ProductCategory PRIMARY KEY CLUSTERED 
	(
	ProductCategoryID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

INSERT INTO dbo.ProductCategory
SELECT 1, 'Home' UNION
SELECT 2, 'Garden' UNION
SELECT 3, 'Electronic' UNION
SELECT 4, 'Fitness' UNION
SELECT 5, 'Toys'

ALTER TABLE dbo.Product ADD CONSTRAINT
	PK_Product PRIMARY KEY CLUSTERED 
	(
	ProductSKU
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

ALTER TABLE dbo.Product ADD CONSTRAINT
	FK_Product_ProductCategory FOREIGN KEY
	(
	ProductCategoryID
	) REFERENCES dbo.ProductCategory
	(
	ProductCategoryID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
CREATE UNIQUE NONCLUSTERED INDEX IX_ProductCategoryName ON dbo.ProductCategory  -- Category Name should be unique.
	(
	CategoryName
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

INSERT INTO [dbo].[Product] ([ProductSKU],[ProductCategoryID],[ProductName],[ProductDescription],[ProductUnitPrice])
SELECT '10001',1,'3 Seat Sofa','Furniture to Go Cleveland 3 Seater Sofa, Fabric, Nova Anthracite, 209 x 90 x 81 cm',789.99 UNION
SELECT '10002',1,'Tri Pin Side Table','MH London Tri Pin Side Table I Handmade Metal Frame & Natural Mango Wood, Naturally Moisture Resistant, Maintenance Free I 53 cm x 53 cm x 60 cm I Chervey, Black',79.99 UNION
SELECT '10003',1,'Tripod Floor Lamp','Versanora VN-L00002 - Cara Tripod 3 Leg Floor Lamp Reading Light, Copper',99.99 UNION
SELECT '10004',1,'Gold Burst Canvas Print','Rivet Blue Stripes and Gold Burst Canvas Print Wall Art Decor, 36" x 24" (61 x 91 cm)',129.99 UNION
SELECT '20001',2,'Ryobi Mower RLM16E36H','Ryobi RLM16E36H 1600W 36cm Lawnmower',139.99 UNION
SELECT '20002',2,'DEWALT DCM563P1-GB','DEWALT DCM563P1-GB 18 V XR Hedge Trimmer, 1 x 5 Ah, Yellow',188.70 UNION
SELECT '20003',2,'Flymo Electric Grass Trimmer','Flymo Mini Trim ST Electric Grass Trimmer, 230 W, Cutting Width 21 cm',29.99 UNION
SELECT '20004',2,'WEED BURNER','Top of the Range WEED BURNER + 4 Cannisters of Butane',17.99 UNION
SELECT '30001',3,'Apple iPad (10.2-inch, Wi-Fi, 32GB)','2020 Apple iPad (10.2-inch, Wi-Fi, 32GB) - Space Grey (8th Generation)',309.99 UNION
SELECT '30002',3,'Samsung Galaxy Tab A7 32 GB Wi-Fi','Samsung Galaxy Tab A7 32 GB Wi-Fi Android Tablet - Dark Grey (UK Version) ',179.99 UNION
SELECT '30003',3,'Android 10.0 FACETEL Tablets 4GB RAM 64GB','Tablet Android 10.0 FACETEL Tablets 4GB RAM 64GB ROM(Expand to 128G), 1280 * 800 IPS HD Display 5MP+8MP Camera, GMS Certification | 8000mAh | Bluetooth | WiFi | FM, Keyboard and Mouse - Black',119.99 UNION
SELECT '30004',3,'Pritom 7 inch Kids Tablet','Pritom 7 inch Kids Tablet | Quad Core Android,16GB ROM | WiFi,Bluetooth,Dual Camera | Educationl,Games,Parental Control,Kids Software Pre-Installed with Kids-Tablet Case (Light Blue)',50.99 UNION
SELECT '40001',4,'Folding Exercise Bike','Folding Exercise Bike with 10-Level Adjustable Magnetic Resistance | Upright and Recumbent Foldable Stationary Bike is The Perfect Workout Bike for Home Use for Men, Women',169.99 UNION
SELECT '40002',4,'Dripex Magnetic Rowing Machine','Dripex Magnetic Rowing Machine for Home Use, Super Silent Indoor Rower with 15-Level Adjustable Resistance, Double Aluminum Sliding Rail, LCD Monitor Fit for Home Gym, Cardio & Strength Training',319.99 UNION
SELECT '40003',4,'BTM Elliptical Cross Trainer','BTM Elliptical Cross Trainer, Home Cross Machine with LCD Monitor and Pulse Rate Grips Magnetic Smooth Quiet Driven,8 Level Magnetic Resistance, Cardio Workout',193.99 UNION
SELECT '40004',4,'Evolve B1 Motorized Electric treadmill','Evolve B1 Motorized Electric treadmill 3 level manual inclination & Foldable running machine with 12 programs - Bluetooth, speaker, USB Port, AUX - Fitness App for smart phone',289.99 UNION
SELECT '50001',5,'Keel Toys 25cm Signature Cuddle Puppy Husky','Keel Toys 25cm Signature Cuddle Puppy Husky',9.99 UNION
SELECT '50002',5,'Sleeping Dog Hugging Pillow','Vintoys Sleeping Dog Hugging Pillow Stuffed Animals Plush Soft Toy Brown 23.5"',21.99 UNION
SELECT '50003',5,'Pokemon Plush Figures Bulbasaur ','Pokemon Plush Figures | 20 cm Plush Animal | Stuffed Toy, Plush:Bulbasaur',19.99 UNION
SELECT '50004',5,'Galt Toys, Soft Blocks','Galt Toys, Soft Blocks, Stacking Toy, Ages 6 Months Plus',12.99

CREATE TABLE dbo.FeaturedProductCategory (
	ProductCategoryID int NOT NULL
)

ALTER TABLE dbo.FeaturedProductCategory ADD CONSTRAINT
	PK_FeaturedProductCategory PRIMARY KEY CLUSTERED 
	(
	ProductCategoryID
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

ALTER TABLE dbo.FeaturedProductCategory ADD CONSTRAINT
	FK_FeaturedProductCategory_ProductCategory FOREIGN KEY
	(
	ProductCategoryID
	) REFERENCES dbo.ProductCategory
	(
	ProductCategoryID
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 

INSERT INTO dbo.FeaturedProductCategory
SELECT 1 UNION
SELECT 2 UNION
SELECT 3

-- In the future we might want to feature a specific product, so this table will allow us to do that
CREATE TABLE dbo.FeaturedProduct (
	ProductSKU varchar(50) NOT NULL
)

ALTER TABLE dbo.FeaturedProduct ADD CONSTRAINT
	PK_FeaturedProduct PRIMARY KEY CLUSTERED 
	(
	ProductSKU
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

ALTER TABLE dbo.FeaturedProduct ADD CONSTRAINT
	FK_FeaturedProduct_Product FOREIGN KEY
	(
	ProductSKU
	) REFERENCES dbo.Product
	(
	ProductSKU
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO

USE [master]
GO

CREATE LOGIN [MMTShopUser] WITH PASSWORD=N'pRPwHg3ShpscaKpE', DEFAULT_DATABASE=[MMTShop], DEFAULT_LANGUAGE=[us_english], CHECK_EXPIRATION=ON, CHECK_POLICY=ON
GO

-- Not recommended for production but granting top level permission to save time.
ALTER SERVER ROLE [sysadmin] ADD MEMBER [MMTShopUser]
GO
