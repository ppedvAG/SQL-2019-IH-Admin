--exakte Kopie der Kundeumsatz

select * into kundeumsatz2 from kundeumsatz


select  top 3 * from KundeUmsatz

--Abfrage: where , Aggregat summe

--Summe der Lieferkosten pro Kunden (Companyname) , die wo aus UK

set statistics io, time on

select companyname, sum(freight) from kundeumsatz
where country = 'UK'
group by CompanyName
--Seiten :  110407,   , CPU-Zeit = 312 ms, verstrichene Zeit = 312 ms.

USE [Northwind]
GO
CREATE NONCLUSTERED INDEX NIX
ON [dbo].[KundeUmsatz] ([Country])
INCLUDE ([CompanyName],[Freight])
GO

--Seiten 549   , CPU-Zeit = 16 ms, verstrichene Zeit = 25 ms.


--jede Änderunge der Abfrage würde einen neuen IX brauchen

CREATE CLUSTERED COLUMNSTORE INDEX [CSIX] ON [dbo].[kundeumsatz2] WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0)

select companyname, sum(freight) from kundeumsatz2
where country = 'UK'
group by CompanyName
--Seiten :  110407,   , CPU-Zeit = 312 ms, verstrichene Zeit = 312 ms.
--Seiten: 0  ,				CPU-Zeit = 0 ms, verstrichene Zeit = 1 ms.


select City, sum(freight) from kundeumsatz2
where customerid = 'ALFKI'
group by City

--für jede SP ein IX angelegt worden ..nein , weil sonst sollte es ansatzweise gleich schnell, aber der ColStore war schneller


---Kundeumsatz = ca 480MB
--Kundeumsatz = ca 3,5 MB?  --> 3,1 MB ja das stimmt oder stimmt nicht:  stimmt, dann aber kann das nur durch Kompression passiert
--trotz weiterer Kompresssion deutlich geringere Zeiten
--3,1 MB sind nun im RAM statt 480MB

