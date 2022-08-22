--Kann man ältere DB restoren (mind SQL 2008)
--ja

--SQL 2016 SP1  BAK---> SQL 2016 scheitert

select @@MICROSOFTVERSION


---Warum sehe ich beim Restore kein BAK Files

--Bist du auf dem richtigen Server?
--Korrekte Endung?

--Wer greift auf die Dateien zu?
--nie der User!    es ist der Dienst!!!
--ist es ein Zeitplan=> SQL Agent
--ist es kein Zeitplan=> SQL Server

--Greift man auf lokale Pfade zu gilt nicht das DomKonto des SQL Server oder Agents
 --falls man Domänen USer für die Service verwendet hat
 --für den lokalen Zugriff verwendet SQL Server immer NT Service Konten

 -- im Falle Remotezugriff (\\..) dann gitl entweder das ComputerKonto der das Dom Konto

 schulung\svcSQL
 schulung\sqlagent

 --Restore der restoreme
 select 1600/37  --43MB / sec  --mit TP Restore
 select 1100/3    --366B/Sec    --V+D 

 --Restore der whoami
 --JamesBond kommt nicht mehr rein
 --User ist zwar, aber das Login fehlt (sind in master)
 --PS: auch die Aufträge sind weg
 --Neuerungen SQL 2022 ;-)

 --Aber wie kann man dem JamesBond wieder ein Login geben
 Neues Login JamesBond via Oberfläche-- Grund: neue SID!!

 select * from syslogins
--0x48FA11791DB8F9498CF1588AD567B2E7

select * from sysusers

--Idee 1: Neues Login mit gleicher SID
--Idee 2: Falls Login vorh anden (aber andere SID) , dann die SID in der DB angleichen
--Idee 3 Workaround

--depricated
use whoami
exec sp_change_users_login 'Report'


exec sp_change_users_login 'Auto_fix', 'JamesBond',NULL, 'ppedv2019!'

exec sp_change_users_login 'Update_one', 'JamesBond','JamesBond'


--sp_help_revlign
Bsp: für autom Generieren:
sqlcmd -i -c:\extractlogins.sql -oc:\Logins.sql  -E -SHvSQL1


--Restorefehler: sp_configure
EXEC sys.sp_configure N'contained database authentication', N'1'
GO
RECONFIGURE WITH OVERRIDE
GO

CREATE DATABASE [ContainedDB]
 CONTAINMENT = PARTIAL
 ON  PRIMARY 
( NAME = N'ContainedDB', FILENAME = N'D:\_SQLDBDATA\ContainedDB.mdf' , SIZE = 8192KB , FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ContainedDB_log', FILENAME = N'D:\_SQLDBLOG\ContainedDB_log.ldf' , SIZE = 8192KB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [ContainedDB] SET COMPATIBILITY_LEVEL = 150
GO
ALTER DATABASE [ContainedDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ContainedDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ContainedDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ContainedDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ContainedDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [ContainedDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ContainedDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ContainedDB] SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF)
GO
ALTER DATABASE [ContainedDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ContainedDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ContainedDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ContainedDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ContainedDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ContainedDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ContainedDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ContainedDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ContainedDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ContainedDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ContainedDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ContainedDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ContainedDB] SET  READ_WRITE 
GO
ALTER DATABASE [ContainedDB] SET RECOVERY FULL 
GO
ALTER DATABASE [ContainedDB] SET  MULTI_USER 
GO
ALTER DATABASE [ContainedDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ContainedDB] SET DEFAULT_FULLTEXT_LANGUAGE = 1031 
GO
ALTER DATABASE [ContainedDB] SET DEFAULT_LANGUAGE = 1031 
GO
ALTER DATABASE [ContainedDB] SET NESTED_TRIGGERS = ON 
GO
ALTER DATABASE [ContainedDB] SET TRANSFORM_NOISE_WORDS = OFF 
GO


--Benutzer mit Kennwort????
USE [ContainedDB]
GO
CREATE USER [Max] WITH PASSWORD=N'ppedv2019!'
GO



