/**********************************************************************************
* Author: Michael Kalkas
* DATE: 2/20/21
* Description: This script was used to reset tables & procedures during development when
*              new columns, keys, indexes needed to be added to system and/or requirement
*              changes required compleate procedure changes.
**********************************************************************************/

USE PartnersDev
GO

DROP TABLE IF EXISTS dbo.TP_Member834_ToSend;
DROP TABLE IF EXISTS dbo.TP_MemberPossibleTP_PCPs;
DROP TABLE IF EXISTS dbo.TP_MemberSentLog;
DROP TABLE IF EXISTS dbo.TP_MemberTPPCP;
GO

DROP PROCEDURE IF EXISTS
	dbo.TP_GetNewMembers,
	dbo.TP_DetermineCareTaker,
	dbo.TP_DeterminePriorityServices,
	dbo.TP_DetermineFamilyMemberAssociations,
	dbo.TP_DeterminePossibleTP_PCP,
	dbo.TP_AssignTP_PCP;
GO
