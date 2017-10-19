requests
url
	
	^ self baseUrl / ('/repos/{owner}/{repo}/issues' format: { 
		'owner' -> ownerName.
		'repo'  -> repositoryName } asDictionary)