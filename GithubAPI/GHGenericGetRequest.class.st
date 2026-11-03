Class {
	#name : 'GHGenericGetRequest',
	#superclass : 'GHGetRequest',
	#instVars : [
		'url'
	],
	#category : 'GithubAPI-Core',
	#package : 'GithubAPI',
	#tag : 'Core'
}

{ #category : 'request' }
GHGenericGetRequest >> queryArguments [
	
	^ Dictionary new
]

{ #category : 'requests' }
GHGenericGetRequest >> url [
	^ url
]

{ #category : 'accessing' }
GHGenericGetRequest >> url: aString [ 
	url := aString
]
