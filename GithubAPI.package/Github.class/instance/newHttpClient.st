helpers
newHttpClient
	
	| client |
	client := ZnClient new.
	credentials configureHttpClient: client.
	client headerAt: 'Accept' put: 'application/vnd.github.v3+json'.
	^ client