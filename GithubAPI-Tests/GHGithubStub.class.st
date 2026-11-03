"
I am a Github connection that answers canned ZnResponses, in order, instead of calling the network. I remember each request URL and the ETag it was sent with.
"
Class {
	#name : 'GHGithubStub',
	#superclass : 'Github',
	#instVars : [
		'responses',
		'requests'
	],
	#category : 'GithubAPI-Tests',
	#package : 'GithubAPI-Tests'
}

{ #category : 'stubbing' }
GHGithubStub >> answer: aZnResponse [

	responses add: aZnResponse
]

{ #category : 'stubbing' }
GHGithubStub >> answerJSON: aString headers: aDictionary [
	"Queue a 200 response with a JSON body and the given headers"

	| response |
	response := ZnResponse ok:
		            (ZnEntity with: aString type: ZnMimeType applicationJson).
	aDictionary keysAndValuesDo: [ :key :value |
		response headers at: key put: value ].
	self answer: response
]

{ #category : 'initialization' }
GHGithubStub >> initialize [

	super initialize.
	responses := OrderedCollection new.
	requests := OrderedCollection new
]

{ #category : 'accessing' }
GHGithubStub >> requests [
	"Associations of each requested URL and the ETag it was sent with"

	^ requests
]

{ #category : 'call' }
GHGithubStub >> responseFor: aRequest ifNoneMatch: anETagOrNil [

	| client |
	client := ZnClient new.
	client url: aRequest url.
	aRequest setQueryArgumentsToClient: client.
	requests add: client request url -> anETagOrNil.
	^ responses removeFirst
]
