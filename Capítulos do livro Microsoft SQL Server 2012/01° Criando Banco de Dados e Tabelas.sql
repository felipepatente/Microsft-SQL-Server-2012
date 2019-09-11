--Use este script para criar um banco de dados com T-SQL
USE master
CREATE DATABASE SBSChp4TSQL
ON PRIMARY
(NAME='SBSChp4TSQL1', FILENAME='C:\SQLDATA\SBSTSQL1.mdf', SIZE=10MB,
MAXSIZE=20, FILEGROWTH=10%)
LOG ON
(NAME='SBSChp4TSQL_log', FILENAME='C:\SQLLog\SBSTSQL_log.ldf',SIZE=10MB, MAXSIZE=200, FILEGROWTH=20%)


--Use este código para adicionar um arquivo e um filegroup a um banco de dados
USE master
ALTER DATABASE SBSChp4TSQL
	ADD FILEGROUP SBSTSQLGroup1

ALTER DATABASE SBSChp4TSQL
	ADD FILE
	(
		NAME = 'SBSChp4TSQL2',
		FILENAME = 'C:\SQLDATA\SBSTSQL2.ndf',
		SIZE = 10MB,
		MAXSIZE = 20,
		FILEGROWTH = 10%
	)
TO FILEGROUP SBSTSQLGroup1

--Desanexando um banco de dados
USE master
EXEC sp_detach_db @dbname = 'SBSChp4TSQL'

--Anexando um banco de dados
USE master
CREATE DATABASE SBSChp4TSQL ON
(FILENAME = 'C:\SQLData\SBSTSQL1.mdf'),
(FILENAME = 'C:\SQLData\SBSTSQL2.ndf'),
(FILENAME = 'C:\SQLLog\SBSTSQL_Log.ldf')
FOR ATTACH


--Use este código  para criar um banco de dados SQL Server com um único arquivo de dados e de log
USE SBSChp4TSQL
GO
CREATE SCHEMA Sales
GO
CREATE SCHEMA HumanResources
GO

USE SBSChp4TSQL
CREATE TABLE HumanResources.Address(
	AddressID INT NOT NULL IDENTITY(1,1),
	StreetAddress VARCHAR(125) NOT NULL,
	StreetAddress2 VARCHAR(75) NULL,
	City VARCHAR(100) NOT NULL,
	State CHAR(2) NOT NULL,
	EmployeeID INT NOT NULL
) ON [SBSTSQLGroup1]


USE SBSChp4TSQL
CREATE TABLE HumanResources.Employee(
	EmployeeID INT NOT NULL IDENTITY(1,1),
	FirstName VARCHAR(50) NOT NULL,
	MiddleName VARCHAR(50) NULL,
	LastName VARCHAR(50) NOT NULL
) ON [SBSTSQLGroup1]



USE SBSChp4TSQL
ALTER TABLE HumanResources.Employee ADD Gender CHAR(1) NOT NULL

--Adicionando uma coluna calculada
ALTER TABLE HumanResources.Employee ADD FullName AS LastName + ', ' + FirstName

--Adicionando chave primaria a uma tabela já existente
ALTER TABLE HumanResources.Employee
	ADD CONSTRAINT pk_Employee PRIMARY KEY (EmployeeID)

ALTER TABLE HumanResources.Address
	ADD CONSTRAINT pk_Address PRIMARY KEY (AddressID)

ALTER TABLE HumanResources.Employee 
	ADD Active BIT NOT NULL

ALTER TABLE HumanResources.Employee 
	ADD SocialSecurityNumber VARCHAR(10) NOT NULL

--Colocando um valor padrão na coluna Active da tabela Employee
ALTER TABLE HumanResources.Employee 
	ADD CONSTRAINT DF_HumanResourcesEmployee_Active_true 
	DEFAULT(1) FOR Active

--Colocando a coluna SocialSecurityNumber como UNIQUE
ALTER TABLE HumanResources.Employee 
	ADD CONSTRAINT UQ_HumanResourcesEmployee_SocialSecurityNumber
	UNIQUE (SocialSecurityNumber)

--Colocando chave estrangeira
ALTER TABLE HumanResources.Address
	ADD CONSTRAINT FK_Employee_To_Address_On_EmployeeID
	FOREIGN KEY (EmployeeID)
	REFERENCES  HumanResources.Employee(EmployeeID)