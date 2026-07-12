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
