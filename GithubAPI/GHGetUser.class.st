Class {
	#name : 'GHGetUser',
	#superclass : 'GHGetRequest',
	#instVars : [
		'username'
	],
	#category : 'GithubAPI-Requests',
	#package : 'GithubAPI',
	#tag : 'Requests'
}

{ #category : 'requests' }
GHGetUser >> url [
	
	^ self baseUrl / ('/users/{username}' format: { 
		'username' -> username } asDictionary)
]

{ #category : 'accessing' }
GHGetUser >> username: aString [ 
	username := aString
]
