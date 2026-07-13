//
//  InMemoryStore.swift
//  swift-server-foundation
//
//  W3-PARKED (C5): stays in the shell pending the swift-time-to-live stub
//  population (a principal ⚑; fill-shape proposal rides the W3 close report).
//  The Any-erasure is a known defect — drop it at the fill, do not move it.
//

import Cache_Primitives
import Dependencies
import Foundation

public actor InMemoryStore {
    /// - Note: `@unchecked Sendable` because `value` is `Any`; `Cache.Bounded`
    ///   requires `Value: Sendable`. Access is confined to the `InMemoryStore` actor.
    private struct Entry: @unchecked Sendable {
        let value: Any
        let expiresAt: Date?
    }

    private let cache: Cache<String, Entry>.Bounded
    private var cleanupTimer: SendableTimer?

    public init(capacity: Int = 1000, cleanupInterval: TimeInterval = 60) {
        self.cache = .init(capacity: capacity)
        Task {
            await self.startCleanupTimer(interval: cleanupInterval)
        }
    }

    deinit {
        // Synchronously invalidate the timer to ensure cleanup happens immediately
        cleanupTimer?.invalidate()
    }

    private func startCleanupTimer(interval: TimeInterval) {
        let timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) {
            [weak self] _ in
            Task { [weak self] in
                await self?.removeExpiredEntries()
            }
        }
        let sendableTimer = SendableTimer()
        sendableTimer.setTimer(timer)
        self.cleanupTimer = sendableTimer
    }
}

extension InMemoryStore {
    private class SendableTimer: @unchecked Sendable {
        private var timer: Timer?

        func setTimer(_ timer: Timer) {
            self.timer = timer
        }

        func invalidate() {
            timer?.invalidate()
            timer = nil
        }
    }
}

extension InMemoryStore {
    public func set(_ key: String, value: Any, expiresIn: TimeInterval? = nil) {
        let expiresAt = expiresIn.map { Date().addingTimeInterval($0) }
        let entry = Entry(value: value, expiresAt: expiresAt)
        cache.insert(entry, forKey: key)
    }

    public func get(_ key: String) -> Any? {
        guard let entry = cache.getValue(forKey: key) else { return nil }

        if let expiresAt = entry.expiresAt, expiresAt < Date() {
            _ = cache.removeValue(forKey: key)
            return nil
        }

        return entry.value
    }

    public func get<T>(_ key: String, as type: T.Type) -> T? {
        guard let entry = cache.getValue(forKey: key) else { return nil }

        if let expiresAt = entry.expiresAt, expiresAt < Date() {
            _ = cache.removeValue(forKey: key)
            return nil
        }

        return entry.value as? T
    }

    public func remove(_ key: String) {
        _ = cache.removeValue(forKey: key)
    }

    public func removeExpiredEntries() {
        let now = Date()
        cache.filter { _, entry in
            guard let expiresAt = entry.expiresAt else { return true }
            return expiresAt > now
        }
    }

    public func clear() {
        cache.removeAll()
    }

    // Additional utility methods that leverage Cache.Bounded capabilities
    public var count: Int {
        cache.count
    }

    public var isEmpty: Bool {
        cache.isEmpty
    }
}

extension InMemoryStore: Dependency.Key.Test {
    public static let testValue: InMemoryStore = .init(capacity: 100)  // Smaller capacity for tests
}

extension Dependency.Values {
    public var inMemoryStore: InMemoryStore {
        get { self[InMemoryStore.self] }
        set { self[InMemoryStore.self] = newValue }
    }
}
