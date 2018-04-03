request
url
	
	^ self baseUrl / ('/repos/{owner}/{repo}/pulls/{number}' format: { 
		'owner' -> ownerName.
		'repo'  -> repositoryName.
		'number' -> number } asDictionary)