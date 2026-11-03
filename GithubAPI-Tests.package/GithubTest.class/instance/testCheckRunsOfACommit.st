tests
testCheckRunsOfACommit

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