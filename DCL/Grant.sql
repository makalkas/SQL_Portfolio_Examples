/****************************************************************************************
* Author: Michael Kalkas
* Date: 5/16/2022
* Description: This script adds the Login, User and permissions for the Windows service
*              I am building that sends member data for assignment to NCFast.
****************************************************************************************/
USE PartnersDev
GO

CREATE LOGIN <domainName>\WindowsServiceTransmit FROM WINDOWS;
GO

CREATE USER WindowsServiceTransmit FROM <domainName>\WindowsServiceTransmit
Go

GRANT EXECUTE ON TP_Member834_ToSend TO ServiceTransmit WITH GRANT OPTION;
EXEC sp_addrolemember ServiceTransmit, WindowsServiceTransmit;


Go
