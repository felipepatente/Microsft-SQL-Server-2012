--Qualquer cadeia de zero ou mais caracteres
SELECT * 
FROM USUARIO 
WHERE Nome LIKE '%THIAGO%'

--Qualquer caractere único
SELECT *
FROM USUARIO
WHERE Nome LIKE '_LINE TANAKA'

--Qualquer caractere único no intervalo ([a-f]) ou conjunto ([abcdef]) especificado.
SELECT * 
FROM USUARIO
WHERE Nome LIKE '[A-R]OSEMEIRE OLIVEIRA DE JESUS'

--Qualquer caractere único que não esteja no intervalo (^[a-f]) ou conjunto ([^abcdef]) especificado.
SELECT * 
FROM USUARIO
WHERE Nome LIKE 'AL[^A]NE TANAKA'

--Refefência
--https://docs.microsoft.com/pt-br/sql/t-sql/language-elements/like-transact-sql?view=sql-server-2017