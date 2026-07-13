//
//  URLOptional.canonical.swift
//  swift-server-foundation
//
//  W3-PARKED (C6): stays in the shell; its home is the swift-uri fill as a
//  design item (ASK-3 ruling 22:41) — an RFC 3986 canonicalization, not a
//  transliteration of this Foundation/URLComponents algorithm.
//

import Foundation

public enum URLCanonicalError: Error, Equatable {
    case invalidURL
    case emptyHost
    case invalidPort(String)
    case malformedIPv6
    case portOutOfRange(Int)
}

extension URL {
    public static func canonical(
        url: URL,
        canonicalHost: String
    ) throws(URLCanonicalError) -> URL {
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            throw URLCanonicalError.invalidURL
        }

        guard !canonicalHost.isEmpty else {
            throw URLCanonicalError.emptyHost
        }

        // IPv6 addresses use bracket notation [host]:port
        if canonicalHost.hasPrefix("[") {
            throw URLCanonicalError.malformedIPv6  // IPv6 not supported yet
        }

        // Handle regular host:port
        let parts = canonicalHost.split(separator: ":", maxSplits: 1).map(String.init)
        components.host = parts.first

        if parts.count == 2 {
            let portString = parts[1]
            guard let port = Int(portString) else {
                throw URLCanonicalError.invalidPort(portString)
            }

            guard port > 0 && port <= 65535 else {
                throw URLCanonicalError.portOutOfRange(port)
            }

            components.port = port
        } else {
            components.port = nil
        }

        guard let resultURL = components.url else {
            throw URLCanonicalError.invalidURL
        }

        return resultURL
    }
}
