CREATE PROCEDURE sp_saudacao 
AS
BEGIN
	DECLARE @Mensagem CHAR(11)
	SET @Mensagem = 'Alo Mundo!'
	PRINT @Mensagem
END

EXEC sp_saudacao

GO
CREATE PROCEDURE sp_dados 
AS
BEGIN
	SELECT NOME, SALARIO FROM cadfun
END
GO

EXEC sp_dados

GO
CREATE PROCEDURE sp_calc
	@A INT,
	@B INT,
	@S INT OUTPUT
AS
BEGIN
	SET @S = @A + @B
END
GO


DECLARE @Saida INT
EXEC sp_calc 5, 3, @Saida OUTPUT
SELECT @Saida--PRINT @Saida

GO
CREATE PROCEDURE sp_decisao1 
	@A FLOAT,
	@B FLOAT
AS
BEGIN
	DECLARE @X FLOAT
	SET @X = @A + @B
	IF (@X >= 10) BEGIN
		PRINT @X
	END
END
GO

EXEC sp_decisao1 5.5, 4.5
EXEC sp_decisao1 5.5, 6.5

GO
CREATE PROCEDURE sp_decisao2 
	@Valor INT
AS
BEGIN
	DECLARE @Resto INTEGER
	DECLARE @Mensagem1 VARCHAR(50)
	DECLARE @Mensagem2 VARCHAR(50)

	SET @Resto = @Valor % 3
	SET @Mensagem1 = 'é um valor divisivel por 3'
	SET @Mensagem2 = 'não é um valor divisivel por 3'
	
	IF (@Resto = 0) BEGIN
		PRINT CAST(@Valor AS VARCHAR) + ' - ' + @Mensagem1
	END
	ELSE BEGIN
		PRINT CAST(@Valor AS VARCHAR) + ' - ' + @Mensagem2
	END
END
GO

EXEC sp_decisao2 4
EXEC sp_decisao2 9

GO
CREATE PROCEDURE sp_fat 
	@Valor INT
AS
BEGIN
	DECLARE @Fator INT
	DECLARE @I INT

	SET @Fator = 1
	SET @I = 1

	WHILE (@I <= @Valor) BEGIN
		SET @Fator = @Fator * @I
		SET @I = @I + 1
	END

	SELECT @Fator

END
GO

EXEC sp_fat 5
EXEC sp_fat 6


GO
CREATE PROCEDURE sp_demite 
	@Codigo INT
AS
BEGIN
	INSERT INTO morto
		SELECT CODFUN, NOME, DEPTO, FUNCAO, SALARIO, ADMISSAO, FILHOS, CPF
		FROM cadfun
		WHERE CODFUN = @Codigo
	DELETE FROM cadfun WHERE CODFUN = @Codigo
END
GO

EXEC sp_demite 24

DROP PROCEDURE sp_saudacao

CREATE TABLE auditoria(
	USUARIO VARCHAR(40),
	ACAO VARCHAR(9),
	DATA DATE,
	CODIGO INT
)

GO
CREATE TRIGGER tr_auditor1 
	ON cadfun FOR INSERT 
AS
BEGIN
	INSERT INTO auditoria 
		SELECT SUSER_NAME(),
		       'Cadastrou',
			   GETDATE(),
			   CODFUN
		FROM inserted
END
GO

INSERT INTO cadfun VALUES(60,'MARINALVA DA SILVA','3','PROGRAMADOR',1200.00,'2016-10-19',0,'50022255599')

SELECT * FROM auditoria


GO
CREATE TRIGGER tr_auditor2 
	ON cadfun FOR UPDATE
AS
BEGIN
	INSERT INTO auditoria 
		SELECT SUSER_NAME(),
			   'Alterou',
			   GETDATE(),
			   CODFUN
		FROM inserted
END
GO

UPDATE cadfun SET FUNCAO = 'SUPERINTENDENTE' WHERE NOME = 'ANTONIO DA SILVA'
UPDATE cadfun SET SALARIO = SALARIO * 1.05

SELECT * FROM auditoria

UPDATE cadfun SET CODFUN = 13 WHERE CODFUN = 12

SELECT * FROM auditoria

GO
CREATE TRIGGER tr_auditor3
	ON cadfun FOR DELETE
AS
BEGIN
	INSERT INTO auditoria
		SELECT SUSER_SNAME(),
			   'Demitiu',
			   GETDATE(),
			   CODFUN
	    FROM deleted
END
GO

EXEC sp_demite 10

SELECT * FROM auditoria

GO
CREATE FUNCTION sf_fat (@N INTEGER) 
	RETURNS INT
AS
BEGIN
	DECLARE @Fator INT, @I INT
	SET @Fator = 1
	SET @I = 1

	IF(@N <= 1) BEGIN
		RETURN (@Fator)
	END
	ELSE BEGIN
		
		WHILE(@I <= @N) BEGIN
			SET @Fator = @Fator * @I
			SET @I = @I + 1
		END

	END

	RETURN (@Fator)

END
GO

SELECT dbo.sf_fat(5)

GO
CREATE FUNCTION sf_raiz(@Base DECIMAL, @Indice DECIMAL)
	RETURNS DECIMAL
AS
BEGIN
	DECLARE @Valor DECIMAL
	SET @Valor = POWER(@Base, 1) / @Indice
	RETURN (@Valor)
END
GO

SELECT dbo.sf_raiz(25,2)
SELECT dbo.sf_raiz(25,3)