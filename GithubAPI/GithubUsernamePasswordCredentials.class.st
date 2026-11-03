Class {
	#name : 'GithubUsernamePasswordCredentials',
	#superclass : 'Object',
	#instVars : [
		'username',
		'password'
	],
	#category : 'GithubAPI-Core',
	#package : 'GithubAPI',
	#tag : 'Core'
}

{ #category : 'configuring' }
GithubUsernamePasswordCredentials >> configureHttpClient: aZnClient [ 
	
	aZnClient username: username password: password
]

{ #category : 'accessing' }
GithubUsernamePasswordCredentials >> password: aString [ 
	password := aString
]

{ #category : 'accessing' }
GithubUsernamePasswordCredentials >> username: aString [ 
	username := aString
]
