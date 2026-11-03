Class {
	#name : 'GithubTokenCredentials',
	#superclass : 'Object',
	#instVars : [
		'token'
	],
	#category : 'GithubAPI-Core',
	#package : 'GithubAPI',
	#tag : 'Core'
}

{ #category : 'instance creation' }
GithubTokenCredentials class >> token: aToken [
	^ self new
		token: aToken;
		yourself
]

{ #category : 'accessing' }
GithubTokenCredentials >> configureHttpClient: aZnClient [ 
	
	aZnClient headerAt: 'Authorization' put: ('token ' , token)

]

{ #category : 'accessing' }
GithubTokenCredentials >> token [
	^ token
]

{ #category : 'accessing' }
GithubTokenCredentials >> token: anObject [
	token := anObject
]
