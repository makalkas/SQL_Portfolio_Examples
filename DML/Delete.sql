/************************************************************************************
* AUTHOR: Michael Kalkas
* DATE: 10/16/2021
* DESCRIPTION: During testing current process is sending all records to NCFast. This
*              means we need to delete anything that has been sent previously.
*
************************************************************************************/

USE PartnersDev
GO

DELETE FROM TP_Members834_ToSend WHERE SentToNCFast = 1;
GO
