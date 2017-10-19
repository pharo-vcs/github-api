requests
url
	
	^ self baseUrl / ('/users/{username}/repos' format: { 
		'username' -> username } asDictionary)