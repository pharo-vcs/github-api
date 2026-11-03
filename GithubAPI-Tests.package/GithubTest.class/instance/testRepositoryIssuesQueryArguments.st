tests
testRepositoryIssuesQueryArguments

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