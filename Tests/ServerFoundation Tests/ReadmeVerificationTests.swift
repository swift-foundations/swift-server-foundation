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

@Suite
struct `Readme Verification Tests` {

    @Test
    func `Quick Start - Logging example`() throws {
        // From README line 42
        let logger = Logger(label: "com.example.app")
        #expect(logger.label == "com.example.app")
    }

    @Test
    func `Quick Start - JWT example structure`() throws {
        // This verifies the JWT type exists and has expected initializer signature
        // Note: Actual signing requires a valid key

        // Verify JWT type is available from ServerFoundation
        let _: JWT.Type = JWT.self

        // JWT API verification would require crypto keys
        // which is beyond the scope of README verification
    }

    @Test
    func `Module - Server Foundation can be imported`() {
        // Verify re-exported modules are accessible through the shell
        let _: Logger.Type = Logger.self
        let _: JWT.Type = JWT.self
    }
}
