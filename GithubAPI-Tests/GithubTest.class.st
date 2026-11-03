Class {
	#name : 'GithubTest',
	#superclass : 'TestCase',
	#instVars : [
		'github'
	],
	#category : 'GithubAPI-Tests',
	#package : 'GithubAPI-Tests'
}

{ #category : 'running' }
GithubTest >> setUp [

	super setUp.
	github := GHGithubStub new
]

{ #category : 'tests' }
GithubTest >> testConditionalRequestSendsETagAndAcceptsNotModified [

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
]

{ #category : 'tests' }
GithubTest >> testIteratorFollowsNextLinks [

	| items |
	github answerJSON: '[{"n":1}]' headers: { ('Link'
		 -> '<https://api.github.com/repos/a/b/issues?page=2>; rel="next"') }
			asDictionary.
	github answerJSON: '[{"n":2}]' headers: Dictionary new.
	items := (github iteratorOn:
			          (GHGetRequest url:
					           'https://api.github.com/repos/a/b/issues'))
		         collect: [ :response | response parseJSON ];
		         select: [ :each | true ];
		         until: [ :each | false ];
		         iterate.
	self
		assert: (items collect: [ :each | each at: 'n' ]) asArray
		equals: #( 1 2 ).
	self
		assert: github requests second key
		equals: 'https://api.github.com/repos/a/b/issues?page=2' asZnUrl
]

{ #category : 'tests' }
GithubTest >> testRateLimitedErrorSaysHowLongToWait [

	| response failed |
	response := ZnResponse statusCode: 429.
	response headers at: 'Retry-After' put: '30'.
	github answer: response.
	failed := [
		          github call:
			          (GHGetRequest url: 'https://api.github.com/user').
		          nil ]
		          on: GithubRequestError
		          do: [ :error | error ].
	self assert: failed response isRateLimited.
	self assert: failed response retryAfter equals: 30 seconds
]

{ #category : 'tests' }
GithubTest >> testRepositoryIssuesQueryArguments [

	github answerJSON: '[]' headers: Dictionary new.
	github call: (GHGetRepositoryIssues new
			 ownerName: 'pharo-vcs';
			 repositoryName: 'tonel';
			 state: 'open';
			 since: (DateAndTime
					  year: 2026
					  month: 11
					  day: 3
					  hour: 10
					  minute: 0
					  second: 0
					  offset: Duration zero);
			 perPage: 100;
			 yourself).
	self
		assert: github requests first key
		equals:
			'https://api.github.com/repos/pharo-vcs/tonel/issues?per_page=100&since=2026-11-03T10:00:00Z&state=open'
				asZnUrl
]

{ #category : 'tests' }
GithubTest >> testResponseAnswersETagAndRateLimit [

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
]
