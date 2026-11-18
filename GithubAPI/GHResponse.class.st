"
I am the response of a github request. I am instantiated with an http response and provide high-level access to it.

To access my contents as string, you may do:

stringContents := response rawContents

And to access the contents as an already parsed JSON object:

json := response parseJSON

I also provide access to the links in the headers, useful for pagination.

links := response links

Links are instances of GHLink. Check this class' comment for more info about them. Moreover,  I provides a much higher-level API, avoiding the need of diving in the links.

response hasLast.
response hasNext.
response nextLink.
response nextUrl.

Moreover, the #next method makes a request to the next url link, using the same github connection as in the first request.

nextPageResponse :=  response next.
"
Class {
	#name : 'GHResponse',
	#superclass : 'Object',
	#instVars : [
		'response',
		'github'
	],
	#category : 'GithubAPI-Core',
	#package : 'GithubAPI',
	#tag : 'Core'
}

{ #category : 'accessing' }
GHResponse >> etag [

	^ response headers at: 'ETag' ifAbsent: [ nil ]
]

{ #category : 'accessing' }
GHResponse >> github [
	
	^ github
]

{ #category : 'accessing' }
GHResponse >> github: aGithub [
	
	github := aGithub
]

{ #category : 'testing' }
GHResponse >> hasLast [
	
	| linksString |
	linksString := response headers at: 'Link' ifAbsent: [ ^ false ].
	^ self links anySatisfy: [ :link | link rel = 'last' ]
]

{ #category : 'testing' }
GHResponse >> hasNext [
	
	| linksString |
	linksString := response headers at: 'Link' ifAbsent: [ ^ false ].
	^ self links anySatisfy: [ :link | link rel = 'next' ]
]

{ #category : 'testing' }
GHResponse >> isNotModified [

	^ response code = 304
]

{ #category : 'testing' }
GHResponse >> isRateLimited [
	"GitHub answers 429, or 403 with no requests left, when a primary or secondary rate limit is hit"

	^ response code = 429 or: [
			  response code = 403 and: [
				  self rateLimitRemaining = 0 or: [ self retryAfter notNil ] ] ]
]

{ #category : 'accessing' }
GHResponse >> links [
	
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
]

{ #category : 'request' }
GHResponse >> next [
	
	^ github call: (GHGetRequest url: self nextUrl)
]

{ #category : 'accessing' }
GHResponse >> nextLink [
	
	^ self links detect: [ :link | link rel = 'next' ]
]

{ #category : 'accessing' }
GHResponse >> nextUrl [
	
	^ self nextLink url
]

{ #category : 'parsing' }
GHResponse >> parseJSON [
	
	^ STON fromString: self rawContents
]

{ #category : 'accessing' }
GHResponse >> rateLimitRemaining [
	"Requests left in the current window, or nil when GitHub did not say"

	^ (response headers at: 'X-RateLimit-Remaining' ifAbsent: [ ^ nil ])
		  asInteger
]

{ #category : 'accessing' }
GHResponse >> rateLimitReset [
	"When the current rate-limit window ends, or nil when GitHub did not say"

	^ DateAndTime fromUnixTime:
		  (response headers at: 'X-RateLimit-Reset' ifAbsent: [ ^ nil ])
			  asInteger
]

{ #category : 'parsing' }
GHResponse >> rawContents [
	
	^ response contents
]

{ #category : 'accessing' }
GHResponse >> response: aZnResponse [ 
	response := aZnResponse
]

{ #category : 'accessing' }
GHResponse >> retryAfter [
	"How long GitHub asks to wait before the next request, or nil when it did not say"

	^ (response headers at: 'Retry-After' ifAbsent: [ ^ nil ]) asInteger
		  seconds
]
