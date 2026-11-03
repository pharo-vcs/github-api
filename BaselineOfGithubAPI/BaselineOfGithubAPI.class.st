Class {
	#name : 'BaselineOfGithubAPI',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfGithubAPI',
	#package : 'BaselineOfGithubAPI'
}

{ #category : 'baselines' }
BaselineOfGithubAPI >> baseline: spec [

	<baseline>
	spec for: #common do: [
			spec
				baseline: 'ZTimestamp'
				with: [ spec repository: 'github://svenvc/ztimestamp:master' ].
			spec package: #GithubAPI with: [ spec requires: #( 'ZTimestamp' ) ] ]
]
