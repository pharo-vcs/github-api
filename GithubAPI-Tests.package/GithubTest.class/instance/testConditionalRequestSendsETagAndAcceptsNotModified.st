tests
testConditionalRequestSendsETagAndAcceptsNotModified

	| response |
	github answer: (ZnResponse new
			 statusLine: (ZnStatusLine code: 304);
			 headers: ZnHeaders new;
			 yourself).
	response := github
		            call: (GHGetRepositoryIssues new
				             ownerName: 'pharo-vcs';
				             repositoryName: 'tonel';
				             yourself)
		            ifNoneMatch: 'W/"abc"'.
	self assert: response isNotModified.
	self assert: github requests first value equals: 'W/"abc"'