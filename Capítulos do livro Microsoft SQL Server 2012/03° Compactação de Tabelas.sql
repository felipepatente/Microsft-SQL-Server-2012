--PARA FAZER UMA COMPACTA��O DE PAGINA � S� MUDAR O VALOR DE "ROW" PARA "PAGE"
--Use este c�digo para compactar a tabela HumanResources.Employee
ALTER TABLE HumanResources.Employee
	REBUILD WITH(DATA_COMPRESSION = ROW)


--Use este c�digo para compactar um �ndice n�o clusterizado na tabela HumanResources.Address
ALTER INDEX IX_Address_StreetAddress
	ON HumanResources.Address
	REBUILD WITH(DATA_COMPRESSION = ROW)


--Use este c�digo para fazer a compacta��o de linha de uma tabela durante a cria��o
CREATE TABLE HumanResources.Department
(
	ID INT PRIMARY KEY,
	FirstName VARCHAR(50),
	LastName VARCHAR(50),
	BirthDate DATETIME
)
WITH (DATA_COMPRESSION = ROW)