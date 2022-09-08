//
//  View+sentimentAlert.swift
//  
//
//  Created by Zane Carter on 8/9/2022.
//

import SwiftUI

public extension View {
    /// Display a sentiment alert using a manually supplied `Bool` binding
    ///
    /// - Parameters:
    /// `isPresented`:  A binding to a Boolean value that determines whether the alert is displayed
    func sentimentAlert(configuration: SentimentAlertConfiguration, isPresented: Binding<Bool>) -> some View {
        SentimentAlert(isPresented: isPresented, configuration: configuration, content: self)
    }
    /// Display a sentiment alert using the given `SentimentAlertConfiguration`
    ///
    /// - Parameters:
    /// `configuration`: The `SentimentAlertConfiguration` for this sentiment alert
    /// `trigger`: The trigger that will cause this sentiment alert to display
    func sentimentAlert(configuration: SentimentAlertConfiguration, trigger: SentimentAlertTrigger) -> some View {
        SentimentTriggeredAlert(configuration: configuration, trigger: trigger, content: self)
    }
}
