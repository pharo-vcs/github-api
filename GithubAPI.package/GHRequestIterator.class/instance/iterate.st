execution
iterate
	
	| response iterables resultStream finished |
	response := github call: request.
	resultStream := OrderedCollection new writeStream.
	finished := false.
	[ finished ] whileFalse: [
		iterables := collectBlock value: response.
		resultStream nextPutAll: (iterables select: selectBlock).
		
		finished := (iterables anySatisfy: finishBlock)
			or: [ response hasNext not ].
		finished ifFalse: [ response := response next ]
	].
	^ resultStream contents