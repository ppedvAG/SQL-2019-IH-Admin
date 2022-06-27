select name,* from syslogins

use Northwind


select * from sysusers

USE [master]
GO
CREATE LOGIN [Hans] WITH PASSWORD=N'123', DEFAULT_DATABASE=[Northwind], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO


--Login scheitert , weil kein Recht auf die DB northwind vorehanden war



--ROLLE = GRUPPE
--SCHEMA = ORDNER

USE [Northwind]
GO
CREATE SCHEMA [FE] AUTHORIZATION [dbo]
GO


USE [Northwind]
GO
CREATE SCHEMA [IT] AUTHORIZATION [dbo]
GO

use [Northwind]
GO
GRANT SELECT ON SCHEMA::[FE] TO [Maria]
GO


USE [Northwind]
GO
ALTER USER [Hans] WITH DEFAULT_SCHEMA=[IT]
GO


USE [Northwind]
GO
ALTER USER MARIA WITH DEFAULT_SCHEMA=[FE]
GO


use [Northwind]
GO
GRANT CREATE TABLE TO [Maria]
GO


use [Northwind]
GO
GRANT ALTER ON SCHEMA::[FE] TO [Maria]
GO


--das alter recht deckt DROP UND CREATE mit ab

use [Northwind]
GO
GRANT ALTER ON SCHEMA::[IT] TO [Hans]
GO



USE [Northwind]
GO
CREATE ROLE [FERolle] AUTHORIZATION [dbo]
GO
USE [Northwind]
GO
ALTER ROLE [FERolle] ADD MEMBER [Maria]
GO
