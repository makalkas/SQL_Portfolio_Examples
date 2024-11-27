USE [Manufacturing_DCS]
GO
/****** Object:  StoredProcedure [dbo].[spDCS_Update_Mach_Shift_Speed_History]    Script Date: 9/16/2021 10:10:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/**************************************************************************************************************************************
* Author: Michael Kalkas
* Date: 09/16/2021
* Description: This stored procedure cleans speed data in table xLine_PK_Mach_Shift_Speed_History. The dirty data comes from miss configured
*              Time parameters on the line PLCs. 
* Parameters:
*     None
*
***************************************************************************************************************************************/
CREATE PROCEDURE [dbo].[spDCS_Clean_PK_Mach_Shift_Speed_History] 
   
AS
BEGIN

  --First Shift
  UPDATE xLine_PK_Mach_Shift_Speed_History
  SET SHIFT_DATE_START = CONVERT(DateTime, CONVERT(varchar(25), CONVERT(date, SHIFT_DATE_START,102) ) + SPACE(1) + CONVERT(varchar(25),'07:00:00.000') )
  WHERE CONVERT(time, SHIFT_DATE_START)  <> '07:00:00.000' AND CONVERT(time, SHIFT_DATE_START)  <> '15:00:00.000' AND CONVERT(time, SHIFT_DATE_START)  <> '23:00:00.000' AND CONVERT(time, SAMPLE_DATE) >= '07:00:00.000' AND CONVERT(time, SAMPLE_DATE) < '15:00:00.000'

  --Second Shift
  UPDATE xLine_PK_Mach_Shift_Speed_History
  SET SHIFT_DATE_START = CONVERT(DateTime, CONVERT(varchar(25), CONVERT(date, SHIFT_DATE_START,102) ) + SPACE(1) + CONVERT(varchar(25),'15:00:00.000') )
  WHERE CONVERT(time, SHIFT_DATE_START)  <> '07:00:00.000' AND CONVERT(time, SHIFT_DATE_START)  <> '15:00:00.000' AND CONVERT(time, SHIFT_DATE_START)  <> '23:00:00.000' AND CONVERT(time, SAMPLE_DATE) >= '15:00:00.000' AND CONVERT(time, SAMPLE_DATE) < '23:00:00.000'

  --Third Shift
  UPDATE xLine_PK_Mach_Shift_Speed_History
  SET SHIFT_DATE_START = CONVERT(DateTime, CONVERT(varchar(25), CONVERT(date, SHIFT_DATE_START,102) ) + SPACE(1) + CONVERT(varchar(25),'23:00:00.000') )
  WHERE CONVERT(time, SHIFT_DATE_START)  <> '07:00:00.000' AND CONVERT(time, SHIFT_DATE_START)  <> '15:00:00.000' AND CONVERT(time, SHIFT_DATE_START)  <> '23:00:00.000' AND CONVERT(time, SAMPLE_DATE) >= '23:00:00.000' AND CONVERT(time, SAMPLE_DATE) < '23:59:59.999'

  UPDATE xLine_PK_Mach_Shift_Speed_History
  SET SHIFT_DATE_START = CONVERT(DateTime, CONVERT(varchar(25), CONVERT(date, SHIFT_DATE_START,102) ) + SPACE(1) + CONVERT(varchar(25),'23:00:00.000') )
  WHERE CONVERT(time, SHIFT_DATE_START)  <> '07:00:00.000' AND CONVERT(time, SHIFT_DATE_START)  <> '15:00:00.000' AND CONVERT(time, SHIFT_DATE_START)  <> '23:00:00.000' AND CONVERT(time, SAMPLE_DATE) >= '00:00:00.000' AND CONVERT(time, SAMPLE_DATE) < '07:00:00.000'

END