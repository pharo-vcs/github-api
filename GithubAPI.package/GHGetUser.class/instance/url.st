requests
url
	
	^ self baseUrl / ('/users/{username}' format: { 
		'username' -> username } asDictionary)