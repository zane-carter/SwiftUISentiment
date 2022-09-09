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

    /// Used internally for presenting the actions associated with the selected option
    @State private var optionPresented = false
    /// The option the user has selected
    @State private var option: SentimentAlertOption?

    var body: some View {
        content
            /// The secondary step showing an option and its various action
            .alert(option?.label ?? "", isPresented: $optionPresented, presenting: option, actions: { option in
                ForEach(option.actions) { action in
                    switch action {
                    case .close(_): Button(role: .cancel, action: {}, label: { Text(action.label) })
                    default: Button(role: .none, action: { action.execute() }, label: { Text(action.label)})
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
                                    option.selected()
                                    self.option = option
                                    /// If there is atleast 1 secondary action, present the list of actions
                                    if !option.actions.isEmpty {
                                        self.optionPresented = true
                                    }
                                }
                            },
                            label: { Text(option.label) }
                        )
                    }
                },
                message: {
                    Text(configuration.details)
                }
            )
    }
}
