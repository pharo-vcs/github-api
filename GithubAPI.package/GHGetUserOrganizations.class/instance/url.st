requests
url
	
	^ self baseUrl / ('/users/{username}/orgs' format: { 
		'username' -> username } asDictionary)