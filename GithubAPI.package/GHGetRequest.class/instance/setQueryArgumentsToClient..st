requests
setQueryArgumentsToClient: aZnClient 
	
	self queryArguments keysAndValuesDo: [ :key :value |
		aZnClient queryAt: key put: value ]