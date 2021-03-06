*signals-morphic
emitSignalInOwnerChain: signal arguments: args sender: aSender
	"Private. Performs the triggering of callbacks."
	
	| wasHandled |
	wasHandled := true.
	(self signalConnectionsForOwnerChain
		at: signal ifAbsent: [^ false]) keysAndValuesDo: [:receiver :configurations |
			wasHandled := wasHandled and: [configurations allSatisfy: [ :connectionConfiguration |
				| selector pattern filteredArgs |
				selector := connectionConfiguration selector.
				pattern := connectionConfiguration pattern.
					
				filteredArgs := pattern
					ifNil: [args]
					ifNotNil: [pattern mapArguments: args useSender: aSender].
				
				self flag: #fixMe. "mt: Should be somehow possible to filter events."
				(receiver perform: selector withArguments: filteredArgs). true]]].
	^ wasHandled 