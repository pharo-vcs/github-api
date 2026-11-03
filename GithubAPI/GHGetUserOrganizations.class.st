Class {
	#name : 'GHGetUserOrganizations',
	#superclass : 'GHGetRequest',
	#instVars : [
		'username'
	],
	#category : 'GithubAPI-Requests',
	#package : 'GithubAPI',
	#tag : 'Requests'
}

{ #category : 'requests' }
GHGetUserOrganizations >> url [
	
	^ self baseUrl / ('/users/{username}/orgs' format: { 
		'username' -> username } asDictionary)
]

{ #category : 'accessing' }
GHGetUserOrganizations >> username: aString [ 
	username := aString
]
