"
I ask for the combined status of a commit (ref: a SHA, branch or tag): the commit statuses that external CI services such as Jenkins report, as opposed to check runs. GitHub answers a dictionary with the overall 'state' and the latest status of each context in 'statuses'.
"
Class {
	#name : 'GHGetCombinedStatus',
	#superclass : 'GHGetRequest',
	#instVars : [
		'ownerName',
		'repositoryName',
		'ref',
		'perPage'
	],
	#category : 'GithubAPI-Requests',
	#package : 'GithubAPI',
	#tag : 'Requests'
}

{ #category : 'accessing' }
GHGetCombinedStatus >> ownerName: aString [

	ownerName := aString
]

{ #category : 'accessing' }
GHGetCombinedStatus >> perPage: anInteger [

	perPage := anInteger
]

{ #category : 'request' }
GHGetCombinedStatus >> queryArguments [

	| arguments |
	arguments := Dictionary new.
	perPage ifNotNil: [
		arguments at: 'per_page' put: perPage printString ].
	^ arguments
]

{ #category : 'accessing' }
GHGetCombinedStatus >> ref: aString [
	"A commit SHA, a branch or a tag"

	ref := aString
]

{ #category : 'accessing' }
GHGetCombinedStatus >> repositoryName: aString [

	repositoryName := aString
]

{ #category : 'request' }
GHGetCombinedStatus >> url [

	^ self baseUrl
	  / ('/repos/{owner}/{repo}/commits/{ref}/status' format: {
				   ('owner' -> ownerName).
				   ('repo' -> repositoryName).
				   ('ref' -> ref) } asDictionary)
]
