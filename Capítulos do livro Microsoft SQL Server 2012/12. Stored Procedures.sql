CREATE PROCEDURE PRG_CONTA_MULTIPLICACAO
(
	@Valor1 INT,
	@Valor2 INT,
	@ResultadoProcedure INT OUTPUT
)
AS
BEGIN
	SET @ResultadoProcedure = @Valor1 * @Valor2
END


GO
DECLARE @Resultado INT
EXEC PRG_CONTA_MULTIPLICACAO @Valor1 = 5, @Valor2 = 10, @ResultadoProcedure = @Resultado OUTPUT
SELECT @Resultado