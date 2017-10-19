testing
hasLast
	
	| linksString |
	linksString := response headers at: 'Link' ifAbsent: [ ^ false ].
	^ self links anySatisfy: [ :link | link rel = 'last' ]