call
responseFor: aRequest ifNoneMatch: anETagOrNil

	| client |
	client := ZnClient new.
	client url: aRequest url.
	aRequest queryArguments keysAndValuesDo: [ :key :value |
		client queryAt: key put: value ].
	requests add: client request url -> anETagOrNil.
	sent add: aRequest.
	^ responses removeFirst