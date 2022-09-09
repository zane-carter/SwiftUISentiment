//
//  SentimentAlertConfiguration.swift
//  
//
//  Created by Zane Carter on 8/9/2022.
//

import SwiftUI


/// The configuration for the sentiment alert
public struct SentimentAlertConfiguration {
    /// The identifier used to identify the view attached to this instance of the sentiment alert
    /// - Note:
    /// This is used to identify how many times the attached view has been loaded for the `count` trigger
    /// It is also used to determine if this alert has been displayed for the `.once` trigger
    var identifier: String
    /// The title to display on the root sentiment alert
    var title: LocalizedStringKey
    /// The detail text to display on the root sentiment alert
    var details: LocalizedStringKey
    /// A set of  `SentimentAlertOption`s to display if the user selects this option
    /// - Note: If no actions are provided the option will present nothing.
    var options: [SentimentAlertOption]
    
    /// Creates a new configuration for displaying a sentiment alert
    /// - Parameters:
    ///   - identifier: The unique identifier for this sentiment alert.
    ///   - title: The title to display at the top of the sentiment alert
    ///   - details: The detail text to display on the sentiment alert
    ///   - options: The available options to display to the user, usually this is a positive and negative option
    public init(identifier: String, title: LocalizedStringKey, details: LocalizedStringKey, options: [SentimentAlertOption]) {
        self.identifier = identifier
        self.title = title
        self.details = details
        self.options = options
    }
    
    /// Reset the trigger count for this configurations `identifier`
    /// - Note: This will reset the stored trigger counts for this configurations `identifier` which means alerts will show again
    func reset() {
        SentimentAlertStore.resetCount(identifier)
    }
}


/// The sentiment option to display on the root sentiment alert
/// There is typically a positive and negative sentiment option
public struct SentimentAlertOption: Identifiable {
    /// The identifier for the `SentimentAlertOption`
    public var id: String
    /// The label to use for this sentiment option in the root sentiment alert.
    /// For a positive sentiment this might be "Yes" or "I love it"
    var label: LocalizedStringKey
    /// The actions that this alert option will present the user with if selected
    /// - Note: You should make sure to include a `close` action in most cases
    var actions: [SentimentAlertAction]
    /// A custom action to run when this `SentimentAlertOption` is selected
    var selected: () -> Void = {}
    
    /// Create a new `SentimentAlertOption` for use in a `SentimentAlertConfiguration`
    /// - Parameters:
    ///    - label: The label to display for the option
    ///    - actions: The actions to show the user if they select this option. Provide an empty array to not display any actions.
    ///    - selected: An optional closure to run when this option is selected
    public init(label: LocalizedStringKey, actions: [SentimentAlertAction], selected: @escaping () -> Void = {}) {
        self.label = label
        self.actions = actions
        self.selected = selected
        self.id = UUID().uuidString
    }
}
