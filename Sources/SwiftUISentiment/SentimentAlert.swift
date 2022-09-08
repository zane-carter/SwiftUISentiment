//
//  SentimentAlert.swift
//  
//
//  Created by Zane Carter on 8/9/2022.
//

import SwiftUI

/// An internal wrapper for showing a root sentiment alert and its proceeding actions
struct SentimentAlert<Content: View>: View {
    /// A binding to a boolean determining wether the root sentiment alert is displayed
    @Binding var isPresented: Bool
    /// The configuration for this sentiment alert
    var configuration: SentimentAlertConfiguration
    /// The parent view
    var content: Content

    /// Used internally for presenting the second step of the sentiment alerts
    @State private var optionPresented = false
    /// The option to use for the secondary alert
    @State private var option: SentimentAlertOption?

    var body: some View {
        content
            /// The secondary step showing an option and its various action
            .alert(option?.title ?? "", isPresented: $optionPresented, presenting: option, actions: { option in
                ForEach(option.actions) { action in
                    Button(action: { action.execute() }) {
                        Text(action.name)
                    }
                }
            })
            /// The root sentiment alert to display
            .alert(
                configuration.title,
                isPresented: $isPresented,
                actions: {
                    ForEach(configuration.options) { option in
                        Button(
                            action: {
                                DispatchQueue.main.async {
                                    self.option = option
                                    self.optionPresented = true
                                }
                            },
                            label: { Text(option.title) }
                        )
                    }
                },
                message: {
                    Text(configuration.details)
                }
            )
    }
}
