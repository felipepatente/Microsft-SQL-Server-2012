--===================FUNÇÕES DE AGREGAÇÃO===================
SELECT AVG(SALARIO) FROM cadfun
SELECT AVG(DISTINCT SALARIO) FROM cadfun
SELECT AVG(SALARIO) FROM cadfun WHERE DEPTO = '3'
SELECT AVG(DISTINCT SALARIO) FROM cadfun WHERE DEPTO = '3'
SELECT COUNT(DISTINCT SALARIO) FROM cadfun

--A função STDEV() retorna o valor do desvio-padrão estatístico dos valores de um campo numérico indicado como expressão, e os valores do tipo
--NULL são ignorados.
SELECT STDEV(FILHOS) FROM cadfun
SELECT STDEV(DISTINCT FILHOS) FROM cadfun

--A função VAR() retorna o valor da variância estatística dos valores de determinado campo da tabela que seja numérico.
SELECT VAR(FILHOS) FROM cadfun
SELECT VAR(DISTINCT FILHOS) FROM cadfun


--===================FUNÇÕES DE DATA===================
--A função DATEADD() retorna determinada data com base em um valor inteiro de intervalo adicionado à parte especificada dessa data.
SELECT DATEADD(MONTH, 1, '26/03/1965')
SELECT DATEADD(DAY, 5, '10/02/2007')

--A função DATEDIFF() retorna como contagem um valor inteiro relacionado aos limites definidos de uma parte em relação a um inicio e a um fim especificados
SELECT NOME, DATEDIFF(DAY, ADMISSAO,'15/09/2017') FROM cadfun
SELECT NOME, DATEDIFF(YEAR, ADMISSAO,'15/09/2017') FROM cadfun

--As funções DAY(), MONTH() e YEAR() retornam como valor inteiro, respectivamente, os números do dia, mês e ano de determinada data fornecida
--como argumento
SELECT NOME, DAY(ADMISSAO), MONTH(ADMISSAO), YEAR(ADMISSAO), ADMISSAO FROM cadfun

--A função DATENAME() retorna uma cadeia de caracteres que representa a parte especificada da data informada
SELECT NOME, ADMISSAO, DATENAME(MONTH, ADMISSAO) FROM cadfun

--A função DATEPART() retorna um valor inteiro que representa a parte especificada da data informada
SELECT NOME, ADMISSAO, DATEPART(MONTH, ADMISSAO) FROM cadfun