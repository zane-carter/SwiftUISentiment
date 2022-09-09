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
    /// Returns the amount of times as an `Int` that the trigger with the given `identifier` has been called
    static func triggerCount(_ identifier: String) -> Int {
        userDefaults.integer(forKey: key(identifier))
    }

    /// Increment the trigger count for a given `identifier`
    static func incrementCount(_ identifier: String) {
        userDefaults.set(triggerCount(identifier) + 1, forKey: key(identifier))
        userDefaults.synchronize()
    }
    
    /// Reset the scounttore for a given `identifier`
    static func resetCount(_ identifier: String) {
        userDefaults.set(0, forKey: key(identifier))
    }

    // MARK: Support
    /// The prefix to use for keys marking alerts as presented and tallying trigger counts
    static var prefix: String { "com.swiftuisentiment" }

    /// Returns a key to use with `UserDefaults` to count the times a trigger has been called
    static private func key(_ identifier: String) -> String {
        "\(prefix).count.\(identifier)"
    }
}
