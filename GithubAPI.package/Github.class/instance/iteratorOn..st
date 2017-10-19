helpers
iteratorOn: aRequest
	
	^ GHRequestIterator new
		github: self;
		initialRequest: aRequest