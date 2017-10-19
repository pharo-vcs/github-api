call
call: aRequest
	
	| client |
	client := self newHttpClient.
	client url: aRequest url.
	aRequest requestTo: client.
	client response isSuccess
		ifFalse: [ GithubRequestError signal: client response ].
	^ GHResponse new
		response: client response;
		github: self