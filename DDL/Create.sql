/*
* problem: Needed a simple "poeple" table for demonstration of a Blazor project. I decided to also add contact information in another table.
* Thoughts: I wanted to create a that had an auto-increment PrimayKey that I could use to link to another table 
* Date: 8/15/2024
*/
USE [PersonDB]
GO

CREATE TABLE [dbo].[People](
	[ID] [BIGINT] IDENTITY NOT NULL PRIMARY KEY CLUSTERED,
	[FirstName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
	[DateOfBirth] [datetime] NULL,
	[EmailAddress] [nvarchar](50) NULL)
GO
CREATE TABLE [dbo].[People.DetailContactInfo](
	[DetailID] [BIGINT] NOT NULL,
	[PhoneType] varchar(50) NOT NULL,
	[Phone] [BIGINT] NULL,
	CONSTRAINT PK_People PRIMARY KEY NONCLUSTERED (DetailID,PhoneType),
	CONSTRAINT FK_People_ContactInfo FOREIGN KEY (DetailID)
		REFERENCES People(ID)
)
