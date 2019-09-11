--Use este código para criar um função de particionamento
USE SBSChp4TSQL
CREATE PARTITION FUNCTION fnPOOrderDate (datetime)
AS RANGE LEFT
FOR VALUES('20051231','20061231', '20071231','20081231')

--Use este código para criar uma função de particionamento
USE SBSChp4TSQL
CREATE PARTITION SCHEME schPOOorderDate
AS PARTITION fnPOOrderDate
TO(Sales2005, Sales2006, Sales2007, Sales2008, Sales2009)--Sales seriam os filegroups

--Particionando uma tabela
USE SBSChp4TSQL

IF(OBJECT_ID('dbo.PurchaseOrderHeader')) IS NOT NULL
	DROP TABLE dbo.PurchaseOrderHeader

GO
CREATE TABLE dbo.PurchaseOrderHeader(
	PurchaseOrderID INT NOT NULL,
	RevisionNumber TINYINT NOT NULL,
	Status TINYINT NOT NULL,
	OrderDate DATETIME NOT NULL,
	ModifieldDate DATETIME NOT NULL
)ON schPOOorderDate(OrderDate)
