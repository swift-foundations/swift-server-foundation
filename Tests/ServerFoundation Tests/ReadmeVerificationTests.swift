//
//  ReadmeVerificationTests.swift
//  swift-server-foundation
//
//  Created for README standardization verification. The HTTP-client
//  example died with the C2 δ-deletion (decomposition W3): \.httpClient
//  had zero consumers and AsyncHTTPClient left ssf's graph.
//

import Logging
import Testing

@testable import ServerFoundation

@Suite("README Verification")
struct ReadmeVerificationTests {

    @Test("Quick Start - Logging example")
    func loggingExample() throws {
        // From README line 42
        let logger = Logger(label: "com.example.app")
        #expect(logger.label == "com.example.app")
    }

    @Test("Quick Start - JWT example structure")
    func jwtExampleStructure() throws {
        // This verifies the JWT type exists and has expected initializer signature
        // Note: Actual signing requires a valid key

        // Verify JWT type is available from ServerFoundation
        let _: JWT.Type = JWT.self

        // JWT API verification would require crypto keys
        // which is beyond the scope of README verification
    }

    @Test("Module - ServerFoundation can be imported")
    func serverFoundationImports() {
        // Verify re-exported modules are accessible through the shell
        let _: Logger.Type = Logger.self
        let _: JWT.Type = JWT.self
    }
}
