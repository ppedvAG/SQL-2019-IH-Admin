/*
master (Logins)
model
msdb (Jobs, Email, Historie, SSIS, Wartungsplan, ...)
tempdb (#t)


Idee. Eigenständige DB


Einschränkungen und Tipps
Vermeiden Sie Logins mit gleichen Namen wie der Contained DB Benutzer. Falls doch, dann ändern sie beim Login die Standarddatenbank so, dass nicht gleich auf die ContDB zugegriffen wird. Sonst gibts Fehler bei der Anmeldung.
keine Kerberos Authentifizierung möglich
beim Anfügen einer Datenbank den Zugriff auf Restricted User stellen, um nicht unegwollte zugriffe auf dem SQL Server zu haben.
keine Replikation
kein CDT und CDC
keine temporären Prozeduren


Datenbankübergreifende Zugriffe?
Ja, das ist möglich. Notwendig dazu ist, dass die Contained Database auf vertrauenswürdig gesetzt ist:

ALTER DATABASE ContDB SET TRUSTWORTHY ON

Anschliessend muss die aktuelle Verbindung des Benutzer zurückgesetzt werden, damit die Änderung aktiv werden kann.

*/

USE [master]
GO
ALTER DATABASE [ContDB] SET CONTAINMENT = PARTIAL WITH NO_WAIT
GO


--Teilweise:
--keine msdb Dinge dabei
--tempdb  die temp Tabellen sind immer noch in tempdb aber erben die Sparchsortierung der COntDB
---master: logins



