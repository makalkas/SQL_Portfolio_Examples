/****************************************************************************
* AUTHOR: Michael Kalkas
* DATE: 7/10/2022
* DESCRIPTION: Needed to see log data and match to member data.
*****************************************************************************/

USE PartnersDev
GO

SELECT DISTINCT 
       [Record_ID]
      ,[Member_ID]
	  ,s.FirstName
	  ,s.LastName
      ,[Transmit_Result]
      ,[Error_ID]
      ,[Error_Description]
  FROM [PartnersDev].[dbo].[TP_MemberTransmitLog] AS l
		INNER JOIN dbo.TP_Member834_ToSend AS s ON s.ID = l.Record_ID
  WHERE l.Transmit_Result = 'SUCCESS';
