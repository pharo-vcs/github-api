requests
getReleasesFromRepo: repoNameString owner: ownerNameString 
	
	^ self call: (GHGetReleases new
		repositoryName: repoNameString;
		ownerName: ownerNameString;
		yourself)