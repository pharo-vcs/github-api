"
I list the check runs of a commit (ref: a SHA, branch or tag), such as those GitHub Actions reports. GitHub answers a dictionary whose 'check_runs' holds them.
"
Class {
	#name : 'GHGetCheckRuns',
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
GHGetCheckRuns >> ownerName: aString [

	ownerName := aString
]

{ #category : 'accessing' }
GHGetCheckRuns >> perPage: anInteger [

	perPage := anInteger
]

{ #category : 'request' }
GHGetCheckRuns >> queryArguments [

	| arguments |
	arguments := Dictionary new.
	perPage ifNotNil: [
		arguments at: 'per_page' put: perPage printString ].
	^ arguments
]

{ #category : 'accessing' }
GHGetCheckRuns >> ref: aString [
	"A commit SHA, a branch or a tag"

	ref := aString
]

{ #category : 'accessing' }
GHGetCheckRuns >> repositoryName: aString [

	repositoryName := aString
]

{ #category : 'request' }
GHGetCheckRuns >> url [

	^ self baseUrl
	  / ('/repos/{owner}/{repo}/commits/{ref}/check-runs' format: {
				   ('owner' -> ownerName).
				   ('repo' -> repositoryName).
				   ('ref' -> ref) } asDictionary)
]
