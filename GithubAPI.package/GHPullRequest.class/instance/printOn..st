printing
printOn: aStream

	aStream
		nextPutAll: 'Pull Request(';
		nextPutAll: self title;
		nextPutAll: ')'