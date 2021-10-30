import swift_event

class Test {
    private var _somethingHappened:Event<String>
    public var somethingHappened: Event<String> {
        return self._somethingHappened
    }
    
    private var _somethingHappenedInvoke:Delegate<String>
    
    public init() {
    }
}
