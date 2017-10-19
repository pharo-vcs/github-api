request
url
	
	^ self baseUrl / ('/repos/{owner}/{repo}/pulls' format: { 
		'owner' -> ownerName.
		'repo'  -> repositoryName } asDictionary)