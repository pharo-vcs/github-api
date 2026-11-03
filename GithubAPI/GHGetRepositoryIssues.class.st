Class {
	#name : 'GHGetRepositoryIssues',
	#superclass : 'GHGetRequest',
	#instVars : [
		'repositoryName',
		'ownerName',
		'state',
		'since',
		'perPage'
	],
	#category : 'GithubAPI-Requests',
	#package : 'GithubAPI',
	#tag : 'Requests'
}

{ #category : 'accessing' }
GHGetRepositoryIssues >> ownerName: aString [ 
	ownerName := aString
]

{ #category : 'accessing' }
GHGetRepositoryIssues >> perPage: anInteger [
	"Page size, at most 100"

	perPage := anInteger
]

{ #category : 'request' }
GHGetRepositoryIssues >> queryArguments [

	| arguments |
	arguments := Dictionary new.
	state ifNotNil: [ arguments at: 'state' put: state ].
	since ifNotNil: [
			arguments
				at: 'since'
				put: (ZTimestamp fromUnixTime: since asUnixTime) printString ].
	perPage ifNotNil: [
		arguments at: 'per_page' put: perPage printString ].
	^ arguments
]

{ #category : 'accessing' }
GHGetRepositoryIssues >> repositoryName: aString [ 
	repositoryName := aString
]

{ #category : 'accessing' }
GHGetRepositoryIssues >> since: aDateAndTime [
	"Only issues updated at or after aDateAndTime"

	since := aDateAndTime
]

{ #category : 'accessing' }
GHGetRepositoryIssues >> state: aString [
	"open, closed or all; GitHub answers only open issues by default"

	state := aString
]

{ #category : 'requests' }
GHGetRepositoryIssues >> url [
	
	^ self baseUrl / ('/repos/{owner}/{repo}/issues' format: { 
		'owner' -> ownerName.
		'repo'  -> repositoryName } asDictionary)
]
