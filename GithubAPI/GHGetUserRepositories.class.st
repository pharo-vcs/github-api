Class {
	#name : 'GHGetUserRepositories',
	#superclass : 'GHGetRequest',
	#instVars : [
		'username'
	],
	#category : 'GithubAPI-Requests',
	#package : 'GithubAPI',
	#tag : 'Requests'
}

{ #category : 'requests' }
GHGetUserRepositories >> url [
	
	^ self baseUrl / ('/users/{username}/repos' format: { 
		'username' -> username } asDictionary)
]

{ #category : 'accessing' }
GHGetUserRepositories >> username: aString [ 
	username := aString
]
