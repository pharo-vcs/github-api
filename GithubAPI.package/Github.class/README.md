I am a connection to Github, providing methods to login and call requests on it. I am implemented using Github's REST API v3. You can find details on it in here:

https://developer.github.com/

# Setting up a connection and login

A new connection to Github can be set up by doing:

connection := Github new.

And then specifying a login.

- Anonymous authentication (default if none specified)

connection anonymous.

- User/password authentication

connection loginUser: 'YOUR_USER' password: 'YOUR_PASSWORD'.

- Token authentication

connection loginToken: 'YOUR_TOKEN'.

# Making a request

The protocol *requests* contains several already implemented requests such as:
 - get the pull requests of a given project
 - get the issues of a given project
 - get a user
 - get the repositories of a suser
 - get the organizations of a user

All these request methods answer a GHResponse object. A GHResponse object contains inside the HTTP response plus some handy methods to parse the data and manage pagination. See the comment on GHResponse for more details.

Besides already implemented requests, you may use the #call: method to call other requests. The #call: method receives a request object, such as a GHGetRequest, and returns a GHResponse object.

Moreover, if something fails in the request, and a failed response is obtained, the #call: method will fail with a GHRequestError exception. The GHRequestError contains the response that originated the error.

# Paginated requests

By default all github requests are paginated with a max page number. For example, at the time of writing this comment, such max number was 30. To help accessing such paginated data, Github provides some meta-data links to the next, previous, last and first pages. This is specified in the following url:

https://developer.github.com/v3/#pagination

This implementation provides two ways of interacting with such paginated data. First, the GHResponse object returned by #call: provides access to the links and some helper methods such as #next and #hasNext. Check the comment in GHResponse for more information about this.

Moreover, the method #iterateOn: returns an iterator on a request. An iterator provides a high level API to access, select and collect data obtained from a paginated request, hiding the details of the page iteration behind. For more detailed information about this, check the GHRequestIterator class comment.
