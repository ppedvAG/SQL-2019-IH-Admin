--TOP FRAGEN ZUR SICHERUNG  --> SLA

--Wie lange darf die DB /Server ausfallen?
--Wie hoch darf der Datenverlust sein, der durch Ausfall entsteht (gemessen in min?


-- Für Backup notwendige Theorie:

--RecoveryModel Wiederherstellungsmodel

--Einfach
--TX werden etwas verzögert aus dem Log gelöscht--> keine Sicherung des Logfiles  Logfile leert sich
--INS UP DEL und BULK rudimentär

--Massenprotokolliert
--wie Einfach, aber es wird nichts gelöscht --> Tlog muss gesichert werden, dadruch wird es wieder geleert


--Vollständig
--I U D auch Bulk wird sehr exakt mitprotokolliert...--> auf Sek restore möglich, aber wächst auch schneller



--Typische Szenarien
--Ausfall darf sein 4 Stunden
--Datenverlust: 2 Stunde

--Recoverymodel: Simple



-------------------------Backupvarianten
--Vollsicherung
-- Checkpoint--> schreibt die schmutzigen Daten aus dem RAM auf die MDF
--wird gesichert: Dateien, Pfade, Dateigrößen, DBNamen, Daten
--Restore eines Zeitpunktes
--V ändert nichts im TLog
--Sicherung ist Online


--Diff
--sichert alle Blöcke weg, die sich geändert haben, seit der letzten Vollsicherung



--Logsicherung
--sichert sich den Weg zu den Daten mit Zeitstempel
--und löscht die committed TX  aus dem Log (je nach Model Full, Simple , Bulk)


--typischer Verlauf einer Sicherung


/*
!V      3:00
	T
	T
	T
	Tx
	D
	T
	T
	T
	T
!	D
	T
	T
	T     12:30


--Was muss man Restoren
	-Restore von 12:30
	V
	D.. das letzte ..
	--alle T seit dem letzten D , ausser es gab kein D, dann alle T seit dem letzten V


	--der schnellste Restore = V, was bedeutet: so häufig wie möglich
	--wie lange dauert der Restore eines T? ..auf Sekunde ca..
	---dauert solange wie die einzelenen TX in original auch brauchten ..

	--daher wollen wir sicher nicht: viele T !!!!
	--vor allem auch nicht dann: wenn ein T aus der Kette defekt ist, dann kannst den Rest danach vergessen

	--Tipp: daher mach immer wieder D Sicherung, weil der Restore kürzer und sicherer wird..



	--V TTTTTTTTTTXTTTTTTTTTTTTT


--Beispiel:

--Größe der DB:  30 GB
--Wie lange darf die DB /Server ausfallen?---> 4 h
--Wie hoch darf der Datenverlust sein, der durch Ausfall entsteht (gemessen in min?--> 1440min

--> Recoverymodel: kein exakter restore notwendig--> simple
--> V ..jeden Tag , alle 4 Stunden D Sicherung


--Größe der DB:  30 GB
--Wie lange darf die DB /Server ausfallen?---> 4 h
--Wie hoch darf der Datenverlust sein, der durch Ausfall entsteht (gemessen in min?--0--->  

--> Hochverfügbarkeitslösung, die DB synchronisiert: Spiegeln oder AVG



--Größe der DB:  30 GB
--Wie lange darf die DB /Server ausfallen?---> 4 h
--Wie hoch darf der Datenverlust sein, der durch Ausfall entsteht (gemessen in min?--30min  oder so exakt wie möglich

--> V  2 bis 3 min einmal täglich
-->T = 30min
--D: alle 3 bis 4 T Sicherung


--Größe der DB:  30 GB
--Wie lange darf die DB /Server ausfallen?--->1 h
--Wie hoch darf der Datenverlust sein, der durch Ausfall entsteht (gemessen in min?--30min  oder so exakt wie möglich


--V einmal täglich
--alle 15 min T
---alle 3 bis 4 T ein D

--manchaml muss man das Recoverymodel auf FULL setzen
--zb Logshipping, Spiegeln AVG


---------------------Fälle: was kann passiern
--Fall1a und 1 b :  HDD kaputt mit Datendateien (log oder und mdf) Server kaputt

--Fall 2 : logischer Fehler. DB ist ok, aber die Daten nicht 

--Fall 3: wenn ich wüsste, dass was passieren kann

--Fall 4: DB auf anderen Server ohne Backup restoren

Dateien anfügen ;-) 

fehlt eine ldf, dann kann diese automatisch erstellt werden
fehlt die mdf, dannb Backup Restore
*/



-----TIPPS---------------------------------------
--Wie mach ich eigtl richtig Backups.
--Tipp: nicht alles in eine Datei
--Wartungsplan

---DB Größe 50 GB   Mo bis Fr  von 6 Urh bis 19 Uhr
--so exakt wie möglich restoren
--Datenverlust 30min
---Stillstand 1 Stunde



/*
V (unter 10 min)   täglich --> mit Kompression .. ca 15 Mo bis  Fr   20 Uhr
D = alle 2 Ts  --> Alternative : T alle 15 min .. und dann alle 3 bis 4 T ein D
T = alle 30min  Mo bis Fr  6:30 -- 19:30

--V TTTT D 
--20min    2Std (30min)  D 

--20min 1 Std (15min)

--Tool für Sicherung : Wartungsplan

*/



























