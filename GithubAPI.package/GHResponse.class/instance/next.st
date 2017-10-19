request
next
	
	^ github call: (GHGetRequest url: self nextUrl)