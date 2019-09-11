--PARA FAZER UMA COMPACTAÇÃO DE PAGINA É SÓ MUDAR O VALOR DE "ROW" PARA "PAGE"
--Use este código para compactar a tabela HumanResources.Employee
ALTER TABLE HumanResources.Employee
	REBUILD WITH(DATA_COMPRESSION = ROW)


--Use este código para compactar um índice não clusterizado na tabela HumanResources.Address
ALTER INDEX IX_Address_StreetAddress
	ON HumanResources.Address
	REBUILD WITH(DATA_COMPRESSION = ROW)


--Use este código para fazer a compactação de linha de uma tabela durante a criação
CREATE TABLE HumanResources.Department
(
	ID INT PRIMARY KEY,
	FirstName VARCHAR(50),
	LastName VARCHAR(50),
	BirthDate DATETIME
)
WITH (DATA_COMPRESSION = ROW)