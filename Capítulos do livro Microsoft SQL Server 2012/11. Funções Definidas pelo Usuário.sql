--Criando uma função
CREATE FUNCTION GetEmployeeAge
(
	@BirthDate datetime
)
RETURNS INT
AS
BEGIN
	--Declara a variável de retorno aqui
	DECLARE @Age INT
	--Adicione as instruções T-SQL para calcular o valor de retorno aqui
	SELECT @Age = DATEDIFF(DAY,@BirthDate, GETDATE())
	--Retorna o resultado da função
	RETURN @Age
END
GO

--Alterando uma função
ALTER FUNCTION GetEmployeeAge
(
	@BirthDate datetime
)
RETURNS INT
AS
BEGIN
	--Declara a variável de retorno aqui
	DECLARE @Age INT
	--Adicione as instruções T-SQL para calcular o valor de retorno aqui
	SELECT @Age = DATEDIFF(YEAR,@BirthDate, GETDATE())
	--Retorna o resultado da função
	RETURN @Age
END
GO

--Utilizando a função
SELECT Nome, dbo.GetEmployeeAge(Nascimento)
FROM PILOTO

--Excluindo uma função
DROP FUNCTION dbo.GetEmployeeAge

GO
--Criando uma função com parametros DEFAULT e OPTIONAL
CREATE FUNCTION GetEmployeeAge
(
	@BirthDate DATE = '1993-06-26', --DEFAULT
	@DateNow DATE = NULL --OPTIONAL
)
RETURNS INT
AS
BEGIN
	--Declara a variável de retorno aqui
	DECLARE @Age INT
	
	--Adicione as instruções T-SQL para calcular o valor de retorno aqui	
	IF @DateNow IS NULL BEGIN
		SELECT @Age = DATEDIFF(YEAR,@BirthDate, GETDATE())
	END
	ELSE BEGIN
		SELECT @Age = DATEDIFF(YEAR,@BirthDate, @DateNow)
	END

	--Retorna o resultado da função
	RETURN @Age
END
GO

--Utilizando a função criada acima
DECLARE @Idade INT
DECLARE @DataNascimento DATE
SET @DataNascimento = '1993-06-26'
DECLARE @NascimentoComHoras DATETIME = CAST(@DataNascimento AS DATETIME)

EXECUTE @Idade = dbo.GetEmployeeAge @BirthDate = @NascimentoComHoras

--Chamando sem parametros
EXECUTE @Idade = dbo.GetEmployeeAge 

--Chamando com um parametro
EXECUTE @Idade = dbo.GetEmployeeAge @BirthDate = @NascimentoComHoras
EXECUTE @Idade = dbo.GetEmployeeAge @NascimentoComHoras

--Chamando com dois parametros
EXECUTE @Idade = dbo.GetEmployeeAge @BirthDate = @NascimentoComHoras, @DateNow = '1997-06-26'
EXECUTE @Idade = dbo.GetEmployeeAge @NascimentoComHoras, '1997-06-26'

SELECT @Idade

--Criando tabelas valores inline
GO
CREATE FUNCTION GetNomesFuncionarios
(
	@Idade INT
)
RETURNS TABLE
AS 
RETURN
(
	SELECT Nome, Idade
	FROM FUNCIONARIO
	WHERE Idade > @Idade
)
GO

--Utilizando a função acima
SELECT *
FROM dbo.GetNomesFuncionarios(20)