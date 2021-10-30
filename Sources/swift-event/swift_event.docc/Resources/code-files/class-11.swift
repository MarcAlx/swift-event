import swift_event

var test = Test()

var handler = EventHandler<String>(handle: {sender, args in print(args)})

test.somethingHappened += handler

test.doSomething() //should raise event, thus leading in an handler call

test.somethingHappened -= handler

test.doSomething() //should print nothing, as handler has been unsubscribe
