//
//  EventLoopGroup Reachability Tests.swift
//  swift-server-foundation
//
//  `MainEventLoopGroup` and `\.mainEventLoopGroup` moved to
//  swift-event-loop-group-dependencies. ssf is a re-export shell, so what
//  consumers depend on is that `import ServerFoundation` still reaches them.
//  These assert that seam, in the shape of swift-uri's `5f780d6`.
//

import Dependencies
import Testing

@testable import ServerFoundation

@Suite("EventLoopGroup reachability")
struct EventLoopGroupReachabilityTests {
    /// Compile-time reachability: the accessor resolves through ssf's
    /// re-export, with no direct import of the owning package.
    @Test
    func `the accessor is reachable through the ServerFoundation re-export`() {
        @Dependency(\.mainEventLoopGroup) var group
        #expect(!"\(type(of: group))".isEmpty)
    }

    /// Positive identity, not absence of the negative — `any EventLoopGroup`
    /// is satisfied by both the multithreaded and the embedded group, which
    /// is exactly why the compiler cannot catch a mis-binding.
    ///
    /// Asserted on the type's name rather than with `is`: ssf no longer
    /// depends on swift-nio, so `MultiThreadedEventLoopGroup` is not nameable
    /// here. The owning package asserts it with `is` where it is.
    @Test
    func `an unscoped read resolves the multithreaded group`() {
        @Dependency(\.mainEventLoopGroup) var group
        #expect("\(type(of: group))" == "MultiThreadedEventLoopGroup")
    }

    /// The type moved but stayed public through the shell.
    @Test
    func `MainEventLoopGroup is reachable through the re-export`() {
        #expect("\(MainEventLoopGroup.self)" == "MainEventLoopGroup")
    }
}
