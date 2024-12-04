/********************************************************************************
* AUTHOR: Michael Kalkas
* DATE: 7/12/2021
* DESCRIPTION: This stored procedure was a test to demonstrate ensuring the member
*			   Record update occures when the log record is created from an SP
* 
*********************************************************************************/

USE PartnersDev
GO

CREATE PROCEDURE sp_CreateNCFastLogRecord
  @transDate datetime,
  @recordID bigint,
  @memberID bigint,
  @tp_PCPId nchar(10),
  @result nchar(10),
  @errorID nchar(10) = null,
  @description nvarchar(max) = null
AS
BEGIN
SET NOCOUNT ON;
BEGIN TRANSACTION;

BEGIN TRY
	INSERT INTO [dbo].[TP_MemberTransmitLog] (Transmit_Date, Record_ID, Member_ID, TP_PCP_ID, Transmit_Result, Error_ID, Error_Description)
    VALUES (@transDate, @recordID, @memberID, @tp_PCPId, @result, @errorID, @description);

	UPDATE m
	SET m.TransDateTime = @transDate,
		m.TransmitID = l.ID,
		m.SentToNCFast = 1,
		m.UpdatedDate = GETDATE()

	FROM [dbo].TP_Member834_ToSend AS m
		INNER JOIN TP_MemberTransmitLog as l ON l.Record_ID = m.ID
	WHERE m.ID = @recordID;

	COMMIT TRANSACTION;
END TRY
BEGIN CATCH
	 IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;

END CATCH
END