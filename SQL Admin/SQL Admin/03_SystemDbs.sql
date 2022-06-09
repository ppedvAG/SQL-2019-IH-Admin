--------------Master--------------
Logins
Datenbanken
Systemkonfiguration
"Herzstück"

select * from sysdatabases

Backup: jupp



------------------model---------------
create database (vorlage Model)
Einstellungen der model werden an neue DBs vererbt

Backup: wenn Änderungen
(script)



--------------------tempdb-----------------
#tabellen  ##tabellen 
Zeilenversionierung
IX Wartung

Backup : no





--------------------msdb--------------------
DB für den Agent
Jobs + Zeitpläne
Proxy (ausführen als...)
Verlauf der Jobs
Email
Wartungspläne

Backup: ja, bei Änderungen 


--distribution (Repliaktion)