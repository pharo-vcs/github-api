accessing
configureHttpClient: aZnClient 
	
	aZnClient headerAt: 'Authorization' put: ('token ' , token)
