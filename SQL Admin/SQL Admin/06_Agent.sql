--SQL AGENT -----

--Jobs, Zeitpläne, Email
--Job hat Schritte (PS, CMD, TSQL, SSIS , SSAS, REPL)


--EMAIL: Nachricht zum Joberfolg
--             Abfrageergbenisse
			-- SMTP Zugang

--Proxy: ausführen als
--nicht jedes Script soll der Agent ausführen können.. sprich AGent soll kein DomAdmin werden

--Proxy besteht aus Anmeldeinfoirmation (Sicherheit)

-- Warnungen (Alerts)
--Ebene 16  Error 206
--Ebene 15
--Ebene 9 
--1 bis 10 ist egal.. sind Infos
--11 bis 16 .. Daufehler 
--14 Security
--ab 17 hellhörig
--bis 25


select * from sysmessages where msglangid = 1031


---EMAIL.......

--Agent  / SQL Server können SMTP Client sein

-- SMTP Server - Zugangsdaten
-- HV-SQL1    Port 25  Auth .. brauchen wir keine

--Profile:(dahinter verstecken sich alle zugangsdaten)

--Dem Gast wurd das Recht auf das Profil gegeben


--Ziel: der Operator soll ne Mail bekommen
--dem Agent das Profil zuweisen
--Agent neu starten
--dann sollte es ab SQL 2016 klappen..












--Operatoren
-- = Kontaktliste (Email oder Pager)


select * from orders where orderid = 10 by order 1

select * orders

