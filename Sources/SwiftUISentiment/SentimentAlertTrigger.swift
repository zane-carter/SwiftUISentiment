//
//  SentimentAlertTrigger.swift
//  
//
//  Created by Zane Carter on 8/9/2022.
//

import SwiftUI

/// The trigger that causes the sentiment alert to display
public enum SentimentAlertTrigger: Identifiable, Equatable {
    /// Display the sentiment alert every time the view count reaches a certain number.
    case repeating(every: Int)
    /// Display the sentiment alert after the attached view has been displayed a certain amount of times
    case once(after: Int = 1)

    /// The identifier
    public var id: String {
        switch self {
        case .once: return "once"
        case .repeating: return "repeating"
        }
    }
}
