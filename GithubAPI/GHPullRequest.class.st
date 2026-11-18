Class {
	#name : 'GHPullRequest',
	#superclass : 'Object',
	#instVars : [
		'prDictionary'
	],
	#category : 'GithubAPI-Model',
	#package : 'GithubAPI',
	#tag : 'Model'
}

{ #category : 'instance-creation' }
GHPullRequest class >> on: aCollection [ 
	
	^ self new
		prDictionary: aCollection;
		yourself
]

{ #category : 'testing' }
GHPullRequest >> isMerged [
	
	^ (prDictionary includesKey: 'merged_at')
		and: [ (prDictionary at: 'merged_at') notNil ]
]

{ #category : 'accessing' }
GHPullRequest >> mergeDate [
	
	^ ZTimestamp fromString: (prDictionary at: 'merged_at')
]

{ #category : 'accessing' }
GHPullRequest >> prDictionary: aCollection [ 
	
	prDictionary := aCollection 
]

{ #category : 'printing' }
GHPullRequest >> printOn: aStream [

	aStream
		nextPutAll: 'Pull Request(';
		nextPutAll: self title;
		nextPutAll: ')'
]

{ #category : 'accessing' }
GHPullRequest >> propertyAt: aKey [

	^ prDictionary at: aKey
]

{ #category : 'accessing' }
GHPullRequest >> title [

	^ prDictionary at: 'title'
]

{ #category : 'accessing' }
GHPullRequest >> updateDate [
	
	^ ZTimestamp fromString: (prDictionary at: 'updated_at')
]
