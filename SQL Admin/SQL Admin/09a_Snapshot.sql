	--Snapshot = Momentaufnahme = lesbare DB
	--kopiert Datenseiten und Blöcke kurz vor Änderung in den Snapshot.
	--Somit hat Snapshot die unveränderten Daten und die OrgDB die geänderten Daten
	--Der Snapshot íst somit ein zeitlich fixes Konstrukt, dass immer die Daten eines best Zeitpunktes anzeigt
-- der Snapshot benötigt nur soviel Platz wie DAtenseiten und Blöcke enthalten sind, auch wenn im Explerer etwas anderes angezeigt wird
--(Sparse files)


---wenn ein Snapshot vorhanden ist, dann kann man keinen normalen Restore der OrigDB machen
--> zuerst Snapshot löschen

--man kann jederzeit mehrere Snapshots haben
--man kann keine Sicherung des Snapshots machen

--ohne voll funktionierender OrgDB ist der Snapshot sinnlos...


CREATE DATABASE DBNAMESNAPSHOT  ON
( NAME =logischer dateiname der OrgDB , FILENAME = 'Pfad und dateiname der neuen SB DB' )
AS SNAPSHOT OF OrgDB
GO

CREATE DATABASE NW_1210  ON
( NAME = Northwind,   FILENAME = 'D:\_SQLDBDATA\NW_1200.mdf' )
AS SNAPSHOT OF northwind;
GO

--aber:: keiner darf auf dem Snapshot sein und kiner auf der origDB-- Aktivitätsmonitor
use master
restore database northwind from database_snapshot = 'nw_1210'