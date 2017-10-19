requests
getOrganizationsFromUser: aString 
	
	^ self call: (GHGetUserOrganizations new
		username: aString;
		yourself)