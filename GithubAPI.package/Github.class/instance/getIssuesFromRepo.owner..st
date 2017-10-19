requests
getIssuesFromRepo: repoNameString owner: ownerNameString 
	
	^ self call: (GHGetRepositoryIssues new
		repositoryName: repoNameString;
		ownerName: ownerNameString;
		yourself)