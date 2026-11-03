"
I change fields of an issue or pull request, such as closing it:

	GHUpdateIssue new ownerName: 'pharo-vcs'; repositoryName: 'tonel'; number: 12; close; yourself
"
Class {
	#name : 'GHUpdateIssue',
	#superclass : 'GHWriteRequest',
	#instVars : [
		'fields'
	],
	#category : 'GithubAPI-Requests',
	#package : 'GithubAPI',
	#tag : 'Requests'
}

{ #category : 'request' }
GHUpdateIssue >> body [

	^ fields
]

{ #category : 'accessing' }
GHUpdateIssue >> close [
	"Close it; GitHub keeps whatever discussion it had"

	fields at: 'state' put: 'closed'
]

{ #category : 'accessing' }
GHUpdateIssue >> closeAsNotPlanned [
	"Close an issue saying it won't be done, rather than completed. Only issues take a reason."

	self close.
	fields at: 'state_reason' put: 'not_planned'
]

{ #category : 'request' }
GHUpdateIssue >> httpMethod [

	^ #PATCH
]

{ #category : 'initialization' }
GHUpdateIssue >> initialize [

	super initialize.
	fields := Dictionary new
]

{ #category : 'request' }
GHUpdateIssue >> url [

	^ self issueUrl
]
