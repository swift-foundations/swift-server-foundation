import Dependencies
import NIOCore
import NIOEmbedded
import NIOPosix

public enum MainEventLoopGroup {}

extension Dependency.Values {
    public var mainEventLoopGroup: any EventLoopGroup {
        get { self[MainEventLoopGroup.self] }
        set { self[MainEventLoopGroup.self] = newValue }
    }
}

// Accessor/conformance CO-LOCATION (di-composition-root-design.md §4.3
// rule 2): the `\.mainEventLoopGroup` accessor above binds its
// `self[MainEventLoopGroup.self]` subscript overload at THIS module's
// compile time. When this module saw only the Key.Test conformance (the
// liveValue conformance lived downstream in boiler), the accessor was
// permanently bound to the testValue-only overload — production reads
// resolved the single-threaded EmbeddedEventLoop and NIO crashed at boot
// (app boot SIGSEGV; marketing main's bind fatal). The key's WIDEST
// conformance must be visible here, so the Witness.Key (liveValue)
// conformance lives HERE, not in a downstream module.
extension MainEventLoopGroup: Witness.Key {
    public static var liveValue: any EventLoopGroup { multithreaded }
}

extension MainEventLoopGroup: Dependency.Key.Test {
    public static var testValue: any EventLoopGroup { embedded }
}

extension MainEventLoopGroup {
    public static var embedded: any EventLoopGroup {
        EmbeddedEventLoop()
    }

    public static var multithreaded: any EventLoopGroup {
        #if DEBUG
            return MultiThreadedEventLoopGroup(numberOfThreads: 1)
        #else
            return MultiThreadedEventLoopGroup(numberOfThreads: System.coreCount)
        #endif
    }
}
