requests
getRepositoriesFromUser: aString 
	
	^ self call: (GHGetUserRepositories new
		username: aString;
		yourself)