baselines
baseline: spec
	<baseline>
	spec
		for: #common
		do: [ spec
				configuration: 'ZTimestamp'
				with: [ spec
						versionString: '20';
						repository: 'http://mc.stfx.eu/Neo' ].
			spec package: #GithubAPI with: [ spec requires: #('ZTimestamp') ] ]
		
	