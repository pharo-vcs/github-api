stubbing
answerJSON: aString headers: aDictionary
	"Queue a 200 response with a JSON body and the given headers"

	| response |
	response := ZnResponse ok:
		            (ZnEntity with: aString type: ZnMimeType applicationJson).
	aDictionary keysAndValuesDo: [ :key :value |
		response headers at: key put: value ].
	self answer: response