requests
url
	
	^ self baseUrl / ('/repos/{owner}/{repo}/releases{latest}' format: { 
		'owner' -> ownerName.
		'repo'  -> repositoryName.
		'latest' -> (latest ifTrue: ['/latest'] ifFalse: ['']) } asDictionary)