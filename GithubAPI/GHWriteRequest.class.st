"
I am a request that changes an issue or pull request of a repository: my subclasses say the HTTP method, the path and the JSON body. Github>>call: sends me like a GHGetRequest.

GitHub's issues endpoints work on pull requests too: a pull request is an issue with code.
"
Class {
	#name : 'GHWriteRequest',
	#superclass : 'Object',
	#instVars : [
		'ownerName',
		'repositoryName',
		'number'
	],
	#category : 'GithubAPI-Core',
	#package : 'GithubAPI',
	#tag : 'Core'
}

{ #category : 'request' }
GHWriteRequest >> body [
	"The JSON object sent, as a dictionary"

	^ self subclassResponsibility
]

{ #category : 'request' }
GHWriteRequest >> httpMethod [
	"#POST or #PATCH"

	^ self subclassResponsibility
]

{ #category : 'request' }
GHWriteRequest >> issueUrl [
	"The issue or pull request, as the issues endpoints name it"

	^ 'https://api.github.com' asZnUrl
	  / ('/repos/{owner}/{repo}/issues/{number}' format: {
				   ('owner' -> ownerName).
				   ('repo' -> repositoryName).
				   ('number' -> number printString) } asDictionary)
]

{ #category : 'accessing' }
GHWriteRequest >> number: anInteger [

	number := anInteger
]

{ #category : 'accessing' }
GHWriteRequest >> ownerName: aString [

	ownerName := aString
]

{ #category : 'request' }
GHWriteRequest >> queryArguments [
	"Writes put everything in the body"

	^ Dictionary new
]

{ #category : 'accessing' }
GHWriteRequest >> repositoryName: aString [

	repositoryName := aString
]

{ #category : 'requests' }
GHWriteRequest >> requestTo: aZnClient [

	aZnClient
		method: self httpMethod;
		entity: (ZnEntity
				 with: (STONJSON toString: self body)
				 type: ZnMimeType applicationJson);
		execute
]

{ #category : 'request' }
GHWriteRequest >> url [

	^ self subclassResponsibility
]
