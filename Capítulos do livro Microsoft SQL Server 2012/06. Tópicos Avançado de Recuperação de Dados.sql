SELECT ID, Empresa, Endereco, Site, Email 
FROM Empresa
ORDER BY id
OFFSET 10 ROWS
FETCH NEXT 10 ROWS ONLY


SELECT Empresa + ' - ' + Email AS [Empresa com Email]
FROM Empresa

SELECT Tempo_Viagem * 2 AS [Tempo Total], Tempo_Viagem
FROM Empresa


DECLARE @ID INT = 1

SELECT *
FROM Empresa
WHERE id = @ID