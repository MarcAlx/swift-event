#  Getting started

## 1. Import package

    import swift_event

## 2. Create an event

    let tmp = Event<String>.create()
    //tmp holds the event in 'event' and a pointer to 'invoke' method

## 3. Create an handler and subscribe

    var handler =  EventHandler<String>(handle: { sender, args in
        print(args)
    })
    tmp.event += handler

## 4. Invoke the event

    tmp.invoke(self,"Hello world !")
    //handler should print "Hello world !"

## 5. (optional) Unsubscribe

    tmp.event -= handler
