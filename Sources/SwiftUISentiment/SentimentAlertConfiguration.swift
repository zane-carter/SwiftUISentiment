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
    var title: String
    /// The detail text to display on the root sentiment alert
    var details: String
    /// A set of  `SentimentAlertOption`s to display
    var options: [SentimentAlertOption]
}


/// The sentiment option to display on the root sentiment alert
/// There is typically a positive and negative sentiment option
public struct SentimentAlertOption: Identifiable {
    /// The title to use for this sentiment option in the root sentiment alert
    /// For a positive sentiment this might be "Yes" or "I like it"
    var title: String
    /// The actions that this alert option will present the user with if selected
    var actions: [SentimentAlertAction]

    /// The identifier for the `SentimentAlertOption`
    public var id: String { title }
}
