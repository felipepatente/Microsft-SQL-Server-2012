--Criando um instant�neo de banco de dados
CREATE DATABASE <nome do instant�neo de banco de dados>
ON
(
	NAME = <Nome L�gico do arquivo de banco de dados de origem>,
	FILENAME = <Caminho do Arquivo onde o arquivo ser� armazenado e o nome do arquivo>
)
AS SNAPSHOT OF <Nome do banco de dados de origem>


--Use este script para remover um instant�neo de banco de dados
USE master
DROP DATABASE SBSChp4TSQL_snapshot_42012400

--Use este script para criar um instant�neo de um banco de dados
USE master
RESTORE DATABASE SBSChp4TSQL FROM DATABASE_SNAPSHOT = 'SBSChp4TSQL_snapshot_42012400'
