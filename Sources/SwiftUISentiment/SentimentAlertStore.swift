//
//  View+SentimentAlertStore.swift
//
//
//  Created by Zane Carter on 8/9/2022.
//

import Foundation

/// An internal helper class for managing whether sentiment alerts have been triggered, or how many times
class SentimentAlertStore {
    static private let userDefaults = UserDefaults.standard
    // MARK: Helpers
    /// Returns a `Bool` indicating if an alert with this `identifier` has been presented before
    static func alertTriggered(_ identifier: String) -> Bool {
        userDefaults.bool(forKey: triggeredKey(identifier))
    }
    
    /// Mark an alert as triggered
    static func markTriggered(_ identifier: String) {
        userDefaults.set(true, forKey: triggeredKey(identifier))
    }
    
    /// Returns the amount of times as an `Int` that the trigger with the given `identifier` has been called
    static func triggerCount(_ identifier: String) -> Int {
        userDefaults.integer(forKey: countKey(identifier))
    }

    /// Increment the trigger count for a given `identifier`
    static func incrementCount(_ identifier: String) {
        userDefaults.set(triggerCount(identifier) + 1, forKey: countKey(identifier))
    }

    // MARK: Support
    /// The prefix to use for keys marking alerts as presented and tallying trigger counts
    static var prefix: String { "com.swiftuisentiment" }

    /// Returns a key to use with `UserDefaults` to mark an alert as presented
    static private func triggeredKey(_ identifier: String) -> String {
        "\(prefix).triggered.\(identifier)"
    }

    /// Returns a key to use with `UserDefaults` to count the times a trigger has been called
    static private func countKey(_ identifier: String) -> String {
        "\(prefix).count.\(identifier)"
    }
}
