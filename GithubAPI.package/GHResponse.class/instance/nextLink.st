accessing
nextLink
	
	^ self links detect: [ :link | link rel = 'next' ]