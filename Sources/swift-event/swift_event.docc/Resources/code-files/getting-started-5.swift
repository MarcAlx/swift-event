import swift_event

let tmp = Event<String>.create()
//tmp holds the event in 'event' and a pointer to 'invoke' method

var handler =  EventHandler<String>(handle: { sender, args in
    print(args)
})
tmp.event += handler

tmp.invoke(self,"Hello world !")
//handler should print "Hello world !"

tmp.event -= handler
