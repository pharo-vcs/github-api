tests
testCombinedStatusOfACommit

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