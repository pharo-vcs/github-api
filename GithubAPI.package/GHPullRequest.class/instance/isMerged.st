testing
isMerged
	
	^ (prDictionary includesKey: 'merged_at')
		and: [ (prDictionary at: 'merged_at') notNil ]