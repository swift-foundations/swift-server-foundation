// swift-tools-version: 6.3.3

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
    static var urlRequestHandler: Self { .product(name: "URLRequestHandler", package: "swift-urlrequest-handler") }
    static var nioCore: Self { .product(name: "NIOCore", package: "swift-nio") }
    static var nioEmbedded: Self { .product(name: "NIOEmbedded", package: "swift-nio") }
    static var nioPosix: Self { .product(name: "NIOPosix", package: "swift-nio") }
    static var dependenciesTestSupport: Self { .product(name: "Dependencies Test Support", package: "swift-dependencies") }
    static var dependencies: Self { .product(name: "Dependencies", package: "swift-dependencies") }
    static var clocksDependencies: Self { .product(name: "Clocks Dependencies", package: "swift-clocks-dependencies") }
    static var throttlingDependencies: Self { .product(name: "Throttling Dependencies", package: "swift-throttling-dependencies") }
    static var translatingDependencies: Self { .product(name: "Translating Dependencies", package: "swift-translating-dependencies") }
    static var environmentDependencies: Self { .product(name: "Environment Dependencies", package: "swift-environment-dependencies") }
    static var logging: Self { .product(name: "Logging", package: "swift-log") }
    static var throttling: Self { .product(name: "Throttling", package: "swift-throttling") }
    static var passwordValidation: Self { .product(name: "PasswordValidation", package: "swift-password") }
    static var crypto: Self { .product(name: "Crypto", package: "swift-crypto") }
    static var jwt: Self { .product(name: "JWT", package: "swift-json-web-token") }
}

let package = Package(
    name: "swift-server-foundation",
    platforms: [
        .macOS(.v26),
        .iOS(.v26)
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
        .package(url: "https://github.com/swift-foundations/swift-json-web-token.git", branch: "main"),
        .package(url: "https://github.com/swift-foundations/swift-password.git", branch: "main"),
        .package(url: "https://github.com/swift-foundations/swift-throttling.git", branch: "main"),
        .package(url: "https://github.com/swift-foundations/swift-dependencies.git", branch: "main"),
        .package(url: "https://github.com/swift-foundations/swift-clocks-dependencies.git", branch: "main"),
        .package(url: "https://github.com/swift-foundations/swift-throttling-dependencies.git", branch: "main"),
        .package(url: "https://github.com/swift-foundations/swift-translating-dependencies.git", branch: "main"),
        .package(url: "https://github.com/swift-foundations/swift-environment-dependencies.git", branch: "main"),
        .package(url: "https://github.com/apple/swift-nio.git", from: "2.0.0"),
        .package(url: "https://github.com/apple/swift-log.git", from: "1.0.0"),
        .package(url: "https://github.com/apple/swift-crypto.git", "3.0.0"..<"5.0.0"),
        .package(url: "https://github.com/swift-foundations/swift-urlrequest-handler.git", branch: "main")
    ],
    targets: [
        .target(
            name: .serverFoundation,
            dependencies: [
                .clocksDependencies,
                .throttlingDependencies,
                .translatingDependencies,
                .dependencies,
                .serverEnvVars,
                .nioCore,
                .nioEmbedded,
                .nioPosix,
                .logging,
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
                .environmentDependencies
            ]
        )
    ],
    swiftLanguageModes: [.v6]
)

extension String { var tests: Self { self + " Tests" } }
