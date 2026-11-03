Class {
	#name : 'GHGetRequest',
	#superclass : 'Object',
	#category : 'GithubAPI-Core',
	#package : 'GithubAPI',
	#tag : 'Core'
}

{ #category : 'instance-creation' }
GHGetRequest class >> url: aString [ 
	
	^ GHGenericGetRequest new
		url: aString;
		yourself
]

{ #category : 'request' }
GHGetRequest >> baseUrl [

	^ 'https://api.github.com' asZnUrl 
]

{ #category : 'request' }
GHGetRequest >> queryArguments [
	
	^ #()
]

{ #category : 'requests' }
GHGetRequest >> requestTo: aZnClient [ 
	
	self setQueryArgumentsToClient: aZnClient.
	aZnClient get
]

{ #category : 'requests' }
GHGetRequest >> setQueryArgumentsToClient: aZnClient [ 
	
	self queryArguments keysAndValuesDo: [ :key :value |
		aZnClient queryAt: key put: value ]
]

{ #category : 'requests' }
GHGetRequest >> url [

	self subclassResponsibility
]
