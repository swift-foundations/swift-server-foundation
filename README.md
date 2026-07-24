# swift-server-foundation

![Status](https://img.shields.io/badge/status-DISSOLVED--W3--shell-red.svg)

> **W3-SHELL (TEMPORARY).** swift-server-foundation is **dissolved**
> (decomposition W3, 2026-07-14). This package survives as a marked re-export
> shell ONLY so existing manifests and the app resolve unchanged until the
> E-program app cutover. Do not add new consumers.
>
> | Former concern | New home |
> |---|---|
> | `\.date` + `Date.Generator` (C1) | [swift-clocks-dependencies](https://github.com/swift-foundations/swift-clocks-dependencies) |
> | `\.httpClient` (C2) | **deleted** — dead code (de-engine R3) |
> | `\.mainEventLoopGroup` (C3) | stays here until β-end (de-engine R5) |
> | console logger handler (C4) | [swift-logger-handlers](https://github.com/swift-foundations/swift-logger-handlers) `Logger.Handler.Console` |
> | `InMemoryStore` TTL cache (C5) | [swift-time-to-live](https://github.com/swift-foundations/swift-time-to-live) `Store.InMemory` |
> | `URL.canonical` (C6) | [swift-uri](https://github.com/swift-foundations/swift-uri) `RFC_3986.URI.canonical(host:)` |
> | `Path` constants (C7) | [swift-url-routing](https://github.com/swift-foundations/swift-url-routing) compat surface |
> | `EnvVars` + `\.envVars`/`\.projectRoot` (C8) | [swift-environment-dependencies](https://github.com/swift-foundations/swift-environment-dependencies) |
> | throttling × dependencies (C9) | [swift-throttling-dependencies](https://github.com/swift-foundations/swift-throttling-dependencies) |
> | translating seam | [swift-translating-dependencies](https://github.com/swift-foundations/swift-translating-dependencies) |

A foundation library for server-side Swift development that consolidates essential packages for building server applications.

## Overview

swift-server-foundation provides a unified interface to commonly-used server development packages. Instead of managing multiple dependencies individually, this foundation package re-exports and integrates type safety, authentication, infrastructure, and utility libraries into a single import.

## Features

- Type-safe domain models for email addresses, domains, and JWT
- Password validation with customizable security policies
- Cryptographic operations via Apple's Crypto framework
- Rate limiting and request throttling
- HTTP client with async/await support
- Structured logging with Apple's unified logging API
- Environment variable handling with type safety
- URL routing with internationalization support
- Declarative content builders

## Installation

Add swift-server-foundation to your Package.swift dependencies:

```swift
dependencies: [
    .package(url: "https://github.com/coenttb/swift-server-foundation.git", from: "0.0.1")
]
```

## Quick Start

Import the foundation to access all included packages:

```swift
import ServerFoundation

// Logging
let logger = Logger(label: "com.example.app")

// HTTP Client
let client = HTTPClient(eventLoopGroupProvider: .shared(eventLoopGroup))

// JWT
let jwt = try JWT(
    payload: ["user_id": "12345"],
    signedBy: key
)
```

## Usage

### Type Safety & Domain Modeling

- [EmailAddress](https://github.com/coenttb/swift-emailaddress-type) - Type-safe email address handling
- [Domain](https://github.com/coenttb/swift-domain-type) - Type-safe domain models
- [JWT](https://github.com/coenttb/swift-jwt) - JSON Web Token implementation
- [PasswordValidation](https://github.com/coenttb/swift-password-validation) - Password validation policies

### Security

- [Crypto](https://github.com/apple/swift-crypto) - Cryptographic operations and key management
- [Throttling](https://github.com/coenttb/swift-throttling) - Rate limiting for API protection

### Server Infrastructure

- [AsyncHTTPClient](https://github.com/swift-server/async-http-client) - Non-blocking HTTP client
- [Logging](https://github.com/apple/swift-log) - Unified logging API

### Configuration

- [EnvironmentVariables](https://github.com/coenttb/swift-environment-variables) - Type-safe environment variable handling
- ServerFoundationEnvVars - Environment-specific configuration

### Date & Time

- [DateParsing](https://github.com/coenttb/swift-date-parsing) - RFC 2822, RFC 5322, and Unix epoch parsing
- [FoundationExtensions](https://github.com/coenttb/swift-foundation-extensions) - Date manipulation and validation

### Routing & Localization

- [URLRouting](https://github.com/pointfreeco/swift-url-routing) - Type-safe URL routing
- [URLRoutingTranslating](https://github.com/coenttb/swift-url-routing-translating) - Multi-language URL patterns
- [Translating](https://github.com/coenttb/swift-translating) - Translation and localization framework

### Utilities

- [Builders](https://github.com/coenttb/swift-builders) - Result builders for declarative syntax
- [Dependencies](https://github.com/pointfreeco/swift-dependencies) - Dependency management
- [CasePaths](https://github.com/pointfreeco/swift-case-paths) - Key path-like functionality for enums
- [IssueReporting](https://github.com/pointfreeco/xctest-dynamic-overlay) - Runtime issue reporting

## Environment Variables

The ServerFoundationEnvVars module provides type-safe access to environment configuration:

```swift
import ServerFoundationEnvVars

// Access with defaults
let port = EnvVars.PORT.value ?? 8080

// Require value (throws if missing)
let apiKey = try EnvVars.API_KEY.require()
```

## Related Packages

### Dependencies

- [swift-environment-variables](https://github.com/coenttb/swift-environment-variables): A Swift package for type-safe environment variable management.
- [swift-jwt](https://github.com/coenttb/swift-jwt): A Swift package for creating, signing, and verifying JSON Web Tokens.
- [swift-logger-handlers](https://github.com/swift-foundations/swift-logger-handlers): Focused logger handlers for Swift Logging.
- [swift-password-validation](https://github.com/coenttb/swift-password-validation): A Swift package for type-safe password validation.
- [swift-throttling](https://github.com/coenttb/swift-throttling): A Swift package for request throttling.
- [swift-urlrequest-handler](https://github.com/coenttb/swift-urlrequest-handler): A Swift package for URLRequest handling with structured error handling.

### Used By

- [coenttb-com-server](https://github.com/coenttb/coenttb-com-server): Production server for coenttb.com built with Boiler.
- [coenttb-newsletter](https://github.com/coenttb/coenttb-newsletter): A Swift package for newsletter subscription and email management.
- [coenttb-server](https://github.com/coenttb/coenttb-server): A Swift package for building fast, modern, and safe servers.
- [swift-github-live](https://github.com/coenttb/swift-github-live): A Swift package with live implementations for the GitHub API.
- [swift-identities-mailgun](https://github.com/coenttb/swift-identities-mailgun): A Swift package integrating Mailgun with swift-identities.
- [swift-server-foundation-vapor](https://github.com/coenttb/swift-server-foundation-vapor): A Swift package integrating swift-server-foundation with Vapor.
- [swift-stripe](https://github.com/coenttb/swift-stripe): The Swift library for the Stripe API.
- [swift-stripe-live](https://github.com/coenttb/swift-stripe-live): A Swift package with live implementations for the Stripe API.

### Third-Party Dependencies

- [pointfreeco/swift-dependencies](https://github.com/pointfreeco/swift-dependencies): A dependency management library for controlling dependencies in Swift.
- [apple/swift-crypto](https://github.com/apple/swift-crypto): Open-source implementation of a substantial portion of the API of Apple CryptoKit.
- [apple/swift-log](https://github.com/apple/swift-log): A Logging API for Swift.

## License

This project is licensed under the Apache 2.0 License. See [LICENSE](LICENSE) for details.

## Contributing

Contributions are welcome. Please open an issue or submit a pull request on [GitHub](https://github.com/coenttb/swift-server-foundation).
