USE [Manufacturing_DCS]
GO
/****** Object:  StoredProcedure [dbo].[spAPPS_GetMachinePanelNodeStatus]    Script Date: 7/2/2021 11:12:26 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*==========================================================================================================================================
* Author:	   Michael Kalkas
* Create date: 07/02/2021
* Description: This stored procedure is used by the Machine Panel applications to set current node status table details for a machine panel
*              Node. The data will be exposed through a service so this procedure will use an SQL Clean function to eliminate possibility of
*              SQL injection.
*============================================================================================================================================*/
CREATE PROCEDURE [dbo].[spPanel_SetMachinePanelNodeStatus]
	 @strWorkstation varchar(50)
	,@strSoftwareCode varchar(50) = null
	,@strVersion varchar(50) = null
	,@dtStartup datetime = GETDATE
	,@dtServer datetime = GETDATE
	,@dtLocal datetime = GETDATE
	,@strMode varchar(50) = null
    ,@strRecent varchar(100) = null
    ,@strLSF varchar(3) = null
    ,@strLineMachine varchar(50) = null
AS
BEGIN
	-- ensure all strings are cleaned to prevent unintentional query injection
	SET @strWorkstation = dbo.ufnSQLCLEAN(@strWorkstation);
	SET @strSoftwareCode = dbo.ufnSQLCLEAN(@strSoftwareCode);
	SET @strVersion = dbo.ufnSQLCLEAN(@strVersion);
	SET @strMode = dbo.ufnSQLCLEAN(@strMode);
	SET @strRecent = dbo.ufnSQLCLEAN(@strRecent);
	SET @strLineMachine = dbo.ufnSQLCLEAN(@strLineMachine);

	--Check to see if there is an already existing record and if so update it, if not insert a new record
	DECLARE @RecordExists int = (SELECT COUNT(*) FROM [Manufacturing_DCS].[dbo].[xDCS_AppStatus] WHERE [strWorkstation] = @strWorkstation)

	IF(@RecordExists = 1)
		BEGIN
			UPDATE [Manufacturing_DCS].[dbo].[xDCS_AppStatus]
			SET [strSoftwareCode] = @strSoftwareCode,[strVersion] = @strVersion, [dtStartup] = @dtStartup, [dtServer] = @dtServer,
				[dtLocal] = @dtLocal, [strMode] = @strMode, [strRecent] = @strRecent, [strLSF] = @strLSF, [strLineMachine] = @strLineMachine
			WHERE [strWorkstation] = @strWorkstation
		END
	ELSE
		IF(@RecordExists = 0)
		BEGIN
			INSERT INTO [Manufacturing_DCS].[dbo].[xDCS_AppStatus] ([strWorkstation],[strSoftwareCode],[strVersion],[dtStartup],[dtServer]
			,[dtLocal],[strMode],[strRecent],[strLSF],[strLineMachine])
			VALUES  (@strWorkstation ,@strSoftwareCode,@strVersion,@dtStartup,@dtServer,@dtLocal,@strMode,@strRecent,@strLSF,@strLineMachine)
		END
END
