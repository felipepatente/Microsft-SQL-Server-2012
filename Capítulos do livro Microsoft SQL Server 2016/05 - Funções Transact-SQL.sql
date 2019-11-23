--===================FUN��ES DE AGREGA��O===================
SELECT AVG(SALARIO) FROM cadfun
SELECT AVG(DISTINCT SALARIO) FROM cadfun
SELECT AVG(SALARIO) FROM cadfun WHERE DEPTO = '3'
SELECT AVG(DISTINCT SALARIO) FROM cadfun WHERE DEPTO = '3'
SELECT COUNT(DISTINCT SALARIO) FROM cadfun

--A fun��o STDEV() retorna o valor do desvio-padr�o estat�stico dos valores de um campo num�rico indicado como express�o, e os valores do tipo
--NULL s�o ignorados.
SELECT STDEV(FILHOS) FROM cadfun
SELECT STDEV(DISTINCT FILHOS) FROM cadfun

--A fun��o VAR() retorna o valor da vari�ncia estat�stica dos valores de determinado campo da tabela que seja num�rico.
SELECT VAR(FILHOS) FROM cadfun
SELECT VAR(DISTINCT FILHOS) FROM cadfun


--===================FUN��ES DE DATA===================
--A fun��o DATEADD() retorna determinada data com base em um valor inteiro de intervalo adicionado � parte especificada dessa data.
SELECT DATEADD(MONTH, 1, '26/03/1965')
SELECT DATEADD(DAY, 5, '10/02/2007')

--A fun��o DATEDIFF() retorna como contagem um valor inteiro relacionado aos limites definidos de uma parte em rela��o a um inicio e a um fim especificados
SELECT NOME, DATEDIFF(DAY, ADMISSAO,'15/09/2017') FROM cadfun
SELECT NOME, DATEDIFF(YEAR, ADMISSAO,'15/09/2017') FROM cadfun

--As fun��es DAY(), MONTH() e YEAR() retornam como valor inteiro, respectivamente, os n�meros do dia, m�s e ano de determinada data fornecida
--como argumento
SELECT NOME, DAY(ADMISSAO), MONTH(ADMISSAO), YEAR(ADMISSAO), ADMISSAO FROM cadfun

--A fun��o DATENAME() retorna uma cadeia de caracteres que representa a parte especificada da data informada
SELECT NOME, ADMISSAO, DATENAME(MONTH, ADMISSAO) FROM cadfun

--A fun��o DATEPART() retorna um valor inteiro que representa a parte especificada da data informada
SELECT NOME, ADMISSAO, DATEPART(MONTH, ADMISSAO) FROM cadfun