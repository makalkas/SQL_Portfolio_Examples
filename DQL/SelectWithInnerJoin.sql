USE PersonDB
GO

SELECT P.FirstName,P.LastName,CI.PhoneType,CI.Phone

FROM People AS P
	INNER JOIN
	[People.DetailContactInfo] AS CI ON P.ID = CI.DetailID
ORDER BY P.LastName