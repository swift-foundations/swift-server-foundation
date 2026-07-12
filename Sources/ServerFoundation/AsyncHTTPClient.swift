import AsyncHTTPClient
import Dependencies

extension Dependency.Values {
    public var httpClient: HTTPClient {
        get { self[HTTPClient.self] }
        set { self[HTTPClient.self] = newValue }
    }
}

extension HTTPClient: @retroactive Dependency.Key.Test {
    public static var testValue: HTTPClient { .default }
}

extension HTTPClient {
    public static var `default`: HTTPClient {
        @Dependency(\.mainEventLoopGroup) var eventLoopGroup
        return HTTPClient(eventLoopGroupProvider: .shared(eventLoopGroup))
    }
}
