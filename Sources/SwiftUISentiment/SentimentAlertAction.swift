//
//  SentimentAlertAction.swift
//  
//
//  Created by Zane Carter on 8/9/2022.
//

import SwiftUI

/// An action to display on the end stage `positive` and `negative` sentiment alerts
/// For example sharing on `.twitter` or navigating to `.url`
public enum SentimentAlertAction: Identifiable {
    /// Open the Twitter app to the given account `handle`
    /// If the Twitter app is not available, the user is taken to the Twitter profile URL in safari
    case twitter(_ label: LocalizedStringKey, handle: String)
    /// Navigate the user to the given `url` in the the external Safari App
    case website(_ label: LocalizedStringKey, url: URL)
    /// Navigates the user to their email client, sending an email to the given `address` string
    case email(_ label: LocalizedStringKey, address: String)
    /// Navigates the user to the apps AppStore page and writes a review (if available)
    case review(_ label: LocalizedStringKey, appId: String)
    /// Performs a custom action
    case custom(_ label: LocalizedStringKey, action: () -> Void)
    /// Close the action list
    case close(_ label: LocalizedStringKey)

    /// The `rawValue`
    private var rawValue: String {
        switch self {
        case .twitter(_, handle: let handle): return "twitter-\(handle)"
        case .email(_, address: let address): return "email-\(address)"
        case .website(_, url: let url): return "website-\(url.absoluteString)"
        case .review(_, appId: let appId): return "review-\(appId)"
        case .custom(let label, action: _), .close(let label): return "\(label)"
        }
    }

    /// The `id` used to identify this `SentimentAlertAction`
    public var id: String { rawValue }

    /// The label to display in the alert for this `SentimentAlertAction` button
    public var label: LocalizedStringKey {
        switch self {
        case .twitter(let label, handle: _): return label
        case .email(let label, address: _): return label
        case .website(let label, url: _): return label
        case .review(let label, appId: _): return label
        case .custom(let label, action: _): return label
        case .close(let label): return label
        }
    }
}

// MARK: Actions
extension SentimentAlertAction {
    /// Execute the appropriate action for this `SentimentAlertAction`
    func execute() {
        let application = UIApplication.shared

        switch self {
        case .twitter(_, handle: let handle):
            let appURL = URL(string: "twitter://user?screen_name=\(handle)")!
            let webURL = URL(string: "https://twitter.com/\(handle)")!

            if application.canOpenURL(appURL) {
                 application.open(appURL)
            } else {
                 application.open(webURL)
            }

        case .email(_, address: let address):
            if let url = URL(string: "mailto:\(address)") {
                application.open(url)
            }

        case .website(_, url: let url):
            application.open(url)

        case .review(_, appId: let appId):
            if let reviewURL = URL(string: "itms-apps://itunes.apple.com/us/app/apple-store/\(appId)?mt=8"), application.canOpenURL(reviewURL) {
                application.open(reviewURL)
            }

        case .custom(_, action: let action):
            action()

        case .close(_):
            return
        }
    }
}
