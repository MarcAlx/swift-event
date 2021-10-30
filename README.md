# swift-event

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Classes to ease observer pattern implementation in Swift inspired by [C# events](https://docs.microsoft.com/fr-fr/dotnet/standard/events/)

This package is built arround the following principes :

1. **Genericity** : every classes supports generic

2. **Simplicity** : inspired by C# event `swift-event` supports subscribe (via `+=` and `subscribe()`), unsubcribe (via `-=` and `unsubscribe()`) and notify via `invoke`.

3. **Encapsulation** : `invoke` is not accessible outside of declaration scope, preventing other classes from breaking internal logic.

[Installation](#Installation) - [Getting started](#getting-started) - [Samples](#samples) - [Docs](#docs) - [Q&A](#q&a) - [Changelog](#changelog)

## Installation

### Swift Package Manager

You can use [The Swift Package Manager](https://swift.org/package-manager) to install `swift-event` by adding the proper description 

#### To your `Package.swift` file:

```
dependencies: [
        .package(url: "https://github.com/MarcAlx/swift-event.git", from: "1.0.0"),
    ]
```

#### Or via Xcode

From your `.xcodeproj` file select your project then go to `Swift Packages` tab then add (via `+`) : `https://github.com/MarcAlx/swift-event.git`

### Copy source code

You can find source code here : https://github.com/MarcAlx/swift-event/blob/master/Sources/swift-event/swift_event.swift

All commented it's <100 sloc just copy and paste it into your code.

## Getting started

### 0. Import package

    import swift_event

### 1. Create an event

    let tmp = Event<String>.create()
    //tmp holds the event in 'event' and a pointer to 'invoke' method

### 2. Create an handler and subscribe

    var handler =  EventHandler<String>(handle: { sender, args in
        print(args)
    })
    tmp.event += handler

### 3. Invoke the event

    tmp.invoke(self,"Hello world !")
    //handler should print "Hello world !"

### 4. (optional) Unsubscribe

    tmp.event -= handler

## Samples

### Quick

    let tmp = Event<String>.create()
    tmp.event += EventHandler<String>(handle: { sender, args in
        print(args)
    })
    tmp.invoke(self,"Hello world !")
    //handler should print "Hello world !"

### Via functions

    let tmp = Event<String>.create()
    let dispose = tmp.event.subscribe(EventHandler<String>(handle: { sender, args in
            print(args)
        })
    )
    tmp.invoke(self,"Hello world !")
    //handler should print "Hello world !"
    dispose()

### Inside a class

#### Test.swift

    import swift_event

    class Test {
        private var _somethingHappened:Event<String>
        public var somethingHappened: Event<String> {
            return self._somethingHappened
        }
        
        private var _somethingHappenedInvoke:Delegate<String>
        
        public init() {
            let tmp = Event<String>.create()
            self._somethingHappened = tmp.event
            self._somethingHappenedInvoke = tmp.invoke
        }
        
        public func doSomething() {
            self._somethingHappenedInvoke(self, "Hello !")
        }
    }

#### Usage

    var test = Test()

    var handler = EventHandler<String>(handle: {sender, args in print(args)})

    test.somethingHappened += handler
    
    test.doSomething() //should raise event, thus leading in an handler call
    
    test.somethingHappened -= handler
    
    test.doSomething() //should print nothing, as handler has been unsubscribe

## Docs

Documentation is also provided as a `.doccarchive` that includes some interractive tutorials, here : `./Doc/swift-event.doccarchive` 

### `class Event<T>`

#### `static func create() -> (invoke:Delegate<T>,event:Event<T>)`

Create an Event and return it along with its invoke method

**note:** this is the only way to instantiate an Event, this way only the class that call this method has access to invoke

**returns:** A tuple containing the created Event along with a pointer to its private invoke

#### `operator overload +=`

Subscribe to an event by adding an handler

#### `operator overload -=`

Unsubsribe from an event by removing handler

#### `func subscribe (handler: EventHandler<T>)-> () -> Void`

Subscribe to an event by adding an handler

**note:** shorthand to +=

**parameter handler:** the EventHandler to add

**returns:** a function that is a shorthand to -=, to ease unsubscribe

#### `func unsubscribe (handler: EventHandler<T>) -> Void`

Unsubsribe from an event by removing handler

**note:** shorthand to -=

### `class EventHandler<T>`

Typed EventHandler for typed Event

**note:** this class is needed as Swift doesn't allow func equity via ===

#### `var handle:Delegate<T>`

The Delegate that will handle the Event

#### `init(handle:@escaping Delegate<T>)`

Instanciate a new typed EventHandler

**parameter handle:** the associated Delegate to handle the Event

### `typealias Delegate<T> = (_ sender:AnyObject?,_ args:T) -> Void`

Shorthand for Event delegation

**parameter sender:** Sender of the event

**parameter args:** Event args

## Q&A 

### Q. Why EventHandler is a class instead of typealias over func

**A.** Because in swift func are not `equatable` and doesn't supports `===` thus leaving `unsubscribe` and `-=` operator unimplemented.

### Q. Why can't `Event.init()` is private ?

**A.** To avoid call to `invoke()` outside of creation scope. (like `invoke() in c#`)

## Contributing

You can contribute to this repo via pull requests, be sure to follow the philosophy of this repo and to update documentation.

## Changelog

### 1.0.0 

First version of the package.
