/*

Taskmanager--> Aktivitätsmonitor--> basierend auf DMVs --> 
--Aufzeichnung XEvents / Profiler / Pefmon

--Lock: User sperrt User
--Latch : system sperrt zeitgleiche Zugriff auf Seiten / Blöcke zb
--IO .. Datenträger
--Network evtl Client


--Windows Taskmanager

--teakids.exe mslaugh.exe als Administrator
--Ist es überhaupt der SQL Server??

--JA!! weil hohe CPU Last oder hohe Schreiblast!!


----------------------------------
--Task Manager für SQL Server --Aktivitätsmonitor  
----------------------------------

select * from sysprocesses
--Prozesse mit einer SPID über 50 sind User oder Agent

select * from sysprocesses where spid > 50

--lastwaittype 0  sys.dm_os_wait_stats


select * from sys.dm_os_wait_Stats
--wait_time_ms = gesamte Wartezeit  (sind kummulierend seit Start)
--signal_time Anteil der Wartezeit auf CPU
--ist die signattime > 25% der Wartezeit, dann CPU Engpass

--man muss die Wartezeit auf Laufzeit de Server umsetzen..
--regelmäßiges beobachten der Werte und und speicher mit Uhrzeit
--wann hat sich der Wert dramatisch veränedrt
--kein Neustart, sonst alle Werte auf 0 

--um 10:20 408227
--10:37  5147782

-- evtl sind Locks schuld an Wartezeit
--Std bei Sperren: ein Schreiben hindert das Lesen: READ COMMITTED

--Zeilensperrren Seitensperre Blocksperre Partionssperren Tabellensperren DB Sperren




--Profiler
--sehr ressourcenhungrud  .. Filter auf DB zb

--XEvents
--weniger ressourcenhungrig
--genauer (ns)
--mehr Dinge aufzeichenbar

*/
select * from Customers


CREATE EVENT SESSION [DemoXY] ON SERVER 
ADD EVENT sqlos.wait_info(
    ACTION(sqlserver.sql_text)
    WHERE ([sqlserver].[like_i_sql_unicode_string]([sqlserver].[database_name],N'northwind'))),
ADD EVENT sqlserver.sp_statement_completed(
    ACTION(sqlserver.sql_text)
    WHERE ([sqlserver].[like_i_sql_unicode_string]([sqlserver].[database_name],N'northwind'))),
ADD EVENT sqlserver.sql_batch_completed(
    ACTION(sqlserver.sql_text)
    WHERE ([sqlserver].[like_i_sql_unicode_string]([sqlserver].[database_name],N'northwind'))),
ADD EVENT sqlserver.sql_batch_starting(
    ACTION(sqlserver.sql_text)
    WHERE ([sqlserver].[like_i_sql_unicode_string]([sqlserver].[database_name],N'northwind')))
ADD TARGET package0.event_file(SET filename=N'D:\_BACKUP\Demoxy.xel'),
ADD TARGET package0.histogram(SET source=N'sqlserver.sql_text')
WITH (MAX_MEMORY=4096 KB,EVENT_RETENTION_MODE=ALLOW_SINGLE_EVENT_LOSS,MAX_DISPATCH_LATENCY=30 SECONDS,MAX_EVENT_SIZE=0 KB,MEMORY_PARTITION_MODE=NONE,TRACK_CAUSALITY=OFF,STARTUP_STATE=OFF)
GO




--Logfiles geben ganz gut technische Problem wieder
--werden ja nach jedem Neustart neu angelegt... max 7 Stück
--es lassen sich ausserdem zusätzlich im Logviewer die NT Eventprotokollen ansehen




--Aufzeichnen 

--Profiler  Perfmon  Query Store

select * from sys.dm_os_performance_counters

--QueryStore


use Northwind



--SCAN Suche vn A bis Z  im TelBuch Suche nach Peter (Vorname)
---SEEK herauspicken Suche nach Maier Alfons

--Abfragen können im Plan verglichen werden.. wer hat mehr % 

set statistics io, time on --läuft nur in dieser Session
--und sollte man bald wieder abschalten mit  ---off
--Messung von CPU Dauer in ms, gesamte DAuer in ms und Anzahl Seiten 
--je weniger desto besser

select * from orders where year(orderdate) = 1997

select * from orders where orderdate between '1.1.1997' and '31.12.1997'