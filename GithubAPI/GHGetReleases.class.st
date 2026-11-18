Class {
	#name : 'GHGetReleases',
	#superclass : 'GHGetRequest',
	#instVars : [
		'repositoryName',
		'ownerName',
		'latest'
	],
	#category : 'GithubAPI-Requests',
	#package : 'GithubAPI',
	#tag : 'Requests'
}

{ #category : 'initialization' }
GHGetReleases >> initialize [ 
	super initialize.
	latest := false.
]

{ #category : 'accessing' }
GHGetReleases >> latest: aBoolean [
	latest := aBoolean
]

{ #category : 'accessing' }
GHGetReleases >> ownerName: aString [ 
	ownerName := aString
]

{ #category : 'request' }
GHGetReleases >> queryArguments [
	
	^ #()
]

{ #category : 'accessing' }
GHGetReleases >> repositoryName: aString [ 
	repositoryName := aString
]

{ #category : 'requests' }
GHGetReleases >> url [
	
	^ self baseUrl / ('/repos/{owner}/{repo}/releases{latest}' format: { 
		'owner' -> ownerName.
		'repo'  -> repositoryName.
		'latest' -> (latest ifTrue: ['/latest'] ifFalse: ['']) } asDictionary)
]
