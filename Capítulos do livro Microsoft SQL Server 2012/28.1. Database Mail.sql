--Habilitando as stored procedures estendidos do Database Mail
EXEC sp_configure 'show advanced options', 1;
GO
RECONFIGURE;
GO
EXEC sp_configure 'Database Mail XPs', 1;
GO 
RECONFIGURE
GO


-----------------------------------------------------------------------------------------
-- Cria uma conta de envio de e-mail no banco de dados
-----------------------------------------------------------------------------------------
 
DECLARE
    @Account_Name SYSNAME = 'ContaEnvioEmail',
    @Profile_Name SYSNAME = 'ProfileEnvioEmail'
    
 
IF ((SELECT COUNT(*) FROM msdb.dbo.sysmail_account WHERE name = @Account_Name) > 0)
    EXEC msdb.dbo.sysmail_delete_account_sp @account_name = @Account_Name
 
 
EXEC msdb.dbo.sysmail_add_account_sp
    @account_name = @Account_Name,
    @description = 'Conta de e-mail para ser utilizada por todos os usu�rios do banco',
    @email_address = 'felipepatente2016@gmail.com',
    --@replyto_address = 'naoresponder@seudominio.com.br',
    @display_name = 'Patente',
    @mailserver_name = 'smtp.gmail.com',
    @mailserver_type = 'SMTP',
    @port = '587',
    @username = 'felipepatente2016@gmail.com',
    @password = 'Numeronumero1',
    @enable_ssl = 1,
    @use_default_credentials = 0
 
 
 
-----------------------------------------------------------------------------------------
-- Cria o profile de e-mail
-----------------------------------------------------------------------------------------
 
IF ((SELECT COUNT(*) FROM msdb.dbo.sysmail_profile WHERE name = @Profile_Name) > 0)
    EXEC msdb.dbo.sysmail_delete_profile_sp @profile_name = @Profile_Name
 

EXEC msdb.dbo.sysmail_add_profile_sp
    @profile_name = @Profile_Name,
    @description = 'Profile P�blico para Envio de E-mail' ;
 
 
-----------------------------------------------------------------------------------------
-- Adiciona a conta ao perfil criado
-----------------------------------------------------------------------------------------
 
DECLARE 
    @profile_id INT = (SELECT profile_id FROM msdb.dbo.sysmail_profile WHERE name = @Profile_Name), 
    @account_id INT = (SELECT account_id FROM msdb.dbo.sysmail_account WHERE name = @Account_Name)
    
 
IF ((SELECT COUNT(*) FROM msdb.dbo.sysmail_profileaccount WHERE account_id = @account_id AND profile_id = @profile_id) > 0)
    EXEC msdb.dbo.sysmail_delete_profileaccount_sp @profile_name = @Profile_Name, @account_name = @Account_Name
 
 
EXEC msdb.dbo.sysmail_add_profileaccount_sp
    @profile_name = @Profile_Name,
    @account_name = @Account_Name,
    @sequence_number = 1;
 
 
-----------------------------------------------------------------------------------------
-- Libera acesso no perfil criado para todos os usu�rios
-----------------------------------------------------------------------------------------
 
IF ((SELECT COUNT(*) FROM msdb.dbo.sysmail_principalprofile WHERE profile_id = @profile_id) > 0)
    EXEC msdb.dbo.sysmail_delete_principalprofile_sp @profile_name = @Profile_Name
 
 
EXEC msdb.dbo.sysmail_add_principalprofile_sp
    @profile_name = @Profile_Name,
    @principal_name = 'public', -- Aqui voc� pode dar acesso para um usu�rio espec�fico, se quiser
    @is_default = 1;
 
 
-----------------------------------------------------------------------------------------
-- Define o tamanho m�ximo por anexo para 5 MB (O Padr�o � 1 MB por arquivo)
-----------------------------------------------------------------------------------------
 
--EXEC msdb.dbo.sysmail_configure_sp 'MaxFileSize', '5242880'; -- 1024 x 1024 x 5

-----------------------------------------------------------------------------------------
--Enviando um e-mail como teste
-----------------------------------------------------------------------------------------
GO
EXEC msdb.dbo.sp_send_dbmail  
    @profile_name = 'ProfileEnvioEmail',
    @recipients = 'felipepatente@yahoo.com.br',  
    @body = 'The stored procedure finished successfully.',  
    @subject = 'Automated Success Message' ; 
