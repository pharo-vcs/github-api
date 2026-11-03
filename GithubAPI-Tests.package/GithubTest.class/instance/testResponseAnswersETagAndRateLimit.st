tests
testResponseAnswersETagAndRateLimit

	| response |
	github answerJSON: '[]' headers: {
			('ETag' -> 'W/"abc"').
			('X-RateLimit-Remaining' -> '4999').
			('X-RateLimit-Reset' -> '1700000000') } asDictionary.
	response := github call:
		            (GHGetRequest url:
			             'https://api.github.com/repos/a/b/issues').
	self assert: response etag equals: 'W/"abc"'.
	self assert: response rateLimitRemaining equals: 4999.
	self
		assert: response rateLimitReset
		equals: (DateAndTime fromUnixTime: 1700000000).
	self deny: response isNotModified