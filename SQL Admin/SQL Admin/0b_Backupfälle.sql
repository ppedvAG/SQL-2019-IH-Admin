--VOLL
BACKUP DATABASE [Northwind] TO  DISK = N'D:\_BACKUP\nwx.bak' WITH NOFORMAT, 
NOINIT,  NAME = N'Northwind-Full ', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO
--DIFF
BACKUP DATABASE [Northwind] TO  DISK = N'D:\_BACKUP\nwx.bak' WITH  DIFFERENTIAL ,
NOFORMAT, NOINIT,  NAME = N'Northwind DIFF', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO
--LOG
BACKUP LOG [Northwind] TO  DISK = N'D:\_BACKUP\nwx.bak' WITH NOFORMAT, 
NOINIT,  NAME = N'Northwind-LOG', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

--V   TTT  D  TTT  D  TTT  2022-06-29T10:38:38.3753969+02:00




------------------Fall: Server tot: DB woanders aus Backup restoren

---von Ordner  Datenbanken aus restoren
--Backup in STd Ordner des Servers kopieren (Rechte)
--Dateipfade anpassen
--Restore

--Fall: Restore einer DB mit geringsten Datenverlust bei logischen Fehlern

--- Restore auf dem gleichen Server... so exakt wie möglich , möglichst ohne Datenverlust
--Letzte Backup T 10:38  Error: 10:50: Meldung kommt 11:10 ... 11:18

--T Backup um 11:18 --läuft 5 min..Online 
--DB Offline um 11:23--> Problem: Offline kein Restore mehr  :-(
--;-) User müssen Offline sein.. 11:18 Backup ungestört--> keine Änderungen mehr seit 11:18
--11:23 Restore 

--viel leichter als gedacht

---> SQL schlgt Fragementsicherung vor. Also beim Restorevorgang wird automatisch ein T-Backup erstellt (fragemntsicherung)
--das schon als Restorezeitpunkt zur Verfügung gestellt wird
--OPTIONEN
--alle User mussen von der DB 
--DB ersetzen

--FALL --Server explodiert, aber Dateien sind da
--Dateien sind definitiv aktuelle als jedes backup
--Anfügen ;-) 


--DB Offline: master kennt sie noch , aber SQL Prozess verwendet sie nicht

--DB Trenne.. der Prozess auf die DAteienwird entfernt und master DB vergisst die DB

--Gegenstück: Anfügen
--Falls das Logfile fehlt: Logfile entfernen.. es wird neues Logfile generiert
--was wenn das mdf weg wäre, aber das ldf ist vorhanden...,doof ;-(





--Fall: Ich weiss, dass was passiern kann... ZB Update Szenario


--Snapshot










