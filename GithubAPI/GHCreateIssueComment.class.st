"
I post a comment on an issue or pull request.
"
Class {
	#name : 'GHCreateIssueComment',
	#superclass : 'GHWriteRequest',
	#instVars : [
		'text'
	],
	#category : 'GithubAPI-Requests',
	#package : 'GithubAPI',
	#tag : 'Requests'
}

{ #category : 'request' }
GHCreateIssueComment >> body [

	^ { ('body' -> text) } asDictionary
]

{ #category : 'request' }
GHCreateIssueComment >> httpMethod [

	^ #POST
]

{ #category : 'accessing' }
GHCreateIssueComment >> text: aString [
	"The comment, in GitHub Markdown"

	text := aString
]

{ #category : 'request' }
GHCreateIssueComment >> url [

	^ self issueUrl / 'comments'
]
