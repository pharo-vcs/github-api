Class {
	#name : 'GHGetPullRequest',
	#superclass : 'GHGetRequest',
	#instVars : [
		'repositoryName',
		'ownerName',
		'number'
	],
	#category : 'GithubAPI-Requests',
	#package : 'GithubAPI',
	#tag : 'Requests'
}

{ #category : 'accessing' }
GHGetPullRequest >> number [
	^ number
]

{ #category : 'accessing' }
GHGetPullRequest >> number: anObject [
	number := anObject
]

{ #category : 'accessing' }
GHGetPullRequest >> ownerName [
	^ ownerName
]

{ #category : 'accessing' }
GHGetPullRequest >> ownerName: anObject [
	ownerName := anObject
]

{ #category : 'request' }
GHGetPullRequest >> queryArguments [
	^ {} asDictionary
]

{ #category : 'accessing' }
GHGetPullRequest >> repositoryName [
	^ repositoryName
]

{ #category : 'accessing' }
GHGetPullRequest >> repositoryName: anObject [
	repositoryName := anObject
]

{ #category : 'request' }
GHGetPullRequest >> url [
	
	^ self baseUrl / ('/repos/{owner}/{repo}/pulls/{number}' format: { 
		'owner' -> ownerName.
		'repo'  -> repositoryName.
		'number' -> number } asDictionary)
]
