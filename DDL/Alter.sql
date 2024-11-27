USE [Manufacturing_DCS]
GO
/****** Object:  UserDefinedFunction [dbo].[ufnSQLCLEAN]    Script Date: 7/2/2021 2:49:24 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*************************************************************************************************************************
* Author: Michael Kalkas
* Date: 07/02/2021
* Description: Created this function to clean varchars to ensure no unintentional query injection through the Varchar
*
**************************************************************************************************************************/
ALTER Function [dbo].[ufnSQLCLEAN] (@strText VARCHAR(1000))
RETURNS VARCHAR(1000)
AS
BEGIN
	WHILE PATINDEX('%[^0-9,a-z,'' '',.,-]%', @strText) > 0
	BEGIN
		SET @strText = STUFF(@strText, PATINDEX('%[^0-9,a-z,'' '',.,-]%', @strText), 1, '')
	END
	RETURN @strText
END
