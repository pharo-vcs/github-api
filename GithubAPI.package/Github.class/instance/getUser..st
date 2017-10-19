requests
getUser: aString 
	
	^ self call: (GHGetUser new
		username: aString;
		yourself)