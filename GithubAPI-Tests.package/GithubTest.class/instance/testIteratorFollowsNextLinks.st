tests
testIteratorFollowsNextLinks

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