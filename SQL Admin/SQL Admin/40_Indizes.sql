/*

L:S   100:1   50:50    10:90

CLUSTERED  Index  (gruppierte)
gut für Bereichsabfragen  > <  =
gibts aber nur 1 mal pro Tabelle (= Tabelle)
--beim Erstellen der Tabellen muss dieser CL IX sofort bestimmt werden

PK : Aufgabe eine Beziehung mit FK eingehen.. dazu muss der PK Wert eindeutig sein
Eindeutigkeit erreicht man durch Indizes
Es gibt keine Bed, welcher IX das sein muss : CL oder NON CL
--PK als CL auf ID Spalte größt Verschwendung


PK wird oft als CL IX eindeutig verschwendet!!!!!
er wäre wesentl. besser zb für Datum, PLZ, ..


NON CLUSTERED (Kopie der Daten)
gut für Abfragen mit rel. geringer Ergebnismenge (< 1%)
bei = , ID Spalten 
--kann es auch pro Tabelle 1000 mal geben

-------------------------------------
abdeckender  (bester IX passend zur Abfrage) reiner SEEK ohne Lookup oder scans

zusammengsetzter IX (hat mehr Spalten .. max 16 ).. meist reichen 4 Stück um Eindeutigkeit zu errreichen

IX mit eingsch Spalten x  ca 1000 Spalten mieinschließen
ind Sicht x
part Index x
gefilterterIX  ! nicht alle DS---muss weniger Ebenen ergeben, sonst sinnlos
eindeutigen IX x
--------------------------------------
Columnstore IX


*/

delete from Customers where customerid = 'PARIS'
select * from customers

insert into customers (customerid,CompanyName) values ( 'ppedv', 'Fa ppedv AG')

select * from best

--nicht TABLE SCAN , sondern CL IX SCAN
--Spieltabelle

SELECT      Customers.CustomerID, Customers.CompanyName, Customers.ContactName, Customers.ContactTitle, Customers.City, Customers.Country, Employees.LastName, Employees.FirstName, Orders.OrderDate, Orders.EmployeeID, Orders.Freight, Orders.ShipName, Orders.ShipAddress, Orders.ShipCity, 
                   Orders.ShipCountry, [Order Details].OrderID, [Order Details].ProductID, [Order Details].UnitPrice, [Order Details].Quantity, Products.ProductName, Products.UnitsInStock
INTO KundeUmsatz
FROM         Customers INNER JOIN
                   Orders ON Customers.CustomerID = Orders.CustomerID INNER JOIN
                   Employees ON Orders.EmployeeID = Employees.EmployeeID INNER JOIN
                   [Order Details] ON Orders.OrderID = [Order Details].OrderID INNER JOIN
                   Products ON [Order Details].ProductID = Products.ProductID


--gedanklich: CL IX auf Orderdate


insert into KundeUmsatz
select * from kundeumsatz
GO 9

--eindeutig Spalte ID dazu
alter table kundeumsatz add id int identity  --kein IX

--reiner HEAP
set statistics io, time on
select id from kundeumsatz where id = 100 --TABLE SCAN 65114


--NIX_ID_eindeutig
select id from kundeumsatz where id = 100 --IX SEEK  3Seiten 0 ms

select id , freight from kundeumsatz where id = 100 --4 Seiten 0 ms


select id , freight from kundeumsatz where id < 12800 --ab ca 13700 IX Seek zum Table SCAN

--am besten wäre es , wenn es keinen Lookup geben würde

--NIX_ID_FR
--jetzt sogar bis 1 Mio reiner IX Seek
select id , freight from kundeumsatz where id < 948000

--NIX_ID_FR_PN
select id , freight, productname from kundeumsatz where id < 15000

--NIX_pid_eID_incl_CICYUPQU
select country, city, sum(unitprice*quantity) from kundeumsatz
where productid = 3 and employeeid = 2
group by country, city

--eigtl 2 Indizes..
select country, city, sum(unitprice*quantity) from kundeumsatz
where productid = 3 or employeeid = 2
group by country, city








