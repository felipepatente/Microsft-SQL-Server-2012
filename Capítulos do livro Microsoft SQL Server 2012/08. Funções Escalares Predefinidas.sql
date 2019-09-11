SELECT TRY_CAST('SADF' AS INT) TRY_CAST


DECLARE @choosevar int = 1
SELECT CHOOSE(@choosevar, 'ONE', 'TWO', 'PATRICK', 'THREE') [Choose],
	   IIF(DATENAME(MONTH,GETDATE()) = 'Agosto','VERDADEIRO','FALSO') as [iIF]	   