import XCTest
@testable import swift_event

final class swift_eventTests: XCTestCase {
    
    func testSubscribeInvoke() {
        let tmp = Event<String>.create()
        let handler = EventHandler<String>(handle: { sender, args in
            XCTAssertEqual(args, "Hello, World!")
        })
        tmp.event += handler
        
        tmp.invoke(nil,"Hello, World!")
    }
    
    func testMultiSubscribe() {
        let tmp = Event<String>.create()
        let handler = EventHandler<String>(handle: { sender, args in
            XCTAssertEqual(args, "Hello, World!")
        })
        tmp.event += handler
        
        let tmp2 = Event<String>.create()
        let handler2 = EventHandler<String>(handle: { sender, args in
            XCTAssertEqual(true,false)
        })
        tmp2.event += handler2
        
        tmp.invoke(nil,"Hello, World!")
        XCTAssertEqual(true,true)
    }
    
    func testSubscribeUnsubscribe() {
        let tmp = Event<String>.create()
        let handler = EventHandler<String>(handle: { sender, args in
            XCTAssertEqual(true,false)
        })
        tmp.event += handler
        tmp.event -= handler
        tmp.invoke(nil,"Test")
        XCTAssertEqual(true,true)
    }
    
    func testSubscribeUnsubscribeViaFunc() {
        let tmp = Event<String>.create()
        let handler = EventHandler<String>(handle: { sender, args in
            XCTAssertEqual(true,false)
        })
        let dispose = tmp.event.subscribe(handler: handler)
        dispose()
        tmp.invoke(nil,"Test")
        XCTAssertEqual(true,true)
    }
    
    func testMultiSubscribeUnsubscribeViaOpAndFunc() {
        let tmp = Event<String>.create()
        tmp.event += EventHandler<String>(handle: { sender, args in
            XCTAssertEqual(args, "Hello, World!")
        })
        tmp.event += EventHandler<String>(handle: { sender, args in
            XCTAssertEqual(args, "Hello, World!")
        })
        let dispose = tmp.event.subscribe(handler: EventHandler<String>(handle: { sender, args in
            XCTAssertEqual(true, false)
        }))
        _ = tmp.event.subscribe(handler: EventHandler<String>(handle: { sender, args in
            XCTAssertEqual(args, "Hello, World!")
        }))
        
        dispose()
        tmp.invoke(nil,"Hello, World!")
        XCTAssertEqual(true,true)
    }
    
    //add other test if needed here, along with reference in allTests, all methods must start by test in order to be seen by Xcode

    static var allTests = [
        ("testSubscribeInvoke", testSubscribeInvoke),
        ("testMultiSubscribe", testMultiSubscribe),
        ("testSubscribeUnsubscribe",testSubscribeUnsubscribe),
        ("testSubscribeUnsubscribeViaFunc",testSubscribeUnsubscribeViaFunc),
        ("testMultiSubscribeUnsubscribeViaOpAndFunc",testMultiSubscribeUnsubscribeViaOpAndFunc)
    ]
}
