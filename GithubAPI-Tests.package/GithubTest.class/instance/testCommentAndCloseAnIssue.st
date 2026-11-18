tests
testCommentAndCloseAnIssue

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