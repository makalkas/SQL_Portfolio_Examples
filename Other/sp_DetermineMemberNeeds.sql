/**************************************************************************
* AUTHOR: Michael Kalkas
* DATE: 8/09/2021
* DESCRIPTION: This stored procedure determines member needs and updates 
*              the Talored Plan PCP for each unassigned member based on 
*              TP conditions and requirements.
**************************************************************************/

USE PartnersDev
GO

CREATE PROCEDURE sp_DetermineMemberNeeds

AS
BEGIN
DROP TABLE IF EXISTS #MembersWhoNeedTPPCP
CREATE TABLE #MembersWhoNeedTPPCP(
	ID nvarchar(10),
	RowIDNumber bigint	
);

DECLARE @members INT;
DECLARE @currentRow bigint;
DECLARE @currentMemberID nvarchar(10);

INSERT INTO #MembersWhoNeedTPPCP( ID, RowIDNumber )
SELECT MemberID, ID FROM dbo.TP_Member834_ToSend WHERE PCP_ID is null OR PCP_ID ='' 


SET @members = (SELECT COUNT(m.ID) FROM #MembersWhoNeedTPPCP AS m)
WHILE(@members >0)
BEGIN
SELECT TOP 1 @currentRow = RowIDNumber, @currentMemberID = ID FROM #MembersWhoNeedTPPCP;

EXEC sp_UpdateMemberPCP(@currentRow, @currentMemberID);

DELETE 
FROM #MembersWhoNeedTPPCP
WHERE ID = @currentMemberID AND RowIDNumber = @currentRow

SET @members = @members-1;
END

DROP TABLE IF EXISTS #MembersWhoNeedTPPCP
END
