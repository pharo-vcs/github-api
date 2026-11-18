Class {
	#name : 'GHRequestIterator',
	#superclass : 'Object',
	#instVars : [
		'github',
		'request',
		'collectBlock',
		'selectBlock',
		'finishBlock'
	],
	#category : 'GithubAPI-Core',
	#package : 'GithubAPI',
	#tag : 'Core'
}

{ #category : 'combinators' }
GHRequestIterator >> collect: aBlockClosure [ 
	
	collectBlock := aBlockClosure
]

{ #category : 'accessing' }
GHRequestIterator >> github: aGithub [ 
	github := aGithub
]

{ #category : 'accessing' }
GHRequestIterator >> initialRequest: initialRequest [ 
	
	request := initialRequest
]

{ #category : 'execution' }
GHRequestIterator >> iterate [
	
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
]

{ #category : 'combinators' }
GHRequestIterator >> select: aBlockClosure [ 
	
	selectBlock := aBlockClosure
]

{ #category : 'accessing' }
GHRequestIterator >> until: aBlockClosure [ 
	
	finishBlock := aBlockClosure
]
