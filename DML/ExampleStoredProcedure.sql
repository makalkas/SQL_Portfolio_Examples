/* Problem: New production line has been added that has a QC station and new test data needs loaded into the existing QC table. 
* Solution: Use a stored procedure [spQC_Move] to move data to local table.
* Author: Michael Kalkas
* Date: 10/6/2020
*/

USE [QCDataDB]
GO
/****** Object:  StoredProcedure [dbo].[spCustomer_GetAll]    Script Date: 10/06/2020 2:00:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[spMagentaLine_MoveQCData]
	
AS
BEGIN
	
	EXEC [dbo].[spQC_Move] 'MagentaLine', '7';
END