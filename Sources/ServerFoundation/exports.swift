//
//  exports.swift
//  swift-server-foundation
//
//  W3-SHELL (TEMPORARY — decomposition W3, 2026-07-14): swift-server-foundation
//  is DISSOLVED. Its concerns live in their own packages (see README table);
//  this umbrella survives ONLY so the app resolves and builds unchanged until
//  the E-program app cutover. Executioners: E-program app-write wave + S6 arc.
//  The Clocks/Throttling/Translating Dependencies lines are the new-home seams;
//  TypesFoundation is itself a W2 shell with the same executioners.
//

@_exported import Clocks_Dependencies
@_exported import Crypto
@_exported import JWT
@_exported import Logging
@_exported import LoggingExtras
@_exported import PasswordValidation
@_exported import ServerFoundationEnvVars
@_exported import Throttling
@_exported import Throttling_Dependencies
@_exported import Translating_Dependencies
@_exported import TypesFoundation
@_exported import URLRequestHandler

#if canImport(FoundationNetworking)
    @_exported import FoundationNetworking
#endif
