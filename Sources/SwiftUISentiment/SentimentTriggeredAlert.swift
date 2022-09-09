//
//  SentimentTriggeredAlert.swift
//  
//
//  Created by Zane Carter on 8/9/2022.
//

import SwiftUI

/// An internal wrapper for showing a `SentimentAlert` with a given trigger
struct SentimentTriggeredAlert<Content: View>: View {
    var configuration: SentimentAlertConfiguration
    /// The trigger to determine if the sentiment alert should be displayed
    var trigger: SentimentAlertTrigger
    /// The parent view
    var content: Content

    /// An internal @State to determine when the root sentiment alert should be displayed
    @State private var isPresented = false

    var body: some View {
        SentimentAlert(isPresented: $isPresented, configuration: configuration, content: content)
            .onAppear {
                print(configuration.identifier)
                print("APPEARED")
                /// Depending on the trigger, either increment or set a flag, and if conditiions are met display the root sentiment alert
                switch trigger {
                /// If the triggered flag is not set, present the alert and then mark the flag as triggered
                case .once:
                    if !SentimentAlertStore.alertTriggered(configuration.identifier) {
                        self.isPresented = true
                    }
                    SentimentAlertStore.markTriggered(configuration.identifier)
                /// If the trigger has been called the correct number of times, present the alert and increment the trigger count
                case .count(let views):
                    SentimentAlertStore.incrementCount(configuration.identifier)
                    if SentimentAlertStore.triggerCount(configuration.identifier) == views {
                        self.isPresented = true
                    }
                }
            }
    }
}
