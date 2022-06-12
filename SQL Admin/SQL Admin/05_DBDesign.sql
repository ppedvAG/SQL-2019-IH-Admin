/*
Primärschlüssel (Eindeutigkeit)--Beziehung --> Fremdschlüssel

Normalisierung

--jeder Primärschlüssel ohne Beziehung ist extrem fragwürdig



*/

use Northwind

create table t1 (id int identity, sp1 char(4100))


insert into t1
select 'XY'
go 20000
--13 Sekunden..sollte 80 MB sein---> 160 MB??

select * into t2 from t1 --Bulk Operation 1 Sek

--Einzeloperation sind deutlich schlechter als Massenoperationen



--DB Design auch im Hintergrund beobachten


nvarchar vs char vs 

Otto

dbcc showcontig('t1')
--- Gescannte Seiten.............................: 20000
--- Mittlere Seitendichte (voll).....................: 50.79%

set statistics io , time on

select * from t1 where id = 10


select * from orders where orderdate between '1.1.1997' and '31.12.1997 23:59:59:997'

char(50)   50
varchar(50)   4
nchar(50)   50*2
nvarchar(50)  4*2 

select customerid, country from customers


delete from customers where CustomerID= 'Paris'