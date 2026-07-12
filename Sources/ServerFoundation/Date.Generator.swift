//
//  Date.Generator.swift
//  swift-server-foundation
//
//  Consumer-local date-generator shim per the migration-wave precedent
//  (swift-time-based-one-time-password, 2026-07-10). The institute
//  swift-dependencies core does not vend `\.date`; this restores the
//  controllable wall-clock surface for ServerFoundation and its consumers.
//

import Foundation

extension Date {
    /// A controllable source of the current date.
    ///
    /// Wraps a `@Sendable () -> Date` closure so the current time can be
    /// injected as a dependency and overridden deterministically in tests:
    ///
    /// ```swift
    /// @Dependency(\.date) var date
    /// let now = date()
    /// ```
    ///
    /// Override in tests:
    ///
    /// ```swift
    /// @Test(.dependency(\.date, .constant(Date(timeIntervalSince1970: 0))))
    /// func feature() { ... }
    /// ```
    public struct Generator: Sendable {
        private let generate: @Sendable () -> Date

        /// Creates a generator from a closure producing the current date.
        ///
        /// - Parameter generate: The closure invoked on each access.
        public init(_ generate: @escaping @Sendable () -> Date) {
            self.generate = generate
        }

        /// Returns the current date from the underlying closure.
        public func callAsFunction() -> Date {
            generate()
        }
    }
}

extension Date.Generator {
    /// A generator that always returns the same fixed date.
    ///
    /// - Parameter date: The date to return on every access.
    /// - Returns: A generator frozen at `date`.
    public static func constant(_ date: Date) -> Self {
        Self { date }
    }
}
