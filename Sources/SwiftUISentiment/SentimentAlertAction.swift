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
    case twitter(_ name: String, handle: String)
    /// Navigate the user to the given `url` in the the external Safari App
    case website(_ name: String, url: URL)
    /// Navigates the user to their email client, sending an email to the given `address` string
    case email(_ name: String, address: String)
    /// Navigates the user to the apps AppStore page and writes a review (if available)
    case review(_ name: String, appId: String)
    /// Performs a custom action
    case custom(_ name: String, action: () -> Void)

    /// The `rawValue`
    private var rawValue: String {
        switch self {
        case .twitter(_, handle: let handle): return "twitter-\(handle)"
        case .email(_, address: let address): return "email-\(address)"
        case .website(_, url: let url): return "website-\(url.absoluteString)"
        case .review(_, appId: let appId): return "review-\(appId)"
        case .custom(let name, action: _): return name
        }
    }

    /// The `id` used to identify this `SentimentAlertAction`
    public var id: String { rawValue }

    /// The name to display in the alert for this `SentimentAlertAction` button
    public var name: String {
        switch self {
        case .twitter(let name, handle: _): return name
        case .email(let name, address: _): return name
        case .website(let name, url: _): return name
        case .review(let name, appId: _): return name
        case .custom(let name, action: _): return name
        }
    }
}

// MARK: Actions
extension SentimentAlertAction {
    /// Execute the appropriate action or ULR open for this `SentimentAlertAction`
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
        }
    }
}
