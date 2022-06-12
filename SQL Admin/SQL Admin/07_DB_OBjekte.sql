--DB Objekte


--Tabelle

--Sicht  -- View
--funktioniert wie eine Tabelle
--S I U D auf View (nicht immer , aber es geht)
--besteht immer aus einer Abfrage (SELECT)
--enthält keine Daten
--Sicht ist auf Dauer nagelegt..aslo auch nach Neustart verfügbar


create view vDemo1
as
select * from orders where orderid < 12000


select * from vdemo1

select * from  (select * from orders where orderid < 12000) vdemo1

--Wofür: komplexe wiederkehredne Abfrage einfachen  zu haben

--wg Security... haben eig Security






--Funktion  Function

--Prozedur   stored procedure

--funktionieren wie ein batchscript  unter Windows
--kann I U D S mehrfach enthalten
--meist komplette Logik enthalten
--liegen auf dem Server zentrale Verwaltjung
--schneller

exec procname par1 , par2

--Prozedur merkt sich den Plan auf Dauer..auch nach Neustart
--Plan wir beim ersten Aufruf generiert

create proc gpName @par1 int
as
select * from tabelle where sp = @par1
insert into tabelle2 set sp = @par1 *40
GO


--Funktionen (Skalar, Tabellenwert)
--sind  i.d.R mies... 
--wird nicht paralellisiert
--kontraproduktiv zu Indizes
create function fdemo (@par1) returns table / int
as
begin

end


select * from kunden where kunde like 'G%'

select * from kunden where left(kunde,1) =  'G'
--wird immer alle Zeilen durchlesen müssen



---------------------------------------------> schnell
--F()  ------> Sicht/adhoc -----------> Proc
--Proc ------> F()  ----->Sicht/adhoc








