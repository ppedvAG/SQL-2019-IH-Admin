--Salamitaktik

select * into k4 from kundeumsatz


--Vorteil des Columnstore? Kompression

--Seitenkompression Zeilenkompression
-- 40 bis 60%


--Die Tabelle k4 wird statt 410 MB nun 110 MB haben

--Was wird passieren:
--vor kompression
--Anzahl der Seiten:  47000
--RAM verbrauch  47000 * 8 Kb in RAM

--nach Kompression:
--weniger Seiten !!! weil 110MB weniger als 410 MB
--RAM: weniger ! oder mehr Seiten kommen immer 1:1 in RAM  also statt 410MB nur noch 110 MB!!!!!

--CPU:  315ms 
--nach Kompression : mehr oder wvlt auch weniger.. je h�her die Kompression desto besser gehts der CPU

--Client: Word 2003 Serienbrief--> komp Tabelle
--Client bekommt immer!! unkomprimierte Daten

--INS sind bei CL IX auch komprimiert und bei Heap zun�chst nicht

--Man bezahlt mit CPU mehr RAM
--eigtl w�rde man damit rechnen, dass die Tablelle mehr Ressourcen und Dauer ben�tigt

--man macht Kompression , damit andere Tabellen mehr Patz im RAM finden


set statistics io, time on

select * from k4 where id < 100
--unkomprimiert:
--, CPU-Zeit = 156 ms, verstrichene Zeit = 214 ms.   51669
--13656 Seiten * 8 KB

--, CPU-Zeit = 156 ms, verstrichene Zeit = 232 ms.

select (51669-13656)*8 --304 MB Ersparnis im RAM

--bei Archivtabellen selten sich �ndernde Tabellen..
--Text besser als Zahlen f�r Kompression

--



create table u2022 (id int identity, jahr int, spx int)

create table u2021 (id int identity, jahr int, spx int)

create table u2020 (id int identity, jahr int, spx int)

create table u2019 (id int identity, jahr int, spx int)


select * from umsatz

create or alter view Umsatz
as
select * from u2022
UNION ALL  --keine Filterung der doppelten Zeilen... kann es gar nicht geben
select * from u2021
UNION ALL
select * from u2020
UNION ALL
select * from u2019

--Bringt das was..?
select * from umsatz where jahr = 2021 --Plan sagt: das macht bisher 0 Sinn!!!!

ALTER TABLE dbo.u2020 ADD CONSTRAINT CK_u2020 CHECK (jahr=2020)
ALTER TABLE dbo.u2021 ADD CONSTRAINT CK_u2021 CHECK (jahr=2021)
ALTER TABLE dbo.u2022 ADD CONSTRAINT CK_u2022 CHECK (jahr=2022)


select * from umsatz where jahr = 2021 
select * from umsatz where id = 2021

--Einschr�nkungen: ��hmm.. ja   kein Identity kein INsert auf die Sicht solange Identity
--der PK muss �ber die Sicht eindeutig werden: PK �ber ID und Jahr

--in vielen F�llen kaum brauchbar. Wenn dann bei Tabellen , die meist nur gelesen werden


--Dateigruppe?
--.mdf = immer in DAteigruppe Primary

create table test (id int)  --ist auf Primary
create table test (id int) on HOT2 --was auch immer HOT2 sein mag.. das weiss der Admin


--Performance in die breite skalierern per mehreren HDDs..


--Partitionierung

--Dateigruppen : bis100, bis200, bis5000, rest

--keine f�hrende Zhal und keine Leerzeichen oder math Operatoren



--F() f�r Zahlenstrahl


--geht auch mit Buchstaben.Hauptsache sortierbar
create partition function fzahlen(int)
as
RANGE LEFT FOR VALUES(100,200)

------100 ----------------------200-------------
--1                    2                                     3


create partition scheme schemaZahl
as
partition fzahlen to (bis100,bis200,rest)
---                                1           2          3

--die DS sind immer dort wo sie sein m�ssen..
--Update auf 17 --> *100   Aus Part1 in Part 3 verschoben



create table parttab (id int identity,nummer int, spx char(4100)) --nicht ohne Dateigruppe, sonst Primary , sondern auf Schema
ON schemaZahl(nummer)


declare @i as int = 1

while @i < 20001
begin
	insert into parttab (nummer, spx) values (@i, 'XY')
	set @i+=1
end


select * from parttab where nummer = 117 --viel besser  1 % vs 99%
select * from parttab where id = 117
select * from parttab where nummer = 1170


--Partitionen verhalten sich wie Tabellen.. fast alles m�glich, was man mit Tabellen auch machen kann
--Part Indizierung  �hnoich wie viele gefilterte Indizes
--auch Kompression pro Partition
--es gibt f�r Tabelle ein neues Sperrniveau: Partitionebene 

--braucht 19800 Seiten .. fast alle Seiten --kommt h�ufig vor
select * from parttab where nummer = 1170

------100---------200-----------------------5000------------------------------------------------

--Idee neue Grenze??
--Tab, Dgruppen, F(), schema
--nie Tabellen�nderung!!    , neue Dgruppe bis5000,  f() muss man �ndern, schema neue DGruppe angeben


--zuerst schema

create partition scheme schemaZahl

alter partition scheme schemaZahl next used bis5000 --kein �nderung bisher

create partition function fZahlen

-----------100-------200-------------------5000  -----------------------------

alter  partition function fZahlen() split range(5000)

select * from parttab where nummer = 1170 --nur noch 4800 Seiten statt 19800


---Grenze entfernen 100

-------------------------200----------------------5000---------------

--Tab? n�   Dgruppe? n�  F() ? jupp  schema? n�

alter partition function fzahlen()  merge range(100)


select * from parttab where nummer = 117

select $partition.fzahlen(117) --2



--A-M         N-R       S-Z
create partition function fKunde(varchar(50))
as
RANGE LEFT FOR VALUES('N'  'S', )

------M  maier ]----------------------200-------------
--1                    2                                     3


--Jahresweise
create partition function fKunde(datetime)--doofes datetime
as
RANGE LEFT FOR VALUES('31.12.2022 23:59:59.997' )


create partition scheme schemaZahl
as
partition fzahlen to ([PRIMARY],[PRIMARY],[PRIMARY])--gehts? macht das Sinn?--immer die eine mdf Datei

--mach Sinn
--verh�lt sich als w�ren es viele kleine Tabellen
create partition scheme schemaZahl
as
partition fzahlen  all to ([PRIMARY])--gehts? macht das Sinn?--immer die eine mdf Datei

----




