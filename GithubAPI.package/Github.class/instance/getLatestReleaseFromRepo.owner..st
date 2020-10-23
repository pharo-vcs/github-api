requests
getLatestReleaseFromRepo: repoNameString owner: ownerNameString 
	
	^ self call: (GHGetReleases new
		repositoryName: repoNameString;
		ownerName: ownerNameString;
		latest: true;
		yourself)