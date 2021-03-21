/// Shorthand for Event delegation
/// - parameter sender: Sender of the event
/// - parameter args: Event args
public typealias Delegate<T> = (_ sender:AnyObject?,_ args:T) -> Void

/// Typed EventHandler for typed Event
/// - note : this class is needed as Swift doesn't allow func equity via ===
public class EventHandler<T> {
    private var _handle:Delegate<T>
    
    /// The Delegate that will handle the Event
    public var handle:Delegate<T> {
        return self._handle
    }
    
    /// Instanciate a new typed EventHandler
    /// - parameter handle: the associated Delegate to handle the Event
    init(handle:@escaping Delegate<T>){
        self._handle = handle
    }
}

/// Typed Event
/// - note : Instanciation is only possible via create
/// - Example :
///       var tmp = Event<String>.create()
///       var dispoe = tmp.event += EventHandler<String>(handle: {sender, args in print(args)})
///       tmp.invoke(self,"Hello")
///       dispose()
class Event<T> {
    /// handlers that will be called on each invoke
    private var handlers:[EventHandler<T>] = []
    
    /// init is private to keep invoke method private
    private init() {
    }
    
    /// Invoke this event on all handlers with given value
    /// - note : private to avoid invokation from anywhere, you get a reference to this method on creation via create
    /// - parameter sender : Sender of the Event
    /// - parameter value : arg that will be forwarded to all handlers
    private func invoke(sender:AnyObject?,value:T) -> Void {
        for handler in self.handlers {
            handler.handle(sender,value)
        }
    }
    
    /// Subscribe to an event by adding an handler
    /// - note : shorthand to +=
    /// - parameter handler: the EventHandler to add
    /// - returns: a function that is a shorthand to -=, to ease unsubscribe
    func subscribe (handler: EventHandler<T>)-> () -> Void {
        self += handler
        return { self.unsubscribe(handler: handler) }
    }
    
    /// Unsubsribe from an event by removing handler
    /// - note : shorthand to -=
    /// - parameter handler: the EventHandler to remove
    func unsubscribe (handler: EventHandler<T>) -> Void {
        self -= handler
    }
    
    /// Unsubsribe from an event by removing handler
    /// - parameter event: the Event to unsubscribe
    /// - parameter handler: the EventHandler to remove
    static func -= ( event: Event, handler: EventHandler<T>) -> Void {
        event.handlers.removeAll{$0 === handler}
    }
    
    /// Subscribe to an event by adding an handler
    /// - parameter event: the Event to subscribe
    /// - parameter handler: the EventHandler to add
    static func += ( event: Event, handler: EventHandler<T>) -> Void {
        event.handlers.append(handler)
    }
    
    /// Create an Event and return it along with its invoke method
    /// - note : this is the only way to instantiate an Event, this way only the class that call this method has access to invoke
    /// - returns : A tuple containing the created Event along with a pointer to its private invoke
    static func create() -> (invoke:Delegate<T>,event:Event<T>){
        let res = Event<T>()
        return (res.invoke,res)
    }
}
