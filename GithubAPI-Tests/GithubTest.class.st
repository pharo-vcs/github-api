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
GithubTest >> testCheckRunsOfACommit [

	| response |
	github
		answerJSON:
		'{"total_count":1,"check_runs":[{"name":"build","status":"completed","conclusion":"success"}]}'
		headers: { ('ETag' -> 'W/"c1"') } asDictionary.
	response := github call: (GHGetCheckRuns new
			             ownerName: 'pharo-vcs';
			             repositoryName: 'tonel';
			             ref: 'abc123';
			             perPage: 100;
			             yourself).
	self
		assert: github requests first key
		equals:
			'https://api.github.com/repos/pharo-vcs/tonel/commits/abc123/check-runs?per_page=100'
				asZnUrl.
	self
		assert:
		((response parseJSON at: 'check_runs') first at: 'conclusion')
		equals: 'success'.
	self assert: response etag equals: 'W/"c1"'
]

{ #category : 'tests' }
GithubTest >> testCombinedStatusOfACommit [

	| response |
	github
		answerJSON:
		'{"state":"failure","statuses":[{"context":"continuous-integration/jenkins/pr-head","state":"failure","target_url":"https://ci.example.org/job/1/"}]}'
		headers: { ('ETag' -> 'W/"s1"') } asDictionary.
	response := github call: (GHGetCombinedStatus new
			             ownerName: 'pharo-project';
			             repositoryName: 'pharo';
			             ref: 'abc123';
			             perPage: 100;
			             yourself).
	self
		assert: github requests first key
		equals:
			'https://api.github.com/repos/pharo-project/pharo/commits/abc123/status?per_page=100'
				asZnUrl.
	self
		assert: ((response parseJSON at: 'statuses') first at: 'target_url')
		equals: 'https://ci.example.org/job/1/'
]

{ #category : 'tests' }
GithubTest >> testCommentAndCloseAnIssue [

	github
		answer: (ZnResponse statusCode: 201);
		answer: (ZnResponse statusCode: 200).
	github call: (GHCreateIssueComment new
			 ownerName: 'a';
			 repositoryName: 'b';
			 number: 7;
			 text: 'Thanks';
			 yourself).
	github call: (GHUpdateIssue new
			 ownerName: 'a';
			 repositoryName: 'b';
			 number: 7;
			 closeAsNotPlanned;
			 yourself).
	self
		assert: github requests first key
		equals: 'https://api.github.com/repos/a/b/issues/7/comments' asZnUrl.
	self assert: github sent first httpMethod equals: #POST.
	self
		assert: github sent first body
		equals: { ('body' -> 'Thanks') } asDictionary.
	self
		assert: github requests second key
		equals: 'https://api.github.com/repos/a/b/issues/7' asZnUrl.
	self assert: github sent second httpMethod equals: #PATCH.
	self assert: github sent second body equals: {
			('state' -> 'closed').
			('state_reason' -> 'not_planned') } asDictionary
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
