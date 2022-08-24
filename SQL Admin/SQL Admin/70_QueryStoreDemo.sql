select * into k3 from kundeumsatz
GO --> HEAP keine IX


select * from k3 where id < 1000000 --SCAN
select * from k3 where id < 2 --SCAN



CREATE UNIQUE NONCLUSTERED INDEX [NonClusteredIndex-20220824-091245] ON [dbo].[k3]
(	[id] ASC)
GO


select * from k3 where id < 1000000 --SCAN
select * from k3 where id < 2 --SEEK --;-)



create proc gpdemo @par1
as
select * from k3 where id <@par
GO

set statistics io , time on
exec gpdemo 2   --, CPU-Zeit = nahezu 0 -- 4  ---> SEEK

exec gpdemo 1000000   --, CPU-Zeit = nahezu 3 Sek CPU 1 MIO Seiten  ---immer noch SEEK
						
dbcc freeproccache --löscht den Plan aller Prozeduren

exec gpdemo 1000000   --neuer Plan : Table Scan!   nie mehr als 47000 Seiten, aber auch nie weniger  47000 Seiten .. 215 ms

exec gpdemo 2   --neuer Plan : Table Scan!   nie mehr als 47000 Seiten, aber auch nie weniger   47000 Seiten 215ms


--QueryStore: Top Abfragen nach Ressourcenverbrauch..  nach Logical Reads   filtern, nach CPU filtern, nach DAuer filtern.. 

--welcher Plan ist in Summe der bessere..?

