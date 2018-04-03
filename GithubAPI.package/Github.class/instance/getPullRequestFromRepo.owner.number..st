requests
getPullRequestFromRepo: repoNameString owner: ownerNameString number: aNumber
	
	^ self call: (GHGetPullRequest new
		repositoryName: repoNameString;
		ownerName: ownerNameString;
		number: aNumber;
		yourself)