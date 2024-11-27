USE [PBIReporting]
GO
/****** Object:  StoredProcedure [dbo].[PI_GETDryerData]    Script Date: 3/31/2021 2:04:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*-------------------------------------------------------------------------------------------------------
** This procedure inserts records from the PI ODBC service brought in through a link server object. 
** It cleans duplicate records from the select queries and inserts the distinct record int the table.
** This Stored procedures requires availability of the link server object:[FT HISTORIAN PI].[piarchive]..[picomp]
** and the base table dbo.TankLevels.
** AUTHOR: Michael Kalkas
** DATE: 3/31/2021
**------------------------------------------------------------------------------------------------------*/


CREATE PROCEDURE [dbo].[PI_GETTankLevels]

AS
BEGIN
	DECLARE @StartDate DATE
	DECLARE @EndtDate DATE
	DECLARE @CurrentDate DATE

	SET @CurrentDate = GETDATE() --'2019-09-19'
	SET @StartDate = DATEADD(ww, DATEDIFF(ww, -1, @CurrentDate),-1)
	SET @EndtDate = DATEADD(ww, DATEDIFF(ww, 5, @CurrentDate), 5)

	BEGIN
		WITH CTETankLevels (tag, SampleTime, Inst_Value) AS (
			SELECT [tag] as tag
				   ,Convert(DateTime,[time]) AS SampleTime
				   ,Convert(float,[value]) AS Inst_Value      
			FROM [FT HISTORIAN PI].[piarchive]..[picomp]
			WHERE [tag] LIKE 'Primary Utilites TNK0%' AND [time] >= @StartDate AND [time] < @EndtDate AND [value] >0 
		)
		INSERT INTO dbo.TankLevels (TAG, Time_Stamp, Inst_VALUE)
		SELECT tag, SampleTime, Inst_Value FROM CTETankLevels
		WHERE  NOT EXISTS (
			SELECT TLevels.TAG, TLevels.Time_Stamp, TLevels.Inst_VALUE
			FROM dbo.TankLevels AS TLevels
			WHERE (TLevels.TAG = CTETankLevels.tag) AND (TLevels.Time_Stamp = CTETankLevels.SampleTime)
			);
	END;
END
