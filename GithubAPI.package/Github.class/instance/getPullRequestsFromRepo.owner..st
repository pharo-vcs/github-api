requests
getPullRequestsFromRepo: repoNameString owner: ownerNameString 
	
	^ self call: (GHGetPullRequests new
		repositoryName: repoNameString;
		ownerName: ownerNameString;
		yourself)