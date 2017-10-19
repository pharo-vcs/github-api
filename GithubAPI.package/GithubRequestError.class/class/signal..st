exceptioninstantiator
signal: response

	| message |
	message := String streamContents: [ :stream |
		response statusLine printCodeAndReasonOn: stream ].

	self new
		errorResponse: response;
		messageText: message;
		signal