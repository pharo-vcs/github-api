# Github API bindings for Pharo

This package implements Github's REST API v3. You can find details on it in here:

https://developer.github.com/

## Setting up a connection and login

A new connection to github can be set up by doing:

```smalltalk
connection := Github new.
```

And then specifying a login.

```smalltalk
connection loginUser: 'YOUR_USER' password: 'YOUR_PASSWORD'.
```

For now, I implement only basic authentication. However, login is managed behind by a credentials object, so new kind of credentials can be added later on.

## Making a request

The protocol *requests* contains several already implemented requests such as:
 - get the pull requests of a given project
```smalltalk
github getPullRequestsFromRepo: 'pharo' owner: 'pharo-project'. 
```
 - get the issues of a given project
```smalltalk
response := github getIssuesFromRepo: 'pharo' owner: 'pharo-project'.
```
 - get a user
```smalltalk
response := github getUser: 'guillep'
```
 - get the respositories of a suser
```smalltalk
response := github getRepositoriesFromUser: 'guillep'.
```
 - get the organizations of a user
```smalltalk
response := github getOrganizationsFromUser: 'guillep'.
```

Besides already implemented requests, you may use the `#call:` method to call other requests. The `#call:` method receives a request object, such as a `GHGetRequest`, and returns a `GHResponse` object. Using it in combination with the `GHGenericGetRequest` class, you can do:

```smalltalk
response := github call: (GHGenericGetRequest url: 'https://api.github.com/users')
```

Notice that if something fails on the request and a failed response is obtained, the `#call:` method will fail with a `GHRequestError` exception. The `GHRequestError` contains the response that originated the error.

## Accessing the response contents

Requests answer a `GHResponse` object. A `GHResponse` object contains inside the HTTP response plus some handy methods to parse the data and manage pagination.

To access a response's contents as string, you may do:

```smalltalk
stringContents := response rawContents
```

And to access them as an already parsed JSON object:

```smalltalk
json := response parseJSON
```

## Pagination

By default all github requests are paginated with a max page number. For example, at the time of writing this comment, such max number was 30.  To help accessing such paginated data, Github provides some meta-data links in response headers to the next, previous, last and first pages, if available. This is specified in the following url:

https://developer.github.com/v3/#pagination

A `GHResponse` provides access to the links in the headers.

```smalltalk
links := response links.
```

Each link understands the messages `#rel` and `#url` to access the link's content. Moreover, a `GHResponse` provides a much higher-level API, avoiding the need of diving in the links. The folling methods provide access to the link data:

- `#hasLast`: specifies if a response has a last link
- `#hasNext`: specifies if a response has a next link
- `#nextLink`: returns the next link
- `#nextUrl`: returns the url of the next link

Moreover, the `#next` method makes a request to the next url link, using the same github connection as in the first request.

```smalltalk
nextPageResponse :=  response next.
```

## Pagination through iteration

As a second alternative, this package provides a request iterator. An iterator provides a high level API to access, select and collect data obtained from a paginated request, hiding the details of the page iteration behind.


```smalltalk
 | iterator prs |	
	iterator := self github iteratorOn: (GHGetPullRequests new
		repositoryName: 'pharo';
		ownerName: 'pharo-project';
		state: 'closed';
		sort: 'updated';
		direction: 'desc';
		yourself).
	
	prs := iterator
		collect: [ :rq | rq parseJSON collect: [ :pr | GHPullRequest on: pr ] ];
		select: [ :pr | pr isMerged and: [ pr mergeDate between: to asZTimestamp and: from asZTimestamp ] ];
		until: [ :pr | pr updateDate < to asZTimestamp ];
		iterate.
```
