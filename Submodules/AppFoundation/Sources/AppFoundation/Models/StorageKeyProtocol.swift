//
//  StorageKeyProtocol.swift
//
//
//  Created by Bilal Bakhrom on 2024-01-14.
//

import Foundation

/// Protocol for defining storage keys.
///
/// Conform to this protocol to create custom keys for use with `StorageKeyDefaults`.
/// Each key is represented as a string.
public protocol StorageKeyProtocol: Hashable {
    /// The string representation of the storage key.
    var key: String { get }
}

/// A generic class to manage storage keys and values in UserDefaults.
///
/// This class provides a type-safe interface for storing and retrieving
/// values from UserDefaults. It uses a generic type that conforms to `StorageKeyProtocol`.
/// This approach ensures that keys are consistent and reduces the likelihood of key mismatch.
public struct StorageKeyDefaults<T: StorageKeyProtocol> {
    /// The domain name for the user defaults, if any.
    private let domainName: String?
    
    /// The UserDefaults instance used for storing and retrieving values.
    private let userDefaults: UserDefaults
    
    /// Initializes a new `StorageKeyDefaults` instance.
    ///
    /// - Parameter suiteName: The suite name to use for UserDefaults. If nil, the standard UserDefaults is used.
    public init(suiteName: String?) {
        self.userDefaults = UserDefaults(suiteName: suiteName) ?? UserDefaults.standard
        self.domainName = suiteName
    }
    
    /// Registers a dictionary of default values for the given keys.
    ///
    /// - Parameter registrationDictionary: A dictionary containing the default values for the keys.
    public func register(defaults registrationDictionary: [T : Any]) {
        let defaults = registrationDictionary.reduce(into: [String: Any]()) { result, pair in
            result[pair.key.key] = pair.value
        }
        userDefaults.register(defaults: defaults)
    }
    
    // The following methods provide a type-safe interface for setting and retrieving
    // various types of values (Any, Int, Bool, etc.) from UserDefaults.

    public func set(_ value: Any?, forKey keyObject: T) {
        userDefaults.set(value, forKey: keyObject.key)
    }
    
    public func set(_ value: Int, forKey keyObject: T) {
        userDefaults.set(value, forKey: keyObject.key)
    }
    
    public func set(_ value: Bool, forKey keyObject: T) {
        userDefaults.set(value, forKey: keyObject.key)
    }
    
    public func setValue(_ value: Any?, forKey keyObject: T) {
        userDefaults.setValue(value, forKey: keyObject.key)
    }

    public func string(forKey keyObject: T) -> String? {
        userDefaults.string(forKey: keyObject.key)
    }

    public func integer(forKey keyObject: T) -> Int {
        userDefaults.integer(forKey: keyObject.key)
    }

    public func object(forKey keyObject: T) -> Any? {
        userDefaults.object(forKey: keyObject.key)
    }

    public func bool(forKey keyObject: T) -> Bool {
        userDefaults.bool(forKey: keyObject.key)
    }

    public func value(forKey keyObject: T) -> Any? {
        userDefaults.value(forKey: keyObject.key)
    }

    public func data(forKey keyObject: T) -> Data? {
        userDefaults.data(forKey: keyObject.key)
    }
    
    /// Removes the value for the specified key.
    ///
    /// - Parameter keyObject: The key for which to remove the value.
    public func removeObject(forKey keyObject: T) {
        userDefaults.removeObject(forKey: keyObject.key)
    }
    
    /// Removes all the data for this instance's domain.
    ///
    /// This method removes all user defaults data for the specified domain name or
    /// the bundle identifier, if the domain name is not specified.
    public func removePersistentDomain() {
        if let domainName = domainName {
            userDefaults.removePersistentDomain(forName: domainName)
        } else if let bundleIdentifier = Bundle.main.bundleIdentifier {
            userDefaults.removePersistentDomain(forName: bundleIdentifier)
        }
    }
}
