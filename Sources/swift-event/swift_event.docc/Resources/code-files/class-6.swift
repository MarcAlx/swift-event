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
