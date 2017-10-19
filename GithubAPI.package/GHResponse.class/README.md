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