import swift_event

var test = Test()

var handler = EventHandler<String>(handle: {sender, args in print(args)})

test.somethingHappened += handler
