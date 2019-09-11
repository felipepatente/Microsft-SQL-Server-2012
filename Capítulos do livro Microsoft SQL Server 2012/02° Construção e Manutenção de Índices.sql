--Use este script para criar um indice clusterizado (Não pode ter mais de 1 indice por tabela)
USE SBSChp4TSQL
CREATE CLUSTERED INDEX CIX_Address_PostTime_StreetAddress
ON HumanResources.Address(
	StreetAddress DESC
)
--Só vai funcionar se já existir essa indice na tabela
WITH(DROP_EXISTING = ON)

--Criando um indice com opções
CREATE CLUSTERED INDEX CIX_Address_PostTime_StreetAddress
ON HumanResources.Address(
	StreetAddress DESC
)
WITH(DROP_EXISTING = ON, SORT_IN_TEMPDB = ON, FILLFACTOR = 80, PAD_INDEX = ON)

--Use este script para criar um indice não clusterizado
CREATE NONCLUSTERED INDEX IX_Address_StreetAddress
ON HumanResources.Address
(
	StreetAddress
)


--Use este script para adicionar colunas incluidas a um índice
CREATE NONCLUSTERED INDEX IX_SalesOrderHeader_FirstName
ON HumanResources.Employee
(
	FirstName
)
INCLUDE(MiddleName, LastName)

--Use esse script para adicionar um filtro a um indice
CREATE NONCLUSTERED INDEX IX_SalesOrderHeader_FirstName
ON HumanResources.Employee
(
	FirstName
)
INCLUDE(MiddleName, LastName)
WHERE(LastName = 0)

--Use esse scritp para desabilitar um índice
ALTER INDEX IX_SalesOrderHeader_FirstName
	ON HumanResources.Employee DISABLE

--Use esse scritp para remover um índice
DROP INDEX IX_SalesOrderHeader_FirstName
	ON HumanResources.Employee

SELECT * FROM HumanResources.Employee
