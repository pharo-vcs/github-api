"
I am a value object containing a link header. I can answer the relationship and the url of the link:

link rel.

link url.
"
Class {
	#name : 'GHLink',
	#superclass : 'Object',
	#instVars : [
		'url',
		'rel'
	],
	#category : 'GithubAPI-Core',
	#package : 'GithubAPI',
	#tag : 'Core'
}

{ #category : 'accessing' }
GHLink >> rel [
	^ rel
]

{ #category : 'accessing' }
GHLink >> rel: aString [ 
	rel := aString
]

{ #category : 'accessing' }
GHLink >> url [
	^ url
]

{ #category : 'accessing' }
GHLink >> url: aString [ 
	url := aString
]
