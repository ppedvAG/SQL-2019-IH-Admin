--HARDWARE
--HDD RAM
--CPU

--DB (trenne Datendatei Logfile)


--Unser Host:

/*

16 GB
1 Socket 
4 Kerne/2 Kerne
1 HDD

16 GB - (OS + Virtualisierung) -4 GB = 12 GB
12-2048 

CPU                     1
RAM                    WINDOWS                                     SQL (MAX RAM)      CPU
HV-DC				2048MB dynamisch																1
HV-SQL1            statisch  5 GB									 3000MB					       4
HV-SQL2			statisch 5 GB									 3000MB                       4

Beachte NUMA Knoten (zuordnung Socket zu Speicherslots.. )  sollte immer die akt Hardware wiederspieglen.

schulung\Administrator
ppedv2019!











































*/