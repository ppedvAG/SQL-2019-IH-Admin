/*
überlappende IX herausfinden und überflüssige (die kaum oder 
gar nicht verwendet werden löschen

Fehlende Indizes  IX Strategie
typischen Workload (mit ca 50000 Abfragen)--> welche Abfrage war in Summe die teuerste

--Tool zum Speichern aller Abfragen: Profiler , Abfragespeicher (QueryStore)

IX Wartung 
Rebuild
Reorg


Statistikwartung


*/


--Statistiken

select * into k3 from kundeumsatz

--beim Schätzen des Planes werden Stat angelegt?

select * from k3 where id = 100 --geschätzt 1
select * from k3 where freight  < 0.05 --??  1024 statt 1600--> NON CL sehr gut geeignet
select * from k3 where city   = 'LONDON' --57000 statt 59000
select * from k3 where Country= 'USA'

--IX nehmen oder nicht..

--INS UP DEL  
--wieviele DS müssen eigtl geändert werden bis die Stats sich aktualisiert?
--bei 20% Änderungen + 500 + Abfrage auf SP-->zu spät!--falscher Plan  Seek statt Scan
select * from k3 where employeeid = 3 and Productid = 10
--2 getrennte Statistiken

--Stat am besten jeden Tag aktualsieren
--Indizes machen 100% genaue Stat und nicht ind Spalten bekommen Stichpobe ab einer best Menge
--_WA_SYS = Spaltenstats, (die hatten keine IX)

--Platzbedarf: 200MB Heap DAten + 1 CL IX + 2 NCL IX= 363 MB

-- Online oder Offline  bzw mit tempdb oder ohne tempdb
--> welche Kombination ist die aufwendigsten (Platzbedarf)

-- ONLINE + TEMPDB--> 1100 MB
-- OFFLINE ohne tempdb--> 860 MB


---überflüssige Indizes

select *  from sys.dm_db_index_usage_stats


--IX fragementieren
--Rebuild: > 30%  gesamte Baum wird renoviert
--Reorg:  >10%   dann wird nur die letzte Ebene verdichtet (unterste Teil des Baume (der mit den Zeigern))

--IX Wartung plus Stat = Wartungsplan (bitte erst ab SQL 2016)

vc6..ppedv   3410
v6.ppev.de   3411


--IndexId = 0  = Heap
--IndexID = 1 = CL IX
--IndexID > 1 --> NON CL IX




