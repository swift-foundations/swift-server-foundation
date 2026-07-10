//
//  EnvVars.live.swift
//  swift-server-foundation
//
//  Live `EnvVars` construction and swift-dependencies integration. The process
//  environment is read through the institute `Environment` package, replacing the
//  superseded swift-environment-variables reader. An optional JSON environment file
//  is overlaid on top of the process environment (file values win).
//

import Dependencies
import Environment
import Foundation

extension EnvVars {
    /// Builds an `EnvVars` from the live process environment, overlaying an optional
    /// JSON environment file (file values take precedence over the process environment).
    public static func live(localEnvFile: URL? = nil) throws -> EnvVars {
        var dictionary = Environment.read.all()
        if let localEnvFile,
            let data = try? Data(contentsOf: localEnvFile),
            let fileValues = try? JSONDecoder().decode([String: String].self, from: data)
        {
            for (key, value) in fileValues { dictionary[key] = value }
        }
        return try EnvVars(dictionary: dictionary, requiredKeys: [])
    }

    /// Builds an `EnvVars` from the live process environment, overlaying the JSON
    /// environment file resolved from `configuration` (file values take precedence).
    public static func live(
        environmentConfiguration configuration: EnvironmentConfiguration
    ) throws -> EnvVars {
        var dictionary = Environment.read.all()
        if let fileValues = configuration.load() {
            for (key, value) in fileValues { dictionary[key] = value }
        }
        return try EnvVars(dictionary: dictionary, requiredKeys: [])
    }
}

extension EnvVars: DependencyKey {
    /// The live value reads the current process environment via institute `Environment`.
    public static var liveValue: EnvVars {
        (try? live()) ?? EnvVars()
    }
}

extension DependencyValues {
    /// The application's environment variables.
    public var envVars: EnvVars {
        get { self[EnvVars.self] }
        set { self[EnvVars.self] = newValue }
    }
}
