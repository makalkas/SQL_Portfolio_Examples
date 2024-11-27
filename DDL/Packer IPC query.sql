USE [Manufacturing_DCS]
GO
/****** Object:  StoredProcedure [dbo].[spDCS_QueryIPC_SHIFT_Speed_History]    Script Date: 3/25/2021 1:55:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*********************************************************************************************************
* Author: Michael Kalkas
* Date: 3/26/2021
* Description: This is a Open Query for getting information from each wrapper/packer IPC view V_Stat_Shift_Machine_Speed
*              as part of the data needed for Bulding25 and their AI reporting.
*
* Parameters:
*   @Node - The linked server name for the line and maker where data will be pulled from (E.g. IPC610MK)
*   @lastSmpleDate - This should be the last date time for records already stored in the database table.
*
* Returns:
*   This stored procedure should return a table with record(s) giving 3 minute sample data for speed of
*   the wrapper/packer/cartonner.
**********************************************************************************************************/
CREATE PROCEDURE [dbo].[spDCS_QueryPK_IPC_SHIFT_Speed_History] 
	  @Line int,
	  @Node varchar(25)
	, @lastSampleDate DateTime = NULL
AS

DECLARE @sqlQuery VARCHAR(2000)
DECLARE @finalQuery VARCHAR(2000)

SET @sqlQuery = 'SELECT [MACHINE_NAME],[SHIFT_DATE_START],[SPEED],[SAMPLE_DATE] FROM ' + @Node + '..[MICRO3].[V_STAT_SHIFT_MACH_SPEED]'

IF @lastSampleDate <> null	
	SET @sqlQuery = @sqlQuery + ' WHERE [SAMPLE_DATE] > ' + @lastSampleDate
	

DECLARE @LineSpeeds Table
		(
			Line int, MACHINE_NAME varchar(50) ,SHIFT_DATE_START DateTime ,SPEED int ,SAMPLE_DATE DateTime
			PRIMARY KEY (MACHINE_NAME, SAMPLE_DATE)
		)
INSERT INTO @LineSpeeds ( MACHINE_NAME ,SHIFT_DATE_START ,SPEED ,SAMPLE_DATE )
EXEC(@sqlQuery)

UPDATE @LineSpeeds
SET Line = @Line

SELECT * FROM @LineSpeeds
