Class {
	#name : 'GHGetPullRequests',
	#superclass : 'GHGetRequest',
	#instVars : [
		'repositoryName',
		'ownerName',
		'state',
		'sort',
		'direction'
	],
	#category : 'GithubAPI-Requests',
	#package : 'GithubAPI',
	#tag : 'Requests'
}

{ #category : 'accessing' }
GHGetPullRequests >> direction: aString [ 
	
	direction := aString
]

{ #category : 'accessing' }
GHGetPullRequests >> ownerName: aString [ 
	ownerName := aString
]

{ #category : 'request' }
GHGetPullRequests >> queryArguments [
	
	^  {
		'state' -> state.
		'sort'  -> sort.
		'direction' -> direction
		} asDictionary
]

{ #category : 'accessing' }
GHGetPullRequests >> repositoryName: aString [ 
	repositoryName := aString
]

{ #category : 'accessing' }
GHGetPullRequests >> sort: aString [ 
	
	sort := aString
]

{ #category : 'accessing' }
GHGetPullRequests >> state: aString [ 
	
	state := aString
]

{ #category : 'request' }
GHGetPullRequests >> url [
	
	^ self baseUrl / ('/repos/{owner}/{repo}/pulls' format: { 
		'owner' -> ownerName.
		'repo'  -> repositoryName } asDictionary)
]
