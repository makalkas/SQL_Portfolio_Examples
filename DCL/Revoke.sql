/****************************************************************************************
* Author: Michael Kalkas
* Date: 5/18/2022
* Description: This script removes the User and permissions for an old Windows service
*              that was previously attempted by a developer and drops an old user.
****************************************************************************************/

USE PartnersDev
GO

REVOKE ALL FROM DWestbrookTestService;

GO

DROP USER IF EXISTS TMartin;
GO
