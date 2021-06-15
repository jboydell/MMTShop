SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [dbo].[spsSelectFeaturedProducts]

AS

SELECT P.*
FROM
dbo.FeaturedProductCategory FPC
	INNER JOIN dbo.Product P ON FPC.ProductCategoryID = P.ProductCategoryID
UNION
SELECT P.*
FROM
dbo.FeaturedProduct FP
	INNER JOIN dbo.Product P ON FP.ProductSKU = P.ProductSKU
GO

/*
EXEC dbo.spsSelectFeaturedProducts
*/
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [dbo].[spsSelectCategories]

AS

SELECT * 
FROM
dbo.ProductCategory
ORDER BY
ProductCategoryID
GO

/*
EXEC dbo.spsSelectCategories
*/
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [dbo].[spsSelectProductsbyCategory]

@ProductCategoryID int

AS

SELECT * 
FROM
dbo.Product
WHERE
ProductCategoryID = @ProductCategoryID
GO

/*
EXEC dbo.spsSelectProductsbyCategory 1
EXEC dbo.spsSelectProductsbyCategory 2
EXEC dbo.spsSelectProductsbyCategory 3
EXEC dbo.spsSelectProductsbyCategory 4
EXEC dbo.spsSelectProductsbyCategory 5
*/
GO
