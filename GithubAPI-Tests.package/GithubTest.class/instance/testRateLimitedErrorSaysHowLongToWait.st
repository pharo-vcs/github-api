tests
testRateLimitedErrorSaysHowLongToWait

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