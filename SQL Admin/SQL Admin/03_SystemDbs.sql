--------------Master--------------
Logins
Datenbanken
Systemkonfiguration
"Herzst�ck"

select * from sysdatabases

Backup: jupp



------------------model---------------
create database (vorlage Model)
Einstellungen der model werden an neue DBs vererbt

Backup: wenn �nderungen
(script)



--------------------tempdb-----------------
#tabellen  ##tabellen 
Zeilenversionierung
IX Wartung

Backup : no





--------------------msdb--------------------
DB f�r den Agent
Jobs + Zeitpl�ne
Proxy (ausf�hren als...)
Verlauf der Jobs
Email
Wartungspl�ne

Backup: ja, bei �nderungen 


--distribution (Repliaktion)