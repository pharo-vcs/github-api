accessing
links
	
	| links |
	links := (response headers at: 'Link') substrings: ','.
	
	^ links collect: [ :linkString | | linkArray rel url |
		"<https://api.github.com/resource?page=2>; rel=""next"""
		linkArray := linkString substrings: ';'.
		rel := linkArray second trim copyFrom: 'rel="' size + 1 to: linkArray second size - 2.
		url := linkArray first  trim copyFrom: 2  to: linkArray first  size - 1.
		GHLink new
			rel: rel;
			url: url;
			yourself
	]