import swift_event

let tmp = Event<String>.create()
let dispose = tmp.event.subscribe(EventHandler<String>(handle: { sender, args in
        print(args)
    })
)
tmp.invoke(self,"Hello world !")
//handler should print "Hello world !"
dispose()
