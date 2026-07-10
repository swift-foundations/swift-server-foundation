// swift-tools-version:6.0

import PackageDescription

extension String {
    static let serverFoundation: Self = "ServerFoundation"
    static let serverEnvVars: Self = "ServerFoundationEnvVars"
}

extension Target.Dependency {
    static var serverFoundation: Self { .target(name: .serverFoundation) }
    static var serverEnvVars: Self { .target(name: .serverEnvVars) }
}

extension Target.Dependency {
    static var typesFoundation: Self { .product(name: "TypesFoundation", package: "swift-types-foundation") }
    static var urlRequestHandler: Self { .product(name: "URLRequestHandler", package: "swift-urlrequest-handler") }
    static var loggingExtras: Self { .product(name: "LoggingExtras", package: "swift-logging-extras") }
    static var asyncHttpClient: Self { .product(name: "AsyncHTTPClient", package: "async-http-client") }
    static var dependenciesTestSupport: Self { .product(name: "DependenciesTestSupport", package: "swift-dependencies") }
    static var environmentVariables: Self { .product(name: "EnvironmentVariables", package: "swift-environment-variables") }
    static var logging: Self { .product(name: "Logging", package: "swift-log") }
    static var throttling: Self { .product(name: "Throttling", package: "swift-throttling") }
    static var passwordValidation: Self { .product(name: "PasswordValidation", package: "swift-password-validation") }
    static var crypto: Self { .product(name: "Crypto", package: "swift-crypto") }
    static var jwt: Self { .product(name: "JWT", package: "swift-jwt") }
}

let package = Package(
    name: "swift-server-foundation",
    platforms: [
        .macOS(.v14),
        .iOS(.v17)
    ],
    products: [
        .library(
            name: .serverFoundation,
            targets: [
                .serverFoundation,
                .serverEnvVars
            ]
        ),
        .library(name: .serverEnvVars, targets: [.serverEnvVars])
    ],
    dependencies: [
        .package(url: "https://github.com/coenttb/swift-types-foundation", from: "0.0.1"),
        .package(url: "https://github.com/coenttb/swift-environment-variables", from: "0.0.1"),
        .package(url: "https://github.com/coenttb/swift-jwt", from: "0.0.1"),
        .package(url: "https://github.com/coenttb/swift-password-validation", from: "0.0.1"),
        .package(url: "https://github.com/coenttb/swift-throttling", from: "0.0.1"),
        .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "1.9.2"),
        .package(url: "https://github.com/swift-server/async-http-client", from: "1.26.1"),
        .package(url: "https://github.com/apple/swift-log", from: "1.0.0"),
        .package(url: "https://github.com/apple/swift-crypto", "3.0.0"..<"5.0.0"),
        .package(url: "https://github.com/coenttb/swift-urlrequest-handler", from: "0.0.2"),
        .package(url: "https://github.com/coenttb/swift-logging-extras", from: "0.0.1")
    ],
    targets: [
        .target(
            name: .serverFoundation,
            dependencies: [
                .typesFoundation,
                .serverEnvVars,
                .asyncHttpClient,
                .environmentVariables,
                .logging,
                .loggingExtras,
                .throttling,
                .urlRequestHandler,
                .passwordValidation,
                .jwt,
                .crypto,
            ]
        ),
        .testTarget(
            name: .serverFoundation.tests,
            dependencies: [
                .serverFoundation,
                .dependenciesTestSupport
            ]
        ),
        .target(
            name: .serverEnvVars,
            dependencies: [
                .environmentVariables,
                .logging
            ]
        ),
        .testTarget(
            name: .serverEnvVars.tests,
            dependencies: [
                .serverEnvVars,
                .dependenciesTestSupport
            ]
        )
    ],
    swiftLanguageModes: [.v6]
)

extension String { var tests: Self { self + " Tests" } }
